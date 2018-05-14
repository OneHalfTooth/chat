//
//  UUMMChatOrderInfoTableViewCell.swift
//  UUMMShop
//
//  Created by 马扬 on 2018/5/4.
//  Copyright © 2018年 mayang. All rights reserved.
//

import UIKit

class UUMMChatOrderInfoTableViewCell: UITableViewCell {

    /** 背景视图 */
    @IBOutlet weak var backView: UIView!
    /** 订单号 */
    @IBOutlet weak var orderNumberLabel: UILabel!

    /** 游戏区服 */
    @IBOutlet weak var gameAreaLabel: UILabel!
    /** 商品类型 */
    @IBOutlet weak var productType: UILabel!
    /** 商品标题 */
    @IBOutlet weak var titleLabel: UILabel!
    /** 购买件数 */
    @IBOutlet weak var buyNumberLabel: UILabel!

    /** 订单金额 */
    @IBOutlet weak var orderMoneyNumberLabel: UILabel!
    /** 交易总数 */
    @IBOutlet weak var moneyNumberLabel: UILabel!

    /** 收货角色名 */
    @IBOutlet weak var userNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()

        self.backView.cornetRadiu(radiu: 3)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
