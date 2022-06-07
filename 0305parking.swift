import Foundation

enum VehicleType{
    case bike, car
}
enum ParkingErrors: Error {
        case empty, full
}

extension String {
    var toInt: Int {
        return Int(self) ?? 0
    }
    // var unWrap: String {
    //     return self
    // }
}

struct Vehicle {
    var Id: String
    var name: String
    var numberPlate: String
    var type: VehicleType
}

// let parkedVehicles = [ ParkingSlot(slotNo: 1, vehicle: Vehicle(Id: "01", name: "lambo", numberPlate: "TN-72 2563", type: .car),
//                             arrivalTime: "Monday, 05 June 2022 07:10:21 AM", depatureTime: ""),
//                      ParkingSlot(slotNo: 4, vehicle: Vehicle(Id: "02", name: "pulsur", numberPlate: "TN-72 3653", type: .bike),
//                             arrivalTime: "Sunday, 04 June 2022 04:06:21 AM", depatureTime: ""),
//                      ParkingSlot(slotNo: 3, vehicle: Vehicle(Id: "03", name: "yamaha", numberPlate: "TN-72 5672", type: .bike),
//                             arrivalTime: "Monday, 05 June 2022 01:04:21 AM", depatureTime: ""),
//                      ParkingSlot(slotNo: 2, vehicle: Vehicle(Id: "04", name: "tesla", numberPlate: "KL-23 6783", type: .car),
//                             arrivalTime: "Sunday, 04 June 2022 06:03:21 AM", depatureTime: "")
//                      ]

class ParkingArea {
    var name: String
    var parkingSlots = [ParkingSlot]()
    var depaturedVehicles = [ParkingSlot]()
    var maxBikeSlot: Int = 0 {
        willSet { print("Max Bike slots changed from \(maxBikeSlot) ")}
        didSet{ print("to \(maxBikeSlot)") }
    }
    var maxCarSlot: Int = 0 {
        willSet { print("Max Car slots changed from \(maxCarSlot) ")}
        didSet{ print("to \(maxCarSlot)") }
    }
    var availableBikeSlot: Int {
        get { maxBikeSlot - parkingSlots.filter { $0.vehicle.type == .bike }.count  }
    }
    
    var availableCarSlot: Int {
        get { maxCarSlot - parkingSlots.filter { $0.vehicle.type == .car }.count }
    }
    var totalSlots: Int {
        get { maxCarSlot + maxBikeSlot }
    }
    var totalAvailableSlot: Int {
        get { availableBikeSlot + availableCarSlot }
    }
    init(name: String) {
        self.name = name
    }
    
    func allocateMaxSlot() {
        while true {
            print("Enter Slots for car: ")
            let enteredCarSlot = (readLine() ?? "").toInt
            if enteredCarSlot > 0 { maxCarSlot = enteredCarSlot } else {
                print("Invalid number")
                continue }
            print("Enter Slots for bike: ")
            let enteredBikeSlot = (readLine() ?? "").toInt
            if enteredBikeSlot > 0 { maxBikeSlot = enteredBikeSlot } else {
                print("Invalid number")
                continue }
            break
        }
    }
    // func slotAllocate(slotNumber: Int, vehicleType : VehicleType) -> Bool {
    //     let vehicle = parkingSlots.first(where: {$0.vehicle.type == vehicleType && $0.slotNo == slotNumber})
    // }
    private func slotAllocation(slotNumber: Int, vehicleType : VehicleType) -> Bool {
        
                if vehicleType == .car, slotNumber <= maxCarSlot {
                    for vehicle in parkingSlots where vehicle.vehicle.type == .car {
                        if vehicle.slotNo == slotNumber {
                            print("Slot already allocated")
                            return false
                        }
                    }    
                    return true
                }
                if vehicleType == .bike, slotNumber <= maxBikeSlot {
                    for vehicle in parkingSlots where vehicle.vehicle.type == .bike {
                        if vehicle.slotNo == slotNumber {
                            print("Slot already allocated")
                            return false
                        }
                    }
                   return true
                } 
        return false
    }
    
    func getVehicleType() -> VehicleType {
        print("""
              Enter Vehicle Type
                1: Car
                2: Bike
              """)
        while true {
            let userSelection = readLine() ?? ""
            switch(userSelection) {
                case "1": return .car
                case "2": return .bike
                default : print("Select a valid type")
            }
        }
                
    }
    
    private func isExist(vehicleId: String, numberPlate: String) -> Bool {
        if vehicleId.count < 0 {
            print("Enter a valid Id")
        }
        return parkingSlots.contains(where: { $0.vehicle.Id == vehicleId || $0.vehicle.numberPlate == numberPlate })
            
        }
    
    private func getDate() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, dd MMMM yyyy HH:mm:ss a"
        return dateFormatter.string(from: date)
    }
    
    func park() {
        if parkingSlots.count == totalSlots{
            print("parking full")
            return
        }
        while true {
            let vehicleType = getVehicleType()
            // if vehicleType == .car {
            //     if availableCarSlot == 0{
            //         print("Car parking full")
            //         return
            //     }
            // }

            // guard vehicleType == .car, availableCarSlot > 0 else {return}
            // if vehicleType == .bike {
            //     if availableBikeSlot == 0{
            //         print("Bike parking full")
            //         return
            //     }
            // }
            // guard vehicleType == .bike, availableBikeSlot > 0 else {return}

            guard vehicleType == .car ? availableCarSlot > 0 : availableBikeSlot > 0 else {return}
            print("Enter Vehicle Id:") 
            let vehicleId = readLine() ?? ""
            print("Enter vehicle Number")
            let numberPlate = readLine() ?? ""
            if numberPlate.count >= 4 { 
            if !isExist(vehicleId: vehicleId, numberPlate: numberPlate) {
                print("Enter slot number")
                let slotNumber = (readLine() ?? "").toInt
                if slotAllocation(slotNumber: slotNumber, vehicleType: vehicleType), slotNumber > 0 {
                print("Enter Vehicle Name:")
                let vehicleName = readLine() ?? ""
                if vehicleName.count > 3 {
                        let vehicledetails = Vehicle(Id: vehicleId, name: vehicleName, numberPlate: numberPlate, type: vehicleType)
                        let parkedSlot = ParkingSlot(slotNo: slotNumber, vehicle: vehicledetails, arrivalTime: getDate(), depatureTime: "")
                        parkingSlots.append(parkedSlot)
                        print("vehicle Parked at \(vehicleType) parking slot \(slotNumber)")
                        return
                        } else { print ("Enter a proper vehicle name") }
                    } else { print("Invalid Slot") }
                } else { print ("Vehicle with Id \(vehicleId) or number \(numberPlate) already exists") }
            } else  { print ("Enter a valid number Plate") } 

        }
    }
    
    func isParkingEmpty() -> Bool{
        return parkingSlots.isEmpty
    }
    
    func dispatchVehicle() throws {
        if isParkingEmpty() {
            throw ParkingErrors.empty
        }
        print("Enter vehicle Id")
        let vehicleId = readLine() ?? ""
        if let vehicleIndex = parkingSlots.firstIndex(where: {$0.vehicle.Id == vehicleId}) {
            parkingSlots[vehicleIndex].depatureTime = getDate()
            depaturedVehicles.append(parkingSlots[vehicleIndex])
            let removed = parkingSlots.remove(at: vehicleIndex)
            print("vehicle \(removed.vehicle.name), \(removed.vehicle.numberPlate) at Slot Number \(removed.slotNo) depatured at \(removed.depatureTime)")
        } else {
            print("vehicle Not Found")
        }
    }
    
    func isSlotFree() -> Bool {
        if parkingSlots.count == totalSlots{
            print("parking full")
            return true
        }
        let vehicleType = getVehicleType()
        let enteredSlot = (readLine() ?? "").toInt
        if vehicleType == .car, enteredSlot <= maxCarSlot {
            return parkingSlots.contains(where: {$0.slotNo == enteredSlot && $0.vehicle.type == vehicleType}) 
        } 
        if vehicleType == .bike, enteredSlot <= maxBikeSlot {
            return parkingSlots.contains(where: {$0.slotNo == enteredSlot && $0.vehicle.type == vehicleType}) 
        } else {
            print("Invalid slot") 
            return true 
        }
    }
    
    func searchForVehicle() -> [ParkingSlot]{
        if isParkingEmpty(){
            print("parking is empty!")
        }
        let enteredValue = readLine() ?? ""
        let filteredVehicle = parkingSlots.filter {
                    $0.vehicle.name.localizedCaseInsensitiveContains(enteredValue) ||
                    $0.vehicle.Id.localizedCaseInsensitiveContains(enteredValue) ||
                    $0.vehicle.numberPlate.localizedCaseInsensitiveContains(enteredValue)
        }
        if filteredVehicle.isEmpty {
            print("not found")
        }
        return filteredVehicle
    }
    
    func checkTotalSlots(){
        print("Bike slots: \(maxBikeSlot), Available: \(availableBikeSlot)")
        print("Car slots: \(maxCarSlot), Available: \(availableCarSlot)")
        print("Total slots: \(totalSlots), Available: \(totalAvailableSlot)")
    }
    
    private func printSlots(slot: ParkingSlot) {
                    print("Vehicle \(slot.vehicle.name), Id \(slot.vehicle.Id), Number \(slot.vehicle.numberPlate) is parked at \(slot.vehicle.type) parking slot number \(slot.slotNo), Parked Time: \(slot.arrivalTime), Depature Time: \(slot.depatureTime)")
    }
    
    func getCurrentlyParkedVehicles() {
        print("""
              1. View all
              2. Bikes
              3. Car
              """)
        let userInput = readLine() ?? ""
        switch(userInput) {
            case "1": for slot in parkingSlots{
                        printSlots(slot: slot)
                    }
            case "2": for slot in parkingSlots where slot.vehicle.type == .bike{
                        printSlots(slot: slot)           
                    }
            case "3": for slot in parkingSlots where slot.vehicle.type == .car{
                        printSlots(slot: slot)
                    }
            default: print("enter correct value")
        }
    }

    func getPreviouslyParkedVehicle() {
        print("""
              1. View all
              2. Bikes
              3. Car
              """)
        let userInput = readLine() ?? ""
        switch(userInput) {
            case "1": for slot in depaturedVehicles {
                    printSlots(slot: slot)
            }
            case "2": for slot in depaturedVehicles where slot.vehicle.type == .bike{
                        printSlots(slot: slot)
            }
            case "3": for slot in depaturedVehicles where slot.vehicle.type == .car{
                        printSlots(slot: slot)
            }
            default: print("enter correct value")
        }
    }
}

struct ParkingSlot {
    var slotNo: Int
    var vehicle: Vehicle
    var arrivalTime: String
    var depatureTime: String
    
}

let parkingPlace = ParkingArea(name: "zoho parking")

func main() {
    while true {
        if parkingPlace.maxBikeSlot == 0 || parkingPlace.maxCarSlot == 0 {
                    print("Max slots allocation")
                    parkingPlace.allocateMaxSlot()
                }
    print("""
          
          1. Set Max Slots
          2. Park vehicle
          3. Remove vehicle
          4. Is Slot Free
          5. Search for vehicle
          6. check total slots
          7. View currently parked vehicle details
          8. View previously parked vehicle details
          
          """)
        let userSelection = readLine() ?? ""
        switch(userSelection) {
            case "1": parkingPlace.allocateMaxSlot()
            case "2": parkingPlace.park()
            case "3": do { 
                        try parkingPlace.dispatchVehicle()
                        } catch ParkingErrors.empty {
                            print("parking is empty")
                        } catch {
                            print("\(error)")
                        }
            case "4": let isNotAvailable = parkingPlace.isSlotFree()
                        if isNotAvailable {
                            print("slot taken")
                        } else {
                            print("slot is free")
                        }
            case "5": let filteredSlot = parkingPlace.searchForVehicle()
                for slots in filteredSlot {
                    print("vehicle \(slots.vehicle.name), \(slots.vehicle.numberPlate) is at \(slots.vehicle.type) parking in slot number \(slots.slotNo)")
                }
            case "6": parkingPlace.checkTotalSlots()
            case "7": parkingPlace.getCurrentlyParkedVehicles()
            case "8": parkingPlace.getPreviouslyParkedVehicle()
            default : print("Enter a correct value")
        }
    }
}
main()
