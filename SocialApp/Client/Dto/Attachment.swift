//
//  Attachment.swift
//  SocialApp
//
//  Created by Дима Давыдов on 28.11.2020.
//

import Foundation

struct AttachmentPhotoSize: Decodable {
    var type: String
    var url: String
    var width: Int
    var height: Int
}

extension AttachmentPhotoSize: JsonObjectInitProtocol {
    init(from anyMap: [String : Any]) {
        self.type = anyMap["type"] as! String
        self.url = anyMap["url"] as! String
        
        self.width = anyMap["width"] as! Int
        self.height = anyMap["height"] as! Int
    }
}

enum PhotoSizeType: String {
    
    // s — пропорциональная копия изображения с максимальной стороной 75px;
    case s
    // m — пропорциональная копия изображения с максимальной стороной 130px;
    case m
    // x — пропорциональная копия изображения с максимальной стороной 604px;
    case x
    // o — если соотношение "ширина/высота" исходного изображения меньше или равно 3:2, то пропорциональная копия с максимальной шириной 130px. Если соотношение "ширина/высота" больше 3:2, то копия обрезанного слева изображения с максимальной шириной 130px и соотношением сторон 3:2.
    case o
    // p — если соотношение "ширина/высота" исходного изображения меньше или равно 3:2, то пропорциональная копия с максимальной шириной 200px. Если соотношение "ширина/высота" больше 3:2, то копия обрезанного слева и справа изображения с максимальной шириной 200px и соотношением сторон 3:2.
    case p
    // q — если соотношение "ширина/высота" исходного изображения меньше или равно 3:2, то пропорциональная копия с максимальной шириной 320px. Если соотношение "ширина/высота" больше 3:2, то копия обрезанного слева и справа изображения с максимальной шириной 320px и соотношением сторон 3:2.
    case q
    // r — если соотношение "ширина/высота" исходного изображения меньше или равно 3:2, то пропорциональная копия с максимальной шириной 510px. Если соотношение "ширина/высота" больше 3:2, то копия обрезанного слева и справа изображения с максимальной шириной 510px и соотношением сторон 3:2
    case r
    // y — пропорциональная копия изображения с максимальной стороной 807px;
    case y
    // z — пропорциональная копия изображения с максимальным размером 1080x1024;
    case z
    // w — пропорциональная копия изображения с максимальным размером 2560x2048px.
    case w

}
extension Array where Element == PhotoSize {
    
    func find(by type: PhotoSizeType) -> PhotoSize? {
        for size in self {
            if size.type != type.rawValue { continue }
            return size
        }
        
        return nil
    }
    
    func sortByWidth() -> [PhotoSize] {
        return self.sorted { (a, b) -> Bool in
            return a.width > b.width
        }
    }
    
    func findBy(width: Int) -> PhotoSize? {
        for size in self {
            if size.width < width { continue }
            
            return size
        }
        
        return nil
    }
}


extension Array where Element == AttachmentPhotoSize {
    
    func find(by type: PhotoSizeType) -> AttachmentPhotoSize? {
        for size in self {
            if size.type != type.rawValue { continue }
            return size
        }
        
        return nil
    }
    
    func sortByWidth() -> [AttachmentPhotoSize] {
        return self.sorted { (a, b) -> Bool in
            return a.width > b.width
        }
    }
    
    func findBy(width: Int) -> AttachmentPhotoSize? {
        for size in self {
            if size.width < width { continue }
            
            return size
        }
        
        return nil
    }
}

struct AttachmentPhoto: Decodable, JsonObjectInitProtocol {
    var id: Int
    var albumId: Int
    var ownerId: UserID
    var userId: UserID
    var text: String
    var date: Int
    var sizes: [AttachmentPhotoSize]
    var width: Int?
    var height: Int?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case albumId = "album_id"
        case ownerId = "owner_id"
        case userId = "user_id"
        case text
        case date
        case sizes
        case width
        case height
    }
    
    init(from anyMap: [String : Any]) {
        self.id = anyMap[CodingKeys.id.rawValue] as! Int
        self.albumId = anyMap[CodingKeys.albumId.rawValue] as! Int
        self.ownerId = anyMap[CodingKeys.ownerId.rawValue] as! UserID
        self.userId = anyMap[CodingKeys.userId.rawValue] as! UserID
        self.text = anyMap[CodingKeys.text.rawValue] as! String
        self.date = anyMap[CodingKeys.date.rawValue] as! Int
        self.width = anyMap[CodingKeys.width.rawValue] as? Int
        self.height = anyMap[CodingKeys.height.rawValue] as? Int
        
        let sizes = anyMap[CodingKeys.sizes.rawValue] as! [[String: Any]]
        self.sizes = sizes.map {AttachmentPhotoSize(from: $0)}
    }
}
struct AttachmentPostedPhoto: Decodable, JsonObjectInitProtocol {
    var id: Int
    var ownerId: UserID
    var photo130: String
    var photo604: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case ownerId = "owner_id"
        case photo130 = "photo_130"
        case photo604 = "photo_604"
    }
    
    init(from anyMap: [String : Any]) {
        self.id = anyMap["id"] as! Int
        self.ownerId = anyMap["owner_id"] as! UserID
        self.photo130 = anyMap["photo_130"] as! String
        self.photo604 = anyMap["photo_604"] as! String
    }
}

struct AttachmentVideoImage: Decodable, JsonObjectInitProtocol {
    var height: Int
    var url: String
    var width: Int
    var withPadding: Int?
    
    enum CodingKeys: String, CodingKey {
        case height
        case url
        case width
        case withPadding = "with_padding"
    }
    
    init(from anyMap: [String : Any]) {
        self.height = anyMap["height"] as! Int
        self.url = anyMap["url"] as! String
        self.width = anyMap["width"] as! Int
        self.withPadding = anyMap["with_padding"] as? Int
    }
}

struct AttachmentVideoFrame: Decodable, JsonObjectInitProtocol {
    var height: Int
    var url: String
    var width: Int
    
    init(from anyMap: [String : Any]) {
        self.height = anyMap["height"] as! Int
        self.url = anyMap["url"] as! String
        self.width = anyMap["width"] as! Int
    }
}

struct AttachmentVideoLikes: Decodable, JsonObjectInitProtocol {
    var count: Int
    var userLikes: Int
    
    enum CodingKeys: String, CodingKey {
        case count
        case userLikes = "user_likes"
    }
    
    init(from anyMap: [String : Any]) {
        self.count = anyMap["count"] as! Int
        self.userLikes = anyMap["user_likes"] as! Int
    }
}

struct AttachmentVideoReposts: Decodable, JsonObjectInitProtocol {
    var count: Int
    var wallCount: Int
    var mailCount: Int
    var userReposted: Int
    
    enum CodingKeys: String, CodingKey {
        case count
        case wallCount = "wall_count"
        case mailCount = "mail_count"
        case userReposted = "user_reposted"
    }
    
    init(from anyMap: [String : Any]) {
        self.count = anyMap["count"] as! Int
        self.wallCount = anyMap["wall_count"] as! Int
        self.mailCount = anyMap["mail_count"] as! Int
        self.userReposted = anyMap["user_reposted"] as! Int
    }
}

struct AttachmentVideo: Decodable, JsonObjectInitProtocol {
    var id: Int
    var ownerId: UserID
    var title: String
    var description: String
    var duration: Int
    var image: [AttachmentVideoImage]
    var firstFrame: [AttachmentVideoFrame]?
    var date: Int
    var addingDate: Int?
    var views: Int
    var localViews: Int?
    var comments: Int
    var player: String?
    var platform: String?
    var canEdit: Int?
    var canAdd: Int?
    var isPrivate: Int?
    var accessKey: String?
    var processing: Int?
    var isFavorite: Bool?
    var canComment: Int
    var canLike: Int
    var canRepost: Int
    var canSubscribe: Int
    var canAddToFavs: Int?
    var canAttachLink: Int?
    var width: Int?
    var height: Int?
    var userId: UserID?
    var converting: Int?
    var added: Int?
    var isSubscribed: Int?
    var isRepeat: Int?
    var type: String
    var likes: AttachmentVideoLikes?
    var reposts: AttachmentVideoReposts?
    
    enum CodingKeys: String, CodingKey {
        case id
        case ownerId = "owner_id"
        case title
        case description
        case duration
        case image
        case firstFrame = "first_frame"
        case date
        case addingDate = "adding_date"
        case views
        case localViews = "local_views"
        case comments
        case player
        case platform
        case canEdit = "can_edit"
        case canAdd = "can_add"
        case isPrivate = "is_private"
        case accessKey = "access_key"
        case processing
        case isFavorite = "is_favorite"
        case canComment = "can_comment"
        case canLike = "can_like"
        case canRepost = "can_repost"
        case canSubscribe = "can_subscribe"
        case canAddToFavs = "can_add_to_fav"
        case canAttachLink = "can_attach_link"
        case width
        case height
        case userId = "user_id"
        case converting
        case added
        case isSubscribed = "is_subscribed"
        case isRepeat = "repeat"
        case type
        case likes
        case reposts
    }
    
    init(from anyMap: [String : Any]) {
        self.id = anyMap[CodingKeys.id.rawValue] as! Int
        self.ownerId = anyMap[CodingKeys.ownerId.rawValue] as! UserID
        self.title = anyMap[CodingKeys.title.rawValue] as! String
        self.description = anyMap[CodingKeys.description.rawValue] as! String
        self.duration = anyMap[CodingKeys.description.rawValue] as! Int
        let avi = anyMap[CodingKeys.image.rawValue] as! [[String:Any]]
        self.image = avi.map{AttachmentVideoImage.init(from: $0)}

        if let avf = anyMap[CodingKeys.firstFrame.rawValue] as? [[String: Any]] {
            self.firstFrame = avf.map{AttachmentVideoFrame.init(from: $0)}
        }

        self.date = anyMap[CodingKeys.date.rawValue] as! Int
        self.addingDate = anyMap[CodingKeys.addingDate.rawValue] as? Int
        self.views = anyMap[CodingKeys.views.rawValue] as! Int
        self.localViews = anyMap[CodingKeys.localViews.rawValue] as? Int
        self.comments = anyMap[CodingKeys.comments.rawValue] as! Int
        self.player = anyMap[CodingKeys.player.rawValue] as? String
        self.platform = anyMap[CodingKeys.platform.rawValue] as? String
        self.canEdit = anyMap[CodingKeys.canEdit.rawValue] as? Int
        self.canAdd = anyMap[CodingKeys.canAdd.rawValue] as? Int
        self.isPrivate = anyMap[CodingKeys.isPrivate.rawValue] as? Int
        self.accessKey = anyMap[CodingKeys.accessKey.rawValue] as? String
        self.processing = anyMap[CodingKeys.processing.rawValue] as? Int
        self.isFavorite = anyMap[CodingKeys.isFavorite.rawValue] as? Bool
        self.canComment = anyMap[CodingKeys.canComment.rawValue] as! Int
        self.canLike = anyMap[CodingKeys.canLike.rawValue] as! Int
        self.canRepost = anyMap[CodingKeys.canRepost.rawValue] as! Int
        self.canSubscribe = anyMap[CodingKeys.canSubscribe.rawValue] as! Int
        self.canAddToFavs = anyMap[CodingKeys.canAddToFavs.rawValue] as? Int
        self.canAttachLink = anyMap[CodingKeys.canAttachLink.rawValue] as? Int
        self.width = anyMap[CodingKeys.width.rawValue] as? Int
        self.height = anyMap[CodingKeys.height.rawValue] as? Int
        self.userId = anyMap[CodingKeys.userId.rawValue] as? UserID
        self.converting = anyMap[CodingKeys.converting.rawValue] as? Int
        self.added = anyMap[CodingKeys.added.rawValue] as? Int
        self.isSubscribed = anyMap[CodingKeys.isSubscribed.rawValue] as? Int
        self.isRepeat = anyMap[CodingKeys.isRepeat.rawValue] as? Int
        self.type = anyMap[CodingKeys.type.rawValue] as! String
        if let avl = anyMap[CodingKeys.likes.rawValue] as? [String:Any] {
            self.likes = AttachmentVideoLikes.init(from: avl)
        }
        if let avr = anyMap[CodingKeys.reposts.rawValue] as? [String: Any] {
            self.reposts = AttachmentVideoReposts(from: avr)
        }
    }
}
struct AttachmentAudio: Decodable, JsonObjectInitProtocol {
    var id: Int
    var ownerId: UserID
    var artist: String
    var title: String
    var duration: Int
    var url: String
    var lyricsId: Int?
    var albumId: Int?
    var genreId: Int?
    var date: Int
    var noSearch: Int?
    var isHQ: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case ownerId = "owner_id"
        case artist
        case title
        case duration
        case url
        case lyricsId = "lyrics_id"
        case albumId = "album_id"
        case genreId = "genre_id"
        case date
        case noSearch = "no_search"
        case isHQ = "is_hq"
    }
    
    init(from anyMap: [String : Any]) {
        self.id = anyMap[CodingKeys.id.rawValue] as! Int
        self.ownerId = anyMap[CodingKeys.ownerId.rawValue] as! UserID
        self.artist = anyMap[CodingKeys.artist.rawValue] as! String
        self.title = anyMap[CodingKeys.title.rawValue] as! String
        self.duration = anyMap[CodingKeys.duration.rawValue] as! Int
        self.url = anyMap[CodingKeys.url.rawValue] as! String
        self.lyricsId = anyMap[CodingKeys.lyricsId.rawValue] as? Int
        self.albumId = anyMap[CodingKeys.albumId.rawValue] as? Int
        self.genreId = anyMap[CodingKeys.genreId.rawValue] as? Int
        self.date = anyMap[CodingKeys.date.rawValue] as! Int
        self.noSearch = anyMap[CodingKeys.noSearch.rawValue] as? Int
        self.isHQ = anyMap[CodingKeys.isHQ.rawValue] as? Int
    }
}

struct AttachmentLink: Decodable, JsonObjectInitProtocol {
    var url: String
    var title: String
    var caption: String?
    var description: String
    var photo: AttachmentPhoto?
    var isFavorite: Bool?
    var target: String?
    
    enum CodingKeys: String, CodingKey {
        case url
        case title
        case caption
        case description
        case photo
        case isFavorite = "is_favorite"
        case target
    }
    
    init(from anyMap: [String : Any]) {
        self.url = anyMap[CodingKeys.url.rawValue] as! String
        self.title = anyMap[CodingKeys.title.rawValue] as! String
        self.caption = anyMap[CodingKeys.caption.rawValue] as? String
        self.description = anyMap[CodingKeys.description.rawValue] as! String
        if let at = anyMap[CodingKeys.photo.rawValue] as? [String: Any] {
            self.photo = AttachmentPhoto(from: at)
        }
        self.isFavorite = anyMap[CodingKeys.isFavorite.rawValue] as? Bool
        self.target = anyMap[CodingKeys.target.rawValue] as? String
    }
}

struct AttachmentAlbum: Decodable, JsonObjectInitProtocol {
    
    struct Thumb: Decodable, JsonObjectInitProtocol {
        var album_id: Int
        var date: Int
        var id: Int
        var owner_id: UserID
        var has_tags: Bool
        var access_key: String
        var sizes: [PhotoSize]
        var text: String
        var user_id: UserID
        
        init(from anyMap: [String : Any]) {
            self.album_id = anyMap["album_id"] as! Int
            self.date = anyMap["date"] as! Int
            self.id = anyMap["id"] as! Int
            self.owner_id = anyMap["owner_id"] as! UserID
            self.has_tags = anyMap["has_tags"] as! Bool
            self.access_key = anyMap["access_key"] as! String
            let ps = anyMap["sizes"] as! [[String: Any]]
            self.sizes = ps.map{PhotoSize.init(from: $0)}
            
            self.text = anyMap["text"] as! String
            self.user_id = anyMap["user_id"] as! UserID
        }
    }
    
    var id: String
    var thumb: Thumb
    var owner_id: UserID
    var title: String
    var description: String
    var created: Int
    var updated: Int
    var size: Int
    
    init(from anyMap: [String : Any]) {
        self.id = anyMap["id"] as! String
        self.thumb = Thumb(from: anyMap["thumb"] as! [String: Any])
        self.owner_id = anyMap["owner_id"] as! UserID
        self.title = anyMap["title"] as! String
        self.description = anyMap["description"] as! String
        self.created = anyMap["created"] as! Int
        self.updated = anyMap["updated"] as! Int
        self.size = anyMap["size"] as! Int
    }
}

struct AttachmentEvent: Decodable, JsonObjectInitProtocol {
    var id: Int
    var buttonText: String
    var isFavorite: Bool
    var text: String
    var address: String
    var memberStatus: Int
    var time: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case buttonText = "button_text"
        case isFavorite = "is_favorite"
        case text
        case address
        case memberStatus = "member_status"
        case time
    }
    
    init(from anyMap: [String : Any]) {
        self.id = anyMap[CodingKeys.id.rawValue] as! Int
        self.buttonText = anyMap[CodingKeys.buttonText.rawValue] as! String
        self.isFavorite = anyMap[CodingKeys.isFavorite.rawValue] as! Bool
        self.text = anyMap[CodingKeys.text.rawValue] as! String
        self.address = anyMap[CodingKeys.address.rawValue] as! String
        self.memberStatus = anyMap[CodingKeys.memberStatus.rawValue] as! Int
        self.time = anyMap[CodingKeys.time.rawValue] as! Int
    }
}

struct AttachmentDocAttachmentDoc: Decodable, JsonObjectInitProtocol {
    var id: Int
    var ownerId: UserID
    var title: String
    var size: Int
    var ext: String
    var date: Int
    var type: Int
    var url: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case ownerId = "owner_id"
        case title
        case size
        case ext
        case date
        case type
        case url
    }
    
    init(from anyMap: [String : Any]) {
        self.id = anyMap["id"] as! Int
        self.ownerId = anyMap["owner_id"] as! UserID
        self.title = anyMap["title"] as! String
        self.size = anyMap["size"] as! Int
        self.ext = anyMap["ext"] as! String
        self.date = anyMap["date"] as! Int
        self.type = anyMap["type"] as! Int
        self.url = anyMap["url"] as! String
    }
}

struct AttachmentDocAttachment: Decodable, JsonObjectInitProtocol {
    var type: String
    var doc: AttachmentDocAttachmentDoc
    
    init(from anyMap: [String : Any]) {
        self.type = anyMap["type"] as! String
        self.doc = AttachmentDocAttachmentDoc(from: anyMap["doc"] as! [String: Any])
    }
}

struct AttachmentDoc: Decodable, JsonObjectInitProtocol {
    var id: Int
    var fromId: UserID?
    var ownerId: UserID
    var date: Int
    var markedAsAds: Int?
    var postType: String?
    var text: String?
    var attachments: [AttachmentDocAttachment]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case fromId = "from_id"
        case ownerId = "owner_id"
        case date
        case markedAsAds = "market_as_ads"
        case postType = "post_type"
        case text
        case attachments
    }
    
    init(from anyMap: [String : Any]) {
        self.id = anyMap["id"] as! Int
        self.fromId = anyMap["from_id"] as? UserID
        self.ownerId = anyMap["owner_id"] as! UserID
        self.date = anyMap["date"] as! Int
        self.markedAsAds = anyMap["market_as_ads"] as? Int
        self.postType = anyMap["post_type"] as? String
        self.text = anyMap["text"] as? String
        
        if let att = anyMap["attachments"] as? [[String: Any]] {
            self.attachments = att.map {AttachmentDocAttachment(from: $0)}
        }
    }
}

enum Attachment {
    case photo(AttachmentPhoto)
    case postedPhoto(AttachmentPostedPhoto)
    case video(AttachmentVideo)
    case audio(AttachmentAudio)
    case link(AttachmentLink)
    case doc(AttachmentDoc)
    case event(AttachmentEvent)
    case album(AttachmentAlbum)
    
    enum type: String, Decodable {
        case photo
        case postedPhoto = "posted_photo"
        case video
        case audio
        case link
        case doc
        case event
        case album
    }
}

extension Attachment: Decodable, JsonObjectInitProtocol {
    
    private enum CodingKeys: String, CodingKey {
        case type
        case photo
        case postedPhoto = "posted_photo"
        case video
        case audio
        case link
        case doc
        case event
        case album
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(Attachment.type.self, forKey: .type)
        
        switch type {
        case .photo:
            let items = try container.decode(AttachmentPhoto.self, forKey: .photo)
            self = .photo(items)
        case .postedPhoto:
            let items = try container.decode(AttachmentPostedPhoto.self, forKey: .postedPhoto)
            self = .postedPhoto(items)
        case .video:
            let items = try container.decode(AttachmentVideo.self, forKey: .video)
            self = .video(items)
        case .audio:
            let items = try container.decode(AttachmentAudio.self, forKey: .audio)
            self = .audio(items)
        case .link:
            let items = try container.decode(AttachmentLink.self, forKey: .link)
            self = .link(items)
        case .doc:
            let items = try container.decode(AttachmentDoc.self, forKey: .doc)
            self = .doc(items)
        case .event:
            let items = try container.decode(AttachmentEvent.self, forKey: .event)
            self = .event(items)
        case .album:
            let items = try container.decode(AttachmentAlbum.self, forKey: .album)
            self = .album(items)
        }
    }
    
    init(from anyMap: [String : Any]) {
        let type = Attachment.type(rawValue: anyMap[CodingKeys.type.rawValue] as! String)!
        switch type {
        case .photo:
            let items = AttachmentPhoto(from: anyMap[CodingKeys.photo.rawValue] as! [String: Any])
            self = .photo(items)
        case .postedPhoto:
            let items = AttachmentPostedPhoto(from: anyMap[CodingKeys.postedPhoto.rawValue] as! [String:Any])
            self = .postedPhoto(items)
        case .video:
            let items = AttachmentVideo(from: anyMap[CodingKeys.video.rawValue] as! [String:Any])
            self = .video(items)
        case .audio:
            let items = AttachmentAudio(from: anyMap[CodingKeys.audio.rawValue] as! [String:Any])
            self = .audio(items)
        case .link:
            let items = AttachmentLink(from: anyMap[CodingKeys.link.rawValue] as! [String:Any])
            self = .link(items)
        case .doc:
            let items = AttachmentDoc(from: anyMap[CodingKeys.doc.rawValue] as! [String:Any])
            self = .doc(items)
        case .event:
            let items = AttachmentEvent(from: anyMap[CodingKeys.event.rawValue] as! [String:Any])
            self = .event(items)
        case .album:
            let items = AttachmentAlbum(from: anyMap[CodingKeys.album.rawValue] as! [String:Any])
            self = .album(items)
        }
    }
}
