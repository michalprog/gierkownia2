import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gierkownia2/33_section/window_widgets/game_33_page.dart';
import 'package:gierkownia2/33_section/window_widgets/game_33_view.dart';
import 'package:gierkownia2/33_section/window_widgets/main_33_view.dart';
import 'package:gierkownia2/33_section/window_widgets/settings_33_view.dart';
import 'package:gierkownia2/main_section/window_widgets/main_view.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const MainView(),
      ),
      ShellRoute(
        builder: (BuildContext context, GoRouterState state, Widget child) {
          return Game33Page(child: child);
        },
        routes: [
          GoRoute(
            path: '/33',
            name: 'main-33',
            builder: (context, state) => const Main33View(),
            routes: [
              GoRoute(
                path: 'game',
                name: 'game-33',
                builder: (context, state) => const Game33View(),
              ),
              GoRoute(
                path: 'settings',
                name: 'settings-33',
                builder: (context, state) => const Settings33View(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});