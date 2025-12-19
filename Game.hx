package passplease;

import kha.Storage;
import se.App;
import se.FSM;
import passplease.ui.UI;

#if !macro
@:build(se.macro.SMacro.build())
#end
/**
 * Точка входа и менеджер конечного автомата (FSM) игры.
 * Управляет переходами между состояниями (Меню -> Игра -> Статистика), глобальными данными игры и сохранением.
 */
class Game {
	static var file = Storage.namedFile("stats");

	public static var currentDorm = "6.2";

	public static var fsm:FSM;
	public static var backStates:Map<State, Void->State>;

	// Определения состояний
	public static var startState = new State();
	public static var statsState = new State();
	public static var badgeUpgradeState = new State();
	public static var settingsState = new State();
	public static var exitState = new State();

	public static var newGameState = new State();
	public static var gameState = new State();
	public static var gameMenuState = new State();
	public static var finishGameState = new State();

	/** Глобальная статистика игры (сохраняемые данные). */
	public static var stats:Stats;

	/**
	 * Инициализирует игру, загружает статистику и настраивает переходы FSM.
	 * Вызывается при запуске приложения.
	 */
	public static function init() {
		stats = file.readObject() ?? {
			days: 0,
			badge: 0,
			score: 0,
			verifiedCount: 0,
			mistakesCount: 0
		}

		stats.badge = 12;
		stats.days = 14;
		stats.score = 640;
		stats.mistakesCount = 49;
		stats.verifiedCount = 656;

		startState.transitions = [
			newGameState => () -> {
				stats = {
					days: 0,
					badge: 0,
					score: 0,
					verifiedCount: 0,
					mistakesCount: 0
				};
				fsm.goto(gameState);
			},
			gameState => () -> {
				if (stats.badge < 20)
					startGame();
			},
			statsState => () -> {
				UI.statsMenu.labels.get("Days").text = Std.string(Game.stats.days);
				UI.statsMenu.labels.get("Badge Level").text = Std.string(Game.stats.badge);
				UI.statsMenu.labels.get("Score").text = Std.string(Game.stats.score);
				UI.statsMenu.labels.get("Verified").text = Std.string(Game.stats.verifiedCount);
				UI.statsMenu.labels.get("Mistakes").text = Std.string(Game.stats.mistakesCount);
				UI.gameScene.setMenu(UI.statsMenu);
			},
			settingsState => () -> {
				UI.gameScene.setMenu(UI.settingsMenu);
			},
			exitState => () -> {
				file.writeObject(stats);
				App.exit();
			}
		];

		newGameState.transitions = [
			gameState => () -> {
				startGame();
			}
		];

		gameState.transitions = [
			gameMenuState => () -> {
				GameCycle.pause();
				UI.gameScene.setMenu(UI.gameMenu);
			},
			finishGameState => () -> {
				GameCycle.pause();
				Game.stats.days += 1;
				Game.stats.score += GameCycle.score;
				if (Game.stats.score < 0)
					Game.stats.score = 0;
				UI.gameScene.setMenu(UI.finishGameMenu);
				UI.finishGameMenu.textWidget.text = 'Day: ${Game.stats.days}. Score: ${GameCycle.score}';
			}
		];

		gameMenuState.transitions = [
			gameState => () -> {
				GameCycle.resume();
				UI.gameScene.setMenu(null);
			},
			settingsState => () -> {
				UI.gameScene.setMenu(UI.settingsMenu);
			},
			startState => () -> {
				exitGame();
			}
		];

		finishGameState.transitions = [
			startState => () -> {
				exitGame();
			},
			gameState => () -> {
				startGame();
			}
		];

		statsState.transitions = [
			startState => () -> {
				UI.gameScene.setMenu(UI.startMenu);
			},
			badgeUpgradeState => () -> {
				UI.gameScene.setMenu(UI.badgeUpgradeMenu);
				UI.badgeUpgradeMenu.reload();
			}
		];

		badgeUpgradeState.transitions = [
			statsState => () -> {
				UI.statsMenu.labels.get("Days").text = Std.string(Game.stats.days);
				UI.statsMenu.labels.get("Badge Level").text = Std.string(Game.stats.badge);
				UI.statsMenu.labels.get("Score").text = Std.string(Game.stats.score);
				UI.statsMenu.labels.get("Verified").text = Std.string(Game.stats.verifiedCount);
				UI.statsMenu.labels.get("Mistakes").text = Std.string(Game.stats.mistakesCount);
				UI.gameScene.setMenu(UI.statsMenu);
			}
		];

		settingsState.transitions = [
			startState => () -> {
				UI.gameScene.setMenu(UI.startMenu);
			},
			gameMenuState => () -> {
				UI.gameScene.setMenu(UI.gameMenu);
			},
		];

		backStates = [
			Game.startState => () -> null,
			Game.statsState => () -> Game.startState,
			Game.badgeUpgradeState => () -> Game.statsState,
			Game.settingsState => () -> {
				if (UI.gameScene.active)
					Game.startState;
				else
					Game.gameMenuState;
			},
			Game.gameState => () -> Game.gameMenuState,
			Game.gameMenuState => () -> Game.gameState
		];

		fsm = new FSM(startState);
	}

	/** Переходит к предыдущему состоянию, определенному в `backStates`. */
	public static function back() {
		Game.fsm.goto(Game.backStates.get(Game.fsm.state)());
	}

	/**
	 * Проигрывает финальную кат-сцену.
	 * Запускается при выполнении определенных игровых условий (например, завершение игры).
	 */
	public static function playFinalScene() {
		UI.splashScreen.open();
		UI.heartImage.visible = true;
		UI.gratzSound.play();
		stats = {
			days: 0,
			badge: 0,
			score: 0,
			verifiedCount: 0,
			mistakesCount: 0
		};
		back();
		se.Timer.set(() -> {
			UI.splashScreen.close().onCompleted(() -> UI.heartImage.visible = false);
		}, 5.0);
	}

	static function startGame() {
		UI.splashScreen.open();
		UI.gameScene.setMenu(null);
		UI.gameScene.flashLight.power = 10.0;
		UI.gameScene.addChild(UI.gameScene.ui);
		UI.gameScene.ui.dayLabel.text = 'Day: ${Game.stats.days + 1}';
		UI.gameScene.ui.badgeWidget.setBadgeLevel(Game.stats.badge);
		GameCycle.start();
		UI.splashScreen.close();
	}

	static function exitGame() {
		GameCycle.stop();
		UI.splashScreen.open();
		UI.gameScene.flashLight.power = 0.0;
		UI.gameScene.moveStudent(() -> {});
		UI.gameScene.removeChild(UI.gameScene.ui);
		UI.gameScene.setMenu(UI.startMenu);
		UI.splashScreen.close();
	}
}

/** Структура, хранящая сохраняемую статистику игрока. */
private typedef Stats = {
	var days:Int;
	var badge:Int;
	var score:Int;
	var verifiedCount:Int;
	var mistakesCount:Int;
}
