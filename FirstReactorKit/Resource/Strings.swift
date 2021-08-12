//
//  Strings.swift
//  FirstReactorKit
//
//  Created by imform-mm-2101 on 2021/08/09.
//

import Foundation

enum Strings {
    struct Common {
        static let MIRAEASSET_PAY = "미래에셋PAY"
        static let CONFIRM = "확인"
        static let CANCEL = "취소"
        static let RETRY = "재시도"
        static let EXIT = "종료"
        static let PERSON_SUFFIX = "님"
    }
    
    struct System {
        static let SECURE_THREAT_DETECTED = "보안 위협이 감지 되었습니다\n앱을 종료합니다."
        static let FAILED_TO_GET_DATA = "데이터를 불러오는데 실패하였습니다."
        static let NFC_NOT_NOT_SUPPORTED = "NFC 미지원 기기입니다."
        static let LOCATION_PERMISSION_NEEDED = "위치권한 허용이 필요합니다."
        static let MOVE_TO_SETTING_LOC = "앱 설정 > 위치 에서 허용해주세요."
    }
    
    struct Menu {
        struct Section {
            static let PAYMENT_MANAGEMENT = "결제수단 관리"
            static let INQUIRY = "조회"
            static let BENEFIT = "혜택"
            static let CUSTOMER_SERVICE = "고객센터"
        }
        
        static let PAYMENT_MANAGEMENT = "결제수단 관리"
        static let PAYMENT_HISTORY = "결제내역"
        static let PAYMENT_REPORT = "소비 리포트"
        static let EVENT = "이벤트"
        static let POINT = "포인트 모아보기"
        
        static let NOTICE = "공지사항"
        static let FAQ = "FAQ"
        static let STORE = "가맹점 안내"
    }
    
    struct Register {
        static let USER_AUTH_SUCCESS_MSG = "본인 인증에\n성공하였습니다."
        static let USER_AUTH_FAIL_MSG = "본인 인증에\n실패하셨습니다."
        static let CANCLE_REGISTRATION = "가입취소"
        
        struct TERM {
            static let MAIN_TITLE = "\(Strings.Common.MIRAEASSET_PAY) 서비스\n이용약관 동의가 필요합니다"
            static let ALL_AGREED = "약관 전체 동의"
            static let REQUIRED = "[필수]"
            static let OPTIONAL = "[선택]"
        }
        
        struct Bio {
            static let BIO_AUTH = "생체 인증"
            static let CHECK = "생체 인증을 확인합니다."
            static let ACTIVATE_BIO_IN_SETTING = "휴대폰에 Face ID(Touch ID) 등록 후 이용할 수 있습니다. '휴대폰 설정 > Face ID(TouchID) 및 암호'에서 등록해주세요."
            static let NOT_AVAILABLE = "기기에서 생체 인증을 사용할 수 없습니다."
            static let NO_PASSCODE = "기기 패스코드가 없습니다\n 패스코드 설정 및 생체인증 기능을 활성화가 필요합니다."
            static let CANCELED = "생체 인증을 취소하셨습니다."
            static let AUTH_FAILED = "생체 인증 등록에 실패하셨습니다."
            static let BIO_LOCK = "생체인증 인증 실패 횟수 초과.\n재인증 후 다시 시도해주세요."
            static let INVALID_CONTEXT = "생체인증 컨텍스트에 오류가 발생했습니다.\n 앱 종료 후 다시 시도해주세요."
        }
        
        struct ALink {
            static let USER_ACCESS = "출입인증"
            static let USER_ACCESS_REGISTER_FAIL = "출입인증 등록 실패"
            static let APP_KEY_CREATE_FAIL = "앱 키 생성에 실패하였습니다."
            static let APP_KEY_CONNECT_FAIL = "앱 키 등록을 위한 서버 통신에 실패하였습니다."
            static let CHECK_TOKEN = "출입 인증 토큰 값이 잘못되었습니다."
        }
    }
    
    struct Card {
        static let CARD_REGISTER_FAIL = "카드 등록 실패"
        static let CARD_OFFLINE_UNUSABLE = "오프라인 사용불가 카드입니다"
        static let CARD_DUPLICATED = "이미 등록된 카드입니다."
        static let CARD_NAME_LENGHT_CHECK = "카드 별칭은 12자리까지 입력 가능합니다."
    }
    
    enum Wallet {
        struct Menu {
            static let PAYMENT = "결제수단"
            static let COUPON = "쿠폰"
            static let HISTORY = "결제내역"
        }
    }
}
