//
//  GroupItemDto.swift
//  SocialApp
//
//  Created by Дима Давыдов on 24.11.2020.
//

import Foundation

struct GroupItemComments: Codable {
    // количество комментариев;
    var count: Int
    // информация о том, может ли текущий пользователь комментировать запись (1 — может, 0 — не может);
    var canPost: Int?
    
    // информация о том, могут ли сообщества комментировать запись;
    var groupsCanPost: Bool?
    // может ли текущий пользователь закрыть комментарии к записи;
    var canClose: Bool?
    // может ли текущий пользователь открыть комментарии к записи.
    var canOpen: Bool?
    
    enum CodingKeys: String, CodingKey {
        case count
        case canPost = "can_post"
        case groupsCanPost = "groups_can_post"
        case canClose = "can_close"
        case canOpen = "can_open"
    }
}

struct GroupItemCopyright: Decodable {
    var id: Int?
    var link: String
    var type: String
    var name: String
}

struct GroupItemLikes: Codable {
    // число пользователей, которым понравилась запись;
    var count: Int
    // наличие отметки «Мне нравится» от текущего пользователя (1 — есть, 0 — нет);
    var userLikes: Int?
    // информация о том, может ли текущий пользователь поставить отметку «Мне нравится» (1 — может, 0 — не может);
    var canLike: Int?
    // информация о том, может ли текущий пользователь сделать репост записи (1 — может, 0 — не может).
    var canPublish: Int?
    
    enum CodingKeys: String, CodingKey {
        case count
        case userLikes = "user_likes"
        case canLike = "can_like"
        case canPublish = "can_publish"
    }
}

struct GroupItemRepost: Codable {
    // число пользователей, скопировавших запись;
    var count: Int
    // наличие репоста от текущего пользователя (1 — есть, 0 — нет)
    var user_reposted: Int?
}

struct GroupItemViews: Codable {
    // число просмотров записи.
    var count: Int
}

struct GroupItemDto: Decodable {
    // идентификатор записи.
    var id: Int
    
    // идентификатор владельца стены, на которой размещена запись. В версиях API ниже 5.7 это поле называется to_id.
    var ownerId: Int
    
    // идентификатор автора записи (от чьего имени опубликована запись).
    var fromId: Int
    
    // идентификатор администратора, который опубликовал запись (возвращается только для сообществ при запросе с ключом доступа администратора). Возвращается в записях, опубликованных менее 24 часов назад.
    var createdBy: Int?
    
    // время публикации записи в формате unixtime.
    var date: Int
    
    // текст записи.
    var text: String
    
    // идентификатор владельца записи, в ответ на которую была оставлена текущая.
    var replyOwnerId: Int?
    
    // идентификатор записи, в ответ на которую была оставлена текущая.
    var replyPostId: Int?
    
    // 1, если запись была создана с опцией «Только для друзей».
    var friendsOnly: Int?
    
    // информация о комментариях к записи
    var comments: GroupItemComments?
    
    // источник материала.
    var copyright: GroupItemCopyright?
    
    // информация о лайках к записи
    var likes: GroupItemLikes
    
    // информация о репостах записи («Рассказать друзьям»)
    var reposts: GroupItemRepost
    
    // информация о просмотрах записи
    var views: GroupItemViews
    
    // тип записи, может принимать следующие значения: post, copy, reply, postpone, suggest.
    var postType: String
    
    // медиавложения записи (фотографии, ссылки и т.п.). Описание массива attachments находится на отдельной странице.
    var attachments: [Attachment]?
    
    // информация о местоположении
    var geo: Geo?
    
    // идентификатор автора, если запись была опубликована от имени сообщества и подписана пользователем;
    var signerId: Int?
    
    // массив, содержащий историю репостов для записи.
    // Возвращается только в том случае, если запись является репостом.
    // Каждый из объектов массива, в свою очередь, является объектом-записью стандартного формата.
    // copy_history
    
    // информация о том, может ли текущий пользователь закрепить запись (1 — может, 0 — не может).
    var canPin: Int?
    
    // информация о том, может ли текущий пользователь удалить запись (1 — может, 0 — не может).
    var canDelete: Int?
    
    // информация о том, может ли текущий пользователь редактировать запись (1 — может, 0 — не может).
    var canEdit: Int?
    
    // информация о том, что запись закреплена.
    var isPinned: Int?
    
    // информация о том, содержит ли запись отметку "реклама" (1 — да, 0 — нет).
    var markedAsAds: Int?
    
    // true, если объект добавлен в закладки у текущего пользователя.
    var isFavorite: Bool?
    
    // информация о записи VK Donut:
    
    // is_donut (boolean) — запись доступна только платным подписчикам VK Donut;
    // paid_duration (integer) — время, в течение которого запись будет доступна только платным подписчикам VK Donut;
    // placeholder (object) — заглушка для пользователей, которые не оформили подписку VK Donut. Отображается вместо содержимого записи.
    // can_publish_free_copy (boolean) — можно ли открыть запись для всех пользователей, а не только подписчиков VK Donut;
    // edit_mode (string) — информация о том, какие значения VK Donut можно изменить в записи. Возможные значения:
    // - all — всю информацию о VK Donut.
    // - duration — время, в течение которого запись будет доступна только платным подписчикам VK Donut.
    // donut
    
    enum CodingKeys: String, CodingKey {
        case id
        case ownerId = "owner_id"
        case fromId = "from_id"
        case createdBy = "created_by"
        case date
        case text
        case replyOwnerId = "reply_owner_id"
        case replyPostId = "reply_post_id"
        case friendsOnly = "friends_only"
        case comments
        case copyright
        case likes
        case reposts
        case views
        case postType = "post_type"
        case attachments
        case geo
        case signerId = "signer_id"
        case canPin = "can_pin"
        case canDelete = "can_delete"
        case canEdit = "can_edit"
        case isPinned = "is_pinned"
        case markedAsAds = "marked_as_ads"
        case isFavorite = "is_favorite"
    }
}
