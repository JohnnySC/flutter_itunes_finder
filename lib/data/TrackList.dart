class TrackList {
  int trackCount;
  List<Track> tracks;

  TrackList({this.trackCount, this.tracks});

  factory TrackList.fromJson(Map<String, dynamic> json) {
    return TrackList(
        trackCount: json['resultCount'],
        tracks:
            (json['results'] as List).map((i) => Track.fromJson(i)).toList());
  }
}

class Track {
  String artistName;
  String name;
  String artistViewUrl;
  String trackPreviewUrl;
  String coverUrl;
  double price;

  Track(
      {this.artistName,
      this.name,
      this.artistViewUrl,
      this.trackPreviewUrl,
      this.coverUrl,
      this.price});

  factory Track.fromJson(Map<String, dynamic> json) {
    return Track(
        artistName: json['artistName'],
        name: json['trackName'],
        artistViewUrl: json['artistViewUrl'],
        trackPreviewUrl: json['previewUrl'],
        coverUrl: json['artworkUrl100'],
        price: json['trackPrice']);
  }
}