//
//  UserDto.swift
//  SocialApp
//
//  Created by Дима Давыдов on 23.11.2020.
//

import Foundation

typealias UserID = Int

struct UserCareerDto: Codable {
    // идентификатор сообщества (если доступно, иначе company);
    var groupId: Int
    
    // название компании (если доступно, иначе group_id);
    var company: String
    
    // идентификатор страны;
    var countryId: Int
    
    // идентификатор города (если доступно, иначе city_name);
    var cityId: Int
    
    // название города (если доступно, иначе city_id);
    var cityName: String
    
    // год начала работы;
    var from: Int
    
    // год окончания работы;
    var until: Int
    
    // должность.
    var position: String
    
    enum CodingKeys: String, CodingKey {
        case groupId = "group_id"
        case company
        case countryId = "country_id"
        case cityId = "city_id"
        case cityName = "city_name"
        case from
        case until
        case position
    }
}

struct City: Codable {
    // идентификатор города, который можно использовать для получения его названия с помощью метода database.getCitiesById;
    var id: Int
    // название города.
    var title: String
}

struct Contacts: Codable {
    // номер мобильного телефона пользователя (только для Standalone-приложений);
    var mobilePhone: String
    // дополнительный номер телефона пользователя.
    var homePhone: String
    
    enum CodingKeys: String, CodingKey {
        case mobilePhone = "mobile_phone"
        case homePhone = "home_phone"
    }
}

// Объект, содержащий следующие поля:
struct Counters: Codable {
    // количество фотоальбомов;
    var albums: Int?
    // количество видеозаписей;
    var videos: Int?
    // количество аудиозаписей;
    var audios: Int?
    // количество фотографий;
    var photos: Int?
    // количество заметок;
    var notes: Int?
    // количество друзей;
    var friends: Int?
    // количество сообществ;
    var groups: Int?
    // количество друзей онлайн;
    var onlineFriends: Int?
    // количество общих друзей;
    var mutualFriends: Int?
    // количество видеозаписей с пользователем;
    var userVideos: Int?
    // количество подписчиков;
    var followers: Int?
    // количество объектов в блоке «Интересные страницы».
    var pages: Int?
    
    enum CodingKeys: String, CodingKey {
        case albums
        case videos
        case audios
        case photos
        case notes
        case friends
        case groups
        case onlineFriends = "online_friends"
        case mutualFriends = "mutual_friends"
        case userVideos = "user_videos"
        case followers
        case pages
    }
}

struct Country: Codable {
    // идентификатор страны, который можно использовать для получения ее названия с помощью метода database.getCountriesById;
    var id: Int
    // название страны.
    var title: String

}

struct Crop: Codable {
    // координата X левого верхнего угла в процентах;
    var x: Double
    // координата Y левого верхнего угла в процентах;
    var y: Double
    // координата X правого нижнего угла в процентах;
    var x2: Double
    // координата Y правого нижнего угла в процентах.
    var y2: Double
}

struct CropPhoto: Codable {
    // объект photo фотографии пользователя, из которой вырезается главное фото профиля.
    var photo: PhotoDto
    // вырезанная фотография пользователя. Содержит следующие поля:
    var crop: Crop
    // миниатюрная квадратная фотография, вырезанная из фотографии crop. Содержит набор полей, аналогичный объекту crop.
    var rect: Crop
}

struct Education: Codable {
    // идентификатор университета;
    var university: Int
    // название университета;
    var universityName: String
    // идентификатор факультета;
    var faculty: Int
    // название факультета;
    var facultyName: String
    // год окончания.
    var graduation: Int
    
    enum CodingKeys: String, CodingKey {
        case university
        case universityName = "university_name"
        case faculty
        case facultyName = "faculty_name"
        case graduation
    }
}

struct LastSeen: Codable {
    // время последнего посещения в формате Unixtime.
    var time: Int
    // тип платформы. Возможные значения:
    //     1 — мобильная версия;
    //     2 — приложение для iPhone;
    //     3 — приложение для iPad;
    //     4 — приложение для Android;
    //     5 — приложение для Windows Phone;
    //     6 — приложение для Windows 10;
    //     7 — полная версия сайта.
    var platform: Int
}

struct Military: Codable {
    // номер части;
    var unit: String
    // идентификатор части в базе данных;
    var unitId: Int
    // идентификатор страны, в которой находится часть;
    var countryId: Int
    // год начала службы;
    var from: Int
    // год окончания службы.
    var until: Int
    
    enum CodingKeys: String, CodingKey {
        case unit
        case unitId = "unit_id"
        case countryId = "country_id"
        case from
        case until
    }
}

struct Occupation: Codable {
    // Возможные значения:
    //   work — работа;
    //   school — среднее образование;
    //   university — высшее образование.
    var type: String
    // идентификатор школы, вуза, сообщества компании (в которой пользователь работает);
    var id: Int
    // название школы, вуза или места работы;
    var name: String
}

struct Personal: Codable {
    // политические предпочтения. Возможные значения:
    //    1 — коммунистические;
    //    2 — социалистические;
    //    3 — умеренные;
    //    4 — либеральные;
    //    5 — консервативные;
    //    6 — монархические;
    //    7 — ультраконсервативные;
    //    8 — индифферентные;
    //    9 — либертарианские.
    var political: Int
    // языки
    var langs: [String]
    // мировоззрение
    var religion: String
    // источники вдохновения
    var inspiredBy: String
    // главное в людях. Возможные значения:
    //    1 — ум и креативность;
    //    2 — доброта и честность;
    //    3 — красота и здоровье;
    //    4 — власть и богатство;
    //    5 — смелость и упорство;
    //    6 — юмор и жизнелюбие.
    var peopleMain: Int
    // главное в жизни. Возможные значения:
    //    1 — семья и дети;
    //    2 — карьера и деньги;
    //    3 — развлечения и отдых;
    //    4 — наука и исследования;
    //    5 — совершенствование мира;
    //    6 — саморазвитие;
    //    7 — красота и искусство;
    //    8 — слава и влияние;
    var lifeMain: Int
    // отношение к курению. Возможные значения:
    //    1 — резко негативное;
    //    2 — негативное;
    //    3 — компромиссное;
    //    4 — нейтральное;
    //    5 — положительное.
    var smoking: Int
    // отношение к алкоголю. Возможные значения:
    //    1 — резко негативное;
    //    2 — негативное;
    //    3 — компромиссное;
    //    4 — нейтральное;
    //    5 — положительное.
    var alcohol: Int
    
    enum CodingKeys: String, CodingKey {
        case political
        case langs
        case religion
        case inspiredBy = "inspired_by"
        case peopleMain = "people_main"
        case lifeMain = "life_main"
        case smoking
        case alcohol
    }
}

struct Relative: Codable {
    // идентификатор пользователя;
    var id: Int?
    // имя родственника (если родственник не является пользователем ВКонтакте, то предыдущее значение id возвращено не будет);
    var name: String
    // тип родственной связи. Возможные значения:
    //    child — сын/дочь;
    //    sibling — брат/сестра;
    //    parent — отец/мать;
    //    grandparent — дедушка/бабушка;
    //    grandchild — внук/внучка.
    var type: String
}

struct School: Codable {
    // идентификатор школы;
    var id: Int
    // идентификатор страны, в которой расположена школа;
    var country: Int
    // идентификатор города, в котором расположена школа;
    var city: Int
    // наименование школы
    var name: String
    // год начала обучения;
    var yearFrom: Int
    // год окончания обучения;
    var yearTo: Int
    // год выпуска;
    var yearGraduated: Int
    // буква класса;
    var classLetter: String
    // специализация;
    var speciality: String
    // идентификатор типа;
    // type_str (string) — название типа. Возможные значения для пар type-typeStr:
    //     0 — "школа";
    //     1 — "гимназия";
    //     2 —"лицей";
    //     3 — "школа-интернат";
    //     4 — "школа вечерняя";
    //     5 — "школа музыкальная";
    //     6 — "школа спортивная";
    //     7 — "школа художественная";
    //     8 — "колледж";
    //     9 — "профессиональный лицей";
    //     10 — "техникум";
    //     11 — "ПТУ";
    //     12 — "училище";
    //     13 — "школа искусств".
    var type: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case country
        case city
        case name
        case speciality
        case type
        case classLetter = "class"
        case yearFrom = "year_from"
        case yearTo = "year_to"
        case yearGraduated = "year_graduated"
    }
}

struct University: Codable {
    // идентификатор университета;
    var id: Int
    // идентификатор страны, в которой расположен университет;
    var country: Int
    // идентификатор города, в котором расположен университет;
    var city: Int
    // наименование университета;
    var name: String
    // идентификатор факультета;
    var faculty: Int
    // наименование факультета;
    var facultyName: String
    // идентификатор кафедры;
    var chair: Int
    // наименование кафедры;
    var chairName: String
    // год окончания обучения;
    var graduation: Int
    // форма обучения;
    var educationForm: String
    // статус (например, «Выпускник (специалист)»)
    var educationStatus: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case country
        case city
        case name
        case faculty
        case facultyName = "faculty_name"
        case chair
        case chairName = "chair_name"
        case graduation
        case educationForm = "education_form"
        case educationStatus = "education_status"
    }
}

struct UserDto: Codable {
    // идентификатор пользователя
    var id: UserID
    
    // имя
    var firstName: String
    
    // фамилия
    var lastName: String
    
    // поле возвращается, если страница пользователя удалена или заблокирована,
    // содержит значение deleted или banned.
    // В этом случае опциональные поля не возвращаются
    var deactivated: String?
    
    // скрыт ли профиль пользователя настройками приватности
    var isClosed: Bool?
    
    // может ли текущий пользователь видеть профиль при is_closed = 1 (например, он есть в друзьях)
    var canAccessClosed: Bool?
    
    // содержимое поля «О себе» из профиля.
    var about: String?
    
    // содержимое поля «Деятельность» из профиля.
    var activities: String?
    
    // дата рождения. Возвращается в формате D.M.YYYY или D.M (если год рождения скрыт).
    // Если дата рождения скрыта целиком, поле отсутствует в ответе.
    var bdate: String?

    // информация о том, находится ли текущий пользователь в черном списке. Возможные значения:
    // 1 — находится;
    // 0 — не находится.
    var blacklisted: Int?

    // информация о том, находится ли пользователь в черном списке у текущего пользователя. Возможные значения:
    // 1 — находится;
    // 0 — не находится.
    var blacklistedByMe: Int?

    // содержимое поля «Любимые книги» из профиля пользователя.
    var books: String?

    // информация о том, может ли текущий пользователь оставлять записи на стене. Возможные значения:
    //
    // 1 — может;
    // 0 — не может.
    var canPost: Int?

    // информация о том, может ли текущий пользователь видеть чужие записи на стене. Возможные значения:
    //
    // 1 — может;
    // 0 — не может.
    var canSeeAllPosts: Int?

    // информация о том, может ли текущий пользователь видеть аудиозаписи. Возможные значения:
    //
    //    1 — может;
    //    0 — не может.
    var canSeeAudio: Int?

    // информация о том, будет ли отправлено уведомление пользователю о заявке в друзья от текущего пользователя. Возможные значения:
    //
    // 1 — уведомление будет отправлено;
    // 0 — уведомление не будет отправлено.
    var canSendFriendRequest: Int?

    // информация о том, может ли текущий пользователь отправить личное сообщение. Возможные значения:
    // 1 — может;
    // 0 — не может.
    var canWritePrivateMessage: Int?

    // информация о карьере пользователя. Объект, содержащий следующие поля:
    var career: UserCareerDto?

    // информация о городе, указанном на странице пользователя в разделе «Контакты». Возвращаются следующие поля:
    var city: City?

    // количество общих друзей с текущим пользователем.
    var commonCount: Int?

    // возвращает данные об указанных в профиле сервисах пользователя, таких как: skype, facebook, twitter, livejournal, instagram. Для каждого сервиса возвращается отдельное поле с типом string, содержащее никнейм пользователя. Например, "instagram": "username".
    var connections: [String: String]?

    // информация о телефонных номерах пользователя. Если данные указаны и не скрыты настройками приватности, возвращаются следующие поля:
    var contacts: Contacts?

    // количество различных объектов у пользователя.
    // Поле возвращается только в методе users.get при запросе информации об одном пользователе, с передачей пользовательского access_token.
    var counters: Counters?
    
    // информация о стране, указанной на странице пользователя в разделе «Контакты».
    var country: Country?

    // возвращает данные о точках, по которым вырезаны профильная и миниатюрная фотографии пользователя, при наличии.
    var cropPhoto: CropPhoto?

    // короткий адрес страницы.
    // Возвращается строка, содержащая короткий адрес страницы (например, andrew).
    // Если он не назначен, возвращается "id"+user_id, например, id35828305.
    var domain: String?

    // информация о высшем учебном заведении пользователя. Возвращаются поля:
    var education: Education?

    // имя в заданном падеже — именительный;
    var firstNameNom: String?
    // имя в заданном падеже — родительный;
    var firstNameGen: String?
    // имя в заданном падеже — дательный;
    var firstNameDat: String?
    // имя в заданном падеже — винительный;
    var firstNameAcc: String?
    // имя в заданном падеже — творительный;
    var firstNameIns: String?
    // имя в заданном падеже — предложный.
    var firstNameAbl: String?

    // количество подписчиков пользователя.
    var followersCount: Int?

    // статус дружбы с пользователем.
    // Возможные значения:
    // 0 — не является другом,
    // 1 — отправлена заявка/подписка пользователю,
    // 2 — имеется входящая заявка/подписка от пользователя,
    // 3 — является другом.
    var friendStatus: Int?

    // содержимое поля «Любимые игры» из профиля.
    var games: String?
    // информация о том, известен ли номер мобильного телефона пользователя.
    // Возвращаемые значения: 1 — известен, 0 — не известен
    var hasMobile: Int?

    // 1, если пользователь установил фотографию для профиля.
    var hasPhoto: Int?

    // название родного города.
    var homeTown: String?

    // содержимое поля «Интересы» из профиля.
    var interests: String?

    // информация о том, есть ли пользователь в закладках у текущего пользователя. Возможные значения:
    // 1 — есть;
    // 0 — нет.
    var isFavorite: Int?

    // информация о том, является ли пользователь другом текущего пользователя. Возможные значения:
    // 1 — да;
    // 0 — нет.
    var isFriend: Int?

    // информация о том, скрыт ли пользователь из ленты новостей текущего пользователя. Возможные значения:
    //   1 — да;
    //   0 — нет
    var isHiddenFromFeed: Int?

    // фамилия в заданном падеже — именительный;
    var lastNameNom: String?
    // фамилия в заданном падеже — родительный;
    var lastNameGen: String?
    // фамилия в заданном падеже — дательный;
    var lastNameDat: String?
    // фамилия в заданном падеже — винительный;
    var lastNameAcc: String?
    // фамилия в заданном падеже — творительный;
    var lastNameIns: String?
    // фамилия в заданном падеже — предложный.
    var lastNameAbl: String?

    // время последнего посещения. Объект, содержащий следующие поля:
    var lastSeen: LastSeen?

    // разделенные запятой идентификаторы списков друзей, в которых состоит пользователь. Поле доступно только для метода friends.get.
    var lists: String?

    // девичья фамилия.
    var maidenName: String?

    // информация о военной службе пользователя.
    var military: Military?

    // содержимое поля «Любимые фильмы» из профиля пользователя.
    var movies: String?
    
    // содержимое поля «Любимая музыка» из профиля пользователя.
    var music: String?
    
    // никнейм (отчество) пользователя.
    var nickname: String?

    // информация о текущем роде занятия пользователя
    var occupation: Occupation?
    
    // [0,1]    информация о том, находится ли пользователь сейчас на сайте.
    // Если пользователь использует мобильное приложение либо мобильную версию, возвращается дополнительное поле online_mobile, содержащее 1.
    // При этом, если используется именно приложение, дополнительно возвращается поле online_app, содержащее его идентификатор.
    var online: Int?

    // информация о полях из раздела «Жизненная позиция».
    var personal: Personal?
    // url квадратной фотографии пользователя, имеющей ширину 50 пикселей.
    // В случае отсутствия у пользователя фотографии возвращается https://vk.com/images/camera_50.png.
    var photo50: String?
    // url квадратной фотографии пользователя, имеющей ширину 100 пикселей.
    // В случае отсутствия у пользователя фотографии возвращается https://vk.com/images/camera_100.png.
    var photo100: String?

    // url фотографии пользователя, имеющей ширину 200 пикселей.
    // В случае отсутствия у пользователя фотографии возвращается https://vk.com/images/camera_200.png.
    var photo200orig: String?
    
    // url квадратной фотографии, имеющей ширину 200 пикселей.
    // Если у пользователя отсутствует фотография таких размеров, в ответе вернется https://vk.com/images/camera_200.png
    var photo200: String?

    // url фотографии, имеющей ширину 400 пикселей.
    // Если у пользователя отсутствует фотография такого размера, в ответе вернется https://vk.com/images/camera_400.png.
    var photo400orig: String?
    
    // строковый идентификатор главной фотографии профиля пользователя в формате {user_id}_{photo_id}, например, 6492_192164258.
    // Обратите внимание, это поле может отсутствовать в ответе.
    var photoId: String?

    // url квадратной фотографии с максимальной шириной.
    // Может быть возвращена фотография, имеющая ширину как 200, так и 100 пикселей.
    // В случае отсутствия у пользователя фотографии возвращается https://vk.com/images/camera_200.png.
    var photoMax: String?

    // url фотографии максимального размера.
    // Может быть возвращена фотография, имеющая ширину как 400, так и 200 пикселей.
    // В случае отсутствия у пользователя фотографии возвращается https://vk.com/images/camera_400.png.
    var photoMaxOrig: String?

    // любимые цитаты.
    var quotes: String?
    //     список родственников. Массив объектов, каждый из которых содержит поля:
    // id (integer) — идентификатор пользователя;
    // name (string) — имя родственника (если родственник не является пользователем ВКонтакте, то предыдущее значение id возвращено не будет);
    // type (string) — тип родственной связи. Возможные значения:
    //    child — сын/дочь;
    //    sibling — брат/сестра;
    //    parent — отец/мать;
    //    grandparent — дедушка/бабушка;
    //    grandchild — внук/внучка.
    var relatives: [Relative]?

    // семейное положение. Возможные значения:
    //1 — не женат/не замужем;
    //2 — есть друг/есть подруга;
    //3 — помолвлен/помолвлена;
    //4 — женат/замужем;
    //5 — всё сложно;
    //6 — в активном поиске;
    //7 — влюблён/влюблена;
    //8 — в гражданском браке;
    //0 — не указано.
    //
    //Если в семейном положении указан другой пользователь, дополнительно возвращается объект relation_partner, содержащий id и имя этого человека.
    var relation: Int?

    // список школ, в которых учился пользователь. Массив объектов, описывающих школы. Каждый объект содержит следующие поля:
    var schools: [School]?
    
    // короткое имя страницы.
    var screenName: String?

    //  [0,1,2]    пол. Возможные значения:
    //
    //1 — женский;
    //2 — мужской;
    //0 — пол не указан.
    var sex: Int?
    
    // адрес сайта, указанный в профиле.
    var site: String?
   
    // статус пользователя. Возвращается строка, содержащая текст статуса, расположенного в профиле под именем.
    // Если включена опция «Транслировать в статус играющую музыку», возвращается дополнительное поле status_audio, содержащее информацию о композиции.
    var status: String?
    
    // временная зона. Только при запросе информации о текущем пользователе.
    var timezone: Int?
    
    // информация о том, есть ли на странице пользователя «огонёк» 0, 1.
    var trending: Int?
    
    // любимые телешоу.
    var tv: String?
    
    // список вузов, в которых учился пользователь.
    // Массив объектов, описывающих университеты. Каждый объект содержит следующие поля:
    var universities: [University]?

    // возвращается 1, если страница пользователя верифицирована, 0 — если нет.
    var verified: Int?

    // режим стены по умолчанию. Возможные значения: owner, all.
    var wallDefault: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case deactivated
        case isClosed = "is_closed"
        case canAccessClosed = "can_access_closed"
        case about
        case activities
        case bdate
        case blacklisted
        case blacklistedByMe = "blacklisted_by_me"
        case books
        case canPost = "can_post"
        case canSeeAllPosts = "can_see_all_posts"
        case canSeeAudio = "can_see_audio"
        case canSendFriendRequest = "can_send_friend_request"
        case canWritePrivateMessage = "can_write_private_message"
        case career
        case city
        case commonCount = "common_count"
        case connections
        case contacts
        case counters
        case country
        case cropPhoto = "crop_photo"
        case domain
        case education
        case firstNameNom = "first_name_nom"
        case firstNameGen = "first_name_gen"
        case firstNameDat = "first_name_dat"
        case firstNameAcc = "first_name_acc"
        case firstNameIns = "first_name_ins"
        case firstNameAbl = "first_name_abl"
        case followersCount = "followers_count"
        case friendStatus = "friend_status"
        case games
        case hasMobile = "has_mobile"
        case hasPhoto = "has_photo"
        case homeTown = "home_town"
        case interests
        case isFavorite = "is_favorite"
        case isFriend = "is_friend"
        case isHiddenFromFeed = "is_hidden_from_feed"
        case lastNameNom = "last_name_nom"
        case lastNameGen = "last_name_gen"
        case lastNameDat = "last_name_dat"
        case lastNameAcc = "last_name_acc"
        case lastNameIns = "last_name_ins"
        case lastNameAbl = "last_name_abl"
        case lastSeen = "last_seen"
        case lists
        case maidenName = "maiden_name"
        case military
        case movies
        case music
        case nickname
        case occupation
        case online
        case personal
        case photo50 = "photo_50"
        case photo100 = "photo_100"
        case photo200orig = "photo_200_orig"
        case photo200 = "photo_200"
        case photo400orig = "photo_400_orig"
        case photoId = "photo_id"
        case photoMax = "photo_max"
        case photoMaxOrig = "photo_max_orig"
        case quotes
        case relatives
        case relation
        case schools
        case screenName = "screen_name"
        case sex
        case site
        case status
        case timezone
        case trending
        case tv
        case universities
        case verified
        case wallDefault = "wall_default"
    }
}
