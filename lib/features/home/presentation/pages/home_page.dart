import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zetaton_task/features/authentication/presentation/pages/pages.dart';
import 'package:zetaton_task/features/authentication/provider/auth_provider.dart';
import 'package:zetaton_task/features/favorites/presentation/favorites_page.dart';
import 'package:zetaton_task/features/home/presentation/widgets/photo_card.dart';
import 'package:zetaton_task/features/home/provider/home_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchPhotosLst();
  }

  fetchPhotosLst() async {
    await Provider.of<HomeProvider>(context, listen: false).fetchPhotosList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer2<HomeProvider, AuthProvider>(
          builder: (_, homeState, authState, __) {
        return SafeArea(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * .72,
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(50),
                          border:
                              Border.all(color: Colors.grey.withOpacity(0.1))),
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      margin:
                          EdgeInsets.only(right: 10.w, left: 10.w, top: 10.h),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: TextField(
                              controller: searchController,
                              decoration: const InputDecoration(
                                  hintText: "Search", border: InputBorder.none),
                              onChanged: (value) => value.isEmpty
                                  ? homeState.fetchPhotosList()
                                  : homeState.fetchSearchPhotosList(
                                      query: value),
                            ),
                          ),
                          const Icon(
                            Icons.search,
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => const FavoritesPage())),
                      child: const Icon(
                        CupertinoIcons.square_favorites_alt,
                        size: 30,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        authState.logout();
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const LoginPage()));
                      },
                      child: const Icon(
                        Icons.logout,
                        size: 30,
                      ),
                    )
                  ],
                ),
                15.verticalSpace,
                homeState.showLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : homeState.pexelPhotosModel != null
                        ? Expanded(
                            child: GridView.builder(
                              itemBuilder: (context, index) {
                                return PhotoCard(
                                  pexelPhotosModel:
                                      homeState.pexelPhotosModel!.photos[index],
                                );
                              },
                              itemCount:
                                  homeState.pexelPhotosModel!.photos.length,
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
