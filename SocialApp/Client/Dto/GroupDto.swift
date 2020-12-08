//
//  GroupDto.swift
//  SocialApp
//
//  Created by Дима Давыдов on 24.11.2020.
//

import Foundation
import RealmSwift

struct BanInfo: Codable {
  // срок окончания блокировки в формате unixtime;
  var endDate: Int

  //комментарий к блокировке.
  var comment: String

  enum CodingKeys: String, CodingKey {
    case endDate = "end_date"
    case comment
  }
}

struct GroupContact: Codable {
  // идентификатор пользователя
  var userId: Int
  // должность;
  var desc: String
  // номер телефона;
  var phone: String
  // адрес e-mail.
  var email: String

  enum CodingKeys: String, CodingKey {
    case userId = "user_id"
    case desc
    case phone
    case email
  }
}

struct GroupCoverImage: Codable {
  // URL копии;
  var url: String
  // ширина копии;
  var width: Int
  // высота копии.
  var height: Int
}

struct GroupCover: Codable {
  // информация о том, включена ли обложка (1 — да, 0 — нет);
  var enabled: Int
  // копии изображений обложки
  var images: [GroupCoverImage]?
}

struct GroupLink: Codable {
    // идентификатор ссылки;
    var id: Int
    // URL;
    var url: String
    // название ссылки;
    var name: String
    // описание ссылки;
    var desc: String
    // URL изображения-превью шириной 50px;
    var photo50: String
    // URL изображения-превью шириной 100px.
    var photo100: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case url
        case name
        case desc
        case photo50 = "photo_50"
        case photo100 = "photo_100"
    }
}

class GroupDto: Object, Codable {
    // идентификатор сообщества.
    @objc dynamic  var id: Int
    
    // название сообщества
    @objc dynamic  var name: String
    
    // короткий адрес, например, apiclub
    @objc dynamic  var screenName: String
    
    // является ли сообщество закрытым. Возможные значения:
    // 0 — открытое;
    // 1 — закрытое;
    // 2 — частное
    @objc dynamic var isClosed: Int
    
    // возвращается в случае, если сообщество удалено или заблокировано. Возможные значения:
    // - deleted — сообщество удалено;
    // - banned — сообщество заблокировано;
    var deactivated: String?
    
    // информация о том, является ли текущий пользователь руководителем. Возможные значения:
    // 1 — является;
    // 0 — не является.
    var isAdmin: Int?
    
    // уровень полномочий текущего пользователя (если is_admin = 1):
    // 1 — модератор;
    // 2 — редактор;
    // 3 — администратор.
    var adminLevel: Int?
    
    // информация о том, является ли текущий пользователь участником. Возможные значения:
    // 1 — является;
    // 0 — не является.
    var isMember: Int?
    
    // информация о том, является ли текущий пользователь рекламодателем. Возможные значения:
    // 1 — является;
    // 0 — не является.
    var isAdvertiser: Int?
    
    // идентификатор пользователя, который отправил приглашение в сообщество.
    // Поле возвращается только для метода groups.getInvites.
    var invitedBy: Int?
    
    // тип сообщества:
    // - group — группа;
    // - page — публичная страница;
    // - event — мероприятие.
    var type: String
    
    // URL главной фотографии с размером 50x50px.
    var photo50: String
    
    // URL главной фотографии с размером 100х100px.
    var photo100: String
    
    // URL главной фотографии в максимальном размере. 
    var photo200: String
    
    
    // строка тематики паблика. У групп возвращается строковое значение, открыта ли группа или нет, а у событий дата начала.
    var activity: String?

    // integer    возрастное ограничение.
    //    1 — нет;
    //    2 — 16+;
    //    3 — 18+.
    var ageLimits: Int?

    // информация о занесении в черный список сообщества (поле возвращается только при запросе информации об одном сообществе)
    var banInfo: BanInfo?

    // информация о том, может ли текущий пользователь создать новое обсуждение в группе. Возможные значения:
    // 1 — может;
    // 0 — не может.
    var canCreateTopic: Int?

    // информация о том, может ли текущий пользователь написать сообщение сообществу. Возможные значения:
    // 1 — может;
    // 0 — не может.
    var canMessage: Int?

    // информация о том, может ли текущий пользователь оставлять записи на стене сообщества. Возможные значения:
    // 1 — может;
    // 0 — не может.
    var canPost: Int?

    // информация о том, разрешено ли видеть чужие записи на стене группы. Возможные значения:
    // 1 — может;
    // 0 — не может.
    var canSeeAllPosts: Int?

    // информация о том, может ли текущий пользователь загружать документы в группу. Возможные значения:
    // 1 — может;
    // 0 — не может.
    var canUploadDoc: Int?

    // информация о том, может ли текущий пользователь загружать видеозаписи в группу. Возможные значения:
    // 1 — может;
    // 0 — не может.
    var canUploadVideo: Int?

    // город, указанный в информации о сообществе
    var city: City?

    // информация из блока контактов публичной страницы
    var contacts: [GroupContact]?

    // объект, содержащий счётчики сообщества, может включать любой набор из следующих полей: photos, albums, audios, videos, topics, docs.
    // Поле возвращается только при запросе данных об одном сообществе
    var counters: Counters?


    var country: Country?

    // обложка сообщества
    var cover: GroupCover?

    // возвращает данные о точках, по которым вырезаны профильная и миниатюрная фотографии сообщества.
    var cropPhoto: CropPhoto?

    // текст описания сообщества.
    var groupDescription: String?

    // идентификатор закрепленной записи. Получить дополнительные данные о записи можно методом wall.getById, передав в поле posts {group_id}_{post_id}.
    var fixedPost: Int?

    // информация о том, установлена ли у сообщества главная фотография. Возможные значения:
    // 1 — установлена;
    // 0 — не установлена.
    var hasPhoto: Int?

    // информация о том, находится ли сообщество в закладках у текущего пользователя. Возможные значения:
    // 1 — находится ;
    // 0 — не находится.
    var isFavorite: Int?

    // информация о том, скрыто ли сообщество из ленты новостей текущего пользователя. Возможные значения:
    // 1 — скрыто ;
    // 0 — не скрыто.
    var isHiddenFromFeed: Int?

    // информация о том, заблокированы ли сообщения от этого сообщества (для текущего пользователя).
    var isMessagesBlocked: Int?
    
    // информация из блока ссылок сообщества
    var links: [GroupLink]?
    
    // идентификатор основного фотоальбома.
    var mainAlbumId: Int?
    
    // информация о главной секции. Возможные значения:
    // 0 — отсутствует;
    // 1 — фотографии;
    // 2 — обсуждения;
    // 3 — аудиозаписи;
    // 4 — видеозаписи;
    // 5 — товары.
    var mainSection: Int?
    
    // статус участника текущего пользователя. Возможные значения:
    // 0 — не является участником;
    // 1 — является участником;
    // 2 — не уверен, что посетит мероприятие;
    // 3 — отклонил приглашение;
    // 4 — запрос на вступление отправлен;
    // 5 — приглашен.
    var memberStatus: Int?
    
    // Количество участников в сообществе
    var membersCount: Int?
    
    // TODO
    // place
    // public_date_label
    // site
    // start_date и finish_date
    // status
    // trending
    // verified
    
    // стена. Возможные значения:
    // 0 — выключена;
    // 1 — открытая;
    // 2 — ограниченная;
    // 3 — закрытая.
    var wall: Int?
    
    // TODO
    // wiki_page
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case screenName = "screen_name"
        case isClosed = "is_closed"
        case deactivated
        case isAdmin = "is_admin"
        case adminLevel = "admin_level"
        case isMember = "is_member"
        case isAdvertiser = "is_advertiser"
        case invitedBy = "invited_by"
        case type
        case photo50 = "photo_50"
        case photo100 = "photo_100"
        case photo200 = "photo_200"
        case activity
        case ageLimits = "age_limits"
        case banInfo = "ban_info"
        case canCreateTopic = "can_create_topic"
        case canMessage = "can_message"
        case canPost = "can_post"
        case canSeeAllPosts = "can_see_all_posts"
        case canUploadDoc = "can_upload_doc"
        case canUploadVideo = "can_upload_video"
        case city
        case contacts
        case counters
        case country
        case cover
        case cropPhoto = "crop_photo"
        case groupDescription = "description"
        case fixedPost = "fixed_post"
        case hasPhoto = "has_photo"
        case isFavorite = "is_favorite"
        case isHiddenFromFeed = "is_hidden_from_feed"
        case isMessagesBlocked = "is_messages_blocked"
        case links
        case mainAlbumId = "main_album_id"
        case mainSection = "main_section"
        case memberStatus = "member_status"
        case membersCount = "members_count"
        case wall
    }
}
