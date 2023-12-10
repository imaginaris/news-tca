// DO NOT MODIFY
// Automatically generated by Arkana (https://github.com/rogerluan/arkana)

import Foundation
import ArkanaKeysInterfaces

public enum ArkanaKeys {
    @inline(__always)
    fileprivate static let salt: [UInt8] = [
        0xe9, 0xdd, 0x4b, 0x88, 0x7e, 0x62, 0xdd, 0x2c, 0xf0, 0xd1, 0xee, 0xf3, 0x29, 0x21, 0xb1, 0x13, 0xd3, 0xe, 0xd1, 0x74, 0x7e, 0x5e, 0xe7, 0x33, 0xf1, 0x7e, 0x3c, 0x40, 0x21, 0xa8, 0xb4, 0xab, 0x52, 0xfb, 0xf3, 0x96, 0xb1, 0xe8, 0xee, 0xef, 0xe1, 0xbe, 0x54, 0xfb, 0x34, 0x30, 0xa6, 0x20, 0x54, 0x26, 0xac, 0xc8, 0x4, 0x91, 0xea, 0xe, 0x3b, 0x95, 0x49, 0x47, 0x25, 0xb7, 0x9f, 0xb8
    ]

    static func decode(encoded: [UInt8], cipher: [UInt8]) -> String {
        return String(decoding: encoded.enumerated().map { offset, element in
            element ^ cipher[offset % cipher.count]
        }, as: UTF8.self)
    }

    static func decode(encoded: [UInt8], cipher: [UInt8]) -> Bool {
        let stringValue: String = Self.decode(encoded: encoded, cipher: cipher)
        return Bool(stringValue)!
    }

    static func decode(encoded: [UInt8], cipher: [UInt8]) -> Int {
        let stringValue: String = Self.decode(encoded: encoded, cipher: cipher)
        return Int(stringValue)!
    }
}

public extension ArkanaKeys {
    struct Global: ArkanaKeysGlobalProtocol {
        public init() {}

        @inline(__always)
        public let newsApiKey: String = {
            let encoded: [UInt8] = [
                0x8a, 0xb9, 0x2f, 0xb1, 0x1a, 0x50, 0xbf, 0x14, 0xc5, 0xb2, 0xd7, 0xc6, 0x1d, 0x18, 0xd0, 0x77, 0xeb, 0x6d, 0xe5, 0x17, 0x47, 0x66, 0xd2, 0x7, 0xc9, 0x1a, 0x5d, 0x24, 0x42, 0x9a, 0x85, 0x9a
            ]
            return ArkanaKeys.decode(encoded: encoded, cipher: ArkanaKeys.salt)
        }()
    }
}
