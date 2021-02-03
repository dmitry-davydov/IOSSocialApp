//
//  AlbumCollectionViewController.swift
//  SocialApp
//
//  Created by Дима Давыдов on 03.02.2021.
//

import Foundation
import AsyncDisplayKit

class AlbumCell: ASCellNode {
    var photo: PhotoAlbum
    var image = ASNetworkImageNode()
    var albumName = ASTextNode()
    
    var imageWidth: CGFloat = 604
    var imageHeight: CGFloat = 456
    
    init(photo: PhotoAlbum) {
        self.photo = photo
        
        self.albumName.attributedText = NSAttributedString(string: photo.title)
        
        var photoSize: PhotoSize?
        if let size = photo.sizes.find(by: .x) {
            photoSize = size
        } else if let size = photo.sizes.sortByWidth().last {
            photoSize = size
        }
        
        if let ps = photoSize{
            if ps.width > 0 {
                imageWidth = CGFloat(ps.width)
            }
            
            if ps.height > 0 {
                imageHeight = CGFloat(ps.height)
            }
            
            image.url = ps.imageUrl()
        } else {
            self.image.url = URL(string: "https://placeimg.com/640/480/any")!
            self.imageWidth = 640
            self.imageHeight = 480
        }
        print("\(image.url?.absoluteString) width: \(imageWidth) height: \(imageHeight)")
        super.init()
        self.automaticallyManagesSubnodes = true
    }
    
    private func getExactImageSize() -> CGSize {
        let width = bounds.size.width
        let aspectRatio: CGFloat = CGFloat(imageHeight)/CGFloat(imageWidth)
        let height: CGFloat = ceil(width*aspectRatio)
        
        return CGSize(width: width, height: height)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        image.style.flexShrink = 1.0
        image.style.flexGrow = 1.0
        image.contentMode = .scaleAspectFit
        image.style.width = ASDimension(unit: .fraction, value: bounds.size.width)
        
//        let newSize = getExactImageSize()
        
//        image.style.preferredSize = newSize
        
        let imageWithRatio = ASRatioLayoutSpec(ratio: imageHeight/imageWidth, child: image)
        
        let mainStack = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 5,
            justifyContent: .center,
            alignItems: .start,
            children: [imageWithRatio, albumName]
        )
        
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5), child: mainStack)
    }
    
}

class Pager {
    var offset = 0
    var limit = 50
    var totalItems: Int = 0
}

class AlbumCollectionViewController: ASDKViewController<ASTableNode> {

    let userId: UserID
    let endpoint = Photos()
    var userAlbums: [PhotoAlbum] = []
    
    let pager = Pager()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(userId: UserID) {
        self.userId = userId
        super.init(node: ASTableNode(style: .plain))
        self.node.delegate = self
        self.node.dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUserAlbums()
    }
    
    func fetchUserAlbums(refresh: Bool = false) {
        let requst = PhotosGetAlbumsRequest(
            ownerId: userId.asString(),
            albumIds: nil,
            offset: refresh ? 0 : pager.offset,
            needSystem: true,
            needCovers: true,
            photoSizes: true
        )
        
        endpoint.getAlbums(request: requst).done { [weak self] (resp) in
            print("Got \(resp.items.count) albums with userId: \(self?.userId)")
            
            self?.userAlbums += resp.items
            self?.pager.totalItems = resp.count
            
            self?.pager.offset = refresh ? 0 : self?.userAlbums.count ?? 0
            self?.node.reloadData()
        }
        .catch { (err) in
            debugPrint("Catched: " + err.localizedDescription)
        }
        .finally {
            print("Api request is done")
        }
    }
    
}

extension AlbumCollectionViewController: ASTableDelegate, ASTableDataSource {
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return userAlbums.count
    }
    
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return 1
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        guard userAlbums.count > indexPath.row else { return { ASCellNode() } }
        let albumDto = userAlbums[indexPath.row]
        
        return {
            return AlbumCell(photo: albumDto)
        }
    }
}
