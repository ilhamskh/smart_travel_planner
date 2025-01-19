class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic data;

  AppException(this.message, {this.code, this.data});

  @override
  String toString() => 'AppException: $message${code != null ? ' ($code)' : ''}';
}

class NetworkException extends AppException {
  NetworkException([super.message = 'No internet connection']) 
    : super(code: 'NETWORK_ERROR');
}

class ServerException extends AppException {
  ServerException([super.message = 'Server error occurred']) 
    : super(code: 'SERVER_ERROR');
}

class LocationException extends AppException {
  LocationException([super.message = 'Location service error']) 
    : super(code: 'LOCATION_ERROR');
}

class CacheException extends AppException {
  CacheException([super.message = 'Cache error occurred']) 
    : super(code: 'CACHE_ERROR');
}

class NoPlacesFoundException extends AppException {
  NoPlacesFoundException([super.message = 'No places found']) 
    : super(code: 'NO_PLACES_FOUND');
}