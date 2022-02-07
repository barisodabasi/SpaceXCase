//
//  NetworkLaunchResponse.swift
//  SpaceXLaunchCase
//
//  Created by BarisOdabasi on 7.02.2022.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkLaunchResponse {
    
   static func getLaunch(completionHandler: @escaping (_ result: NetworkLaunchModel?, _ error: String?) -> Void){
    let baseUrl = URL(string: "https://api.spacexdata.com/v4/launches/latest")!
    
    AF.request(baseUrl).responseJSON { response in
        debugPrint(response)
        switch response.result {
        case .success(let jsonResult):
            print("getLaunch Response : \(jsonResult)")
            do{
                let userDataResponse = try JSONDecoder().decode(NetworkLaunchModel.self, from: try JSON(jsonResult).rawData())
                if (response.response?.statusCode == 200){
                    completionHandler(userDataResponse, nil)
                }else {
                    completionHandler(nil, userDataResponse.details)
                }
            } catch let error{
                print("getLaunch Json Parse Error : \(error)")
                completionHandler(nil, "\(error)")
            }
        case .failure(let error):
            print("getLaunch Request failed with error: \(error)")
        }
    }
}

}
