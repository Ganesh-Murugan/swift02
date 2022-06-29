protocol VehicleProtocol {
    associatedtype VehicleSpeed: FloatingPoint
    var name: String {get}
    var type: VehicleType {get}
    var speed: VehicleSpeed {get}
}
extension VehicleProtocol {
    func travelTime(_ distance: VehicleSpeed) -> VehicleSpeed{
        return self.speed * distance
    }
}

protocol BikeProtocol: VehicleProtocol {
    var someBikeProp: String {get}
}

enum VehicleType {
    
    enum Color {
        case blue, green, yellow
    }
    enum Model {
        case v1, v2, v3
    }
    enum Weight {
        case small, normal, large
        
    }
    
    case bike(_ color: Color, _ model: Model, _ weight: Weight)
    case car(_ color: Color, _ model: Model, _ weight: Weight)
    
    var description: String {
        switch self {
        case let .bike(color, model, weight):
            return "Bike with \(color) color, model: \(model), weight: \(weight)"
        case let .car(color, model, weight):
            return "Car with \(color) color, model: \(model), weight: \(weight)"
        }
    }
    
}
extension VehicleType.Weight {
    init(weight: Float) {
        switch weight {
        case 100...1000:
            self = .small
        case 1001...10000:
            self = .normal
        default:
            self = .large
        }
    }
}

struct VehicleModel: VehicleProtocol {
    typealias VehicleSpeed = Float
    var name: String
    var type: VehicleType
    var speed: Float
    
}

struct BikeModel: BikeProtocol {
    var name: String
    var type: VehicleType
    var speed: Float
    typealias VehicleSpeed = Float
    
    var someBikeProp: String
    
}

struct VehicleViewModel{
//    static let vehicleModel = VehicleModel()
//    private init(){}
    static var vehicles = [
        VehicleModel(name: "lambo", type: .car(.blue, .v1, .init(weight: 2000)), speed: 24),
        VehicleModel(name: "Pulsar", type: .car(.green, .v2, .init(weight: 200)), speed: 24),
        VehicleModel(name: "Pulsar", type: .car(.green, .v3, .normal), speed: 24),
    ]
}

VehicleViewModel.vehicles[1].type = .bike(.yellow, .v3, .init(weight: 300))
print(VehicleViewModel.vehicles[1].type.description)
print(VehicleViewModel.vehicles[0].travelTime(10))
