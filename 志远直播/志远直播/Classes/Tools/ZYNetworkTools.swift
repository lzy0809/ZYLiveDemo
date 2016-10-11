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
    class func POST_Request(_ urlString : String, params : [String : String], returnDataType: returnDataType, success : @escaping (_ responseObject : Any)->(), failture : @escaping (_ error : NSError)->()) {
        let messagename = params["messagename"] ?? "无名氏"
        switch returnDataType {
        case .JSON:
            Alamofire.request(urlString, method: .post, parameters: params, encoding: URLEncoding.default).responseJSON { (response) in
                print("网络请求\(messagename)的接口是：\(response.request!)")
                switch response.result{
                case .success(let data):
                    success(data)
                case .failure(let encodingError):
                    failture(encodingError as NSError)
                    
                }
            }
        default:
            Alamofire.request(urlString, method: .post, parameters: params, encoding: URLEncoding.default).responseData(completionHandler: { (responseXML) in
                print("网络请求\(messagename)的接口是：\(responseXML.request!)")
                switch responseXML.result{
                case .success( _):
                    success(responseXML.data)
                case .failure(let encodingError):
                    failture(encodingError as NSError)
                    
                }
            })
        }
    }
    
    /// 发送GET请求
    class func GET_Request(_ urlString : String, params : [String : String], returnDataType: returnDataType, success : @escaping (_ responseObject : Any)->(), failture : @escaping (_ error : NSError)->()) {
        let messagename = params["messagename"] ?? "无名氏"
        switch returnDataType {
        case .JSON:
            Alamofire.request(urlString, method: .get, parameters: params, encoding: URLEncoding.default).responseJSON { (response) in
                print("网络请求\(messagename)的接口是：\(response.request!)")
                switch response.result{
                case .success(let data):
                    success(data)
                case .failure(let encodingError):
                    failture(encodingError as NSError)
                    
                }
            }
        default:
            Alamofire.request(urlString, method: .get, parameters: params, encoding: URLEncoding.default).responseData(completionHandler: { (responseXML) in
                print("网络请求\(messagename)的接口是：\(responseXML.request!)")
                switch responseXML.result{
                case .success( _):
                    success(responseXML.data)
                case .failure(let encodingError):
                    failture(encodingError as NSError)
                    
                }
            })
        }
        
    }
}
