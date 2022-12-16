class ConstructStringEndPoint {
  final String nameInUrl;
  final String path;

  ConstructStringEndPoint({
    required this.nameInUrl,
    required this.path,
  });

  fetchAllUrl() {
    if (nameInUrl.isEmpty) {
      return path;
    }
    return "$path/$nameInUrl";
  }

  createUrl([Map<String, dynamic>? options]) {
    var url = "$path/$nameInUrl";
    return url;
  }

  deleteUrl({
    String? id,
  }) {
    var url = "$path/$nameInUrl";
    if (id != null) {
      url = "$url/$id";
    }
    return url;
  }

  updateUrl({
    String? id,
  }) {
    var url = "$path/$nameInUrl";
    if (id != null) {
      url = "$url/$id";
    }
    return url;
  }
}
