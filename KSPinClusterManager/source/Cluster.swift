
import KSGeometry

public struct Cluster: XYLocatable, Hashable, Equatable {
    public var id: String
    public var centerPin: Pin
    public var pins: Set<Pin>
    public var x: Float { return centerPin.x }
    public var y: Float { return centerPin.y }
    
    
    
}
