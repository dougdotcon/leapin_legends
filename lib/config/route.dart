import 'package:flappy_game/features/game/presentation/view/game_view.dart';
import 'package:flappy_game/features/game/presentation/view/leaderboard_view.dart';
import 'package:flutter/cupertino.dart';

import '../features/menu/presentation/views/menu_view.dart';

const String gameView = '/game';
const String leaderboardView = '/leaderboard';
const String menuView = '/';

Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case gameView:
      return CupertinoPageRoute(builder: (_) => const GameView(), settings: settings);
    case menuView:
      return CupertinoPageRoute(builder: (_) => const MenuView(), settings: settings);
    case leaderboardView:
      return CupertinoPageRoute(builder: (_) => const LeaderboardView(), settings: settings);
    default:
      throw ('Route does not exist');
  }
}
