import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/document.dart'; // Ensure this import is correct

class DocumentService {
  final String baseUrl;

  DocumentService({required this.baseUrl});

  Future<Document> uploadDocument(String filePath) async {
    final uri = Uri.parse('$baseUrl/api/documents/upload');
    final request = http.MultipartRequest('POST', uri);

    request.files.add(await http.MultipartFile.fromPath('file', filePath));

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      return Document.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to upload document');
    }
  }
}