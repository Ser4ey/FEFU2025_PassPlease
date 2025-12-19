package passplease.game;

/**
 * Представляет идентификационный пропуск студента.
 * Содержит личную информацию и логику валидации.
 */
class Pass {
	public var gender:String = ["Male", "Female"][Std.random(2)];
	public var dorm:String = Generator.getDorm();
	public var faculty:String = Generator.getFaculty();
	public var fullName:Map<String, String>;
	public var idCardColor:String;
	public var passId:String;

	/** Генерирует новый пропуск со случайными данными, основанными на правилах для пола. */
	public function new() {
		fullName = Generator.getFullName(gender);
		idCardColor = Generator.getIdCardColor(gender);
		passId = Generator.generatePassId(fullName);
	}

	/**
	 * Проверяет пропуск на соответствие правилам игры.
	 * 
	 * Проверяет:
	 * - Номер общежития (должен совпадать с текущим общежитием).
	 * - Существование факультета.
	 * - Соответствие цвета ID-карты полу.
	 * - Формат ID пропуска и его корреляцию с именем.
	 * 
	 * @return `true`, если все критерии валидации соблюдены.
	 */
	public function isValid() {
		// dorm, faculty, idCardColor, passId
		function checkPassId(passId:String):Bool {
			var part1 = Std.parseInt(passId.substr(0, 3));
			var part2 = passId.substr(3, passId.length - 3);
			var part2FromFullName = '${fullName['surname'].toUpperCase()}${fullName['name'].toUpperCase().substr(0, 1)}${fullName['patronymics'].toUpperCase().substr(0, 2)}';
			if (!((100 <= part1) && (part1 < 1000)))
				return false;
			if (part2 != part2FromFullName)
				return false;
			return true;
		}

		if (dorm != Game.currentDorm)
			return false;
		if (![for (k in Generator.facultyCodes.keys()) k].contains(faculty))
			return false;
		switch [idCardColor, gender] {
			case ["blue", "Female"]:
				return false;
			case ["pink", "Male"]:
				return false;
			default:
		}

		return checkPassId(passId);
	}
}
