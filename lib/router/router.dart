import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gierkownia2/33_section/window_widgets/game_33_page.dart';
import 'package:gierkownia2/33_section/window_widgets/game_33_view.dart';
import 'package:gierkownia2/33_section/window_widgets/main_33_view.dart';
import 'package:gierkownia2/33_section/window_widgets/result_33_view.dart';
import 'package:gierkownia2/33_section/window_widgets/settings_33_view.dart';
import 'package:gierkownia2/33_section/models/game_33_result.dart';
import 'package:gierkownia2/main_section/window_widgets/main_view.dart';
import 'package:gierkownia2/tictactoe_section/models/game_ttt_result.dart';
import 'package:gierkownia2/tictactoe_section/window_widgets/ttt_game_view.dart';
import 'package:gierkownia2/tictactoe_section/window_widgets/ttt_main_view.dart';
import 'package:gierkownia2/tictactoe_section/window_widgets/ttt_result_view.dart';
import 'package:gierkownia2/tictactoe_section/window_widgets/ttt_page_view.dart';
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
                builder: (context, state) => Game33View(
                  isBotGame: state.uri.queryParameters['mode'] == 'bot',
                ),
              ),
              GoRoute(
                path: 'settings',
                name: 'settings-33',
                builder: (context, state) => const Settings33View(),
              ),
              GoRoute(
                path: 'result',
                name: 'result-33',
                builder: (context, state) {
                  final result = state.extra;
                  if (result is! Game33Result) {
                    return const Main33View();
                  }
                  return Result33View(currentResult: result);
                },
              ),
            ],
          ),
        ],
      ),
      ShellRoute(
        builder: (BuildContext context, GoRouterState state, Widget child) {
          return TttPageView(child: child);
        },
        routes: [
          GoRoute(
            path: '/ttt',
            name: 'ttt-main',
            builder: (context, state) => const TttMainView(),
            routes: [
              GoRoute(
                path: 'game',
                name: 'ttt-game',
                builder: (context, state) => TttGameView(
                  isBotGame: state.uri.queryParameters['mode'] == 'bot',
                ),
              ),
              GoRoute(
                path: 'result',
                name: 'ttt-result',
                builder: (context, state) {
                  final result = state.extra;
                  if (result is! GameTttResult) {
                    return const TttMainView();
                  }
                  return TttResultView(currentResult: result);
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );
});