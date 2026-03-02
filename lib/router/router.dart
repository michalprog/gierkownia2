import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gierkownia2/33_section/window_widgets/main_33_view.dart';
import 'package:gierkownia2/main_section/window_widgets/main_view.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'main',
        builder: (context, state) => const MainView(),
      ),
      GoRoute(
        path: '/33/',
        name: 'main',
        builder: (context, state) => const Main33View(),
      ),
    ],
  );
});