//
//  ApiGetResponse.swift
//  Exito
//
//  Created by Mayerly Rios on 9/4/19.
//  Copyright © 2019 Pragma S.A. All rights reserved.
//

import Foundation
import UIKit

public class ApiResponse {

    func getData(url:String, Ok:@escaping((NSData) -> Void), Error:@escaping((NSError) -> Void))
    {
             
            let apiRest = ApiService()
            let headers = [
                "Content-Type":"application/json"]
            
            apiRest.getApi(url: url,
                           Headers: headers as NSDictionary,
                           statusCodeCorrect: [200, 201],
                           Ok: {data in
                            
                            Ok(data as NSData)
                            
            }, Error: {error in
                
                Error(error as NSError)
            })
    }
    
    
    func postData(url:String, parameters:NSDictionary, Ok:@escaping((NSData) -> Void), Error:@escaping((NSError) -> Void))
    {

            let apiRest = ApiService()
            let headers = [
                "Content-Type":"application/json"]
            
            apiRest.postApi(url: url,
                            headers: headers,
                            parameters: parameters,
                            statusCodeCorrect: [200, 201],
                            Ok: {data in
                                Ok(data as NSData)
            }, Error: {error in
                Error(error as NSError)
            })
    }
    
    func putData(url:String, parameters:NSDictionary, Ok:@escaping((NSData) -> Void), Error:@escaping((NSError) -> Void))
    {
        

            let apiRest = ApiService()
            let headers = [
                "Content-Type":"application/json"]
            
            apiRest.putApi(url: url,
                           headers: headers,
                           parameters: parameters,
                           statusCodeCorrect: [200, 201],
                           Ok: {data in
                            Ok(data as NSData)
            }, Error: {error in
                
                Error(error as NSError)
            })
    }
    
    
    
}
