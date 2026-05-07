import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../utilities/_utils.dart';
import '_widget.dart';

class UploadRow extends StatefulWidget {
  final String title;
  final String description;
  final String buttonText;
  final double widthFactor;
  final EdgeInsets margin;
  final ValueChanged<String?>? onFileSelected; // <-- callback

  const UploadRow({
    super.key,
    required this.title,
    required this.description,
    required this.buttonText,
    this.widthFactor = 0.75,
    this.margin = EdgeInsets.zero,
    this.onFileSelected,
  });

  @override
  State<UploadRow> createState() => _UploadRowState();
}

class _UploadRowState extends State<UploadRow> {
  String? _fileName;

  double width(BuildContext context) => MediaQuery.of(context).size.width;

  Future<void> _pickFromCamera(BuildContext context) async {
    final picker = ImagePicker();

    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50, // Lower quality for smaller file size
      maxWidth: 1280,   // Resize width
      maxHeight: 720,   // Resize height
    );

    if (pickedFile != null) {
      final file = File(pickedFile.path);
      final fileSize = await file.length();

      /// Optional: log actual size in MB
      debugPrint('Image size: ${(fileSize / (1024 * 1024)).toStringAsFixed(2)} MB');

      if (fileSize > 2 * 1024 * 1024) {
        showSnackBarError(context, message: 'File size must be 2 MB or less');
        return;
      }

      setState(() {
        _fileName = pickedFile.name;
      });
      widget.onFileSelected?.call(pickedFile.path);
    }
  }

  Future<void> _pickFromFiles(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null && result.files.single.path != null) {
      final filePath = result.files.single.path!;
      final file = File(filePath);

      /// ✅ Check file size (max 5MB)
      final fileSize = await file.length();
      if (fileSize > 5 * 1024 * 1024) {
        showSnackBarError(context, message: 'File size must be 5 MB or less');
        return;
      }

      setState(() {
        _fileName = result.files.single.name;
      });
      widget.onFileSelected?.call(filePath);
    }
  }

  void _showPickerOptions(BuildContext context) {
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
                title: CustomText(
                  text: 'Take a Photo',
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  margin: EdgeInsets.zero,
                ),
                onTap: () {
                  Navigator.pop(context);
                  _pickFromCamera(context);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.insert_drive_file,
                  color: Colors.white,
                ),
                title: CustomText(
                  text: 'Choose from files',
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  margin: EdgeInsets.zero,
                ),
                onTap: () {
                  Navigator.pop(context);
                  _pickFromFiles(context);
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
    return Padding(
      padding: widget.margin,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SizedBox(
              width: width(context) * widget.widthFactor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: widget.title,
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                  CustomText(
                    text: widget.description,
                    fontSize: 12,
                    color: Colors.grey,
                    fontWeight: FontWeight.normal,
                  ),
                  if (_fileName != null && _fileName!.isNotEmpty)
                    CustomText(
                      text: 'file: $_fileName',
                      fontSize: 13,
                      color: Colors.red,
                      fontWeight: FontWeight.normal,
                    ),
                ],
              ),
            ),
          ),
          SizedBox(width: 10,),
          CustomButton(
            title: widget.buttonText,
            buttonHeight: 30,
            textColor: Colors.white,
            fontSize: 12,
            buttonColor: primaryColor,
            borderRadius: 20,
            fontWeight: FontWeight.bold,
            paddingButton: const EdgeInsets.symmetric(horizontal: 10),
            onTap: () => _showPickerOptions(context),
          ),
        ],
      ),
    );
  }
}

