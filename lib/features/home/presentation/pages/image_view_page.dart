import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:zetaton_task/core/themes/app_colors.dart';
import 'package:zetaton_task/features/favorites/model/favorites_model.dart';
import 'package:zetaton_task/features/favorites/provider/favorites_provider.dart';

class ImageViewerPage extends StatefulWidget {
  const ImageViewerPage({Key? key, required this.favoritePhotoModel})
      : super(key: key);
  final FavoritePhotoModel favoritePhotoModel;

  @override
  State<ImageViewerPage> createState() => _ImageViewerPageState();
}

class _ImageViewerPageState extends State<ImageViewerPage> {
  @override
  void initState() {
    super.initState();
    fetchPhotosLst();
  }

  fetchPhotosLst() async {
    await Provider.of<FavoritesProvider>(context, listen: false)
        .checkIsFavorite(favoritePhotoModel: widget.favoritePhotoModel);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoritesProvider>(builder: (_, favoriteState, __) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            leading: IconButton(
              icon: const Icon(
                Icons.close,
                color: AppColors.primaryColor,
                size: 30,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                  onPressed: () async {
                    favoriteState.isFavorite
                        ? favoriteState.removeFromFavorites(
                            favoritePhotoModel: widget.favoritePhotoModel)
                        : favoriteState.addToFavorites(
                            favoritePhotoModel: widget.favoritePhotoModel);
                  },
                  icon: Icon(
                    favoriteState.isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border_outlined,
                    color: AppColors.primaryColor,
                    size: 30,
                  ))
            ],
          ),
          body: PhotoView(
            imageProvider: NetworkImage(
              widget.favoritePhotoModel.originalImgUrl,
            ),
          ));
    });
  }
}
