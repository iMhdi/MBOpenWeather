import XCTest
import MBOpenWeather

class Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMissingAPIKey() throws {
        MBWeatherManager.shared.weatherInfo(forCityName: "Paris", withSuccess: { weatherData in
            XCTFail("Success with missing API KEY") // Starfoullah !?
        }) { error in
            XCTAssertTrue(error.domain == "MISSING_API_KEY", "")
        }
    }
    
    func testCityWeather() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        var weatherInformation: MBWeatherModel? = nil
        let expectation = self.expectation(description: "API Call")
        MBWeatherManager.shared.setAPIKey("439d4b804bc8187953eb36d2a8c26a02")
        MBWeatherManager.shared.weatherInfo(forCityName: "Paris", withSuccess: { weatherData in
            print("success")
            weatherInformation = weatherData
            expectation.fulfill()
        }) { error in
            XCTFail("failure : \(error)")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10) { error in
            XCTAssertTrue(
                weatherInformation != nil,
                "expectation failed : \(error?.localizedDescription ?? "")"
            )
        }
    }

    func testCoordinatesWeather() throws { //48.8530143, 2.3465163 = Notre-Dame
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        var weatherInformation: MBWeatherModel? = nil
        let expectation = self.expectation(description: "API Call")
        MBWeatherManager.shared.setAPIKey("439d4b804bc8187953eb36d2a8c26a02")
        MBWeatherManager.shared.weatherInfo(forLatitude: 48.8530143, longitude: 2.3465163, withSuccess: { weatherData in
            print("success")
            weatherInformation = weatherData
            expectation.fulfill()
        }) { error in
            XCTFail("failure : \(error)")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10) { error in
            XCTAssertTrue(
                weatherInformation != nil,
                "expectation failed : \(error?.localizedDescription ?? "")"
            )
        }
    }
}
