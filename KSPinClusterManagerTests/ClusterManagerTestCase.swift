
import XCTest
import KSPinClusterManager
import KSGeometry

class ClusterManagerTestCase: XCTestCase {
    
    let pins: [Pin] = [
        Pin(id: "0", point: Point(x: 0, y: 0)),
        Pin(id: "1", point: Point(x: 1, y: 0)),
        Pin(id: "2", point: Point(x: 2, y: 0)),
        Pin(id: "3", point: Point(x: 3, y: 0)),
        Pin(id: "4", point: Point(x: 4, y: 0)),
    ]
    
    let bounds = Rect(x: -100, y: -100, width: 200, height: 200)
    
    func test_initialise() {
        let sut = ClusterManager(bounds: bounds)
        XCTAssertEqual(sut.pinsQuadTree.count(), 0)
        XCTAssertEqual(sut.clustersQuadTree.count(), 0)
        XCTAssertEqual(sut.pins.count, 0)
    }
    
    func test_insertPin() {
        let sut = ClusterManager(bounds: bounds)
        try! sut.insertPin(Pin(id: "", point: Point.zero))
        XCTAssertEqual(sut.pinsQuadTree.count(), 1)
        XCTAssertEqual(sut.pins.count, 1)
    }
    
    func test_insertPins() {
        let sut = ClusterManager(bounds: bounds)
        sut.insert(pins)
        XCTAssertEqual(sut.pinsQuadTree.count(), pins.count)
        XCTAssertEqual(sut.pins, pins)
    }
    
    func test_clear() {
        let sut = ClusterManager(bounds: bounds)
        sut.insert(pins)
        sut.clear()
        XCTAssertEqual(sut.pinsQuadTree.count(), 0)
        XCTAssertEqual(sut.pins.count, 0)
    }
    
    func test_rebuildClusters_with_catchement_smaller_than_pin_separation() {
        let sut = ClusterManager(bounds: bounds)
        sut.insert(pins)
        sut.rebuildClusters(catchementSize: Size.zero)
        XCTAssertEqual(sut.clustersQuadTree.count(), pins.count)
    }
    
    func test_rebuildClusters_from_two_close_pins() {
        let sut = ClusterManager(bounds: bounds)
        sut.insert([pins[0],pins[1]])
        sut.rebuildClusters(catchementSize: Size(width: 2.0001, height: 2))
        XCTAssertEqual(sut.clustersQuadTree.count(), 1)
    }
    
    func test_rebuildClusters_from_two_close_pins_one_distant_pin() {
        let sut = ClusterManager(bounds: bounds)
        sut.insert([pins[0],pins[1], pins[4]])
        sut.rebuildClusters(catchementSize: Size(width: 2.1, height: 2))
        XCTAssertEqual(sut.clustersQuadTree.count(), 2)
    }
    
}
