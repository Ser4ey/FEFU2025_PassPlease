package passplease;

import se.Timer;
import se.math.SMath;
import passplease.ui.UI;
import passplease.game.Person;

/**
 * Управляет основным игровым циклом, течением времени и очередью студентов.
 * Отвечает за симуляцию "рабочего дня", включая временные лимиты и появление студентов.
 */
class GameCycle {
	static var timer:Timer;

	static var startTime:Int;
	static var timeFormatted(get, never):String;
	static var stamps:Array<Int>;

	static var currentStudent(default, set):Person;

	@:isVar public static var time(default, set):Int;
	public static var students:Array<Person>;
	public static var mistakes:Array<Person>;

	public static var score:Int;

	/**
	 * Запускает игровой уровень.
	 * Инициализирует таймер, расписание генерации студентов и синхронизацию UI.
	 */
	public static function start() {
		initLevel();
		syncUI();

		timer = new Timer(tick, 0.2);
		timer.loop();
		se.App.input.keyboard.onKeyDown(H, () -> {
			if (currentStudent != null)
				UI.gameScene.ui.studentContainer.visible = !UI.gameScene.ui.studentContainer.visible;
		});
	}

	/** Возобновляет игровой таймер. */
	public static function resume() {
		timer.loop();
	}

	/** Приостанавливает игровой таймер. */
	public static function pause() {
		timer.stop();
	}

	/** Полностью останавливает игру и сбрасывает время. */
	public static function stop() {
		timer.stop();
		timer = null;
		time = 0;
	}

	/**
	 * Обрабатывает решение, принятое по текущему студенту.
	 * Обновляет счет и счетчики ошибок в зависимости от правильности решения.
	 * Переходит в состояние завершения, если все студенты обработаны.
	 * 
	 * @param isValid Решение игрока: `true` (разрешить), `false` (отказать).
	 */
	public static function processPerson(isValid:Bool) {
		var student = students.shift();
		var studentIsValid = student.pass.isValid() && (Game.stats.badge > 10 ? student.backpack.isValid() : true);
		if (studentIsValid != isValid) {
			score -= 10 + Game.stats.badge;
			mistakes.push(student);
		} else
			score += 10;
		syncUI();

		if (students.length > 0)
			currentStudent = students[0];
		else
			currentStudent = null;

		if (stamps.length + students.length == 0)
			Game.fsm.goto(Game.finishGameState);
	}

	/**
	 * Инициализирует параметры уровня.
	 * Генерирует расписание прибытия студентов на основе нормального распределения.
	 */
	static function initLevel() {
		UI.gameScene.ui.backpackWidget.visible = Game.stats.badge > 10;

		static final sigma = 360;
		static final period = 20;

		score = 0;
		students = [];
		mistakes = [];

		startTime = 720 * (Game.stats.badge % 2);
		time = startTime;
		final mu = time + 360;
		final min = Std.int(720 / period);

		stamps = [
			for (i in 0...min)
				time + i * period
		];
		while (stamps.length < min + Game.stats.badge * 10) {
			var u1 = Math.random();
			var u2 = Math.random();
			var z = Math.sqrt(-2 * Math.log(u1)) * Math.cos(2 * Math.PI * u2);
			var t = Std.int(mu + z * sigma);
			if (t >= time && t < time + 720)
				stamps.push(t);
		}
		stamps.sort((a, b) -> a - b);
	}

	/**
	 * Основной обработчик тика таймера.
	 * Продлевает время и создает студентов, когда наступает их запланированное время.
	 */
	static function tick() {
		++time;

		if (time >= startTime + 720)
			Game.fsm.goto(Game.finishGameState);
		else if (time >= stamps[0]) {
			stamps.shift();
			students.push(new Person());
			if (students.length == 1)
				currentStudent = students[0];
		}

		syncUI();
	}

	static function syncUI() {
		UI.gameScene.ui.timeLabel.text = timeFormatted;
		UI.gameScene.ui.studentsLabel.text = 'Students left: ${stamps.length + students.length}';
	}

	static function get_timeFormatted():String {
		var pad = (x:Int) -> x < 10 ? '0$x' : Std.string(x);
		return '${pad(Std.int(time / 60))}:${pad(time % 60)}';
	}

	static function set_currentStudent(value:Person) {
		var containerIsVisible = UI.gameScene.ui.studentContainer.visible;
		UI.gameScene.ui.studentContainer.visible = false;
		UI.gameScene.ui.permitButton.visible = false;
		UI.gameScene.ui.kickoutButton.visible = false;
		if (currentStudent != null) {
			UI.gameScene.moveStudent(() -> {
				if (currentStudent != null) {
					UI.gameScene.pushStudent(currentStudent, () -> {
						UI.gameScene.ui.passWidget.loadPass(currentStudent.pass);
						UI.gameScene.ui.backpackWidget.loadBackpack(currentStudent.backpack);
						UI.gameScene.ui.studentContainer.visible = containerIsVisible;
						UI.gameScene.ui.permitButton.visible = true;
						UI.gameScene.ui.kickoutButton.visible = true;
					});
				}
			});
		} else if (value != null) {
			UI.gameScene.pushStudent(value, () -> {
				UI.gameScene.ui.passWidget.loadPass(currentStudent.pass);
				UI.gameScene.ui.backpackWidget.loadBackpack(currentStudent.backpack);
				UI.gameScene.ui.studentContainer.visible = containerIsVisible;
				UI.gameScene.ui.permitButton.visible = true;
				UI.gameScene.ui.kickoutButton.visible = true;
			});
		}
		currentStudent = value;
		return currentStudent;
	}

	static function set_time(value:Int):Int {
		time = value;
		if (UI.gameScene != null) {
			var t = max(0, min(1, (time / 720)));
			UI.gameScene.envLight.color = mix(vec3(0.5, 0.5, 1.0), vec3(1.0, 1.0, 0.5), t);
		}
		return time;
	}
}
