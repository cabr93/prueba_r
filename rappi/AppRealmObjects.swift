//
//  AppRealmObjects.swift
//  rappi
//
//  Created by Carlos Buitrago on 15/12/16.
//  Copyright © 2016 Carlos Buitrago. All rights reserved.
//

import Foundation
import RealmSwift

class aplicaciones:Object{
    dynamic var nombre = ""
    dynamic var categorias = ""
    dynamic var descripcion = ""
    dynamic var autor = ""
    dynamic var logo_path = Data()
    dynamic var tipo = 0
}
