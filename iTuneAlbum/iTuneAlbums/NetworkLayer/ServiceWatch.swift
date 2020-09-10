//
//  ServiceWatch.swift
//  iTueneAlbums
//
//  Created by Suresh Dokula on 09/10/20.
//  Copyright © 2020 suresh. All rights reserved.
//

import Foundation

class ServiceWatch {
    var request:URLRequest?
    var response:URLResponse?
    var startDate:Date?
    var endDate:Date?
    var result:ResponseResult?
}

class ResponseResult {
    
    private (set) var statusCode:Int?
    private (set) var resonseDescription:String?
    private (set) var headerFileds:String?
    private (set) var error:Error?
    
    init(code:Int?, headerFileds:String?, description:String?, error:Error?){
        self.statusCode = code
        self.resonseDescription = description
        self.headerFileds = headerFileds
        self.error = error
    }
}

