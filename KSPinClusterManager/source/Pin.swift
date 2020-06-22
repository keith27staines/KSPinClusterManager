
import KSGeometry

public struct Pin: XYLocatable, Hashable, Equatable {
    public var id: String
    public var point: Point
    public var x: Float { point.x }
    public var y: Float { point.y }
    
    
}
