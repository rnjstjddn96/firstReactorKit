// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct AllAnimal: Codable {
    let pagination: Pagination?
    let animals: [Animal]?
}

// MARK: - Animal
struct Animal: Codable {
    let name: String?
    let type: Species?
    let breeds: Breeds?
    let videos: [JSONAny]?
    let primaryPhotoCropped: Photo?
    let contact: Contact?
    let coat: String?
    let colors: Colors?
    let id: Int?
    let links: AnimalLinks?
    let gender: Gender?
    let statusChangedAt, publishedAt: Date?
    let organizationAnimalID: String?
    let attributes: Attributes?
    let animalDescription: String?
    let tags: [String]?
    let url: String?
    let organizationID: String?
    let status: Status?
    let distance: JSONNull?
    let species: Species?
    let photos: [Photo]?
    let environment: Environment?
    let age: Age?
    let size: Size?

    enum CodingKeys: String, CodingKey {
        case name, type, breeds, videos
        case primaryPhotoCropped = "primary_photo_cropped"
        case contact, coat, colors, id
        case links = "_links"
        case gender
        case statusChangedAt = "status_changed_at"
        case publishedAt = "published_at"
        case organizationAnimalID = "organization_animal_id"
        case attributes
        case animalDescription = "description"
        case tags, url
        case organizationID = "organization_id"
        case status, distance, species, photos, environment, age, size
    }
}

enum Age: String, Codable {
    case adult = "Adult"
    case baby = "Baby"
    case senior = "Senior"
    case young = "Young"
}

// MARK: - Attributes
struct Attributes: Codable {
    let specialNeeds, houseTrained, spayedNeutered, shotsCurrent: Bool?
    let declawed: Bool?

    enum CodingKeys: String, CodingKey {
        case specialNeeds = "special_needs"
        case houseTrained = "house_trained"
        case spayedNeutered = "spayed_neutered"
        case shotsCurrent = "shots_current"
        case declawed
    }
}

// MARK: - Breeds
struct Breeds: Codable {
    let unknown: Bool?
    let primary: String?
    let secondary: String?
    let mixed: Bool?
}

// MARK: - Colors
struct Colors: Codable {
    let primary: String?
    let tertiary: JSONNull?
    let secondary: String?
}

// MARK: - Contact
struct Contact: Codable {
    let email, phone: String?
    let address: Address?
}

// MARK: - Address
struct Address: Codable {
    let state: String?
    let country: Country?
    let postcode: String?
    let address1: String?
    let address2: JSONNull?
    let city: String?
}

enum Country: String, Codable {
    case us = "US"
}

// MARK: - Environment
struct Environment: Codable {
    let children, dogs, cats: Bool?
}

enum Gender: String, Codable {
    case female = "Female"
    case male = "Male"
}

// MARK: - AnimalLinks
struct AnimalLinks: Codable {
    let organization, type, linksSelf: Next?

    enum CodingKeys: String, CodingKey {
        case organization, type
        case linksSelf = "self"
    }
}

// MARK: - Next
struct Next: Codable {
    let href: String?
}

// MARK: - Photo
struct Photo: Codable {
    let small, full, medium, large: String?
}

enum Size: String, Codable {
    case large = "Large"
    case medium = "Medium"
    case small = "Small"
}

enum Species: String, Codable {
    case cat = "Cat"
    case dog = "Dog"
}

enum Status: String, Codable {
    case adoptable = "adoptable"
}

// MARK: - Pagination
struct Pagination: Codable {
    let totalCount: Int?
    let links: PaginationLinks?
    let countPerPage, currentPage, totalPages: Int?

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case links = "_links"
        case countPerPage = "count_per_page"
        case currentPage = "current_page"
        case totalPages = "total_pages"
    }
}

// MARK: - PaginationLinks
struct PaginationLinks: Codable {
    let next: Next?
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}
