
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
    }
    
    func test_addPin_not_same() {
        var sut = makeSUT(id: "id0")
        sut.addPin(Pin(id: "id1", x: 0, y: 0))
        XCTAssertEqual(sut.count, 2)
    }
    
    func test_addPin_same() {
        var sut = makeSUT(id: "id0")
        sut.addPin(centerPin)
        XCTAssertEqual(sut.count, 1)
    }
    
    func test_catchmentRectangleWithSize(size: Size) {
        let sut = makeSUT(id: "")
        XCTAssertEqual(
            sut.catchmentRectangle(size: size),
            Rect(center: sut.centerPin.point, size: size)
        )
    }
    
    func makeSUT(id: String) -> Cluster {
        Cluster(id: id, centerPin: centerPin)
    }

    
}
