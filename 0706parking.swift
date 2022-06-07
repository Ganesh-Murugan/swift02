import Foundation

enum VehicleType{
    case bike, car
}
enum ParkingErrors: Error {
        case Empty, Full(VehicleType), InvalidSlot(Int), Exist(String), NotFound
}

extension String {
    var toInt: Int {
        return Int(self) ?? 0
    }
}

extension Optional where Wrapped == String {
    var unwrap: String {
        guard let self = self else { return "" }
        return self
    }
}

extension Array where Element == ParkingSlot {
    var checkIsEmpty: Bool { parkedVehicles().isEmpty }
    
    func getBikes(isParked: Bool = true) -> [ParkingSlot] { 
        self.filter { $0.vehicle.type == .bike && $0.vehicle.parked == isParked }
    }
    func getCars(isParked: Bool = true) -> [ParkingSlot] {
        self.filter { $0.vehicle.type == .car  && $0.vehicle.parked == isParked }
    }
    func parkedVehicles(isParked: Bool = true) -> [ParkingSlot] { self.filter { $0.vehicle.parked == isParked } }

    func getVehicleIndex(_ type: VehicleType, _ slotNo: Int) -> Int {
        self.firstIndex(where: {  $0.vehicle.type == type && $0.slotNo == slotNo && $0.vehicle.parked}) ?? -1
    }
    
    func search(_ searchKeyword: String) -> [ParkingSlot] {
        return self.filter {
            $0.vehicle.parked && ($0.vehicle.name.localizedCaseInsensitiveContains(searchKeyword) ||
            String($0.slotNo).localizedCaseInsensitiveContains(searchKeyword) ||
            $0.vehicle.numberPlate.localizedCaseInsensitiveContains(searchKeyword))
        }
    }
    func checkSlot(_ enteredSlot: Int, _ vehicleType: VehicleType) -> Bool{
        self.contains(where: { $0.slotNo == enteredSlot && $0.vehicle.type == vehicleType && $0.vehicle.parked})
    }
    var printSlots: Void {
        for slot in self {
            print("Vehicle \(slot.vehicle.name), Number \(slot.vehicle.numberPlate) is parked at \(slot.vehicle.type) parking slot number \(slot.slotNo), Parked Time: \(slot.arrivalTime), Depature Time: \(slot.depatureTime)")
        }       
    }
    mutating func clearHistory(){
        self.removeAll(where: {!$0.vehicle.parked})
    }
}

let parkedVehicleList = [ ParkingSlot(slotNo: 1, vehicle: Vehicle(name: "lambo", numberPlate: "TN-72 2563", type: .car, parked: true),
                            arrivalTime: "Monday, 05 June 2022 07:10:21 AM", depatureTime: ""),
                     ParkingSlot(slotNo: 4, vehicle: Vehicle(name: "pulsur", numberPlate: "TN-72 3653", type: .bike, parked: true),
                            arrivalTime: "Sunday, 04 June 2022 04:06:21 AM", depatureTime: ""),
                     ParkingSlot(slotNo: 3, vehicle: Vehicle(name: "yamaha", numberPlate: "TN-72 5672", type: .bike, parked: true),
                            arrivalTime: "Monday, 05 June 2022 01:04:21 AM", depatureTime: ""),
                     ParkingSlot(slotNo: 2, vehicle: Vehicle(name: "tesla", numberPlate: "KL-23 6783", type: .car, parked: false),
                            arrivalTime: "Sunday, 04 June 2022 06:03:21 AM", depatureTime: "Monday, 05 June 2022 06:03:21 AM")]

struct Vehicle {
    var name: String
    var numberPlate: String
    var type: VehicleType
    var parked: Bool = false
}

struct ParkingSlot {
    var slotNo: Int
    var vehicle: Vehicle
    var arrivalTime: String = ""
    var depatureTime: String = ""
}
extension ParkingSlot{
    mutating func setDate() {
        let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "EEEE, dd MMMM yyyy HH:mm:ss a"
        let date = dateFormatter.string(from: Date())
        if !self.vehicle.parked { self.depatureTime = date } else { self.arrivalTime = date }
    }
}

class ParkingArea {
    let name: String = "Zoho Parking"
    var parkingSlots = parkedVehicleList
    var maxBikeSlot: Int = 0
    var maxCarSlot: Int = 0
    var totalSlots: Int {maxBikeSlot + maxCarSlot}
    var availableBikeSlot: Int { maxBikeSlot - parkingSlots.getBikes().count }
    var availableCarSlot: Int { maxCarSlot-parkingSlots.getCars().count }
    var availableTotalSlot: Int { availableBikeSlot + availableCarSlot }
    
    func allocateMaxSlot() {
        print("Enter Total Car and Bike slots")
        let enteredCarSlot = readLine().unwrap.toInt
        enteredCarSlot > 0 ? maxCarSlot = enteredCarSlot : print("0 cannot be maxslot")
        let enteredBikeSlot = readLine().unwrap.toInt
        enteredBikeSlot > 0 ? maxBikeSlot = enteredBikeSlot : print("0 cannot be maxslot")
    }
    
    func park() throws {
        let vehicleType = getVehicleType()
        guard vehicleType == .car ? availableCarSlot > 0 : availableBikeSlot > 0 else {
            throw ParkingErrors.Full(vehicleType)
        }
        
        print("Enter \(vehicleType) number, Name and Slot Number")
        let vehicleNumber = readLine().unwrap
        let name = readLine().unwrap
        
        guard !isExist(vehicleNumber) else {
            throw ParkingErrors.Exist(vehicleNumber)
        }
        
        let slotNumber = readLine().unwrap.toInt
        guard slotNumber > 0, !slotAllocation(slotNumber, vehicleType) else {
            throw ParkingErrors.InvalidSlot(slotNumber)
        }
        
        var parkedSlot = ParkingSlot(slotNo: slotNumber, vehicle: Vehicle(name: name, numberPlate: vehicleNumber, type: vehicleType, parked: true))
        parkedSlot.setDate()
        parkingSlots.append(parkedSlot)
    }

    func dispatchVehicle() throws {
        let type = getVehicleType()
        print("Enter Slot number")
        let slotNo = readLine().unwrap.toInt
        let vehicleIndex = parkingSlots.getVehicleIndex(type, slotNo)
        guard vehicleIndex >= 0 else {
            throw ParkingErrors.NotFound
        }
        parkingSlots[vehicleIndex].vehicle.parked = false
        parkingSlots[vehicleIndex].setDate()
        print("vehicle depatured")
    }
    
    func isSlotOccupied() -> Bool {
        let vehicleType = getVehicleType()
        let enteredSlot = readLine().unwrap.toInt
        let slotValid: Bool = vehicleType == .car ? (enteredSlot <= maxCarSlot && enteredSlot > 0) : (enteredSlot <= maxBikeSlot && enteredSlot > 0)
        return availableTotalSlot > 0 ? (slotValid ? parkingSlots.checkSlot(enteredSlot, vehicleType) : true) : true
    }
    
    func searchForVehicle() -> [ParkingSlot] {
        let searchKeyWord = readLine().unwrap
        return parkingSlots.search(searchKeyWord)
    }
    
    func checkTotalSlots(){
        print("Bike slots: \(maxBikeSlot), Available: \(availableBikeSlot)")
        print("Car slots: \(maxCarSlot), Available: \(availableCarSlot)")
        print("Total slots: \(totalSlots), Available: \(availableTotalSlot)")
    }

    func getVehicles(_ parked: Bool){
        print("""
              1. View all
              2. Bikes
              3. Car
              """)
        let userInput = readLine().unwrap
        if parked  {
        switch(userInput) {
            case "1": parkingSlots.parkedVehicles().printSlots
            case "2": parkingSlots.getBikes().printSlots
            case "3": parkingSlots.getCars().printSlots
            default: print("Enter correct value")
        } } else {
        switch(userInput) {
            case "1": parkingSlots.parkedVehicles(isParked: false).printSlots
            case "2": parkingSlots.getBikes(isParked: false).printSlots
            case "3": parkingSlots.getCars(isParked: false).printSlots
            default: print("Enter correct value")
            }
        }
    }
    func clearParkingHistory() {
        parkingSlots.clearHistory()
    }
}

extension ParkingArea {
    private func slotAllocation(_ slotNumber: Int, _ vehicleType: VehicleType) -> Bool {
        return parkingSlots.contains(where: {$0.vehicle.type == vehicleType && $0.slotNo == slotNumber && $0.vehicle.parked })
    }
    
    private func isExist(_ numberPlate: String) -> Bool {
        return parkingSlots.contains(where: { $0.vehicle.numberPlate == numberPlate && $0.vehicle.parked })
    }
    
    private func getVehicleType() -> VehicleType{ 
        print("Enter Vehicle Type -> 1: Car 2: Bike")
        while true {
            let userSelection = readLine().unwrap
            switch(userSelection) {
                case "1": return .car
                case "2": return .bike
                default : print("Select a valid type")
            }
        }
    }
}

let parkingPlace = ParkingArea()

func main() {
    while true {
        if parkingPlace.maxBikeSlot == 0 && parkingPlace.maxCarSlot == 0 { parkingPlace.allocateMaxSlot() }
        print("""
              
              1. Set Max Slots
              2. Park vehicle
              3. Remove vehicle
              4. Is Slot Free
              5. Search for vehicle
              6. check total slots
              7. View currently parked vehicle details
              8. View previously parked vehicle details
              9. Clear parking history
              
              """)
        let userSelection = readLine().unwrap
        switch(userSelection) {
            case "1": parkingPlace.allocateMaxSlot()
            case "2": do {
                        try parkingPlace.park() 
                        } catch ParkingErrors.Full(let type) {
                            print("\(type) slot full")
                        } catch ParkingErrors.Exist(let number) {
                            print("\(number) already parked")
                        } catch ParkingErrors.Empty {
                            print("No Available Slots ")
                        } catch ParkingErrors.InvalidSlot(let slot) {
                            print("Slot Number \(slot) is Invalid or taken")
                        } catch { print("\(error)") }
            case "3": do { 
                        try parkingPlace.dispatchVehicle()
                        } catch ParkingErrors.NotFound {
                            print("Vehicle Not found")
                        } catch { print("\(error)") }
            case "4": let isAvailable = parkingPlace.isSlotOccupied()
                        isAvailable ? print("slot taken or invalid") : print("slot is free") 
            case "5": parkingPlace.searchForVehicle().printSlots
            case "6": parkingPlace.checkTotalSlots()
            case "7": parkingPlace.getVehicles(true)
            case "8": parkingPlace.getVehicles(false)
            case "9": parkingPlace.clearParkingHistory()
            default : print("Enter a correct value")
        }
    }
}
main()
