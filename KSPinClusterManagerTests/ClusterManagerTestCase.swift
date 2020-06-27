
import XCTest
import KSGeometry
@testable import KSPinClusterManager

class ClusterManagerTestCase: XCTestCase {
    
    let bounds = Rect(x: -100, y: -100, width: 200, height: 200)
    let testPinBounds = Rect(x: -0.1, y: -0.1, width: 4.2, height: 4.2)
    let testPins: [Pin] = [
        Pin(id: "0", point: Point(x: 0, y: 0)),
        Pin(id: "1", point: Point(x: 1, y: 0)),
        Pin(id: "2", point: Point(x: 2, y: 0)),
        Pin(id: "3", point: Point(x: 3, y: 0)),
        Pin(id: "4", point: Point(x: 4, y: 0)),
        Pin(id: "5", point: Point(x: 0, y: 1)),
        Pin(id: "6", point: Point(x: 1, y: 1)),
        Pin(id: "7", point: Point(x: 2, y: 1)),
        Pin(id: "8", point: Point(x: 3, y: 1)),
        Pin(id: "9", point: Point(x: 4, y: 1)),
        Pin(id: "10", point: Point(x: 0, y: 2)),
        Pin(id: "11", point: Point(x: 1, y: 2)),
        Pin(id: "12", point: Point(x: 2, y: 2)),
        Pin(id: "13", point: Point(x: 3, y: 2)),
        Pin(id: "14", point: Point(x: 4, y: 2)),
        Pin(id: "15", point: Point(x: 0, y: 3)),
        Pin(id: "16", point: Point(x: 1, y: 3)),
        Pin(id: "17", point: Point(x: 2, y: 3)),
        Pin(id: "18", point: Point(x: 3, y: 3)),
        Pin(id: "19", point: Point(x: 4, y: 3)),
        Pin(id: "20", point: Point(x: 0, y: 4)),
        Pin(id: "20", point: Point(x: 1, y: 4)),
        Pin(id: "20", point: Point(x: 2, y: 4)),
        Pin(id: "20", point: Point(x: 3, y: 4)),
        Pin(id: "20", point: Point(x: 4, y: 4)),
    ]
    
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
        sut.insert(testPins)
        XCTAssertEqual(sut.pinsQuadTree.count(), testPins.count)
        XCTAssertEqual(sut.pins, testPins)
    }
    
    func test_clear() {
        let sut = ClusterManager(bounds: bounds)
        sut.insert(testPins)
        sut.clear()
        XCTAssertEqual(sut.pinsQuadTree.count(), 0)
        XCTAssertEqual(sut.pins.count, 0)
    }
    
    func test_rebuildClusters_with_catchement_smaller_than_pin_separation() {
        let sut = ClusterManager(bounds: bounds)
        sut.insert(testPins)
        sut.rebuildClusters(catchementSize: Size.zero, in: testPinBounds)
        XCTAssertEqual(sut.clustersQuadTree.count(), testPins.count)
    }
    
    func test_rebuildClusters_from_two_close_pins() {
        let sut = ClusterManager(bounds: bounds)
        sut.insert([testPins[0],testPins[1]])
        sut.rebuildClusters(catchementSize: Size(width: 2.0001, height: 2), in: bounds)
        XCTAssertEqual(sut.clustersQuadTree.count(), 1)
    }
    
    func test_rebuildClusters_from_two_close_pins_one_distant_pin() {
        let sut = ClusterManager(bounds: bounds)
        sut.insert([testPins[0],testPins[1], testPins[4]])
        sut.rebuildClusters(catchementSize: Size(width: 2.1, height: 2), in: bounds)
        XCTAssertEqual(sut.clustersQuadTree.count(), 2)
    }
    
    func test_getClusters() {
        let sut = ClusterManager(bounds: bounds)
        sut.insert(testPins)
        sut.rebuildClusters(catchementSize: bounds.size, in: bounds)
        XCTAssertEqual(sut.getClusters().count, testPins.count)
    }
    
}
