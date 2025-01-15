class Document {
  final int? id; // Make id nullable
  final String fileName;
  final String extractedData;
  final String uploadDate;

  Document({
    this.id, // Make id nullable
    required this.fileName,
    required this.extractedData,
    required this.uploadDate,
  });

  factory Document.fromJson(Map<String, dynamic> json) {
    return Document(
      id: json['id'] as int?, // Parse id as nullable int
      fileName: json['fileName'] as String,
      extractedData: json['extractedData'] as String,
      uploadDate: json['uploadDate'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fileName': fileName,
      'extractedData': extractedData,
      'uploadDate': uploadDate,
    };
  }
}