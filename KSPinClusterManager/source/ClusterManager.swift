
import KSGeometry
import KSQuadTree

public class ClusterManager {
    public let bounds: Rect
    public var pinsQuadTree: KSQuadTree
    public var clustersQuadTree: KSQuadTree
    public var pins: [Pin] = [] {
        didSet {
            
        }
    }
    
    public init(bounds: Rect) {
        self.bounds = bounds
        pinsQuadTree = KSQuadTree(bounds: bounds)
        clustersQuadTree = KSQuadTree(bounds: bounds)
    }
    
    public func insertPins(_ pins: [Pin]) {
        clear()
        for pin in pins {
            try? insertPin(pin)
        }
    }
    
    public func insertPin(_ pin: Pin) throws {
        let item = KSQuadTreeItem(point: pin.point, object: nil)
        try pinsQuadTree.insert(item: item)
        pins.append(pin)
    }
    
    public func clear() {
        pins = []
        pinsQuadTree = KSQuadTree(bounds: bounds)
        clustersQuadTree = KSQuadTree(bounds: bounds)
    }
    
    public func rebuildClusters(catchmentSize: Size) {
        clustersQuadTree = KSQuadTree(bounds: bounds)
        for pin in pins {
            let catchment = Rect(center: pin.point, size: catchmentSize)
            let nearby = clustersQuadTree.retrieveWithinRect(catchment)
            guard let nearestCluster = findNearest(to: pin, from: nearby)?.object as? Cluster
                else {
                    let newCluster = Cluster(id: "", centerPin: pin)
                    let item = KSQuadTreeItem(point: newCluster.centerPin.point, object: newCluster)
                    try? clustersQuadTree.insert(item: item)
                    continue
            }
            nearestCluster.addPin(pin)
        }
    }
    
    func findNearest<A:XYLocatable, B:XYLocatable>(to object: A, from others: [B] ) -> B? {
        var leastDistance = Float.greatestFiniteMagnitude
        var closest: B?
        for other in others {
            let aDistance = object.distance2From(other)
            if aDistance < leastDistance {
                leastDistance = aDistance
                closest = other
            }
        }
        return closest
    }
}

extension XYLocatable {
    func distance2From(_ other: XYLocatable) -> Float {
        (x - other.x)*(x - other.x) + (y - other.y)*(y - other.y)
    }
}
