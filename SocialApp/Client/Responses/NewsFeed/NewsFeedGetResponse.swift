//
//  NewsFeedGetResponse.swift
//  SocialApp
//
//  Created by Дима Давыдов on 30.12.2020.
//

import Foundation

struct Likes: Decodable, JsonObjectInitProtocol {
    // число пользователей, которым понравилась запись
    var count: Int
    
    // наличие отметки «Мне нравится» от текущего пользователя
    var userLikes: Bool
    
    // информация о том, может ли текущий пользователь поставить отметку «Мне нравится»
    var canLike: Bool?
    
    // информация о том, может ли текущий пользователь сделать репост записи
    var canPublish: Bool?
    
    private enum CodingKeys: String, CodingKey {
        case count = "count"
        case userLikes = "user_likes"
        case canLike = "can_like"
        case canPublish = "can_publish"
    }
    
    init(from decoder: Decoder) throws {
        let main = try decoder.container(keyedBy: CodingKeys.self)
        
        self.count = try main.decode(Int.self, forKey: .count)
        self.userLikes = try main.decode(Int.self, forKey: .userLikes) == 1
        self.canLike = try main.decode(Int.self, forKey: .canLike) == 1
        self.canPublish = try main.decode(Int.self, forKey: .canPublish) == 1
    }
    
    init(from anyMap: [String: Any]) {
        self.count = anyMap[CodingKeys.count.rawValue] as! Int
        self.userLikes = anyMap[CodingKeys.userLikes.rawValue] as! Int == 1
        self.canLike = (anyMap[CodingKeys.canLike.rawValue] as? Int == 1)
        self.canPublish = (anyMap[CodingKeys.canPublish.rawValue] as? Int == 1)
    }
}

struct Reposts: Decodable, JsonObjectInitProtocol {
    // число пользователей, сделавших репост
    var count: Int
    
    // наличие репоста от текущего пользователя
    var userReposted: Bool
    
    private enum CodingKeys: String, CodingKey {
        case count
        case userReposted = "user_reposted"
    }
    
    init(from decoder: Decoder) throws {
        let main = try decoder.container(keyedBy: CodingKeys.self)
        
        self.count = try main.decode(Int.self, forKey: .count)
        self.userReposted = try main.decode(Int.self, forKey: .userReposted) == 1
    }
    
    init(from anyMap: [String: Any]) {
        self.count = anyMap[CodingKeys.count.rawValue] as! Int
        self.userReposted = anyMap[CodingKeys.userReposted.rawValue] as! Int == 1
    }
}

struct Comments: Decodable, JsonObjectInitProtocol {
    var count: Int
    
    init(from anyMap: [String: Any]) {
        self.count = anyMap["count"] as! Int
    }
}

struct NewsFeedPhotosDto: Decodable, JsonObjectInitProtocol {
    var likes: Likes?
    var reposts: Reposts?
    var comments: Comments?
    var canComment: Int = 0
    var canRepost: Int = 0
    
    // идентификатор фотографии.
    var id: Int
    // идентификатор альбома, в котором находится фотография.
    var albumId: Int
    // идентификатор владельца фотографии.
    var ownerId: Int
    // идентификатор пользователя, загрузившего фото (если фотография размещена в сообществе).
    //текст описания фотографии.
    var text: String
    // дата добавления в формате Unixtime.
    var date: Int
    
    // массив с копиями изображения в разных размерах
    var sizes: [PhotoSize]
    
    // ширина оригинала фотографии в пикселах.
    var width: Int?
    // высота оригинала фотографии в пикселах.
    var height: Int?
    
    var src: String?
    var srcBig: String?
    
    enum CodingKeys: String, CodingKey {
        case likes
        case reposts
        case comments
        case canComment = "can_comment"
        case canRepost = "can_repost"
        case id
        case albumId = "album_id"
        case ownerId = "owner_id"
        case text
        case date
        case sizes
        case width
        case height
        case src
        case srcBig = "src_big"
    }
    
    init(from anyMap: [String : Any]) {
        if let likes = anyMap[CodingKeys.likes.rawValue] as? [String: Any] {
            self.likes = Likes(from: likes)
        }
        if let reposts = anyMap[CodingKeys.reposts.rawValue] as? [String: Any] {
            self.reposts = Reposts(from: reposts)
        }
        if let comments = anyMap[CodingKeys.comments.rawValue] as? [String: Any] {
            self.comments = Comments(from: comments)
        }
        self.canComment = anyMap[CodingKeys.canComment.rawValue] as! Int
        self.canRepost = anyMap[CodingKeys.canRepost.rawValue] as! Int
        self.id = anyMap[CodingKeys.id.rawValue] as! Int
        self.albumId = anyMap[CodingKeys.albumId.rawValue] as! Int
        self.ownerId = anyMap[CodingKeys.ownerId.rawValue] as! Int
        self.text = anyMap[CodingKeys.text.rawValue] as! String
        self.date = anyMap[CodingKeys.date.rawValue] as! Int
        let sizes = anyMap[CodingKeys.sizes.rawValue] as! [[String: Any]]
        self.sizes = sizes.map{PhotoSize.init(from: $0)}
        self.width = anyMap[CodingKeys.width.rawValue] as? Int
        self.height = anyMap[CodingKeys.height.rawValue] as? Int
        self.src = anyMap[CodingKeys.src.rawValue] as? String
        self.srcBig = anyMap[CodingKeys.srcBig.rawValue] as? String
    }
}

struct Comment: Decodable {
    var count: Int
    var canPost: Bool
    
    enum CodingKeys: String, CodingKey {
        case count = "count"
        case canPost = "can_post"
    }
    
    init(from decoder: Decoder) throws {
        let main = try decoder.container(keyedBy: CodingKeys.self)
        
        self.count = try main.decode(Int.self, forKey: .count)
        self.canPost = try main.decode(Int.self, forKey: .canPost) == 1
    }
    
    init(from anyMap: [String: Any]) {
        self.count = anyMap["count"] as! Int
        self.canPost = anyMap["can_post"] as! Int == 1
    }
}

struct ItemGeo: Decodable {
    // идентификатор места;
    var placeId: Int
    // название места;
    var title: String
    // тип места
    var type: String
    // идентификатор страны;
    var countryId: Int
    // идентификатор города;
    var cityId: Int
    // строка с указанием адреса места в городе;
    var address: String
    
    private enum CodingKeys: String, CodingKey {
        case placeId = "place_id"
        case title
        case type
        case countryId = "country_id"
        case cityId = "city_id"
        case address
    }
    
    init(from anyMap: [String: Any]) {
        self.placeId = anyMap[CodingKeys.placeId.rawValue] as! Int
        self.title = anyMap[CodingKeys.title.rawValue] as! String
        self.type = anyMap[CodingKeys.type.rawValue] as! String
        self.countryId = anyMap[CodingKeys.countryId.rawValue] as! Int
        self.cityId = anyMap[CodingKeys.cityId.rawValue] as! Int
        self.address = anyMap[CodingKeys.address.rawValue] as! String
    }
}

struct NewsFeedItem: Decodable {
    // тип списка новости, соответствующий одному из значений параметра filters
    var type: String
    
    // идентификатор источника новости (положительный — новость пользователя, отрицательный — новость группы)
    var source_id: Int
    
    // время публикации новости в формате unixtime
    var date: Int
    
    // находится в записях со стен и содержит идентификатор записи на стене владельца
    var post_id: Int?
    
    // находится в записях со стен, содержит тип новости (post или copy)
    var post_type: String
    
    // передается в случае, если этот пост сделан при удалении
    var final_post: String?
    
    // находится в записях со стен и содержит текст записи
    var text: String
    
    // true, если текущий пользователь может редактировать запись
    var can_edit: Bool?
    
    // возвращается, если пользователь может удалить новость, всегда содержит true
    var can_delete: Bool?
    
    // находится в записях со стен и содержит информацию о комментариях к записи, содержит поля
    var comments: Comment
    
    // находится в записях со стен и содержит информацию о числе людей, которым понравилась данная запись
    var likes: Likes
    
    // находится в записях со стен и содержит информацию о числе людей, которые скопировали данную запись на свою страницу
    var reposts: Reposts
    
    // находится в записях со стен и содержит массив объектов, которые прикреплены к текущей новости (фотография, ссылка и т.п.)
    var attachments: [Attachment]?
    
    // находится в записях со стен, в которых имеется информация о местоположении
    var geo: ItemGeo?
    
    var photos: [NewsFeedPhotosDto]?
}

extension NewsFeedItem: JsonObjectInitProtocol {
    init(from anyMap: [String : Any]) {
        self.type = anyMap["type"] as! String
        self.source_id = anyMap["source_id"] as! Int
        self.date = anyMap["date"] as! Int
        self.post_id = anyMap["post_id"] as? Int
        self.post_type = anyMap["post_type"] as! String
        self.final_post = (anyMap["final_post"] as? String) ?? nil
        self.text = anyMap["text"] as! String
        self.can_edit = (anyMap["can_edit"] as? Bool) ?? nil
        self.can_delete = (anyMap["can_delete"] as? Bool) ?? nil
        self.comments = Comment(from: anyMap["comments"] as! [String: Any])
        self.likes = Likes(from: anyMap["likes"] as! [String: Any])
        self.reposts = Reposts(from: anyMap["reposts"] as! [String: Any])
        
        var att: [Attachment] = []
        for attItem in anyMap["attachments"] as! [[String: Any]] {
            att.append(Attachment(from: attItem))
        }
        
        self.attachments = att
        
        if let geo = anyMap["geo"] {
            self.geo = ItemGeo.init(from: geo as! [String: Any])
        }
        
        self.photos = nil
    }
}

struct NewsFeedProfile: Decodable, JsonObjectInitProtocol {
    
    struct OnlineInfo: Decodable, JsonObjectInitProtocol {
        var visible: Bool
        var isOnline: Bool
        var isMobile: Bool
        
        private enum CodingKeys: String, CodingKey {
            case visible
            case isOnline = "is_online"
            case isMobile = "is_mobile"
        }
        
        init(from anyMap: [String : Any]) {
            self.visible = anyMap[CodingKeys.visible.rawValue] as! Bool
            self.isOnline = anyMap[CodingKeys.isOnline.rawValue] as! Bool
            self.isMobile = anyMap[CodingKeys.isMobile.rawValue] as! Bool
        }
    }
    
    var firstName: String?
    var id: UserID
    var lastName: String
    var canAccessClosed: Bool
    var isClosed: Bool
    var sex: Int
    var screenName: String
    var photo50: String
    var photo100: String
    var online: Int
    var onlineInfo: OnlineInfo
    
    private enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case id
        case lastName = "last_name"
        case canAccessClosed = "can_access_closed"
        case isClosed = "is_closed"
        case sex
        case screenName = "screen_name"
        case photo50 = "photo_50"
        case photo100 = "photo_100"
        case online
        case onlineInfo = "online_info"
    }
    
    init(from anyMap: [String : Any]) {
        self.firstName = anyMap[CodingKeys.firstName.rawValue] as? String
        self.id = anyMap[CodingKeys.id.rawValue] as! UserID
        self.lastName = anyMap[CodingKeys.lastName.rawValue] as! String
        self.canAccessClosed = anyMap[CodingKeys.canAccessClosed.rawValue] as! Bool
        self.isClosed = anyMap[CodingKeys.isClosed.rawValue] as! Bool
        self.sex = anyMap[CodingKeys.sex.rawValue] as! Int
        self.screenName = anyMap[CodingKeys.screenName.rawValue] as! String
        self.photo50 = anyMap[CodingKeys.photo50.rawValue] as! String
        self.photo100 = anyMap[CodingKeys.photo100.rawValue] as! String
        self.online = anyMap[CodingKeys.online.rawValue] as! Int
        self.onlineInfo = OnlineInfo(from: anyMap[CodingKeys.onlineInfo.rawValue] as! [String: Any])
    }
}

struct NewsFeedGroup: Decodable, JsonObjectInitProtocol {
    
    var id: Int
    var name: String
    var screenName: String
    var isClosed: Int?
    var type: String
    var isAdmin: Int?
    var isMember: Int?
    var isAdvertiser: Int?
    var photo50: String?
    var photo100: String?
    var photo200: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case screenName = "screen_name"
        case isClosed = "is_closed"
        case type
        case isAdmin = "is_admin"
        case isMember = "is_member"
        case isAdvertiser = "is_advertiser"
        case photo50 = "photo_50"
        case photo100 = "photo_100"
        case photo200 = "photo_200"
    }
    
    init(from anyMap: [String : Any]) {
        self.id = anyMap[CodingKeys.id.rawValue] as! Int
        self.name = anyMap[CodingKeys.name.rawValue] as! String
        self.screenName = anyMap[CodingKeys.screenName.rawValue] as! String
        self.isClosed = anyMap[CodingKeys.isClosed.rawValue] as? Int
        self.type = anyMap[CodingKeys.type.rawValue] as! String
        self.isAdmin = anyMap[CodingKeys.isAdmin.rawValue] as? Int
        self.isMember = anyMap[CodingKeys.isMember.rawValue] as? Int
        self.isAdvertiser = anyMap[CodingKeys.isAdvertiser.rawValue] as? Int
        self.photo50 = anyMap[CodingKeys.photo50.rawValue] as? String
        self.photo100 = anyMap[CodingKeys.photo100.rawValue] as? String
        self.photo200 = anyMap[CodingKeys.photo200.rawValue] as? String
    }
}

class NewsFeedGetResponse: NotifiableDecodableGroup {
    
    var items: [NewsFeedItem]?
    var profiles: [NewsFeedProfile]?
    var groups: [NewsFeedGroup]?
    
    var group: DispatchGroup
    var queue: DispatchQueue
    
    required init(queue: DispatchQueue, group: DispatchGroup) {
        self.queue = queue
        self.group = group
    }
    
    func decode(from data: Data) throws {
        
        let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String: Any]
        
        let response = json["response"] as! [String: Any]
        let items = response["items"] as! [[String: Any]]
        let profiles = response["profiles"] as! [[String: Any]]
        let groups = response["groups"] as! [[String: Any]]
        
        
        self.items = [NewsFeedItem]()
        self.groups = [NewsFeedGroup]()
        self.profiles = [NewsFeedProfile]()
        print("items start")
        for item in items {
            queue.async(group: group, flags: .barrier) {
                self.items?.append(NewsFeedItem.init(from: item))
            }
        }
        print("items end")
        print("profiles start")
        for profile in profiles {
            queue.async(group: group, flags: .barrier) {
                self.profiles?.append(NewsFeedProfile.init(from: profile))
            }
        }
        print("profiles end")
        
        print("groups start")
        for groupItem in groups {
            queue.async(group: group, flags: .barrier) {
                self.groups?.append(NewsFeedGroup(from: groupItem))
            }
        }
        print("groups end")
        
        //
        //        queue.async(group: group, flags: .barrier) {
        //            print("profiles start")
        //
        //            let container = try! root.nestedContainer(keyedBy: CodingKeys.self, forKey: .response)
        //            self.profiles = try? container.decode([NewsFeedProfile].self, forKey: .profiles)
        //            print("profiles end")
        //        }
        //        queue.async(group: group, flags: .barrier) {
        //            print("groups start")
        //
        //            let container = try! root.nestedContainer(keyedBy: CodingKeys.self, forKey: .response)
        //            self.groups = try? container.decode([NewsFeedGroup].self, forKey: .groups)
        //            print("groups end")
        //
        //        }
        
        
        print("main")
    }
    
    func getNotifyGroup() -> DispatchGroup? {
        return group
    }
}

protocol JsonObjectInitProtocol {
    init(from anyMap: [String: Any])
}

protocol NotifiableDecodableGroup: class {
    func getNotifyGroup() -> DispatchGroup?
    func decode(from data: Data) throws
    init(queue: DispatchQueue, group: DispatchGroup)
}
