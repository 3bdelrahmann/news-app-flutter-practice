import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/search/search_screen.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state) {
          var cubit = AppCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              title: const Text('News App'),
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.search,
                  ),
                  onPressed: () {
                    navigateTo(context, SearchScreen());
                  },
                ),
                IconButton(
                  icon: Icon(
                    cubit.isDark
                        ? Icons.nightlight_round_outlined
                        : Icons.wb_sunny_outlined,
                  ),
                  onPressed: () {
                    cubit.changeMode();
                  },
                ),
              ],
            ),
            body: cubit.screens[cubit.index],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.index,
              items: cubit.botNavBarItems,
              onTap: (index) {
                cubit.changeBottomNav(index);
              },
            ),
          );
        });
  }
}
