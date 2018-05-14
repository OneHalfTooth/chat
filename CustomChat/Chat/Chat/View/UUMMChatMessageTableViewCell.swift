//
//  UUMMChatMessageTableViewCell.swift
//  UUMMShop
//
//  Created by 马扬 on 2018/5/12.
//  Copyright © 2018年 mayang. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import SwiftyJSON

class UUMMChatMessageTableViewCell: UITableViewCell {

    var model : UUMMChatModel?{
        didSet{
            self.update()
        }
    }

    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var userImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = KBackgroundColor
        
        self.contentLabel.preferredMaxLayoutWidth = screenWidth - CGFloat(131.0)

        let top : CGFloat = 17.0
        let left : CGFloat = 6.0
        let bottom : CGFloat = 6.0
        let right : CGFloat = 7.0
        let image = UIImage.init(named: "myqp")?.resizableImage(withCapInsets: UIEdgeInsetsMake(top, left, bottom, right), resizingMode: UIImageResizingMode.stretch)
        self.backImageView.image = image
    }

    fileprivate func update(){
        guard self.model != nil else {
            return
        }
//        guard let data = content.data(using: String.Encoding.utf8) else{
//            return
//        }
//        guard let att = try? NSAttributedString.init(data: data, options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) else {
//            return
//        }
//        self.contentLabel.attributedText = att
        self.contentLabel.attributedText = self.model?.Content
    }



    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
