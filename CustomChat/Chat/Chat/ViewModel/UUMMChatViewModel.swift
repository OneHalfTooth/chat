//
//  UUMMChatViewModel.swift
//  UUMMShop
//
//  Created by 马扬 on 2018/5/12.
//  Copyright © 2018年 mayang. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import SwiftyJSON

class UUMMChatViewModel: NSObject {

    

    weak var vc : UUMMChatViewController?
    /** 和卖家聊天 */
    var chat : UUMMSignalRManager?

    /** 和谁聊天
     * 3 卖家
     * 2 客服 */
    var type : Variable<String> = Variable("3")

    /** 消息列表 */
    var datas2 : Variable<[UUMMChatModel]> = Variable([])
    var datas3 : Variable<[UUMMChatModel]> = Variable([])

    /** 订单号 */
    var orderNo : Variable<String> = Variable("")
    var ASPNETSESSIONGUID : Variable<String> = Variable("")


    override init() {
        super.init()
    }

    func bind(){

        self.orderNo.asObservable().subscribe(onNext: {[weak self] (x) in
            self?.createChat()
        }).disposed(by: disposeBag)
        self.type.asObservable().subscribe(onNext: {[weak self] (x) in
            if x == "3"{
                self?.vc?.title = "与卖家聊天"
                return
            }
            self?.vc?.title = "与客服聊天"
        }).disposed(by: disposeBag)

    }

    /** 接收到新的scoket消息 */
    fileprivate func receiveMessage(x:JSON){

        var lastId = x["lastID2"].stringValue
        if x["msgType"].stringValue == "3"{
            lastId = x["lastID3"].stringValue
            /** 获取所有历史消息 ，只有进入的时候会获取默认历史消息，所以只有在type==3的时候才会获取*/
            if lastId == "0"{
                self.datas2.value =  self.createModel(by: x["data"]["msgType2"])
                self.datas3.value = self.createModel(by: x["data"]["msgType3"])
                self.vc?.tableView?.datas = self.datas3.value
                return
            }
            /** 收到新消息 */
//            guard let data = try? self.datas3.value.merged(with: x["data"]["msgType3"])else{
//                return
//            }
//            self.datas3.value = data
//            if self.type.value == "3"{
//                self.vc?.tableView?.datas = self.datas3.value
//            }
            return
        }

        /** 获取最新消息 */
        /** 收到新消息 */
//        guard let data = try? self.datas2.value.merged(with: x["data"]["msgType2"])else{
//            return
//        }
//        self.datas2.value = data
//        if self.type.value == "2"{
//            self.vc?.tableView?.datas = self.datas2.value
//        }

    }

    /** 通过json 创建model */
    fileprivate func createModel(by json : JSON) -> ([UUMMChatModel]){

        var datas = [UUMMChatModel]()
        for (_,model) in json {

            let chatModel = UUMMChatModel()
            if let data = model["Content"].stringValue.data(using: String.Encoding.utf8){
                if let att = try? NSAttributedString.init(data: data, options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
                        chatModel.Content = att
                    }
            }
            chatModel.Receiver = model["Receiver"].stringValue
            chatModel.ID = model["ID"].stringValue
            chatModel.MsgType = model["MsgType"].stringValue
            chatModel.Sender = model["Sender"].stringValue
            chatModel.SenderType = model["SenderType"].stringValue
            chatModel.CreatedTime = model["CreatedTime"].stringValue
            datas.append(chatModel)
        }
        return datas
    }
    /** 创建scoket 链接 */
    fileprivate func createChat(){
        
        if self.ASPNETSESSIONGUID.value == "" || self.orderNo.value == "" {
            return
        }
        self.chat = UUMMSignalRManager.init(orderNO: self.orderNo.value, ASPNETSESSIONGUID: self.ASPNETSESSIONGUID.value)
        self.chat?.online()
        self.chat?.connectioned.subscribe({[weak self] (x) in
            self?.chat?.receiveMsgList(ID: self!.orderNo.value, msgType: self!.type.value, lastID2: "0", lastID3: "0")
        }).disposed(by: disposeBag)

        self.chat?.receiveSignal.subscribe(onNext: {[weak self] (x) in

            self?.receiveMessage(x: x)
        }).disposed(by: disposeBag)
        self.chat?.sendSignal.subscribe(onNext: { (x) in

        }).disposed(by: disposeBag)
    }
}
