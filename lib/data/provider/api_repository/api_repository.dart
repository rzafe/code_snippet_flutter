import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path_provider/path_provider.dart';

import '../../../utilities/_utils.dart';
import '../../model/_model.dart';
import '../_provider.dart';

class PostsRepo {
  /// FETCH
  // static Future<List<News>> fetchNews() async {
  //   var client = http.Client();
  //   APIResult resultAPI;
  //   List<News> posts = [];
  //   final String printName = 'fetchNews';
  //
  //   // printDebug(printName);
  //
  //   if (!dotenv.isInitialized) {
  //     await dotenv.load(fileName: '.env');
  //   }
  //
  //   final String? dbName = dotenv.env['DB_NAME'];
  //   final String? localToken = dotenv.env['LOCAL_TOKEN'];
  //   final String? apiKeyAWS = dotenv.env['API_KEY'];
  //   Map<String, String> header = {'x-api-key': apiKeyAWS ?? ''};
  //
  //   try {
  //     /// Construct the query parameters
  //     final queryParameters = {
  //       'token': '${encryptMd5(value: DateTime.now().toString()).characters.take(13)}$localToken',
  //       'db_name': dbName,
  //       'endpoint': 'fetch_news',
  //     };
  //
  //     /// Construct the URI with query parameters
  //     final uri = Uri.parse('$baseURL$baseURLTransactionGet').replace(queryParameters: queryParameters);
  //
  //     var response = await client.get(uri, headers: header);
  //
  //     printDebug(response.body, title: printName);
  //
  //     if (response.statusCode >= 200 && response.statusCode < 300) {
  //       resultAPI = HTTPResponse().response(response);
  //       if (resultAPI.result is List) {
  //         List<dynamic> fetch = resultAPI.result;
  //         for (var i = 0; i < fetch.length; i++) {
  //           News post = News.fromJson(fetch[i] as Map<String, dynamic>);
  //           final file = post.file;
  //           if (file != null) {
  //             if (isImage(file)) {
  //               post.type = 'IMAGE';
  //             } else if (isVideo(file)) {
  //               post.type = 'VIDEO';
  //             }
  //           }
  //           posts.add(post);
  //         }
  //       }
  //     } else {
  //       posts = [];
  //     }
  //     return posts;
  //   } catch (e) {
  //     printDebug(e.toString(), title: printName);
  //     return [];
  //   } finally {
  //     client.close();
  //   }
  // }

}
