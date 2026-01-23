package passplease.game;

/**
 * Представляет рюкзак студента, содержащий предметы.
 * Отвечает за проверку переносимых предметов на наличие запрещенных веществ.
 */
class Backpack {
	/** Список предметов, находящихся в данный момент в рюкзаке. */
	public var items:Array<String>;

	/** Создает новый рюкзак со случайно сгенерированными предметами. */
	public function new() {
		items = Generator.generateItems();
	}

	/**
	 * Проверяет, содержит ли рюкзак какие-либо запрещенные предметы.
	 * 
	 * @return `true`, если запрещенных предметов нет, иначе `false`.
	 */
	public function isLegal() {
		for (backpackItem in this.items)
			if (Generator.bannedItems.contains(backpackItem))
				return false;
		return true;
	}
}
