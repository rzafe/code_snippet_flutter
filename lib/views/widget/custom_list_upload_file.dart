import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

import '../../utilities/_utils.dart';
import '_widget.dart';

class FileUploadList extends FormField<Map<String, String>> {
  FileUploadList({
    super.key,
    required List<String> files,
    Map<String, String>? initialValue,
    void Function(String label, String filePath)? onFileSelected,
    bool required = true,
    FormFieldSetter<Map<String, String>>? onSaved,
    FormFieldValidator<Map<String, String>>? validator,
  }) : super(
    initialValue: initialValue ?? {},
    validator: (value) {
      if (required) {
        final missing = files.where((f) => !(value?.containsKey(f) ?? false));
        if (missing.isNotEmpty) {
          return 'Please upload all required files';
        }
      }
      if (validator != null) return validator(value);
      return null;
    },
    onSaved: onSaved,
      builder: (field) {
        final selectedFiles = Map<String, String>.from(field.value ?? {});

        Future<void> pickFromCamera(BuildContext context, String label) async {
          final picker = ImagePicker();
          final pickedFile = await picker.pickImage(
            source: ImageSource.camera,
            imageQuality: 50,
            maxWidth: 1280,
            maxHeight: 720,
          );

          if (pickedFile != null) {
            final file = File(pickedFile.path);
            final fileSize = await file.length();

            if (fileSize > 2 * 1024 * 1024) {
              showSnackBarError(context, message: 'File size must be 2 MB or less');
              return;
            }

            selectedFiles[label] = pickedFile.path;
            field.didChange(selectedFiles);
            if (onFileSelected != null) onFileSelected(label, pickedFile.path);
          }
        }

        Future<void> pickFromFiles(BuildContext context, String label) async {
          final result = await FilePicker.platform.pickFiles(type: FileType.image);

          if (result != null && result.files.single.path != null) {
            final filePath = result.files.single.path!;
            final file = File(filePath);
            final fileSize = await file.length();

            if (fileSize > 5 * 1024 * 1024) {
              showSnackBarError(context, message: 'File size must be 5 MB or less');
              return;
            }

            selectedFiles[label] = filePath;
            field.didChange(selectedFiles);
            if (onFileSelected != null) onFileSelected(label, filePath);
          }
        }

        void showPickerOptions(BuildContext context, String label) {
          showModalBottomSheet(
            backgroundColor: primaryColor,
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (_) {
              return SafeArea(
                child: Wrap(
                  children: [
                    ListTile(
                      leading: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                      ),
                      title: const CustomText(
                        text: 'Take a Photo',
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        margin: EdgeInsets.zero,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        pickFromCamera(context, label);
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.insert_drive_file,
                        color: Colors.white,
                      ),
                      title: const CustomText(
                        text: 'Choose from files',
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        margin: EdgeInsets.zero,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        pickFromFiles(context, label);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...files.map((file) {
              final selectedPath = selectedFiles[file];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: CustomText(
                            text: file,
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        CustomButton(
                          text: 'Upload',
                          buttonColor: primaryColor,
                          borderRadius: 30,
                          textColor: Colors.white,
                          fontWeight: FontWeight.w600,
                          onTap: () => showPickerOptions(field.context, file),
                        ),
                      ],
                    ),
                    if (selectedPath != null) ...[
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          File(selectedPath),
                          height: 120,
                          width: double.infinity,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                    // const Gap(5),
                    Divider(color: tertiaryColor),
                  ],
                ),
              );
            }),
            if (field.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 5, left: 5),
                child: CustomText(
                  text: field.errorText ?? '',
                  fontSize: 13,
                  color: Colors.red,
                ),
              ),
          ],
        );
      },
  );
}

/// ----------------------------------------------------------------------------
class FileUploadWithSubtitleList extends StatefulWidget {
  final List<Map<String, String>> files; // FIXED: list of maps
  final void Function(String label, String filePath)? onFileSelected;

  const FileUploadWithSubtitleList({
    super.key,
    required this.files,
    this.onFileSelected,
  });

  @override
  State<FileUploadWithSubtitleList> createState() => _FileUploadWithSubtitleListState();
}

class _FileUploadWithSubtitleListState extends State<FileUploadWithSubtitleList> {
  String? _fileName;
  final Map<String, String> _selectedFiles = {};

  Future<void> _pickFromCamera(BuildContext context, String label) async {
    final picker = ImagePicker();

    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 1280,
      maxHeight: 720,
    );

    if (pickedFile != null) {
      final file = File(pickedFile.path);
      final fileSize = await file.length();

      debugPrint('📷 Image size: ${(fileSize / (1024 * 1024)).toStringAsFixed(2)} MB');

      if (fileSize > 2 * 1024 * 1024) {
        showSnackBarError(context, message: 'File size must be 2 MB or less');
        return;
      }

      setState(() {
        _fileName = pickedFile.name;
        _selectedFiles[label] = pickedFile.path;
      });
      widget.onFileSelected?.call(label, pickedFile.path);
    }
  }

  Future<void> _pickFromFiles(BuildContext context, String label) async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null && result.files.single.path != null) {
      final filePath = result.files.single.path!;
      final file = File(filePath);

      final fileSize = await file.length();
      debugPrint('📂 File size: ${(fileSize / (1024 * 1024)).toStringAsFixed(2)} MB');

      if (fileSize > 5 * 1024 * 1024) {
        showSnackBarError(context, message: 'File size must be 5 MB or less');
        return;
      }

      setState(() {
        _fileName = result.files.single.name;
        _selectedFiles[label] = filePath;
      });
      widget.onFileSelected?.call(label, filePath);
    }
  }

  void _showPickerOptions(BuildContext context, String label) {
    showModalBottomSheet(
      backgroundColor: primaryColor,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                ),
                title: const CustomText(
                  text: 'Take a Photo',
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  margin: EdgeInsets.zero,
                ),
                onTap: () {
                  Navigator.pop(context);
                  _pickFromCamera(context, label);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.insert_drive_file,
                  color: Colors.white,
                ),
                title: const CustomText(
                  text: 'Choose from files',
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  margin: EdgeInsets.zero,
                ),
                onTap: () {
                  Navigator.pop(context);
                  _pickFromFiles(context, label);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.files.map((file) {
        final title = file["title"] ?? "";
        final subtitle = file["subtitle"] ?? "";
        final selectedPath = _selectedFiles[title];

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: title,
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                        ),
                        CustomText(
                          text: subtitle,
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                  CustomButton(
                    text: 'Upload',
                    borderRadius: 30,
                    textColor: Colors.white,
                    buttonColor: primaryColor,
                    fontWeight: FontWeight.w600,
                    onTap: () => _showPickerOptions(context, title),
                  ),
                ],
              ),
              if (selectedPath != null) ...[
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    File(selectedPath),
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
              const Gap(10),
            ],
          ),
        );
      }).toList(),
    );
  }
}
