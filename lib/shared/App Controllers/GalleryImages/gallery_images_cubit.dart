import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:zoom_travel/shared/network/end_points.dart';
import 'package:zoom_travel/shared/network/remote/dio_helper.dart';
import '../../components/constants.dart';
part 'gallery_images_state.dart';

class GallaryImagesCubit extends Cubit<GallaryImagesState> {
  GallaryImagesCubit() : super(GallaryImagesInitial());

  static GallaryImagesCubit get(context) => BlocProvider.of(context);
  List images = [];
  int carouselIndex = 0;

  void changeCarouselIndex(int index) {
    carouselIndex = index;
    emit(ChangeCarouselIndexState());
  }

  void getGalleryImages({required int id}) {
    {
      emit(GallaryImagesLoading());
      DioHelper.getData(url: '${ApiUrl.galleryImages}/$id', token: token)
          .then((value) {
        if (value.statusCode == 200) {
          images = value.data['content']['images'];
          images.isEmpty ? images.add('assets/images/cairo.jpeg') : null;
          print(value.data['content']['images']);
          print('Images get Successfully !');
        }
      }).catchError((e) {
        emit(GallaryImagesSuccess());
        print(e.toString());
      });
    }
  }
}
