//
//  UUMMChatEditView.swift
//  UUMMShop
//
//  Created by 马扬 on 2018/5/12.
//  Copyright © 2018年 mayang. All rights reserved.
//

import UIKit

class UUMMChatEditView: UIView,UITextViewDelegate {

    @IBOutlet weak var 确认收货按钮: UIButton!

    @IBOutlet weak var 未收到货按钮: UIButton!

    @IBOutlet weak var 联系客服按钮: UIButton!
    
    @IBOutlet weak var 发送订单按钮: UIButton!
    @IBOutlet weak var textView: editTextView!
    @IBOutlet weak var 表情按钮: UIButton!
    @IBOutlet weak var imageViewButton: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)

    }


    func createView() -> Void {
        self.发送订单按钮.cornetRadiu(radiu: 10)
        self.未收到货按钮.cornetRadiu(radiu: 10)
        self.联系客服按钮.cornetRadiu(radiu: 10)
        self.确认收货按钮.cornetRadiu(radiu: 10)

        self.发送订单按钮.addBorder(width: 0.5, color: KColor333)
        self.未收到货按钮.addBorder(width: 0.5, color: KColor333)
        self.联系客服按钮.addBorder(width: 0.5, color: KColor333)
        self.确认收货按钮.addBorder(width: 0.5, color: KColor333)

    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {

        if text == "\n" {
            return false
        }
        return true
    }
}

class editTextView: UITextView {
    override var contentSize: CGSize{
        didSet{
            var height = contentSize.height < 32 ? 32 : contentSize.height
            height = height > 100 ? 100 : height
            self.snp.updateConstraints { (make) in
                make.height.equalTo(height)
            }
        }
    }
}
