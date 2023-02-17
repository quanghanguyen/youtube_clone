import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:youtube_app/components/video_items.dart';
import 'package:youtube_app/pages/details/detail_bloc.dart';
import 'package:youtube_app/pages/details/details_event.dart';
import 'package:youtube_app/pages/details/details_page.dart';
import 'package:youtube_app/pages/home_bloc.dart';
import 'package:youtube_app/pages/home_event.dart';
import 'package:youtube_app/pages/home_state.dart';
import 'package:youtube_app/theme/colors.dart';
import '../models/popular_video/item_video.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  List<String> list = ["All", "Mixed", "Music", "Movies", "Iphone"];
  String nextPageToken = '';
  late ScrollController controller = ScrollController();
  late DraggableScrollableController draggableScrollableController =
      DraggableScrollableController();
  late TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (!controller.hasListeners) {
      controller.addListener(() {
        if (controller.position.atEdge && controller.position.pixels != 0) {
          context.read<HomeBloc>().add(const LoadMoreEvent());
        }
      });
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  InkWell(
                      onTap: () {},
                      child: Image.asset('assets/images/youtube.png',
                          fit: BoxFit.fill, width: 100)),
                  const Spacer(),
                  Image.asset(
                    'assets/images/tv.png',
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  Image.asset('assets/images/notify.png'),
                  const SizedBox(
                    width: 15.0,
                  ),
                  InkWell(
                      onTap: (() {
                        if (search.text.isNotEmpty) {
                          context
                              .read<HomeBloc>()
                              .add(SearchEvent(search.text));
                          FocusScope.of(context).unfocus();
                        }
                      }),
                      child: Image.asset('assets/images/search.png')),
                  const SizedBox(
                    width: 15.0,
                  ),
                  Image.asset('assets/images/avatar.png'),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Divider(
                thickness: 1,
                color: AppColors.greyLine,
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(children: [
                    Container(
                      width: 100,
                      height: 36,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: AppColors.greyBox,
                          borderRadius: BorderRadius.circular(6)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/navigate.png"),
                          const SizedBox(width: 10.0),
                          const Text(
                            "Explore",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.0),
                      child: SizedBox(
                        height: 25,
                        child: VerticalDivider(
                          color: AppColors.greyLine,
                          thickness: 1,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ...List.generate(
                        5,
                        (index) => Container(
                              margin: const EdgeInsets.only(right: 5),
                              child: Container(
                                height: 36,
                                padding:
                                    const EdgeInsets.only(left: 12, right: 12),
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: AppColors.greyLine),
                                    borderRadius: BorderRadius.circular(18),
                                    color: index == 0
                                        ? AppColors.greyCheck
                                        : AppColors.greyBox),
                                child: Center(
                                  child: Text(
                                    list[index],
                                    style: TextStyle(
                                        color: index == 0
                                            ? Colors.white
                                            : Colors.black),
                                  ),
                                ),
                              ),
                            ))
                  ]),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is VideoStateLoading && state.isFirstFetch) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                List<Items> videos = [];
                bool isLoading = false;
                if (state is VideoStateLoading) {
                  isLoading = true;
                  videos = state.oldVideos;
                } else if (state is VideoStateLoadFinished) {
                  videos = state.videos;
                }
                return ListView.builder(
                    controller: controller,
                    itemCount: videos.length,
                    itemBuilder: (context, index) => InkWell(
                          onTap: (() {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => BlocProvider(
                                          create: (_) => DetailsBloc()
                                            ..add(LoadRelativeVideoEvent(
                                                videos[index].id!)),
                                          child:
                                              DetailsPage(video: videos[index]),
                                        )));
                          }),
                          child: VideoItem(
                            video: videos[index],
                          ),
                        ));
              },
            ))
          ],
        ),
      ),
    );
  }
}
