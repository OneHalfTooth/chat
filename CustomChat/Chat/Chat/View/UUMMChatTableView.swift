//
//  UUMMChatTableView.swift
//  UUMMShop
//
//  Created by 马扬 on 2018/5/12.
//  Copyright © 2018年 mayang. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import SwiftyJSON

class UUMMChatTableView: UITableView,UITableViewDelegate,UITableViewDataSource {

    /** 数据源 */
    var datas : [UUMMChatModel] = []{
        didSet{
            self.reloadData()
        }
    }

    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.delegate = self
        self.dataSource = self
        self.separatorStyle = .none
        self.backgroundColor = KBackgroundColor
        self.register(UINib.init(nibName: "UUMMChatMessageTableViewCell", bundle: nil), forCellReuseIdentifier: "UUMMChatMessageTableViewCell")
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datas.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cell = self.tableView(self, cellForRowAt: indexPath)
        let height = cell.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
        return height
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "UUMMChatMessageTableViewCell") as! UUMMChatMessageTableViewCell
        cell.model = self.datas[indexPath.row]
        return cell
    }

}
