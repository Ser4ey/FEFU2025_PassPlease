package passplease.game;

/**
 * Представляет сущность студента в игре.
 * Объединяет пропуск и рюкзак.
 */
class Person {
	/** Идентификационный пропуск студента. */
	public var pass:Pass;
	/** Рюкзак студента с предметами. */
	public var backpack:Backpack;
	/** Список конкретных ошибок, найденных у этого человека (опциональное отслеживание). */
	public var mistakes:Array<String> = [];

	/** Создает нового студента со сгенерированным пропуском и рюкзаком. */
	public function new() {
		pass = new Pass();
		backpack = new Backpack();
	}
}
