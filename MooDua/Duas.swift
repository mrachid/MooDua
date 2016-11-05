//
//  Duas.swift
//  MooDua
//
//  Created by Rachid on 25/10/2016.
//  Copyright © 2016 Rachid. All rights reserved.
//

import Foundation
import Firebase
import SwiftyJSON

class Duas {
    
    var chapName: [String] = []
    var duaInfos: [(String?,String?,String?,String?)] = []
    private var dua : JSON?
    
    init(dua: JSON?) {
        self.dua = dua
    }
    
    func parseDuaInfo() {
        if let duas = dua{
            for (key,subJson):(String, JSON) in duas {
                chapName.append(key)
                let data = (subJson.dictionary?["Ar"]?.stringValue, subJson.dictionary?["Fr"]?.stringValue, subJson.dictionary?["Tr"]?.stringValue, subJson.dictionary?["Audio"]?.stringValue)
                duaInfos.append(data)
            }
        
        }
    }

}
