
import KSGeometry
import KSQuadTree

public class ClusterManager {
    public var pinsQuadTree: KSQuadTree
    public var clustersQuadTree: KSQuadTree
    
    public init(bounds: Rect) {
        pinsQuadTree = KSQuadTree(bounds: bounds)
        clustersQuadTree = KSQuadTree(bounds: bounds)
    }
    
    public func insertPin(pin: Pin) throws {
        let item = KSQuadTreeItem(point: pin.point, object: nil)
        try pinsQuadTree.insert(item: item)
    }
    
    public func rebuildClusters(catchmentSize: Size) {
        
    }
    
}
