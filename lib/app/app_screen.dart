import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:youtube_app/pages/home_bloc.dart';
import 'package:youtube_app/pages/home_event.dart';
import 'package:youtube_app/pages/home_pages.dart';

class AppPage extends StatefulWidget {
  const AppPage({super.key});

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  final pageController = PageController();
  final ValueNotifier<double> playerExpandProgress = ValueNotifier(40);
  bool selectVideo = true;
  late int currentTab;
  final page = [
    // Bloc Provider để UI thông báo cho Bloc
    // Bloc sẽ emit state tương ứng với event và UI gửi
    BlocProvider(
        create: (_) => HomeBloc()..add(LoadVideoEvent()), child: HomePage()),
    Container(),
    Container(),
    Container(),
    Container(),
  ];

  @override
  void initState() {
    currentTab = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      PageView(
      /// [PageView.scrollDirection] defaults to [Axis.horizontal].
      /// Use [Axis.vertical] to scroll vertically.
      controller: pageController,
      children: <Widget>[
        ...page
      ],
    ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentTab,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        selectedLabelStyle: const TextStyle(fontFamily: 'Roboto'),
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/icons/home_icon.svg"),
            label: "Home",
          ),
          BottomNavigationBarItem(
                icon: SvgPicture.asset("assets/icons/short_icon.svg"),
                label: "Short",
                backgroundColor: Colors.black),
            BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/icons/create_icon.svg"),
              label: "",
              //backgroundColor: Colors.black
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/icons/subscription_icon.svg"),
              label: "Subscription",
              //backgroundColor: Colors.black
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/icons/library_icon.svg"),
              label: "Library",
              //backgroundColor: Colors.black
            ),
        ],
      ),
    );
  }
}
