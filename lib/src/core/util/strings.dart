abstract class Strings {
  static const String initialRoute = '/';
  static const String homeRoute = '/homePage';
  static const String imagesRoute = '/imagesPage';
  static const String mapRoute = '/mapPage';
  static const String appRouteDefault = 'Undefined route';
  static const String emptyGridMessage = 'No movies to show';
  static const String error = 'An error has occurred while loading movies:';
  static const String initialPageTitle = 'Movies App';
  static const String imagesPageTitle = 'Images';
  static const String movieCollectionName = 'movie';
  static const String locationCollectionName = 'location';
  static const String argumentTitle = 'title';
  static const String argumentUseCase = 'useCase';
  static const String argumentSortingWay = 'sortingWay';
  static const String ascendingTitle =
      'Movies will be shown ascending by title\n"Click to change to descending"';
  static const String descendingTitle =
      'Movies will be shown descending by title\n"Click to change to ascending"';
  static const String movieUseCaseTitle = 'All movies';
  static const String popularityMovieUseCaseTitle = 'The most popular movies';
  static const String imagesPageButtonTitle = 'Select images';
  static const String mapPageButtonTitle = 'Show map';

  static const String ascendingSortStrategy = 'AscendingSortStrategy';
  static const String descendingSortStrategy = 'DescendingSortStrategy';
  static const String movieUseCaseAscendingSortStrategy =
      'MovieUseCaseAscendingSortStrategy';
  static const String movieUseCaseDescendingSortStrategy =
      'MovieUseCaseDescendingSortStrategy';
  static const String popularityMovieUseCaseAscendingSortStrategy =
      'PopularityMovieUseCaseAscendingSortStrategy';
  static const String popularityMovieUseCaseDescendingSortStrategy =
      'PopularityMovieUseCaseDescendingSortStrategy';

  static const String movieButton1TestKey = 'movie-button-1';

  static const String imagesPageDefaultMessageDeviceImages =
      'No images selected';
  static const String imagesPageDefaultMessageStorageImages =
      'No images stored';
  static const String imagesPageSelect = 'Select';
  static const String imagesPageGallery = 'Gallery';
  static const String imagesPageCamera = 'Camera';
  static const String imagesPageTitleDeviceImages = 'Selected device images';
  static const String imagesPageTitleStorageImages =
      'Images stored in storage recently';
  static const String imagesPageTextButtonDeviceImages = 'Select an image';
  static const String imagesPageTextButtonStorageImages = 'Upload image';
  static const String imagesPageSnackBarWithImages =
      'The selected images were saved in storage';
  static const String imagesPageSnackBarWithoutImages =
      'No images selected to save';
  static const String imageStorageCache = 'cache/';
  static const String imageStorageImages = 'images';

  static const String mapOpenStreetMap =
      'https://tile.openstreetmap.org/{z}/{x}/{y}.png';
  static const String mapExample = 'com.example.app';
  static const String mapDateFormat = 'dd/MM/yyyy hh:mm:ss a';
  static const String mapNotificationIcon = 'notification_icon';
  static const String mapNotificationChannelId = 'channelId';
  static const String mapNotificationChannelName = 'channelName';
  static const String mapNotificationTitle = 'New location detected';
  static const String mapNotificationBody =
      'A location was inserted into the database';
}
