import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zetaton_task/core/themes/themes.dart';
import 'package:zetaton_task/features/favorites/provider/favorites_provider.dart';
import 'package:zetaton_task/features/home/presentation/pages/image_view_page.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchPhotosLst();
  }

  fetchPhotosLst() async {
    await Provider.of<FavoritesProvider>(context, listen: false)
        .fetchfavoritesList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Favorites',
          style: AppStyles.primaryTextStyle24_400,
        ),
      ),
      body: Consumer<FavoritesProvider>(builder: (_, favoritesState, __) {
        return SafeArea(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: <Widget>[
                // Text(
                //   'Favorites',
                //   style: AppStyles.primaryTextStyle24_400,
                // ),
                15.verticalSpace,
                favoritesState.showLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : favoritesState.favoritePhotoModel != null
                        ? favoritesState.favoritePhotoModel!.isEmpty
                            ? Expanded(
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.favorite_border_outlined,
                                        color: AppColors.primaryColor,
                                        size: 40,
                                      ),
                                      10.verticalSpace,
                                      Text(
                                        'No Favorites Yet !',
                                        style: AppStyles.primaryTextStyle24_400,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Expanded(
                                child: GridView.builder(
                                  itemBuilder: (context, index) {
                                    return Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.w, vertical: 3.h),
                                        child: GestureDetector(
                                          onTap: () => Navigator.of(context)
                                              .push(MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          ImageViewerPage(
                                                            favoritePhotoModel:
                                                                favoritesState
                                                                        .favoritePhotoModel![
                                                                    index],
                                                          ))),
                                          child: Container(
                                              height: 60.w,
                                              width: 60.w,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          favoritesState
                                                              .favoritePhotoModel![
                                                                  index]
                                                              .smallImgUrl),
                                                      fit: BoxFit.cover))),
                                        ));
                                  },
                                  itemCount:
                                      favoritesState.favoritePhotoModel!.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          childAspectRatio: 1,
                                          crossAxisSpacing: 5,
                                          mainAxisSpacing: 5),
                                ),
                              )
                        : Container()
              ],
            ),
          ),
        );
      }),
    );
  }
}
