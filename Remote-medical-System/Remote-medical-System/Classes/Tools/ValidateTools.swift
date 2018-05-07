//
//  ValidateTools.swift
//  Remote-medical-System
//
//  Created by j on 2017/9/26.
//  Copyright © 2017年 newfolder. All rights reserved.
//

import UIKit

class ValidateTools{
    static let shareInstance: ValidateTools={
        let tools=ValidateTools();
        return tools
    }()
}

enum ValidatedType {
    case Email
    case PhoneNumber
    case Password
    case Message
}


extension ValidateTools{
func ValidateText(validatedType type: ValidatedType, validateString: String) -> Bool {
    do {
        let pattern: String
        
        if type == ValidatedType.Email {
            
            pattern = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
            
        }
            
        else if type == ValidatedType.PhoneNumber {
            
            pattern = "^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$"
            
        }
        
        else if type == ValidatedType.Password {
            
            pattern = "^.{6,}$"
            
        }
        
        else{
            
            pattern = "^[0-9]{6}$"
            
        }
        
        
        
        let regex: NSRegularExpression = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
        
        let matches = regex.matches(in: validateString, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSMakeRange(0, validateString.characters.count))
        
        return matches.count > 0
        
    }
        
    catch {
        
        return false
        
    }
    
}

    func EmailIsValidated(vStr: String) -> Bool {
    
    return ValidateText(validatedType: ValidatedType.Email, validateString: vStr)
    
    }

    func PhoneNumberIsValidated(vStr: String) -> Bool {
    
    return ValidateText(validatedType: ValidatedType.PhoneNumber, validateString: vStr)
    
    }
    func PasswordIsValidated(vStr: String) -> Bool {
        
        return ValidateText(validatedType: ValidatedType.Password, validateString: vStr)
        
    }
    func MessageIsValidated(vStr: String) -> Bool {
        
        return ValidateText(validatedType: ValidatedType.Message, validateString: vStr)
        
    }
}
