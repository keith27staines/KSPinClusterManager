
import XCTest
import KSPinClusterManager
import KSGeometry

class ClusterTestCase: XCTestCase {
    
    let centerPin = Pin(id: "pinId", x: 1, y: 0)
    
    func test_cluster_initialise() {
        let sut = makeSUT(id: "id")
        XCTAssertEqual(sut.id, "id")
        XCTAssertEqual(sut.centerPin, centerPin)
        XCTAssertEqual(sut.pins.first, centerPin)
        XCTAssertEqual(sut.count, 1)
        XCTAssertEqual(sut.x, centerPin.x)
        XCTAssertEqual(sut.y, centerPin.y)
    }
    
    func test_equality_and_hash() {
        let sut1 = makeSUT(id: "1")
        let sut2 = makeSUT(id: "2")
        XCTAssertNotEqual(sut1, sut2)
        XCTAssertNotEqual(sut1.hashValue, sut2.hashValue)
    }
    
    func test_addPin_not_same() {
        let sut = makeSUT(id: "id0")
        sut.addPin(Pin(id: "id1", x: 0, y: 0))
        XCTAssertEqual(sut.count, 2)
    }
    
    func test_addPin_same() {
        let sut = makeSUT(id: "id0")
        sut.addPin(centerPin)
        XCTAssertEqual(sut.count, 1)
    }
    
    func test_catchementRectangleWithSize() {
        let size = Size(width: 2, height: 3)
        let sut = makeSUT(id: "")
        XCTAssertEqual(
            sut.catchementRectangle(size: size),
            Rect(center: sut.centerPin.point, size: size)
        )
    }
    
    func makeSUT(id: String) -> Cluster {
        Cluster(id: id, centerPin: centerPin)
    }

    
}
