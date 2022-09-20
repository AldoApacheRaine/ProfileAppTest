//
//  UserModel.swift
//  ProfileAppTest
//
//  Created by Максим Хмелев on 15.09.2022.
//

import Foundation

class UserModel {

    var name: String?
    var surname: String?
    var patronymic: String?
    var birthDate: String?
    var gender: String?
    
    enum FieldsTypes: Int, CustomStringConvertible, CaseIterable {
        case name
        case surname
        case patronymic
        case birthDate
        case gender
        
        var description: String{
            switch self {
            case .name:
                return "Имя"
            case .surname:
                return "Фамилия"
            case .patronymic:
                return "Отчество"
            case .birthDate:
                return "Дата рождения"
            case .gender:
                return "Пол"
                
            }
        }
    }
    
    enum Gender: CaseIterable {
        case none
        case man
        case woman
        
        var description: String {
            switch self {
            case .none:
                return "Не указан"
            case .man:
                return "Мужской"
            case .woman:
                return "Женский"
            }
        }
    }
    
    func saveUser(model: UserModel) {
        let userDefaults  = UserDefaults.standard
        var userData = [String]()
        userData.append(model.name ?? "")
        userData.append(model.surname ?? "")
        userData.append(model.patronymic ?? "")
        userData.append(model.birthDate ?? "")
        userData.append(model.gender ?? "")
        userDefaults.set(userData, forKey: "UserData")        
    }
    
    func validate() -> Bool {
        if name  == nil || surname == nil || birthDate == nil || gender == "Не указан" {
            return false
        }
        return true
    }
    
    func dataChanged() -> Bool {
        let userDateDafaults  = UserDefaults.standard
        let userDate = userDateDafaults.object(forKey: "UserData") as! [String]
        if userDate[0] != name || userDate[1] != surname || userDate[2] != patronymic || userDate[3] != birthDate || userDate[4] != gender {
            return true
        }
        return false
    }
}

