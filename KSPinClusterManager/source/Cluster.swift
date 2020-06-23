
import KSGeometry

public class Cluster: XYLocatable, Hashable, Equatable {
    
    public let id: String
    public let centerPin: Pin
    public private (set) var pins: Set<Pin>
    public var x: Float { return centerPin.x }
    public var y: Float { return centerPin.y }
    public var count: Int { return pins.count }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(centerPin)
        hasher.combine(id)
    }
    
    public static func == (lhs: Cluster, rhs: Cluster) -> Bool {
        lhs.centerPin == rhs.centerPin && lhs.id == rhs.id
    }
    
    public func addPin(_ pin: Pin) {
        pins.insert(pin)
    }
    
    public init(id: String, centerPin: Pin) {
        self.id = id
        self.centerPin = centerPin
        self.pins = Set<Pin>([centerPin])
    }
    
    public func catchmentRectangle(size: Size) -> Rect {
        Rect(center: centerPin.point, size: size)
    }
    
}
