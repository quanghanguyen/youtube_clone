import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:youtube_app/models/popular_video/item_video.dart';
import 'package:youtube_app/theme/colors.dart';
import 'package:youtube_app/utils/extensions.dart';
import '/utils/constants.dart';

class VideoItem extends StatefulWidget {
  final Items video;
  const VideoItem({super.key, required this.video});

  @override
  State<VideoItem> createState() => _VideoItemState();
}

class _VideoItemState extends State<VideoItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(children: [
        SizedBox(
          height: 220,
          width: double.infinity,
          child: Image.network(
            widget.video.snippet!.thumbnails!.standard!.url ?? '',
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(
                  widget.video.snippet!.thumbnails!.medium!.url ?? ''),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.video.snippet!.title!,
                    style: const TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    softWrap: true,
                  ),
                  const SizedBox(height: 5.0),
                  Row(
                    children: [
                      ConstrainedBox(
                        constraints: const BoxConstraints(minWidth: 10, maxWidth: 100),
                        child: Text(
                          maxLines: 1,
                          widget.video.snippet!.channelTitle!,
                          style: const TextStyle(
                            color: AppColors.greyText,
                            fontSize: 12,
                            fontFamily: 'Roboto',
                          ),                        
                        ),
                      ),
                      const SizedBox(width: 2),
                      const Text(".",
                          style: TextStyle(
                              color: AppColors.greyText,
                              fontSize: 12,
                              fontFamily: 'Roboto')),
                      const SizedBox(width: 2),
                      Text(
                        "${(widget.video.statistics == null ? '0' : widget.video.statistics!.viewCount!).transformViews()} views",
                        style: const TextStyle(
                            color: AppColors.greyText,
                            fontSize: 12,
                            fontFamily: 'Roboto'),
                      ),
                      const SizedBox(width: 2),
                      const Text(".",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: AppColors.greyText,
                              fontSize: 12,
                              fontFamily: 'Roboto')),
                      const SizedBox(width: 2),
                      Text(widget.video.snippet!.publishedAt!.transformDate(),
                          style: const TextStyle(
                              color: AppColors.greyText,
                              fontSize: 12,
                              fontFamily: 'Roboto')),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(width: 10),
            InkWell(
                onTap: () {}, child: Image.asset('assets/images/more_icon.png'))
          ]),
        )
      ]),
    );
  }
}
