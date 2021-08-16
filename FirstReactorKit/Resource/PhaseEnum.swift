//
//  PhaseEnum.swift
//  FirstReactorKit
//
//  Created by 권성우 on 2021/08/14.
//

import Foundation
import UIKit
import ReactorKit

enum RegisterPhase: CaseIterable {
    case term
//    case input
//    case phone_auth
    case user_auth
    case pincode
    case bio
    case signature
    
    var title: String {
        switch self {
        case .term: return "약관"
//        case .input: return ""
//        case .phone_auth: return ""
        case .user_auth: return "본인 인증"
        case .pincode: return "결제 비밀번호 설정"
        case .bio: return "생체 인증 설정"
        case .signature: return "결제 서명 설정"
        }
    }
}
