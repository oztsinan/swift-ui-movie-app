//
//  NetworkService.swift
//  SwiftUIMovieApp
//
//  Created by Sinan Öztürk on 18.09.2024.
//

import Foundation

enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
}

class NetworkService {
    var authToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjNGU3MzVkYjU3MTgyYTQ1YTRhYjFiZjkyODE2MDQwYSIsIm5iZiI6MTcyNjY4ODUxNy41MDc0MDksInN1YiI6IjYyZmE1MTAyYTMxM2I4MDA4NGU3N2Q1MiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.w0IYOlHj5D2vn_YeGhz1kbcT2KRPZjA_6C-GxJqyqY0"

    func performRequest<T: Decodable>(
        url: URL,
        method: HTTPMethod,
        body: Data? = nil, // gönderilecek veri, GET için nil
        query: [String: String]? = nil,
        expecting: T.Type
    ) async throws -> T {
        // URLComponents kullanarak query ekle
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)

        // Varsayılan query item
        var queryItems = [
            URLQueryItem(name: "language", value: "en-EN")
        ]

        // Dışarıdan gelen query parametreleri varsa ekle
        if let additionalQuery = query {
            for (key, value) in additionalQuery {
                queryItems.append(URLQueryItem(name: key, value: value))
            }
        }

        components?.queryItems = queryItems

        // URLComponents'dan tekrar URL'yi oluştur
        guard let finalURL = components?.url else {
            throw NSError(domain: "URL Error", code: 0, userInfo: nil)
        }

        var request = URLRequest(url: finalURL)
        request.httpMethod = method.rawValue
        request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")

        // Eğer POST, PUT gibi veri gönderimi gerekiyorsa body ekliyoruz
        if let body = body {
            request.httpBody = body
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }

        // URLSession üzerinden veri isteği
        let (data, _) = try await URLSession.shared.data(for: request)

        // Veriyi decode et ve sonucu döndür
        do {
            let decodedData = try JSONDecoder().decode(expecting, from: data)
            return decodedData
        } catch {
            throw error
        }
    }
}
