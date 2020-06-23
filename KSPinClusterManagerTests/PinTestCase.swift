
import XCTest
import KSPinClusterManager
import KSGeometry

class PinTestCase: XCTestCase {
    
    func test_pin_initialise_with_point() {
        let sut = Pin(id: "id", point: Point(x: 1, y: 2))
        XCTAssertEqual(sut.id, "id")
        XCTAssertEqual(sut.point, Point(x: 1, y: 2))
    }
    
    func test_pin_initialise_with_coordinates() {
        XCTAssertEqual(Pin(id: "id", x: 1, y: 2), Pin(id: "id", point: Point(x: 1, y: 2)))
    }
}
