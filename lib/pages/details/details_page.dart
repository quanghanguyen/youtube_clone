import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:share_plus/share_plus.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:youtube_app/components/play_items.dart';
import 'package:youtube_app/components/video_items.dart';
import 'package:youtube_app/models/popular_video/item_video.dart';
import 'package:youtube_app/pages/details/detail_bloc.dart';
import 'package:youtube_app/pages/details/details_event.dart';
import 'package:youtube_app/pages/details/details_state.dart';
import 'package:youtube_app/pages/home_event.dart';
import 'package:youtube_app/pages/youtube_play/video_bloc.dart';
import 'package:youtube_app/pages/youtube_play/video_state.dart';
import 'package:youtube_app/theme/colors.dart';
import 'package:youtube_app/utils/extensions.dart';

class DetailsPage extends StatefulWidget {
  final Items video;
  Widget? parent;
  DetailsPage({super.key, required this.video, this.parent});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    // add listener scroll_view
    controller.addListener(() {
      if (controller.position.atEdge && controller.position.pixels != 0) {
        context.read<DetailsBloc>().add(const LoadMoreVideoEvent());
      }
    });
    // Load more
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(children: [
          Container(
              color: Colors.blue,
              height: 280.0,
              width: MediaQuery.of(context).size.width,
              child: BlocProvider(
                create: (context) => VideoBloc(),
                child: VideoPlayer(video: widget.video),
              )),
          Expanded(
            child: SizedBox(
              child: BlocBuilder<DetailsBloc, DetailState>(
                  builder: (context, state) {
                if (state is VideoRelativeStateLoading && state.isFirstFetch) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                List<Items> videos = [];
                bool isLoading = false;
                if (state is VideoRelativeStateLoading) {
                  isLoading = true;
                  videos = state.oldVideo;
                } else if (state is VideoRelativeStateLoadFinished) {
                  videos = state.videos;
                }

                return SizedBox(
                  height: MediaQuery.of(context).size.height - 280.0,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                      controller: controller,
                      itemCount: videos.length,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return Column(
                            children: [
                              const SizedBox(height: 12),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        child: Text(
                                          widget.video.snippet!.title!,
                                          // "How to Fix Discoloration in Product Photos with Photoshop",
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'Roboto',
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5.0),
                                      child: SvgPicture.asset(
                                          "assets/icons/drop_down.svg"),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: RichText(
                                        text: TextSpan(
                                            style: const TextStyle(
                                                color: AppColors.greyText,
                                                fontFamily: 'Roboto'),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text:
                                                      "${(widget.video.statistics == null ? '0' : widget.video.statistics!.viewCount!).transformViews()} . ${(widget.video.snippet!.publishedAt)?.transformDate()}",
                                                  style: const TextStyle(
                                                      color: AppColors.greyText,
                                                      fontFamily: 'Roboto')),
                                              TextSpan(
                                                  text:
                                                      " #${widget.video.snippet!.tags![0]} #${widget.video.snippet!.tags![1]} #${widget.video.snippet!.tags![3]}",
                                                  style: const TextStyle(
                                                      color: Colors.blue,
                                                      fontFamily: 'Roboto'))
                                            ]),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 30.0),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          SvgPicture.asset(
                                              'assets/icons/like.svg'),
                                          const SizedBox(height: 5),
                                          Text(
                                              (widget.video.statistics!
                                                      .likeCount!)
                                                  .transformViews(),
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: 'Roboto'))
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          SvgPicture.asset(
                                              'assets/icons/dis_like.svg'),
                                          const SizedBox(height: 5),
                                          const Text("65",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: 'Roboto'))
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          InkWell(
                                            onTap: () async {
                                              await Share.share(
                                                  "https://www.youtube.com/watch?v=${(widget.video.id)}",
                                                  subject:
                                                      'Share this video to Facebook');
                                            },
                                            child: SvgPicture.asset(
                                                'assets/icons/share.svg'),
                                          ),
                                          const SizedBox(height: 5),
                                          const Text("Share",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: 'Roboto'))
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          SvgPicture.asset(
                                              'assets/icons/download.svg'),
                                          const SizedBox(height: 5),
                                          const Text("Download",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: 'Roboto'))
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          SvgPicture.asset(
                                              'assets/icons/save.svg'),
                                          const SizedBox(height: 5),
                                          const Text("Save",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: 'Roboto'))
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Divider(
                                thickness: 1,
                                color: AppColors.greyLine,
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0,
                                      bottom: 8.0,
                                      left: 16.0,
                                      right: 16.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image: NetworkImage(widget
                                                        .video
                                                        .snippet!
                                                        .thumbnails!
                                                        .medium!
                                                        .url ??
                                                    ''),
                                                fit: BoxFit.cover)),
                                      ),
                                      const SizedBox(
                                        width: 18.0,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ConstrainedBox(
                                            constraints: const BoxConstraints(
                                                minWidth: 10, maxWidth: 100),
                                            child: Text(
                                              maxLines: 1,
                                              widget
                                                  .video.snippet!.channelTitle!,
                                              style: const TextStyle(
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          const Text(
                                            "289K subsciber",
                                            style: TextStyle(
                                                fontSize: 14.0,
                                                color: AppColors.greyText),
                                          )
                                        ],
                                      ),
                                      const Spacer(),
                                      Column(
                                        children: const [
                                          SizedBox(
                                            height: 12.0,
                                          ),
                                          Text(
                                            "SUBSCRIBE",
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 15.0,
                                      )
                                    ],
                                  )),
                              const Divider(
                                thickness: 1,
                                color: AppColors.greyLine,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0,
                                    bottom: 8.0,
                                    left: 16.0,
                                    right: 16.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        const Text(
                                          "Comments",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15.0),
                                        ),
                                        const SizedBox(
                                          width: 5.0,
                                        ),
                                        Text(
                                          widget.video.statistics!.commentCount!
                                              .transformViews(),
                                          style: const TextStyle(
                                              color: AppColors.greyText,
                                              fontSize: 15.0),
                                        ),
                                        const Spacer(),
                                        SvgPicture.asset(
                                            'assets/icons/expand.svg')
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Image.asset(
                                            'assets/images/person_avatar.png'),
                                        const SizedBox(width: 10),
                                        const Expanded(
                                          child: Text(
                                            "All in one place. Get it now for less than month. The global insight you need to understand every angle.",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12.0),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          );
                        }
                        if (index < videos.length) {
                          return InkWell(
                            onTap: () {
                              showGeneralDialog(
                                context: context,
                                barrierDismissible: false,
                                barrierColor: Colors.black.withOpacity(0.5),
                                transitionDuration:
                                    const Duration(milliseconds: 0),
                                pageBuilder: (context, anim1, anim2) {
                                  return BlocProvider(
                                    create: (_) => DetailsBloc()
                                      ..add(LoadRelativeVideoEvent(
                                          videos[index].id!)),
                                    child: DetailsPage(video: videos[index]),
                                  );
                                },
                                transitionBuilder:
                                    (context, anim1, anim2, child) {
                                  return SlideTransition(
                                    position: Tween(
                                            begin: const Offset(0, 1),
                                            end: const Offset(0, 0))
                                        .animate(anim1),
                                    child: child,
                                  );
                                },
                              );
                            },
                            child: VideoItem(video: videos[index]),
                          );
                        } else {
                          controller
                              .jumpTo(controller.position.maxScrollExtent);
                          return SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 100,
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                      }),
                );
              }),
            ),
          )
        ]),
      ),
    );
  }
}
