//
//  ZYNetworkTools.swift
//  志远直播
//
//  Created by 梁志远 on 16/10/11.
//  Copyright © 2016年 soufunmedia. All rights reserved.
//

import UIKit
import Alamofire

enum returnDataType {
    ///json数据
    case JSON
    ///xml数据
    case XML
}

class ZYNetworkTools{
    
    
    /// 发送POST请求
    class func POST_Request(_ urlString : String, params : [String : String], returnDataType: returnDataType, finishedCallback : @escaping (_ responseObject : Any)->()) {
        let messagename = params["messagename"] ?? "无名氏"
        switch returnDataType {
        case .JSON:
            Alamofire.request(urlString, method: .post, parameters: params, encoding: URLEncoding.default).responseJSON { (response) in
                //打印接口地址
                print("接口\(messagename)地址：\(response.request!)")
                //获取结果
                guard let result = response.result.value else {
                    print("接口\(messagename)失败原因:\(response.result.error)")
                    return
                }
                // 将结果回调出去
                finishedCallback(result)
            }
        default:
            Alamofire.request(urlString, method: .post, parameters: params, encoding: URLEncoding.default).responseData(completionHandler: { (responseXML) in
                //打印接口地址
                print("接口\(messagename)地址：\(responseXML.request!)")
                //获取结果
                guard let resultXML = responseXML.result.value else {
                    print("接口\(messagename)失败原因:\(responseXML.result.error)")
                    return
                }
                // 将结果回调出去
                finishedCallback(resultXML)
            })
        }
    }
    
    /// 发送GET请求
    class func GET_Request(_ urlString : String, params : [String : String], returnDataType: returnDataType, finishedCallback : @escaping (_ responseObject : Any)->()) {
        let messagename = params["messagename"] ?? "无名氏"
        switch returnDataType {
        case .JSON:
            Alamofire.request(urlString, method: .get, parameters: params, encoding: URLEncoding.default).responseJSON { (response) in
                //打印接口地址
                print("接口\(messagename)地址：\(response.request!)")
                //获取结果
                guard let result = response.result.value else {
                    print("接口\(messagename)失败原因:\(response.result.error)")
                    return
                }
                // 将结果回调出去
                finishedCallback(result)
            }
        default:
            Alamofire.request(urlString, method: .get, parameters: params, encoding: URLEncoding.default).responseData(completionHandler: { (responseXML) in
                //打印接口地址
                print("接口\(messagename)地址：\(responseXML.request!)")
                //获取结果
                guard let resultXML = responseXML.result.value else {
                    print("接口\(messagename)失败原因:\(responseXML.result.error)")
                    return
                }
                // 将结果回调出去
                finishedCallback(resultXML)
            })
        }
        
    }

}
