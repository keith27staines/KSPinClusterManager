
import KSGeometry
import KSQuadTree

public class ClusterManager {
    public let bounds: Rect
    public var pinsQuadTree: KSQuadTree
    public var clustersQuadTree: KSQuadTree
    public private (set) var pins: [Pin] = []
    
    public init(bounds: Rect) {
        self.bounds = bounds
        pinsQuadTree = KSQuadTree(bounds: bounds)
        clustersQuadTree = KSQuadTree(bounds: bounds)
    }
    
    public func insert(_ pins: [Pin]) {
        for pin in pins {
            try? insertPin(pin)
        }
    }
    
    func insertPin(_ pin: Pin) throws {
        let item = KSQuadTreeItem(point: pin.point, object: nil)
        try pinsQuadTree.insert(item: item)
        pins.append(pin)
    }
    
    public func clear() {
        pins = []
        pinsQuadTree = KSQuadTree(bounds: bounds)
        clustersQuadTree = KSQuadTree(bounds: bounds)
    }
    
    public func getClusters() -> [Cluster] {
        clustersQuadTree.retrieveAll().compactMap { ($0.object as? Cluster) }
    }
    
    public func rebuildClusters(catchementSize: Size) {
        clustersQuadTree = KSQuadTree(bounds: bounds)
        for pin in pins {
            let catchement = Rect(center: pin.point, size: catchementSize)
            addPinToNearestClusterInCatchementRect(pin: pin, rect: catchement)
        }
    }
    
    func addPinToNearestClusterInCatchementRect(pin: Pin, rect: Rect) {
        let nearby = clustersQuadTree.retrieveWithinRect(rect)
        guard let nearestCluster = findNearest(to: pin, from: nearby)?.object as? Cluster
            else {
                let newCluster = Cluster(id: "", centerPin: pin)
                let item = KSQuadTreeItem(point: newCluster.centerPin.point, object: newCluster)
                try? clustersQuadTree.insert(item: item)
                return
        }
        nearestCluster.addPin(pin)
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
