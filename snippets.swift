//FontSet
enum FontSet {
    case caption, body
}
extension UILabel {
    
    func setFont(_ fontSet: FontSet) {
        switch fontSet{
        case .caption:
            self.font = .monospacedSystemFont(ofSize: 15, weight: .bold)
            self.textColor = .gray
            self.lineBreakMode = .byWordWrapping
            self.numberOfLines = 0
        case .body:
            self.font = .systemFont(ofSize: 18)
        }
    }
}


//toInt
extension String {
    var toInt: Int {
        Int(self) ?? 0
    }
}

//toString
extension Int {
    var toString: String  {
        String(self)
    }
}

extension Array where Element == Int {
    var toString: [String] {
        return self.map({$0.toString})
    }
}

//Defaultable, unwrapping
protocol Default {
    static var defaultValue: Self { get }
}

extension Optional where Wrapped: Default {

    var unwrap: Wrapped {
        switch self {
        case .none:
            return Wrapped.defaultValue
        case .some(let wrapped):
            return wrapped
        }
    }
}

extension Int: Default {
    static var defaultValue: Int {
        0
    }
}

extension String: Default {
    static var defaultValue: String {
        "0"
    }
}

//urlSession
extension URLSession {
    enum CustomError: Error{
        case invalidUrl, invalidData
    }
    func request<T: Decodable>(for urlString: String,expecting: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(CustomError.invalidUrl))
            return
        }
        let task = dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(CustomError.invalidData))
                }
                return
            }
            do {
                let object = try JSONDecoder().decode(expecting, from: data)
                completion(.success(object))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}

