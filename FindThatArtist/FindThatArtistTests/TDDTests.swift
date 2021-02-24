//
//  TDDTests.swift
//  FindThatArtistTests
//
//  Created by Field Employee on 2/22/21.
//

import Foundation
import XCTest

class Test{
    
    let svc = SearchViewController()
    
    func testEnteredTextFieldSearchValue(){
        let artistNameEntered: String = svc.searchArtist.text!
        XCTAssertEqual(artistNameEntered,svc.searchArtist.text)
    }
    
    func testDefaultHidden(){
        XCTAssertEqual(svc.artistTable.isHidden, true)
        XCTAssertEqual(svc.activitySpin.isHidden, true)
        XCTAssertEqual(svc.newSearchButton.isHidden, true)
    }
}
