import Foundation

extension Optional where Wrapped == String {
    var unwrap: String {
        self ?? ""
    }
}
extension String {
    var toInt: Int {
        Int(self) ?? -1
    }
}
extension Int {
    var toString: String {
        String(self)
    }
}
enum Places: CaseIterable {
    case chennai, tirunelveli, bangalore
    
    static let placeList: [Places] = Self.allCases
    
    static var printList: Void {
        Self.placeList.enumerated().forEach({print($0.offset + 1, ": ", $0.element)})
    }
}
enum TravelDetail: Equatable {
    //    enum TravelDetail {
    //        case from(_ place: Places),
    //             to(_ place: Places),
    //             Time(_ date: Date)
    //    }
    
    case travelDetail(from: Places, to: Places, time: Date? = nil)
    //    case travelLog(bus: BusModel, from: Places, to: Places, time: Date, rating: Int = 0)
    
//    var description: String {
//        switch self {
//        case let LocationDetail(from, to, time):
//            return "From: \(from), To: \(to), Time: \(time))"
//        //        default:
//        //            return ""
//        }
//    }
}

protocol Model {
    var name: String {get set}
}

struct BookingModel {
    var from: Places
    var to: Places
    var time: Date
    var occupiedBy = String()
    var occupiedSeatNumber = Int()
}

struct BusModel: Model {
    var name: String
    var totalSeats: Int = 20
    var availableSeats: Int { 20 }
    var places: [BookingModel]
    var bookedSeats = [BookedSeat]()
}

struct BookedSeat {
    var occupiedBy: UserModel
    var seatNumber: Int
}

struct UserModel: Model {
    var name: String
    var password: String
    var loggedIn: Bool = false
    var userHistory = [BookingModel]()
    
}

class BusViewModel {
    var busList = BusList.busList
    
    func showList() {
        busList.printAll()
    }
    func availableBuses(from: Places, destination: Places) -> [BusModel]? {
        return busList.filterList(from, destination)
    }
}

class UserViewModel {
    var userList = UserList.userList
    
    func showList() {
        userList.printAll()
    }
    
    func verify(_ name: String, _ password: String) -> UserModel? {
        return userList.getUser(name, password)
    }
}

extension Array where Element: Model {
    func filterList(_ from: Places, _ to: Places)  -> [BusModel]? {
        let `self` = self as? [BusModel]
//        var filteredList = self?.map({$0.places.filter({$0.from == from && $0.to == to})})
//        print(filteredList)
        
//        return filteredList
        var newList = self?.filter({$0.places.contains( where: {$0.from == from && $0.to == to})})
        return self?.filter{$0.places.contains( where: {$0.from == from && $0.to == to})}
    }
    
    func printAll() {
        self.enumerated().forEach { if let element = $0.element as? UserModel {
            print("\($0.offset+1) Name: \(element.name)")
            element.userHistory.forEach({ print("\tfrom: \($0.from), to: \($0.to), time: \($0.time)")})
        } else if let element = $0.element as? BusModel {
            print("\($0.offset+1) Travels Name: \(element.name)")
            element.places.forEach({ print("\tfrom: \($0.from), to: \($0.to), time: \($0.time)")})
        }
        }
        //        for element in self {
        //            if let element = element as? UserModel {
        //                print(element.name, element.userHistory.map { $0.description })
        //            } else if let element = element as? BusModel {
        //                print(element.name, element.places.description.map { $0.description })
        //            }
        //        }
    }
    
    func getUser(_ name: String, _ password: String) -> UserModel? {
        let `self` = self as? [UserModel]
        return self?.first {  $0.name == name && $0.password == password }
    }
}

class Booking {
    func login() {
        let userName = readLine().unwrap
        let password = readLine().unwrap
        guard var currentUser = UserViewModel().verify(userName, password) else {
            return
        }
        currentUser.loggedIn = true
        bookingMenu(currentUser)
    }
    
    private func bookingMenu(_ currentUser: UserModel) {
        print("""
              1. Book a Ticket
              2. Logout
              """)
        let selection = readLine().unwrap
        userSelection(selection)
    }
    
    private func book() {
        let places = Places.allCases
        print("Select From Location")
        Places.printList
        let fromLocationIndex = readLine().unwrap.toInt - 1
        print("Select Destination Location")
        let toLocationIndex = readLine().unwrap.toInt - 1
        guard toLocationIndex >= 0, toLocationIndex < places.count,
              fromLocationIndex >= 0, fromLocationIndex < places.count else {
                  print("index error", fromLocationIndex, toLocationIndex)
            return
        }
        guard let bus = BusViewModel().availableBuses(
                from: places[fromLocationIndex], destination: places[toLocationIndex]
        ) else {
            return
        }
        selectBus(bus)
    }
}
extension Booking {
    private func userSelection(_ selection: String){
        switch selection {
        case "1": book()
        case "2": break
        case "3": break
        default:
            break
        }
    }
    private func selectBus(_ bus: [BusModel]) {
        bus.printAll()
        let selectedBus = readLine().unwrap.toInt - 1
        guard selectedBus >= 0, selectedBus < bus.count else {
            return
        }
        selectSeat(bus[selectedBus])
    }
    private func selectSeat(_ bus: BusModel) {
        
    }
}

struct BusList {
    static var busList: [BusModel] = [
        BusModel(name: "Sundara travels", places: [
            BookingModel(from: .bangalore, to: .tirunelveli, time: Date()),
            BookingModel(from: .tirunelveli, to: .bangalore, time: Date())
        ]),
        BusModel(name: "Jupyter travels", places: [
            BookingModel(from: .tirunelveli, to: .chennai, time: Date()),
            BookingModel(from: .chennai, to: .tirunelveli, time: Date()),
            BookingModel(from: .bangalore, to: .chennai, time: Date()),
            BookingModel(from: .chennai, to: .bangalore, time: Date())
        ]),
    ]
}

struct UserList {
    static var userList: [UserModel] = [
        UserModel(name: "ganesh", password: "123456",
                  userHistory: [
                    BookingModel(from: .tirunelveli, to: .chennai, time: Date()),
                    BookingModel(from: .tirunelveli, to: .chennai, time: Date())
                  ]),
    ]
}

Booking().login()
