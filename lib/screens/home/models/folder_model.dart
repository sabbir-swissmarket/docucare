class FolderModel {
  final String id;
  final String name;
  final String createdTime;
  final List<String> files;

  FolderModel(
      {required this.id,
      required this.name,
      required this.createdTime,
      required this.files});
}
