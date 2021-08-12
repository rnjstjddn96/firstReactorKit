//
//  CardAccount.swift
//  FirstReactorKit
//
//  Created by imform-mm-2101 on 2021/08/12.
//

import Foundation
import UIKit

struct CardAccountInfo: Codable, Equatable, Identifiable {
    var id: String = ""
    var created: String = ""
    var cardNumber: Double = 0.0
    var cardCompCode: String = ""
    var cardLastNum: String = ""
    var cardNickName: String = ""
    
    var thumbnail: UIImage? {
        CardCompany.init(rawValue: cardCompCode)?.thumbnail
    }
    var image: UIImage? {
        CardCompany.init(rawValue: cardCompCode)?.image
    }
    var logoImage: UIImage? {
        CardCompany.init(rawValue: cardCompCode)?.logo
    }
    
    var cardName: String? {
        CardCompany.init(rawValue: cardCompCode)?.name
    }
    
    init(id: String, cardCompCode: String, cardLastNum: String, cardNickName: String, cardNumber: Double) {
        self.id = id
        self.cardCompCode = cardCompCode
        self.cardLastNum = cardLastNum
        self.cardNickName = cardNickName
        self.cardNumber = cardNumber
    }
}

enum CardCompany: String {
    case CARD_SHINHAN = "ABA01"
    case CARD_KB = "ABA02"
    case CARD_SAMSUNG = "ABA04"
    case CARD_BC = "ABA07"
    case CARD_LOTTE = "ABA05"
    case CARD_HYUNDAI = "ABA03"
    case CARD_HANA = "ABA08"
    case CARD_NH = "ABA06"
    case CARD_CITY = "씨티카드"
    case CARD_WOORI = "우리카드"
    case CARD_KAKAO = "카카오뱅크"
    case CARD_KBANK = "케이뱅크"
    case CARD_JEONBOOK = "전북카드"
    case CARD_GJ = "광주카드"
    case CARD_JEJU = "제주카드"
    case CARD_POST = "우체국카드"
    case CARD_SUHYUP = "수협카드"
    case CARD_SHINHYUP = "신협카드"
    case CARD_JC = "저축은행"
    case CARD_SAEMAEUL = "새마을금고"
    case CARD_SANUP = "산업"
    
    var name: String? {
        switch self {
            case .CARD_SHINHAN:
                return "신한카드"
            case .CARD_KB:
                return "국민카드"
            case .CARD_SAMSUNG:
                return "삼성카드"
            case .CARD_BC:
                return "비씨카드"
            case .CARD_LOTTE:
                return "롯데카드"
            case .CARD_HYUNDAI:
                return "현대카드"
            case .CARD_HANA:
                return "하나카드"
            case .CARD_NH:
                return "농협카드"
            case .CARD_CITY:
                return "시티카드"
            case .CARD_WOORI:
                return "우리카드"
            case .CARD_KAKAO:
                return "카카오카드"
            case .CARD_KBANK:
                return "케이뱅크"
            case .CARD_JEONBOOK:
                return "전북카드"
            case .CARD_GJ:
                return "광주카드"
            case .CARD_JEJU:
                return "제주카드"
            case .CARD_POST:
                return "우체국카드"
            case .CARD_SUHYUP:
                return "수협카드"
            case .CARD_SHINHYUP:
                return "신협카드"
            case .CARD_JC:
                return "저축은행카드"
            case .CARD_SAEMAEUL:
                return "새마을카드"
            case .CARD_SANUP:
                return "산업카드"
        }
    }
    
    var image: UIImage {
        switch self {
               case .CARD_SHINHAN:
                   return "shinhancard".asImage
               case .CARD_KB:
                   return "kbcard".asImage
               case .CARD_SAMSUNG:
                   return "samsungcard".asImage
               case .CARD_BC:
                   return "bccard".asImage
               case .CARD_LOTTE:
                   return "lottecard".asImage
               case .CARD_HYUNDAI:
                   return "hyundaicard".asImage
               case .CARD_HANA:
                   return "hanacard".asImage
               case .CARD_NH:
                   return "nhcard".asImage
               case .CARD_CITY:
                   return "citycard".asImage
               case .CARD_WOORI:
                   return "wooricard".asImage
               case .CARD_KAKAO:
                   return "kakaocard".asImage
               case .CARD_KBANK:
                   return "kbankcard".asImage
               case .CARD_JEONBOOK:
                   return "jbcard".asImage
               case .CARD_GJ:
                   return "gjcard".asImage
               case .CARD_JEJU:
                   return "jejucard".asImage
               case .CARD_POST:
                   return "postcard".asImage
               case .CARD_SUHYUP:
                   return "shcard".asImage
               case .CARD_SHINHYUP:
                   return "sinhyupcard".asImage
               case .CARD_JC:
                   return "jccard".asImage
               case .CARD_SAEMAEUL:
                   return "saemaeulcard".asImage
               case .CARD_SANUP:
                   return "sanupcard".asImage
           }
       }
       
       var thumbnail:  UIImage {
        switch self {
               case .CARD_SHINHAN:
                   return "shinhanthumbnail".asImage
               case .CARD_KB:
                   return "kbthumbnail".asImage
               case .CARD_SAMSUNG:
                   return "samsungthumbnail".asImage
               case .CARD_BC:
                   return "bcthumbnail".asImage
               case .CARD_LOTTE:
                   return "lottethumbnail".asImage
               case .CARD_HYUNDAI:
                   return "hyundaithumbnail".asImage
               case .CARD_HANA:
                   return "hanathumbnail".asImage
               case .CARD_NH:
                   return "nhthumbnail".asImage
               case .CARD_CITY:
                   return "citythumbnail".asImage
               case .CARD_WOORI:
                   return "woorithumbnail".asImage
               case .CARD_KAKAO:
                   return "kakaothumbnail".asImage
               case .CARD_KBANK:
                   return "kbankthumbnail".asImage
               case .CARD_JEONBOOK:
                   return "jbthumbnail".asImage
               case .CARD_GJ:
                   return "gjthumbnail".asImage
               case .CARD_JEJU:
                   return "jejuthumbnail".asImage
               case .CARD_POST:
                   return "postthumbnail".asImage
               case .CARD_SUHYUP:
                   return "shthumbnail".asImage
               case .CARD_SHINHYUP:
                   return "sinhyupthumbnail".asImage
               case .CARD_JC:
                   return "jcthumbnail".asImage
               case .CARD_SAEMAEUL:
                   return "saemaeulthumbnail".asImage
               case .CARD_SANUP:
                   return "sanupthumbnail".asImage
           }
       }
       
       var logo: UIImage {
        switch self {
               case .CARD_SHINHAN:
                   return "shinhanlogo".asImage
               case .CARD_KB:
                   return "kblogo".asImage
               case .CARD_SAMSUNG:
                   return "samsunglogo".asImage
               case .CARD_BC:
                   return "bclogo".asImage
               case .CARD_LOTTE:
                   return "lottelogo".asImage
               case .CARD_HYUNDAI:
                   return "hyundailogo".asImage
               case .CARD_HANA:
                   return "hanalogo".asImage
               case .CARD_NH:
                   return "nhlogo".asImage
               case .CARD_CITY:
                   return "citylogo".asImage
               case .CARD_WOORI:
                   return "woorilogo".asImage
               case .CARD_KAKAO:
                   return "kakaologo".asImage
               case .CARD_KBANK:
                   return "kbanklogo".asImage
               case .CARD_JEONBOOK:
                   return "jblogo".asImage
               case .CARD_GJ:
                   return "gjlogo".asImage
               case .CARD_JEJU:
                   return "jejulogo".asImage
               case .CARD_POST:
                   return "postlogo".asImage
               case .CARD_SUHYUP:
                   return "shlogo".asImage
               case .CARD_SHINHYUP:
                   return "sinhyuplogo".asImage
               case .CARD_JC:
                   return "jclogo".asImage
               case .CARD_SAEMAEUL:
                   return "saemaeullogo".asImage
               case .CARD_SANUP:
                   return "sanuplogo".asImage
           }
       }
}

