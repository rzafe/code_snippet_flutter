// import 'dart:typed_data';
// import 'package:firebase_ai/firebase_ai.dart';
//
// import '../data/model/_model.dart';
// import '_utils.dart';
//
// Future<DocumentInfo> generateContent(Uint8List imageBytes) async {
//   // String _eventToken = 'not yet';
//
//   final generationConfig = GenerationConfig();
//   final safetySettings = [
//     SafetySetting(HarmCategory.hateSpeech, HarmBlockThreshold.medium, HarmBlockMethod.severity),
//     SafetySetting(HarmCategory.dangerousContent, HarmBlockThreshold.medium, HarmBlockMethod.severity),
//     SafetySetting(HarmCategory.sexuallyExplicit, HarmBlockThreshold.medium, HarmBlockMethod.severity),
//     SafetySetting(HarmCategory.harassment, HarmBlockThreshold.medium, HarmBlockMethod.severity),
//   ];
//
//   final systemInstruction = Content('system', [
//     TextPart(
//       'You are a document extraction assistant. Given a document image, your task is to extract the following details ONLY if available:\n\n'
//           '- Full Name\n- First Name\n- Middle Name\n- Last Name\n- Date of Birth\n- Place of Birth\n- Document Type\n- Date Issued\n- ID Number\n\n'
//           'Reply only with these fields. Do not add extra explanation.',
//     ),
//   ]);
//
//   final model = FirebaseAI.vertexAI().generativeModel(
//     model: 'gemini-2.5-pro',
//     generationConfig: generationConfig,
//     safetySettings: safetySettings,
//     systemInstruction: systemInstruction,
//   );
//
//   final chat = model.startChat();
//
//   final imagePart = InlineDataPart('image/jpeg', imageBytes);
//
//   final content = Content('user', [
//     imagePart,
//     TextPart('Please extract the required fields.'),
//   ]);
//
//   final responseText = await sendMessage(chat, content);
//
//   /// Parse the AI response first
//   final info = DocumentInfo.fromAIResponse(responseText);
//
//   /// Now validate and correct the document type
//   final rawType = info.documentType;
//   final matchedType = rawType != null ? findMatchingDocumentType(rawType) : null;
//
//   if (matchedType != null) {
//     info.documentType = matchedType;
//   } else {
//     printDebug('⚠️ No match for document type: $rawType');
//     info.documentType = null; // or "Unknown"
//   }
//
//   return info;
// }
//
// String? findMatchingDocumentType(String extractedType) {
//   final normalizedExtracted = extractedType.toLowerCase().trim();
//
//   for (final entry in validIDTypeAliases.entries) {
//     for (final alias in entry.value) {
//       if (normalizedExtracted.contains(alias)) {
//         return entry.key; // Return the official document type
//       }
//     }
//   }
//
//   return null; // No match found
// }
//
// Future<String> sendMessage(ChatSession chat, Content content) async {
//   final response = await chat.sendMessage(content);
//   return response.text ?? ''; // ✅ ensure non-null
// }
