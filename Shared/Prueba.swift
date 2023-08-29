//
//  Prueba.swift
//  ChatBot Demo
//
//  Created by DANIEL ALARCON S on 12/08/23.
//
/*
import Foundation

class EnhancedChatBot {

  // Singleton para acceder al chatbot
  //private static let sharedInstance = EnhancedChatBot()
  //static func getInstance() -> EnhancedChatBot {
  //  return sharedInstance
  //}

  private init() {
    conditionsRepository.loadConditions(from: "conditions.json")
  }

  private let conditionsRepository = ConditionsRepository()

  //private let gptAPIEndpoint = "https://api.openai.com/v1/engines/gpt-3.5-turbo/completions"
  //private let gptAPIKey = "TU_LLAVE_DE_API"

  //func getResponse(message: String, completion: @escaping (Result<String, Error>) -> Void) {
   // let formattedMessage = conditionsRepository.formatMessage(message: message)
   // getGPT3Response(message: formattedMessage, completion: completion)
  //}

  private func getGPT3Response(message: String, completion: @escaping (Result<String, Error>) -> Void) {
    if let request = createGPT3Request(message: message) {
      let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        if let data = data {
          do {
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
               let choices = json["choices"] as? [[String: Any]],
               let firstChoice = choices.first,
               let text = firstChoice["text"] as? String {
              completion(.success(text.trimmingCharacters(in: .whitespacesAndNewlines)))
            } else {
              completion(.failure(NSError(domain: "InvalidResponse", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid response format from GPT-3.5 API"])))
            }
          } catch {
            completion(.failure(error))
          }
        } else if let error = error {
          completion(.failure(error))
        } else {
          completion(.failure(NSError(domain: "UnknownError", code: 0, userInfo: [NSLocalizedDescriptionKey: "An unknown error occurred"])))
        }
      }
      task.resume()
    } else {
      completion(.failure(NSError(domain: "InvalidRequest", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to create request for GPT-3.5 API"])))
    }
  }

  private func createGPT3Request(message: String) -> URLRequest? {
    let url = URL(string: gptAPIEndpoint)!
    var request = URLRequest(url: url)

    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("Bearer \(gptAPIKey)", forHTTPHeaderField: "Authorization")

    let payload: [String: Any] = [
      "prompt": message,
      "max_tokens": 150
    ]

    if let jsonData = try? JSONSerialization.data(withJSONObject: payload, options: []) {
      request.httpBody = jsonData
      return request
    }

    return nil
  }

  func addCondition(key: String, value: String) {
    conditionsRepository.addCondition(key: key, value: value)
  }

  func removeCondition(key: String) {
    conditionsRepository.removeCondition(key: key)
  }
}

class ConditionsRepository {

  private var conditions: [String: String] = [:]

  // Carga las condiciones desde un archivo JSON.
  func loadConditions(from file: String) {
    if let data = try? Data(contentsOf: URL(fileURLWithPath: file)),
       let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: String] {
      conditions = json
    }
  }

  // Guarda las condiciones en un archivo JSON.
  func saveConditions(to file: String) {
    if let data = try? JSONSerialization.data(withJSONObject: conditions, options: .prettyPrinted) {
      try? data.write(to: URL(fileURLWithPath: file), options: .atomic)
    }
  }

  // Agrega una nueva condición (o actualiza si ya existe).
  func addCondition(key: String, value: String) {
    conditions[key] = value
  }

  // Elimina una condición.
  func removeCondition(key: String) {
    conditions.removeValue(forKey: key)
  }

  // Formatea el mensaje con una condición predefinida si coincide.
  func formatMessage(message: String) -> String {
    for (key, value) in conditions {
      if message.contains(key) {
        return value
      }
    }
    return message
  }
}

*/
