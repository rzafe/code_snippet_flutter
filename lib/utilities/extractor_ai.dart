// import 'dart:typed_data';
// import 'package:firebase_ai/firebase_ai.dart';
//
// import '../data/model/document_file.dart';
// import 'global.dart';
// import 'helpers.dart';
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
//       'You are a document extraction assistant. Given an image of an identification document, extract the following fields only if they are explicitly present and clearly readable in the document:'
//           '-Full Name (as written on the document, exactly)'
//           '-First Name (given name only)'
//           '-Middle Name'
//           '-Last Name (surname/family name)'
//           '-Date of Birth'
//           '-Place of Birth'
//           '-Sex'
//           '-Document Type'
//           '-Date Expiration'
//           '-ID Number'
//           '\n\nExtraction Rules:'
//           '-Do not infer or guess any field.'
//           '- Determine name parts using explicit labels, line structure, and standard identification document formatting.'
//           '- Do not invent or assume name components that are not present.'
//           '-The middle name always directly follows the first name. However, the first name may consist of one or more words separated by spaces (e.g., compound first names). Do not incorrectly '
//           'split a multi-word first name and treat part of it as a middle name. Only extract a middle name if it is explicitly indicated and clearly follows the complete first name.'
//           '-If the date of birth is ambiguous, partially visible, or inferred from age, do not extract it.'
//           '-Preserve original spelling, order, and formatting as shown in the document.',
//     ),
//   ]);
//
//   final model = FirebaseAI.vertexAI().generativeModel(
//     model: 'gemini-2.5-flash',
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
//   printDebug(responseText, title: 'AI');
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
//
//   printDebug('Finish reason: ${response.candidates.first.finishReason}');
//
//   final buffer = StringBuffer();
//
//   for (final candidate in response.candidates) {
//     for (final part in candidate.content.parts) {
//       if (part is TextPart) {
//         buffer.writeln(part.text);
//       }
//     }
//   }
//
//   return buffer.toString().trim();
// }
