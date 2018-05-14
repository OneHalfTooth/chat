//
//  UUMMChatViewController.swift
//  UUMMShop
//
//  Created by 马扬 on 2018/5/12.
//  Copyright © 2018年 mayang. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import SwiftyJSON

class UUMMChatViewController: UUMMBaseViewController {

    let viewModel = UUMMChatViewModel()

    var tableView : UUMMChatTableView?
    var editView : UUMMChatEditView?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = KBackgroundColor
        self.viewModel.vc = self
        self.viewModel.bind()


    }

    internal override func createView(){

        self.createEditView()
        self.createTableView()

    }
    fileprivate func createEditView(){

        guard let nibs = Bundle.main.loadNibNamed("UUMMChatEditView", owner: self, options: nil) else {
            return
        }
        guard let xib = nibs.last as? UUMMChatEditView else {
            return
        }
        self.editView = xib
        self.editView?.createView()
        self.view.addSubview(self.editView!)
        self.editView?.snp.makeConstraints({ (make) in
            make.bottom.left.right.equalToSuperview()
        })
    }

    fileprivate func createTableView(){

        guard self.editView != nil else {
            return
        }
        self.tableView = UUMMChatTableView.init(frame: .zero, style: .plain)
        self.view.addSubview(self.tableView!)
        self.tableView?.snp.makeConstraints({[weak self] (make) in
            make.left.right.top.equalToSuperview()
            make.bottom.equalTo(self!.editView!.snp.top)
        })
    }


}
