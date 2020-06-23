
import KSGeometry

public struct Pin: XYLocatable, Hashable, Equatable {
    public let id: String
    public let point: Point
    public var x: Float { point.x }
    public var y: Float { point.y }
    
    public init(id: String, point: Point) {
        self.id = id
        self.point = point
    }
    
    public init(id: String, x: Float, y: Float) {
        self.init(id: id, point: Point(x: x, y: y))
    }
}
