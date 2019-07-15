//
//  Coments.swift
//  Comments
//
//  Created by Horbach on 6/22/19.
//  Copyright © 2019 Horbach. All rights reserved.
//

import Foundation

struct Comments: Decodable {
    let postId : Int
    let id : Int
    let name : String
    let email : String
    let body : String
}

