part of 'gallery_images_cubit.dart';

@immutable
abstract class GallaryImagesState {}

class GallaryImagesInitial extends GallaryImagesState {}

class GallaryImagesLoading extends GallaryImagesState {}

class GallaryImagesSuccess extends GallaryImagesState {}

class GallaryImagesError extends GallaryImagesState {}
class ChangeCarouselIndexState extends GallaryImagesState {}
