//: Playground - noun: a place where people can play

import Foundation
import UIKit

let baseURL = URL(string: "http://food2fork.com/api/search?")!

let query: [String: String] = [
    "key": "0bef0e09d13316b22b89a8b44b7e0666",
    "q": "garlic"
]

let url = baseURL.withQueries(query)
let task = URLSession.shared.dataTask(with: url) { (data,
    response, error) in
    if let data = data,
        let string = String(data: data, encoding: .utf8) {
        print(string)
    }
}

task.resume()

extension URL {
func withQueries(_ queries: [String: String]) -> URL? {
    var components = URLComponents(url: self,
                                   resolvingAgainstBaseURL: true)
    components?.queryItems = queries.flatMap
        { URLQueryItem(name: $0.0, value: $0.1) }
    return components?.url
}
}
