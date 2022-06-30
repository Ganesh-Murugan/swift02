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
    
    // static let placeList: [Places] = Self.allCases
    
    static var printList: Void {
        Self.allCases.enumerated().forEach({print($0.offset + 1, ": ", $0.element)})
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
    var totalSeats: Int = 20
    var from: Places
    var to: Places
    var time: Date
    var occupiedBy = String()
    var occupiedSeatNumber: Int = 0
    var occupiedSeatCount: Int = 0
    var availableSeats: Int { totalSeats - occupiedSeatCount }

    // init(from: Places, to: Places, time: Date){
    //     self.from = from
    //     self.to = to
    //     self.time = time
    // }
}

struct BusModel: Model {
    var name: String
    var places: [BookingModel]
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
        let filteredList = busList.filterList(from, destination)
        return filteredList
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
        Places.printList
        print("Select From Location")
        let fromLocationIndex = readLine().unwrap.toInt - 1
        print("Select Destination Location")
        let toLocationIndex = readLine().unwrap.toInt - 1
        guard toLocationIndex >= 0, toLocationIndex < places.count,
              fromLocationIndex >= 0, fromLocationIndex < places.count,
              toLocationIndex != fromLocationIndex else {
            return
        }
        guard let bus = BusViewModel().availableBuses(
                from: places[fromLocationIndex], destination: places[toLocationIndex]
        ) else {
            return
        }
        guard let selectedBus = selectBus(bus, places[fromLocationIndex], places[toLocationIndex]) else {
            return
        }
        selectSeat(selectedBus)
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
    private func selectBus(_ bus: [BusModel], _ from: Places, _ to: Places) -> BusModel? {
        bus.printAll()
        let selectedBus = readLine().unwrap.toInt - 1
        guard selectedBus >= 0, selectedBus < bus.count else {
            return nil
        }
        // let filteredDetails = bus[selectedBus].places.filter({$0.from == from && $0.to == to})
        // bus[selectedBus].places = filteredDetails
        return bus[selectedBus]
    }
    private func selectSeat(_ bus: BusModel) {
        // let bookingDetails = bus.
        let available = "🟩" 
        let taken = "🟥"
        var color = ""
        print(bus.places[0])
            for seat in 1...bus.places[0].totalSeats {
                color = bus.places[0].occupiedSeatNumber == seat ? taken : available
                [4,8,12,16,20].contains(seat) ? print(color, terminator: "\n") : print(color, terminator: "\t")
            }
           
        }
}

struct BusList {
    static var busList: [BusModel] = [
        BusModel(name: "Sundara travels", places: [
            BookingModel(from: .bangalore, to: .tirunelveli, time: Date(), occupiedSeatNumber: 2),
            BookingModel(from: .tirunelveli, to: .bangalore, time: Date())
        ]),
        BusModel(name: "Jupyter travels", places: [
            BookingModel(from: .tirunelveli, to: .chennai, time: Date(), occupiedSeatNumber: 2),
            BookingModel(from: .chennai, to: .tirunelveli, time: Date(), occupiedSeatNumber: 2),
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
                    BookingModel(from: .tirunelveli, to: .chennai, time: Date(), occupiedSeatNumber: 2)
                  ]),
    ]
}

Booking().login()
