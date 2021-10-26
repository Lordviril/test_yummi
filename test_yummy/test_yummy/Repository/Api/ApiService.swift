//
//  ApiRequest.swift
//  Exito
//
//  Created by Mayerly Rios on 9/3/19.
//  Copyright © 2019 Pragma S.A. All rights reserved.
//

import Foundation
import Alamofire

public class ApiService {
    func getApi(url:String,
                Headers:NSDictionary,
                statusCodeCorrect:[Int],
                Ok:@escaping ((Data) -> Void),
                Error:((Error) -> Void))
    {
        
        Alamofire.request(url, method: .get, headers: Headers as? HTTPHeaders).responseJSON { response in
            
            switch response.result
            {
                case .success:
                    let result = response.data
                    Ok(result!)
                case .failure:
                    let result = response.data
                    Ok(result!)
                
            }
            
        }
    }
    
    
    func getApiCorrect(url:String,
                Headers:NSDictionary,
                statusCodeCorrect:[Int],
                Ok:@escaping ((Data) -> Void),
                Error:@escaping((Error) -> Void))
    {
        
        Alamofire.request(url, method: .get, headers: Headers as? HTTPHeaders).responseJSON { response in
            print("::: STATUS CODE \(String(describing: response.response?.statusCode))")

            
            var isCorrect = false;
            for status in statusCodeCorrect{
                if response.response?.statusCode == status{
                    isCorrect = true;
                    break
                }
            }
            if isCorrect
            {
                let result_ = response.data
                Ok(result_!)
            }else{
                if let errorrr = response.error{
                    Error(errorrr)
                }else{
                    let errorTemp = NSError(domain:"Ha ocurrido un erro", code:302, userInfo:nil)

                    Error(errorTemp)
                }
                //definir errores
            }
        }
    }
    
    func postApiCorrect(url: String,
                 headers: HTTPHeaders,
                 parameters: NSDictionary?,
                 statusCodeCorrect:[Int],
                 Ok: @escaping((Data) -> Void),
                 Error: @escaping((Error) -> Void))
    {
        Alamofire.request(url, method: .post, parameters: parameters as? Parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            
            print("::: STATUS CODE \(response.response?.statusCode ?? 0)")
             var isCorrect = false;
             for status in statusCodeCorrect{
                 if response.response?.statusCode == status{
                     isCorrect = true;
                     break
                 }
             }
             if isCorrect
             {
                 let result_ = response.data
                 Ok(result_!)
             }else{
                 if let errorrr = response.error{
                     Error(errorrr)
                 }else{
                     let errorTemp = NSError(domain:"Ha ocurrido un erro", code:302, userInfo:nil)

                     Error(errorTemp)
                 }
                 
                 //definir errores
             }
        }
    }
    
    func deleteApiCorrect(url: String,
                 headers: HTTPHeaders,
                 parameters: NSDictionary?,
                 statusCodeCorrect:[Int],
                 Ok: @escaping((Data) -> Void),
                 Error: @escaping((Error) -> Void))
    {
        Alamofire.request(url, method: .delete, parameters: parameters as? Parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            
            print("::: STATUS CODE \(response.response?.statusCode ?? 0)")
             var isCorrect = false;
             for status in statusCodeCorrect{
                 if response.response?.statusCode == status{
                     isCorrect = true;
                     break
                 }
             }
             if isCorrect
             {
                 let result_ = response.data
                 Ok(result_!)
             }else{
                 if let errorrr = response.error{
                     Error(errorrr)
                 }else{
                     let errorTemp = NSError(domain:"Ha ocurrido un erro", code:302, userInfo:nil)

                     Error(errorTemp)
                 }
                 
                 //definir errores
             }
        }
    }
    
    
    func postApi(url: String,
                 headers: HTTPHeaders,
                 parameters: NSDictionary?,
                 statusCodeCorrect:[Int],
                 Ok: @escaping((Data) -> Void),
                 Error: ((Error) -> Void))
    {
        Alamofire.request(url, method: .post, parameters: parameters as? Parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
           
            switch response.result
            {
                case .success:
                    let result = response.data
                    Ok(result!)
                case .failure:
                    let result = response.data

                    Ok(result!)
            }
        }
    }
    
    func putApi(url: String,
                    headers: HTTPHeaders,
                    parameters: NSDictionary?,
                    statusCodeCorrect:[Int],
                    Ok: @escaping((Data) -> Void),
                    Error: ((Error) -> Void))
       {
           Alamofire.request(url, method: .put, parameters: parameters as? Parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
               
               switch response.result
               {
                   case .success:
                       let result = response.data
                       Ok(result!)
                   case .failure:
                       let result = response.data
                       Ok(result!)
               }
           }
       }
    
    
    


    
    
}

