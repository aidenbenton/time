//
//  File.swift
//
//
//  Created by Dave DeLong on 4/11/20.
//

import XCTest
import Time

class RegionTests: XCTestCase {

    static var allTests = [
        ("test24HourPreference", test24HourPreference),
        ("testCodableRegion", testCodableRegion)
    ]
    
    func test24HourPreference() {
        
        XCTAssertFalse(Region.posix.wants24HourTime)
        
        let france = Region(calendar: .current, timeZone: .current, locale: Locale(identifier: "fr_FR"))
        XCTAssertTrue(france.wants24HourTime)
        
    }

    func testCodableRegion() throws {
        let calendar = try XCTUnwrap(Calendar(identifier: .gregorian))
        let timeZone = try XCTUnwrap(TimeZone(identifier: "Australia/Sydney"))
        let locale = try XCTUnwrap(Locale(identifier: "en_AU"))
        let region = Region(calendar: calendar, timeZone: timeZone, locale: locale)
        
        let encoded = try JSONEncoder().encode(region)
        let decoded = try JSONDecoder().decode(Region.self, from: encoded)
        
        XCTAssertEqual(region, decoded)
    }
}
