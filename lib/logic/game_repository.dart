import 'package:tic_tac_game/logic/models.dart';
import 'game_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class GameRepository {
  Future<GameModel> provideGameModel();

  Future<Level> getLevel();

  Future<void> setLevel(Level level);

  Future<WhosTurnBeFirst> whosTurnBeFirst();

  Future<void> setWhosTurnBeFirst(WhosTurnBeFirst who);

  Future<GameType> gameType();

  Future<void> setGameType(GameType type);

  Future<bool> isGameWithComp();

  Future<void> setGameWithComp(bool value);
}

class GameRepositoryImpl extends GameRepository {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  Future<GameModel> provideGameModel() async {
    Level level = await getLevel();
    WhosTurnBeFirst who = await whosTurnBeFirst();
    GameType type = await gameType();
    bool gameWithComp = await isGameWithComp();
    return GameModel(level, who, type, gameWithComp);
  }

  @override
  Future<Level> getLevel() async {
    final SharedPreferences prefs = await _prefs;
    String type = prefs.getString("game_level") ?? "easy";
    Level result;
    if (type == "middle") {
      result = Level.middle;
    } else if (type == "hard") {
      result = Level.hard;
    } else {
      result = Level.easy;
    }
    return result;
  }

  @override
  Future<void> setLevel(Level level) async {
    final SharedPreferences prefs = await _prefs;
    String t;
    if (level == Level.easy) {
      t = "easy";
    } else if (level == Level.middle) {
      t = "middle";
    } else {
      t = "hard";
    }
    prefs.setString("game_level", t);
  }

  @override
  Future<WhosTurnBeFirst> whosTurnBeFirst() async {
    final SharedPreferences prefs = await _prefs;
    String type = prefs.getString("game_who_first") ?? "me";
    WhosTurnBeFirst result;
    if (type == "me") {
      result = WhosTurnBeFirst.me;
    } else if (type == "opponent") {
      result = WhosTurnBeFirst.opponent;
    } else if (type == "alternately") {
      result = WhosTurnBeFirst.alternately;
    } else {
      result = WhosTurnBeFirst.me;
    }
    return result;
  }

  @override
  Future<void> setWhosTurnBeFirst(WhosTurnBeFirst who) async {
    final SharedPreferences prefs = await _prefs;
    String t;
    if (who == WhosTurnBeFirst.me) {
      t = "me";
    } else if (who == WhosTurnBeFirst.opponent) {
      t = "opponent";
    } else if (who == WhosTurnBeFirst.alternately) {
      t = "alternately";
    } else {
      t = "me";
    }
    prefs.setString("game_who_first", t);
  }

  @override
  Future<GameType> gameType() async {
    final SharedPreferences prefs = await _prefs;
    String type = prefs.getString("game_type") ?? "g_3_3_3";
    GameType result;
    if (type == "g_3_3_3") {
      result = GameType.g_3_3_3;
    } else if (type == "g_4_4_3") {
      result = GameType.g_4_4_3;
    } else if (type == "g_5_5_3") {
      result = GameType.g_5_5_3;
    } else if (type == "g_5_5_4") {
      result = GameType.g_5_5_4;
    } else if (type == "g_5_5_5") {
      result = GameType.g_5_5_5;
    } else if (type == "g_6_6_4") {
      result = GameType.g_6_6_4;
    } else {
      result = GameType.g_3_3_3;
    }
    return result;
  }

  @override
  Future<void> setGameType(GameType type) async {
    final SharedPreferences prefs = await _prefs;
    String t;
    if (type == GameType.g_3_3_3) {
      t = "g_3_3_3";
    } else if (type == GameType.g_4_4_3) {
      t = "g_4_4_3";
    } else if (type == GameType.g_5_5_3) {
      t = "g_5_5_3";
    } else if (type == GameType.g_5_5_4) {
      t = "g_5_5_4";
    } else if (type == GameType.g_5_5_5) {
      t = "g_5_5_5";
    } else {
      t = "g_6_6_4";
    }
    prefs.setString("game_type", t);
  }

  @override
  Future<bool> isGameWithComp() async {
    final SharedPreferences prefs = await _prefs;
    bool type = prefs.getBool("game_with_comp") ?? true;
    return type;
  }

  @override
  Future<void> setGameWithComp(bool value) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setBool("game_with_comp", value);
  }
}
