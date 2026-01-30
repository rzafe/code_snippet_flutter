// import 'dart:io';
//
// import 'package:Tayabazen/utilities/_utils.dart';
// import 'package:Tayabazen/views/widget/_widget.dart';
// import 'package:Tayabazen/views/widget/appbar/_appbar.dart';
// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';
// import 'package:image/image.dart' as img;
// import 'package:flutter/services.dart';
// import 'package:path_provider/path_provider.dart';
//
// Future<File?> showCapture({
//   required BuildContext context,
//   bool hideIdWidget = false,
// }) async {
//   return await Navigator.push<File?>(
//     context,
//     MaterialPageRoute(
//       builder: (_) => CaptureView(
//         hideIdWidget: hideIdWidget,
//         fileCallback: (_) {},
//       ),
//     ),
//   );
// }
//
// class CaptureController {
//   /// Static method to crop an image and return the cropped image.
//   ///
//   /// The method takes a [File] `imageFile` representing the original image to be cropped.
//   /// It calculates a fixed width based on a 3:2 aspect ratio and crops the image
//   /// to that width, centered vertically. The cropped image is then saved to a temporary file,
//   /// and the [XFile] representing the path of the cropped image is returned.
//   ///
//   /// Example:
//   /// ```dart
//   /// File imageFile = ...; // The original image file
//   /// XFile? croppedImage = await CaptureController.cropImage(imageFile);
//   /// print('Cropped image path: ${croppedImage?.path}');
//   /// ```
//   static Future<File?> cropImage(File imageFile) async {
//     // Read the image file
//     List<int> imageBytes = await imageFile.readAsBytes();
//     img.Image originalImage = img.decodeImage(Uint8List.fromList(imageBytes))!;
//
//     // Define the fixed width based on a 3:2 aspect ratio
//     int width = originalImage.width - 48; // Remove 24 pixels from both left and right
//     int height = (2 * width) ~/ 3;
//
//     // Calculate the cropping rectangle centered on the modified width
//     int x = 24; // Offset to remove 24 pixels from the left
//     int y = (originalImage.height - height) ~/ 2;
//
//     // Crop the image
//     img.Image croppedImage = img.copyCrop(
//       originalImage,
//       x: x,
//       y: y,
//       width: width,
//       height: height,
//     );
//
//     // Convert the cropped image to bytes
//     Uint8List croppedBytes = Uint8List.fromList(img.encodePng(croppedImage));
//
//     // Generate a unique filename using the current timestamp
//     String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
//     Directory tempDir = await getTemporaryDirectory();
//
//     String tempPath = '${tempDir.path}/cropped_image_$timestamp.png';
//
//     // Save the cropped image to the new temporary file
//     await File(tempPath).writeAsBytes(croppedBytes);
//
//     // Return the cropped image path as a [XFile]
//     return File(tempPath);
//   }
// }
//
// class CaptureView extends StatefulWidget {
//   const CaptureView({
//     Key? key,
//     required this.fileCallback,
//     this.info,
//     this.hideIdWidget,
//   }) : super(key: key);
//
//   final Function(File imagePath) fileCallback;
//   final String? info;
//   final bool? hideIdWidget;
//
//   @override
//   State<CaptureView> createState() => _CaptureViewState();
// }
//
// class _CaptureViewState extends State<CaptureView> {
//   CameraController? _controller;
//   List<CameraDescription> _cameras = [];
//   FlashMode _flashMode = FlashMode.off;
//   bool _isInitializing = true;
//
//   @override
//   void initState() {
//     super.initState();
//     _setupCamera();
//   }
//
//   Future<void> _setupCamera() async {
//     try {
//       _cameras = await availableCameras();
//
//       final camera = _cameras.isNotEmpty ? _cameras.first : _defaultCameraDescription();
//
//       _controller = CameraController(
//         camera,
//         ResolutionPreset.ultraHigh,
//         enableAudio: false,
//       );
//
//       await _controller!.initialize();
//       await _controller!.setFlashMode(_flashMode);
//
//       if (!mounted) return;
//       setState(() => _isInitializing = false);
//     } catch (e) {
//       debugPrint('Camera initialization failed: $e');
//     }
//   }
//
//   CameraDescription _defaultCameraDescription() {
//     return const CameraDescription(
//       name: 'default',
//       lensDirection: CameraLensDirection.back,
//       sensorOrientation: 180,
//     );
//   }
//
//   Future<void> _toggleFlash() async {
//     if (_controller == null || !_controller!.value.isInitialized) return;
//
//     final nextMode = _flashMode == FlashMode.off ? FlashMode.torch : FlashMode.off;
//
//     await _controller!.setFlashMode(nextMode);
//
//     setState(() {
//       _flashMode = nextMode;
//     });
//   }
//
//   Future<void> _captureImage() async {
//     if (_controller == null || !_controller!.value.isInitialized || _controller!.value.isTakingPicture) {
//       return;
//     }
//
//     final XFile file = await _controller!.takePicture();
//
//     final File? croppedImage = await CaptureController.cropImage(File(file.path));
//
//     if (croppedImage == null) return;
//
//     widget.fileCallback(croppedImage);
//     Navigator.pop(context, croppedImage);
//   }
//
//   @override
//   void dispose() {
//     _controller?.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (_isInitializing || _controller == null) {
//       return const Scaffold(
//         backgroundColor: Colors.black,
//         body: Center(child: CircularProgressIndicator()),
//       );
//     }
//
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: appBarWidget(
//         context,
//         title: 'Capture Your ID',
//         iconColor: Colors.white,
//         textColor: Colors.white,
//         isCenterTitle: true,
//         backgroundColor: primaryColor.withValues(alpha: .8),
//         onTap: () {
//           Navigator.pop(context);
//         },
//       ),
//       body: Stack(
//         fit: StackFit.expand,
//         children: [
//           CameraPreview(_controller!),
//
//           FramingCaptureWidget(
//             hideIdWidget: widget.hideIdWidget ?? false,
//           ),
//
//
//           /// ─── OPTIONAL INFO TEXT ────────────────────────────────────
//           if (widget.info != null)
//             Positioned(
//               top: 90,
//               left: 20,
//               right: 20,
//               child: Text(
//                 widget.info!,
//                 textAlign: TextAlign.center,
//                 style: const TextStyle(
//                   color: Colors.white70,
//                   fontSize: 14,
//                 ),
//               ),
//             ),
//
//           /// ─── CAPTURE BUTTON ────────────────────────────────────────
//           Positioned(
//             bottom: 30,
//             left: 0,
//             right: 0,
//             child: Center(
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   IconButton(
//                     onPressed: _toggleFlash,
//                     icon: Container(
//                       width: 72,
//                       height: 72,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: Colors.white,
//                         border: Border.all(color: Colors.black12, width: 4),
//                       ),
//                       child: Icon(
//                         _flashMode == FlashMode.torch ? Icons.flash_on : Icons.flash_off,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: _captureImage,
//                     child: Container(
//                       width: 72,
//                       height: 72,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: Colors.white,
//                         border: Border.all(color: Colors.black12, width: 4),
//                       ),
//                       child: const Icon(
//                         Icons.camera,
//                         size: 32,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class FramingCaptureWidget extends StatelessWidget {
//   /// Constructs a `FramingCaptureWidget`.
//   ///
//   /// Parameters:
//   /// - `hideIdWidget`: A boolean indicating whether to hide the `IdWidget` in the center.
//   const FramingCaptureWidget({
//     super.key,
//     required this.hideIdWidget,
//   });
//
//   /// Determines whether the `IdWidget` in the center should be hidden.
//   final bool hideIdWidget;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       // Border styling for the framing overlay
//       padding: const EdgeInsets.symmetric(horizontal: 8.0),
//       decoration: BoxDecoration(
//         border: Border.symmetric(
//           vertical: const BorderSide(
//             color: Colors.black54,
//             width: 10,
//           ),
//           horizontal: BorderSide(
//             color: Colors.black54,
//             width: MediaQuery.of(context).size.height * 0.32,
//           ),
//         ),
//       ),
//       child: Stack(
//         children: [
//           // Centered container with customizable border
//           Align(
//             alignment: Alignment.center,
//             child: Container(
//               width: double.infinity,
//               decoration: ShapeDecoration(
//                 color: Colors.transparent,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                   side: const BorderSide(width: 3, color: Colors.white),
//                 ),
//               ),
//               // Display the IdWidget in the center, unless explicitly hidden
//               child: hideIdWidget ? null : const IdWidget(),
//             ),
//           ),
//           // Color-filtered background for framing overlay
//           ColorFiltered(
//             colorFilter: const ColorFilter.mode(
//               Colors.black54,
//               BlendMode.srcOut,
//             ),
//             child: Stack(
//               children: [
//                 Container(
//                   decoration: const BoxDecoration(
//                     color: Colors.transparent,
//                   ),
//                   child: Align(
//                     alignment: Alignment.center,
//                     child: Container(
//                       width: double.infinity,
//                       decoration: BoxDecoration(
//                         color: Colors.black,
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class IdWidget extends StatelessWidget {
//   /// Constructs an `IdWidget`.
//   ///
//   /// Parameters:
//   /// - `key`: An optional key to uniquely identify this widget.
//   const IdWidget({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         // Header section with person icon
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Icon(
//               Icons.person_outline,
//               size: 140,
//               color: Colors.white.withValues(alpha: 0.3),
//             ),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const SizedBox(
//                     height: 40,
//                   ),
//                   // Line representing a name field
//                   Container(
//                     width: 80,
//                     height: 8,
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.3),
//                       borderRadius: BorderRadius.circular(4),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   // Line representing another field
//                   Container(
//                     width: 170,
//                     height: 8,
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.3),
//                       borderRadius: BorderRadius.circular(4),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 40,
//                   ),
//                   // Two lines arranged in a row
//                   Row(
//                     children: [
//                       Container(
//                         width: 60,
//                         height: 8,
//                         decoration: BoxDecoration(
//                           color: Colors.white.withOpacity(0.3),
//                           borderRadius: BorderRadius.circular(4),
//                         ),
//                       ),
//                       const SizedBox(
//                         width: 20,
//                       ),
//                       Container(
//                         width: 60,
//                         height: 8,
//                         decoration: BoxDecoration(
//                           color: Colors.white.withOpacity(0.3),
//                           borderRadius: BorderRadius.circular(4),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   // Line representing another field
//                 ],
//               ),
//             ),
//           ],
//         ),
//         const Spacer(),
//         // Bottom section with lines and spaces
//         Container(
//           height: 8,
//           margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//           decoration: BoxDecoration(
//             color: Colors.white.withOpacity(0.3),
//             borderRadius: BorderRadius.circular(4),
//           ),
//         ),
//         Container(
//           height: 8,
//           margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//           decoration: BoxDecoration(
//             color: Colors.white.withOpacity(0.3),
//             borderRadius: BorderRadius.circular(4),
//           ),
//         ),
//         const SizedBox(
//           height: 20,
//         ),
//       ],
//     );
//   }
// }
