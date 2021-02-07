//
//  NewsFeedTableViewCell.swift
//  SocialApp
//
//  Created by Дима Давыдов on 30.12.2020.
//

import UIKit


protocol CellHeightChangedDelegate: class {
    func cellHeightDidChanged(newHeight: CGFloat, at indexPath: IndexPath)
    func cellHeightWillChange(at indexPath: IndexPath)
}

struct Specs {
    static let topPaddingSize: CGFloat = 8
    static let leadingPaddingSize: CGFloat = 8
    static let trailingPaddingSize: CGFloat = 8
    static let bottomPaddingSize: CGFloat = 8
    
    static let paddingBetweenViews: CGFloat = 8
    static let avatarSize: CGSize = CGSize(width: 40, height: 40)
    static let bottomButtonsHeight: CGFloat = 20
    
    static let dateFormat: String = "dd.MM.yyyy HH.mm"
    
    static let maxTextViewHeight: CGFloat = 200
}

class NewsFeedTableViewCell: UITableViewCell {

    weak var cellHeightChangedDelegate: CellHeightChangedDelegate?
    
    // top views
    var avatar: UIImageView = UIImageView()
    var postOwner: UILabel = UILabel()
    var dateLabel: UILabel = UILabel()
    
    // middle view
    // text
    var textView: UITextView = UITextView()
    
    // bitton view
    var likeButton: UIButton = UIButton()
    var commentsButton: UIButton = UIButton()
    var shareButton: UIButton = UIButton()
    var viewsCount: UIButton = UIButton()
    var indexPath: IndexPath?
    
    var showMoreButton: UIButton = UIButton()
       
    var isFullTextShowing: Bool = false
    var isShowMoreButtonEnabled: Bool = false
    
    var showMoreButtonY: CGFloat {
        if showMoreButton.frame.height == 0 {
            return textView.frame.maxY + Specs.paddingBetweenViews
        }
        
        return showMoreButton.frame.maxY + Specs.paddingBetweenViews
    }
    
    lazy private var bottomItemWidth: CGFloat = {
        return ceil((UIScreen.main.bounds.width - Specs.leadingPaddingSize - Specs.trailingPaddingSize)/4)
    }()
    
    var cellHeight: CGFloat {
        
        var height: CGFloat = Specs.topPaddingSize + Specs.bottomPaddingSize + Specs.avatarSize.height + Specs.bottomButtonsHeight
        
        var textViewHeight = textView.sizeThatFits(CGSize(width: UIScreen.main.bounds.width - Specs.leadingPaddingSize - Specs.trailingPaddingSize, height: CGFloat.greatestFiniteMagnitude)).height + Specs.paddingBetweenViews + Specs.paddingBetweenViews
        
        if isShowMoreButtonEnabled && !isFullTextShowing {
            textViewHeight = Specs.maxTextViewHeight + Specs.paddingBetweenViews + Specs.paddingBetweenViews
        }
        
        height += textViewHeight
        
        height += showMoreButton.frame.height
        
        return height
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        contentView.addSubview(avatar)
        contentView.addSubview(postOwner)
        contentView.addSubview(dateLabel)
        contentView.addSubview(textView)
        contentView.addSubview(likeButton)
        contentView.addSubview(commentsButton)
        contentView.addSubview(shareButton)
        contentView.addSubview(viewsCount)
        contentView.addSubview(showMoreButton)
        
        postOwner.font = .systemFont(ofSize: 17)
        postOwner.numberOfLines = 0
        postOwner.backgroundColor = .systemBackground
        
        dateLabel.font = .systemFont(ofSize: 11)
        dateLabel.numberOfLines = 0
        dateLabel.backgroundColor = .systemBackground
        
        textView.font = .systemFont(ofSize: 13)
        textView.isEditable = false
        textView.textAlignment = .justified
        textView.textContainerInset = .zero
        textView.textContainer.lineFragmentPadding = 0
        textView.isScrollEnabled = false
        textView.isOpaque = false
        textView.textInputView.backgroundColor = .systemBackground
        textView.textInputView.isOpaque = false
        textView.layer.isOpaque = true
        textView.textContainer.lineBreakMode = .byTruncatingTail
        
        likeButton.setImage(UIImage.init(systemName: "suit.heart"), for: .normal)
        likeButton.setTitle("0", for: .normal)
        setupBottomButton(view: likeButton)
        
        commentsButton.setImage(UIImage.init(systemName: "bubble.left.and.bubble.right"), for: .normal)
        commentsButton.setTitle("0", for: .normal)
        setupBottomButton(view: commentsButton)
        
        shareButton.setImage(UIImage.init(systemName: "square.and.arrow.up"), for: .normal)
        shareButton.setTitle("0", for: .normal)
        setupBottomButton(view: shareButton)
        
        viewsCount.setImage(UIImage(systemName: "eye"), for: .normal)
        viewsCount.setTitle("0", for: .normal)
        viewsCount.isUserInteractionEnabled = false
        setupBottomButton(view: viewsCount)
        
        showMoreButton.setTitle("Show More", for: .normal)
        showMoreButton.titleLabel?.font = .systemFont(ofSize: 15)
        showMoreButton.setTitleColor(.gray, for: .normal)
        showMoreButton.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        showMoreButton.contentHorizontalAlignment = .right
        showMoreButton.addTarget(self, action: #selector(showMoreButtonPressed(_:)), for: .touchUpInside)
        showMoreButton.isUserInteractionEnabled = true
    
    }
    
    private func setupBottomButton(view: UIButton) {
        view.setTitleColor(.gray, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 11)
        view.imageView?.tintColor = .gray
        view.backgroundColor = .systemBackground
        view.titleLabel?.backgroundColor = .systemBackground
        view.imageView?.backgroundColor = .systemBackground
        view.imageView?.isOpaque = false
    }
    
    @objc func showMoreButtonPressed(_ sender: UIButton) {
        print("button pressed")
        if let indexPath = indexPath {
            cellHeightChangedDelegate?.cellHeightWillChange(at: indexPath)
        }
        
        if self.isFullTextShowing {
            self.showMoreButton.setTitle("Show more", for: .normal)
        } else {
            self.showMoreButton.setTitle("Show less", for: .normal)
        }
        
        self.isFullTextShowing.toggle()
        
        self.layoutTextView()
        self.layoutBottomButtons()
        if let indexPath = self.indexPath {
            self.cellHeightChangedDelegate?.cellHeightDidChanged(newHeight: self.cellHeight, at: indexPath)
        }

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)
    }
    
    //MARK: - setters
    
    func setText(text: String) {
        textView.text = text
        layoutTextView()
    }
    
    func setAvatarImage(_ img: UIImage) {
        avatar.image = img
        layoutAvatar()
    }
    
    func setPostOwner(_ text: String) {
        postOwner.text = text
        layoutPostOwner()
    }
    
    func setLike(count: Int, isUserLiked: Bool) {
        likeButton.setTitle(count.asString(), for: .normal)
        
        let imageName = isUserLiked ? "suit.heart.fill" : "suit.heart"
        
        likeButton.setImage(UIImage.init(systemName: imageName), for: .normal)
        likeButton.imageView?.tintColor = isUserLiked ? UIColor(named: "like") : .gray
        likeButton.setTitleColor(isUserLiked ? UIColor(named: "like") : .gray, for: .normal)
        
        layoutLikeButton()
    }
    
    func setComments(count: Int) {
        commentsButton.setTitle(count.asString(), for: .normal)
        layoutCommentsButton()
    }
    
    func setShare(count: Int) {
        shareButton.setTitle(count.asString(), for: .normal)
        layoutShareButton()
    }
    
    func setViewsCount(count: Int) {
        viewsCount.setTitle(count.asString(), for: .normal)
        layoutViewCount()
    }
    
    func setdate(_ timestamp: TimeInterval) {
        
        let dateFormatterInstance = DateTimeFormatterService.getInstance(format: Specs.dateFormat);
        
        _ = dateFormatterInstance.format(from: timestamp).done(on: .main) { [weak self] result in
            self?.dateLabel.text = result
            self?.layoutDate()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // first row views
        layoutAvatar()
        layoutPostOwner()
        layoutDate()
        
        
        // middle row
        layoutTextView()
        
        // bottom row
        
        layoutBottomButtons()
    }
    
    private func layoutBottomButtons() {
        layoutLikeButton()
        layoutCommentsButton()
        layoutShareButton()
    
        layoutViewCount()
    }
    
    //MARK: - layout views
    
    private func layoutViewCount() {
        viewsCount.frame = CGRect(
            x: shareButton.frame.maxX,
            y: shareButton.frame.minY,
            width: bottomItemWidth,
            height: Specs.bottomButtonsHeight
        )
        viewsCount.contentHorizontalAlignment = .right
    }
    
    private func layoutTextView() {
        let contentSize = textView.sizeThatFits(CGSize(width: UIScreen.main.bounds.width - Specs.leadingPaddingSize - Specs.trailingPaddingSize, height: CGFloat.greatestFiniteMagnitude))
        
        print("content size: \(contentSize.height) at indexPath: \(indexPath)")
        
        var frameHeight: CGFloat = contentSize.height
        
        isShowMoreButtonEnabled = contentSize.height > Specs.maxTextViewHeight
        
        if isFullTextShowing && isShowMoreButtonEnabled {
            frameHeight = ceil(contentSize.height)
        } else if isShowMoreButtonEnabled {
            frameHeight = Specs.maxTextViewHeight
        }
        
        textView.frame = CGRect(
            x: Specs.leadingPaddingSize,
            y: avatar.frame.maxY + Specs.paddingBetweenViews,
            width: contentSize.width,
            height: frameHeight
        )
        
        if isShowMoreButtonEnabled {
            showMoreButton.frame = CGRect(
                x: Specs.leadingPaddingSize,
                y: textView.frame.maxY ,
                width: UIScreen.main.bounds.width - Specs.leadingPaddingSize - Specs.leadingPaddingSize,
                height: getLabelSize(text: showMoreButton.titleLabel?.text, font: .systemFont(ofSize: 15)).height
            )
        }
    }
    
    private func layoutLikeButton() {
        likeButton.frame = CGRect(
            x: Specs.leadingPaddingSize,
            y: showMoreButtonY,
            width: bottomItemWidth,
            height: Specs.bottomButtonsHeight
        )
        likeButton.contentHorizontalAlignment = .left
    }
    
    private func layoutCommentsButton() {
        commentsButton.frame = CGRect(
            x: likeButton.frame.maxX,
            y: likeButton.frame.minY,
            width: bottomItemWidth,
            height: Specs.bottomButtonsHeight
        )
        commentsButton.contentHorizontalAlignment = .left
    }
    
    private func layoutShareButton() {
        shareButton.frame = CGRect(
            x: commentsButton.frame.maxX,
            y: commentsButton.frame.minY,
            width: bottomItemWidth,
            height: Specs.bottomButtonsHeight
        )
        shareButton.contentHorizontalAlignment = .left
    }
    
    private func layoutAvatar() {
        avatar.frame = CGRect(
            x: Specs.leadingPaddingSize,
            y: Specs.topPaddingSize,
            width: Specs.avatarSize.width,
            height: Specs.avatarSize.height
        )
    }
    
    private func layoutPostOwner() {
        postOwner.frame = CGRect(
            x: avatar.frame.maxX + Specs.paddingBetweenViews,
            y: Specs.topPaddingSize,
            width: bounds.width - avatar.bounds.maxX - Specs.trailingPaddingSize,
            height: getLabelSize(text: postOwner.text, font: .systemFont(ofSize: 17)).height
        )
    }
    
    private func layoutDate() {
        dateLabel.frame = CGRect(
            x: avatar.frame.maxX + Specs.paddingBetweenViews,
            y: Specs.topPaddingSize + postOwner.frame.height + Specs.paddingBetweenViews,
            width: bounds.width - avatar.bounds.maxX - Specs.trailingPaddingSize,
            height: getLabelSize(text: dateLabel.text, font: .systemFont(ofSize: 11)).height
        )
    }
    
    func getLabelSize(text: String!, font: UIFont) -> CGSize {
        guard let text = text else {
            return CGSize(width: 0, height: 0)
        }
        // определяем максимальную ширину текста - это ширина ячейки минус отступы слева и справа
        let maxWidth = bounds.width - Specs.trailingPaddingSize
        // получаем размеры блока под надпись
        // используем максимальную ширину и максимально возможную высоту
        let textBlock = CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude)
        // получаем прямоугольник под текст в этом блоке и уточняем шрифт
        let rect = text.boundingRect(with: textBlock, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        // получаем ширину блока, переводим её в Double
        let width = Double(rect.size.width)
        // получаем высоту блока, переводим её в Double
        let height = Double(rect.size.height)
        // получаем размер, при этом округляем значения до большего целого числа
        let size = CGSize(width: ceil(width), height: ceil(height))
        
        return size
    }
}
