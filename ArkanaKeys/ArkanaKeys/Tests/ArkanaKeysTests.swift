// DO NOT MODIFY
// Automatically generated by Arkana (https://github.com/rogerluan/arkana)

import Foundation
import ArkanaKeysInterfaces
import XCTest
@testable import ArkanaKeys

final class ArkanaKeysTests: XCTestCase {
    private var salt: [UInt8]!
    private var globalSecrets: ArkanaKeysGlobalProtocol!

    override func setUp() {
        super.setUp()
        salt = [
            0xe9, 0xdd, 0x4b, 0x88, 0x7e, 0x62, 0xdd, 0x2c, 0xf0, 0xd1, 0xee, 0xf3, 0x29, 0x21, 0xb1, 0x13, 0xd3, 0xe, 0xd1, 0x74, 0x7e, 0x5e, 0xe7, 0x33, 0xf1, 0x7e, 0x3c, 0x40, 0x21, 0xa8, 0xb4, 0xab, 0x52, 0xfb, 0xf3, 0x96, 0xb1, 0xe8, 0xee, 0xef, 0xe1, 0xbe, 0x54, 0xfb, 0x34, 0x30, 0xa6, 0x20, 0x54, 0x26, 0xac, 0xc8, 0x4, 0x91, 0xea, 0xe, 0x3b, 0x95, 0x49, 0x47, 0x25, 0xb7, 0x9f, 0xb8
        ]
        globalSecrets = ArkanaKeys.Global()
    }

    override func tearDown() {
        globalSecrets = nil
        salt = nil
        super.tearDown()
    }

    func test_decodeRandomHexKey_shouldDecode() {
        let encoded: [UInt8] = [
            0x8a, 0xec, 0x78, 0xb0, 0x47, 0x52, 0xe8, 0x4e, 0xc9, 0xe9, 0x8d, 0xc1, 0x1d, 0x40, 0x88, 0x27, 0xea, 0x6b, 0xe4, 0x41, 0x4b, 0x6d, 0xd0, 0x1, 0xc2, 0x4b, 0x8, 0x26, 0x43, 0xcb, 0xd5, 0x93, 0x61, 0x9d, 0xc5, 0xf5, 0x82, 0xda, 0xd8, 0xdd, 0x87, 0xdb, 0x65, 0x98, 0xc, 0x1, 0xc3, 0x10, 0x35, 0x16, 0x9a, 0xf9, 0x62, 0xa8, 0xde, 0x68, 0x2, 0xf0, 0x2c, 0x25, 0x44, 0x81, 0xa7, 0xdc, 0xd8, 0xbc, 0x7a, 0xec, 0x1d, 0x5a, 0xef, 0x1e, 0xc7, 0xb5, 0xda, 0xc7, 0x11, 0x13, 0xd0, 0x22, 0xe2, 0x3b, 0xe8, 0x47, 0x49, 0x6b, 0xd2, 0x56, 0xc4, 0x4e, 0x5d, 0x24, 0x10, 0x99, 0x86, 0xcf, 0x60, 0xce, 0xc4, 0xa2, 0xd5, 0xde, 0xdd, 0xd7, 0xd6, 0x8b, 0x65, 0x9e, 0x55, 0x4, 0xc0, 0x18, 0x61, 0x1f, 0xc8, 0xfd, 0x3c, 0xf4, 0x89, 0x6a, 0x5a, 0xa6, 0x7f, 0x70, 0x41, 0xd2, 0xac, 0x8f
        ]
        XCTAssertEqual(ArkanaKeys.decode(encoded: encoded, cipher: salt), "c138905b98c24a949e555372354fbca83f6c3262fe1c81e0a061f94f9eeba68d1a1dc8227d4482a11593755e50ad112d2574d638751ea4f859d58ecda367de37")
    }

    func test_decodeRandomBase64Key_shouldDecode() {
        let encoded: [UInt8] = [
            0xb9, 0x89, 0x5, 0xee, 0x1f, 0x3, 0x92, 0x4e, 0x81, 0xb4, 0xdc, 0x85, 0x1a, 0x16, 0xc4, 0x38, 0xf8, 0x76, 0xb8, 0x31, 0x38, 0x36, 0x93, 0x58, 0x9c, 0x4a, 0xe, 0xa, 0x60, 0xe2, 0xf6, 0xcd, 0x7d, 0xa3, 0xc7, 0xde, 0x82, 0xda, 0x97, 0xbd, 0x89, 0xe7, 0x1d, 0x92, 0x5d, 0x3, 0xd6, 0x53, 0x1d, 0x76, 0x94, 0x82, 0x76, 0xc1, 0x9c, 0x3a, 0x51, 0xba, 0xd, 0x32, 0x43, 0xef, 0xe5, 0x8e, 0x84, 0xec, 0xf, 0xc6, 0x10, 0xf, 0xad, 0x6b, 0x89, 0x99, 0xa8, 0xbc, 0x1b, 0x68, 0xc9, 0x59, 0x95, 0x7c, 0xfa, 0x37, 0x16, 0x39, 0xda, 0xe
        ]
        XCTAssertEqual(ArkanaKeys.decode(encoded: encoded, cipher: salt), "PTNfaaObqe2v37u++xiEFhtkm42JAJBf/X4H32yRhYIii3psIP8JrPv4j/DufXz6m1DNnmpGyHFO2IxJFr+Chg==")
    }

    func test_decodeUUIDKey_shouldDecode() {
        let encoded: [UInt8] = [
            0xdb, 0xbf, 0x72, 0xbf, 0x47, 0x53, 0xef, 0x1a, 0xdd, 0xb7, 0xdf, 0xcb, 0x4d, 0xc, 0x85, 0x76, 0xb1, 0x39, 0xfc, 0x15, 0x46, 0x6d, 0x84, 0x1e, 0xc8, 0x1c, 0x5, 0x77, 0x44, 0x9d, 0xd0, 0x9a, 0x6b, 0xcc, 0x92, 0xf2
        ]
        XCTAssertEqual(ArkanaKeys.decode(encoded: encoded, cipher: salt), "2b979126-f18d-4eb7-a83c-9b97e5d197ad")
    }

    func test_decodeTrueBoolValue_shouldDecode() {
        let encoded: [UInt8] = [
            0x9d, 0xaf, 0x3e, 0xed
        ]
        XCTAssertTrue(ArkanaKeys.decode(encoded: encoded, cipher: salt))
    }

    func test_decodeFalseBoolValue_shouldDecode() {
        let encoded: [UInt8] = [
            0x8f, 0xbc, 0x27, 0xfb, 0x1b
        ]
        XCTAssertFalse(ArkanaKeys.decode(encoded: encoded, cipher: salt))
    }

    func test_decodeIntValue_shouldDecode() {
        let encoded: [UInt8] = [
            0xdd, 0xef
        ]
        XCTAssertEqual(ArkanaKeys.decode(encoded: encoded, cipher: salt), 42)
    }

    func test_decodeIntValueWithLeadingZeroes_shouldDecodeAsString() {
        let encoded: [UInt8] = [
            0xd9, 0xed, 0x7b, 0xb9
        ]
        XCTAssertEqual(ArkanaKeys.decode(encoded: encoded, cipher: salt), "0001")
    }

    func test_decodeMassiveIntValue_shouldDecodeAsString() {
        let encoded: [UInt8] = [
            0xd0, 0xef, 0x79, 0xbb, 0x4d, 0x55, 0xef, 0x1c, 0xc3, 0xe7, 0xd6, 0xc6, 0x1d, 0x16, 0x86, 0x26, 0xeb, 0x3e, 0xe6, 0x4d, 0x4c, 0x6c, 0xd4, 0, 0xc6, 0x4c, 0xc, 0x73, 0x17, 0x90, 0x81, 0x9f, 0x65, 0xcc, 0xc6, 0xae, 0x81, 0xdf
        ]
        XCTAssertEqual(ArkanaKeys.decode(encoded: encoded, cipher: salt), "92233720368547758079223372036854775807")
    }

    func test_decodeNegativeIntValue_shouldDecodeAsString() {
        let encoded: [UInt8] = [
            0xc4, 0xe9, 0x79
        ]
        XCTAssertEqual(ArkanaKeys.decode(encoded: encoded, cipher: salt), "-42")
    }

    func test_decodeFloatingPointValue_shouldDecodeAsString() {
        let encoded: [UInt8] = [
            0xda, 0xf3, 0x7a, 0xbc
        ]
        XCTAssertEqual(ArkanaKeys.decode(encoded: encoded, cipher: salt), "3.14")
    }

    func test_encodeAndDecodeValueWithDollarSign_shouldDecode() {
        let encoded: [UInt8] = [
            0x9b, 0xb8, 0x2a, 0xe4, 0x21, 0x46, 0xb1, 0x45, 0x9d, 0x8e, 0x9d, 0x9b, 0x48, 0x45, 0xc8
        ]
        XCTAssertEqual(ArkanaKeys.decode(encoded: encoded, cipher: salt), "real_$lim_shady")
    }
}
