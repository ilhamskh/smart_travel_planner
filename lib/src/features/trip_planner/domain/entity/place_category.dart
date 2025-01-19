enum PlaceCategory {
  restaurant('Restaurant', ['restaurant', 'cafe', 'bakery']),
  hotel('Hotel', ['lodging']),
  attraction('Attraction', [
    'tourist_attraction',
    'museum',
    'park',
    'art_gallery'
  ]);

  final String displayName;
  final List<String> googlePlaceTypes;
  const PlaceCategory(this.displayName, this.googlePlaceTypes);
} 