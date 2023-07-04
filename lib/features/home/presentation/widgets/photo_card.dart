import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zetaton_task/features/favorites/model/favorites_model.dart';
import 'package:zetaton_task/features/home/model/pexel_photo_model.dart';
import 'package:zetaton_task/features/home/presentation/pages/image_view_page.dart';

class PhotoCard extends StatelessWidget {
  const PhotoCard({super.key, required this.pexelPhotosModel});
  final Photos pexelPhotosModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
        child: GestureDetector(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => ImageViewerPage(
                      favoritePhotoModel: FavoritePhotoModel(
                    photoId: pexelPhotosModel.id,
                    originalImgUrl: pexelPhotosModel.src.original,
                    smallImgUrl: pexelPhotosModel.src.small,
                  )))),
          child: Container(
              height: 60.w,
              width: 60.w,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(pexelPhotosModel.src.small),
                      fit: BoxFit.cover))),
        ));
  }
}
