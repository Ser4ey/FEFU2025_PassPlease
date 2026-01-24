package passplease.game;

/**
 * Утилитарный класс для процедурной генерации игровых данных.
 * Содержит базы данных имен, фамилий, факультетов и предметов.
 */
class Generator {
	public static var maleNames:Array<String> = [
		  "Vladimir",  "Grigoriy",     "Ruslan",    "Viktor",     "Ivan",
		    "Maksim",   "Dmitriy",      "Yegor",     "Yuriy",   "Nikita",
		     "Anton",    "Andrey",     "Artyom",     "Pavel",  "Mikhail",
		      "Igor",   "Vitaliy", "Konstantin",   "Georgiy",     "Oleg",
		    "Sergey", "Stanislav",    "Valeriy",   "Vasiliy",    "Boris",
		  "Yaroslav",   "Timofey",        "Lev", "Vladislav",  "Arkadiy",
		"Vyacheslav",  "Gennadiy",   "Anatoliy", "Aleksandr",   "Stepan",
		    "Zakhar",     "Roman",     "Kirill",    "Savely", "Veniamin",
		    "Fyodor",     "Pyotr",      "Ignat",    "Matvey",   "Elisey",
		      "Gleb",    "Daniil",     "Albert",    "Eduard",  "Prokhor"
	];

	public static var femaleNames:Array<String> = [
		    "Sofiya",     "Yelena", "Yekaterina",     "Raisa",   "Tatyana",
		"Anastasiya",       "Olga",   "Lyudmila",   "Natalya",     "Irina",
		     "Darya",     "Mariya",      "Alisa",   "Kseniya",    "Polina",
		  "Svetlana",     "Alyona",   "Veronika", "Viktoriya",  "Nadezhda",
		       "Eva",      "Zlata",     "Marina",    "Oksana",    "Larisa",
		     "Diana", "Yelizaveta",     "Yuliya",      "Anna", "Valentina",
		      "Vera",     "Galina",     "Lyubov",   "Taisiya",     "Agata",
		      "Yana",     "Karina",    "Adelina",  "Vasilisa",    "Zhanna",
		     "Alina",      "Arina",     "Milana",  "Snezhana", "Miroslava",
		      "Nika",  "Stefaniya",    "Amaliya",   "Varvara",    "Lidiya"
	];

	public static var maleSurnames:Array<String> = [
		    "Makarov",      "Karpov", "Kuznetsov",    "Sidorov",     "Orlov",
		    "Komarov",     "Belyaev",     "Popov",    "Novikov",   "Tarasov",
		    "Lebedev",     "Zaytsev",    "Petrov",    "Smirnov",   "Morozov",
		     "Ivanov",     "Yegorov",  "Fyodorov",    "Borisov",  "Vorobyov",
		   "Semyonov", "Aleksandrov",  "Vasilyev",    "Romanov", "Grigoryev",
		   "Solovyov",    "Gavrilov",  "Kiselyov",     "Volkov",   "Chernov",
		    "Kalinin",    "Melnikov",  "Nikolaev",   "Afanasev",   "Denisov",
		      "Bykov",     "Abramov",  "Polyakov", "Vinogradov",   "Ushakov",
		"Kozhevnikov",  "Kondratyev",  "Savelyev",     "Zhukov",  "Larionov",
		  "Shestakov",      "Sharov",   "Davydov",  "Yeremeyev",    "Shubin"
	];

	public static var femaleSurnames:Array<String> = [
		    "Lebedeva",   "Gavrilova",  "Novikova",    "Romanova", "Aleksandrova",
		     "Petrova",   "Kiselyeva", "Solovyova",    "Komarova",     "Belyaeva",
		      "Popova",     "Volkova",  "Tarasova",    "Yegorova",      "Karpova",
		   "Semyonova",    "Zaytseva", "Fyodorova",    "Borisova",   "Kuznetsova",
		     "Ivanova",    "Smirnova",  "Makarova",  "Grigoryeva",       "Orlova",
		   "Vasilyeva",    "Sidorova", "Vorobyova",    "Morozova",     "Chernova",
		    "Kalinina",   "Melnikova", "Nikolaeva",   "Afanaseva",     "Denisova",
		      "Bykova",    "Abramova", "Polyakova", "Vinogradova",     "Ushakova",
		"Kozhevnikova", "Kondratyeva", "Savelyeva",     "Zhukova",    "Larionova",
		  "Shestakova",     "Sharova",  "Davydova",  "Yeremeyeva",      "Shubina"
	];

	public static var malePatronymics:Array<String> = [
		 "Maksimovich",     "Kirillovich",   "Georgievich",      "Sergeevich",    "Viktorovich",
		   "Ivanovich",       "Pavlovich", "Vladimirovich",     "Ruslanovich",   "Alekseyevich",
		 "Andreyevich",     "Artyomovich",     "Olegovich",       "Yuryevich",   "Mikhailovich",
		 "Dmitrievich",      "Borisovich",  "Grigoryevich",     "Vasilyevich", "Stanislavovich",
		  "Yegorovich", "Konstantinovich",  "Timofeyevich",   "Yaroslavovich",    "Valeryevich",
		     "Lvovich",      "Antonovich",   "Vitalyevich",       "Igorevich",    "Fyodorovich",
		   "Petrovich",    "Anatolyevich",   "Arkadyevich", "Vyacheslavovich",   "Gennadyevich",
		 "Stepanovich",     "Zakharovich",    "Romanovich",     "Savelyevich",  "Veniaminovich",
		 "Eliseyevich",       "Glebovich",   "Daniilovich",     "Albertovich",    "Eduardovich",
		"Prokhorovich",     "Matveyevich",   "Ignatyevich",     "Afanasevich",     "Denisovich"
	];

	public static var femalePatronymics:Array<String> = [
		 "Maksimovna",     "Kirillovna",   "Georgievna",      "Sergeevna",    "Viktorovna",
		   "Ivanovna",       "Pavlovna", "Vladimirovna",     "Ruslanovna",   "Alekseyevna",
		 "Andreyevna",     "Artyomovna",     "Olegovna",       "Yuryevna",   "Mikhailovna",
		 "Dmitrievna",      "Borisovna",  "Grigoryevna",     "Vasilyevna", "Stanislavovna",
		  "Yegorovna", "Konstantinovna",  "Timofeyevna",   "Yaroslavovna",    "Valeryevna",
		     "Lvovna",      "Antonovna",   "Vitalyevna",       "Igorevna",    "Fyodorovna",
		   "Petrovna",    "Anatolyevna",   "Arkadyevna", "Vyacheslavovna",   "Gennadyevna",
		 "Stepanovna",     "Zakharovna",    "Romanovna",     "Savelyevna",  "Veniaminovna",
		 "Eliseyevna",       "Glebovna",   "Daniilovna",     "Albertovna",    "Eduardovna",
		"Prokhorovna",     "Matveyevna",   "Ignatyevna",     "Afanasevna",     "Denisovna"
	];

	public static var currentDorm: String = '6.2';

	public static var otherDorms = [
		'1.1', '1.2', '1.3', '1.4', '1.5', '1.6', '1.7', '1.8', '1.9', '1.10', '1.11', '1.12', '2.1', '2.2', '2.3', '2.4', '2.5', '2.6', '2.7', '3', '4', '5',
		'6.1', '7.1', '7.2', '8.1', '8.2', '9', '10', '11'
	];

	public static var facultyCodes:Map<String, String> = [
		"01.03.02" => "Applied Math",
		"02.03.01" => "Math & CS",
		"09.03.01" => "CS & Eng",
		"10.03.01" => "Info Sec",
		"38.03.01" => "Economics",
		"38.03.02" => "Management",
		"40.03.01" => "Law",
		"44.03.01" => "Pedagogy",
		"45.03.02" => "Linguistics",
		"54.03.01" => "Design",
		"10.05.01" => "Comp. Sec",
		"21.05.04" => "Mining Eng",
		"26.05.06" => "Ship PowerSys",
		"26.05.07" => "Ship ElecSys",
		"45.05.01" => "Translation",
	];

	public static var bannedItems = ["beer", "cigarettes"];
	public static var items = [
		"beer",
		"books",
		"glasses",
		"headphones",
		"laptop",
		"passport",
		"pencilcase",
		"cigarettes",
		"termos"
	];

	/**
	 * Генерирует полное имя на основе пола.
	 * 
	 * @param gender "Male" (Мужской) или "Female" (Женский).
	 * @return Map, содержащий "surname" (фамилия), "name" (имя) и "patronymics" (отчество).
	 */
	public static function getFullName(gender:String) {
		var fullName:Map<String, String> = [];

		fullName.set("gender", gender);

		if (gender == "Male") {
			fullName.set("surname", maleSurnames[Std.random(maleSurnames.length)]);
			fullName.set("name", maleNames[Std.random(maleNames.length)]);
			fullName.set("patronymics", malePatronymics[Std.random(malePatronymics.length)]);
		} else if (gender == "Female") {
			fullName.set("surname", femaleSurnames[Std.random(femaleSurnames.length)]);
			fullName.set("name", femaleNames[Std.random(femaleNames.length)]);
			fullName.set("patronymics", femalePatronymics[Std.random(femalePatronymics.length)]);
		}

		return fullName;
	}

	/**
	 * Возвращает случайное число (0-99), используемое для вероятностной генерации ошибок.
	 * @return Случайное целое число от 0 до 99.
	 */
	public static function randomMistake():Int {
		return Std.random(100);
	}

	/**
	 * Выбирает номер общежития.
	 * Имеет шанс вернуть неправильное общежитие.
	 */
	public static function getDorm() {
		var randomNumber:Int = Generator.randomMistake();

		var dorm:String = '';
		if (randomNumber > 10) {
			dorm = '6.2';
		} else {
			dorm = Generator.otherDorms[Std.random(Generator.otherDorms.length)];
		}
		return dorm;
	}

	/**
	 * Определяет цвет ID-карты на основе пола с небольшим шансом ошибки.
	 * 
	 * @param gender Пол студента.
	 * @return "blue" (синий) или "pink" (розовый).
	 */
	public static function getIdCardColor(gender:String) {
		if (Generator.randomMistake() > 95)
			return gender == "Male" ? "pink" : "blue";
		else
			return gender == "Male" ? "blue" : "pink";
	}

	/**
	 * Генерирует строку факультета, состоящую из кода и названия.
	 */
	public static function getFaculty():String {
		var facultyKeys = [for (k in Generator.facultyCodes.keys()) k];
		var key = facultyKeys[Std.random(facultyKeys.length)];
		var value = facultyCodes[key];
		return '$key $value';
	}

	/**
	 * Генерирует уникальный ID пропуска.
	 * 
	 * Формат: 3 цифры + Фамилия + Первая буква Имени + Первые 2 буквы Отчества.
	 * Имеет небольшой шанс использовать имя противоположного пола для хеша ID, создавая несоответствие.
	 * 
	 * @param fullName Map с полным именем студента.
	 * @return Сгенерированная строка ID пропуска.
	 */
	public static function generatePassId(fullName:Map<String, String>):String {
		if (Generator.randomMistake() > 95)
			fullName = Generator.getFullName(fullName['gender'] == "Male" ? "Female" : "Male");

		var part2 = '${fullName['surname'].toUpperCase()}${fullName['name'].toUpperCase().substr(0, 1)}${fullName['patronymics'].toUpperCase().substr(0, 2)}';
		return Std.random(900) + 100 + part2;
	}

	/**
	 * Наполняет рюкзак случайным набором предметов.
	 * 
	 * Логика:
	 * - Генерирует от 1 до 5 предметов.
	 * - Имеет шанс включить запрещенные предметы на основе вероятности randomMistake.
	 * - Избегает дубликатов.
	 * 
	 * @return Массив названий предметов.
	 */
	public static function generateItems():Array<String> {
		var backpackItems = [];
		for (_ in 0...(Std.random(5) + 1)) {
			while (true) {
				var randomNumber:Int = Generator.randomMistake();
				if (randomNumber > 3) {
					var legalItem = items[Std.random(items.length)];
					if (!(backpackItems.contains(legalItem)) && !(Generator.bannedItems.contains(legalItem))) {
						backpackItems.push(legalItem);
						break;
					}
				} else { // запрещенный предмет
					var bannedItem = Generator.bannedItems[Std.random(Generator.bannedItems.length)];
					if (!backpackItems.contains(bannedItem)) {
						backpackItems.push(bannedItem);
						break;
					}
				}
			}
		}
		return backpackItems;
	}
}
