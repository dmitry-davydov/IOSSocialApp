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

struct AttachmentPhoto: Decodable {
    var id: Int
    var albumId: Int
    var ownerId: UserID
    var userId: UserID
    var text: String
    var date: Int
    var sizes: [AttachmentPhotoSize]
    var width: Int?
    var height: Int?
    
    enum CodingKeys: String, CodingKey {
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
}
struct AttachmentPostedPhoto: Decodable {
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
}

struct AttachmentVideoImage: Decodable {
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
}

struct AttachmentVideoFrame: Decodable {
    var height: Int
    var url: String
    var width: Int
}

struct AttachmentVideoLikes: Decodable {
    var count: Int
    var userLikes: Int
    
    enum CodingKeys: String, CodingKey {
        case count
        case userLikes = "user_likes"
    }
}

struct AttachmentVideoReposts: Decodable {
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
}

struct AttachmentVideo: Decodable {
    var id: Int
    var ownerId: UserID
    var title: String
    var description: String
    var duration: Int
    var image: [AttachmentVideoImage]
    var firstFrame: [AttachmentVideoFrame]
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
    var width: Int
    var height: Int
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
    
}
struct AttachmentAudio: Decodable {
    var id: Int
    var ownerId: UserID
    var artist: String
    var title: String
    var duration: Int
    var url: String
    var lyricsId: Int
    var albumId: Int
    var genreId: Int
    var date: Int
    var noSearch: Int
    var isHQ: Int
    
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
}

struct AttachmentLink: Decodable {
    var url: String
    var title: String
    var caption: String?
    var description: String
    var photo: AttachmentPhoto?
    var isFavorite: Bool
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
}

struct AttachmentDocAttachmentDoc: Decodable {
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
}

struct AttachmentDocAttachment: Decodable {
    var type: String
    var doc: AttachmentDocAttachmentDoc
}

struct AttachmentDoc: Decodable {
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
}

enum Attachment {
    case photo(AttachmentPhoto)
    case postedPhoto(AttachmentPostedPhoto)
    case video(AttachmentVideo)
    case audio(AttachmentAudio)
    case link(AttachmentLink)
    case doc(AttachmentDoc)
    
    enum type: String, Decodable {
        case photo
        case postedPhoto = "posted_photo"
        case video
        case audio
        case link
        case doc
    }
}

extension Attachment: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case type
        case photo
        case postedPhoto = "posted_photo"
        case video
        case audio
        case link
        case doc
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
        }
    }
}


