//
//  Singleton.swift
//  EcoSAN
//
//  Created by Bradley Chippi on 1/20/18.
//  Copyright © 2018 spartahack18. All rights reserved.
//

import Foundation
final class Singleton{
    static let chatService = ChatServiceManager()
    private init() {}
}
