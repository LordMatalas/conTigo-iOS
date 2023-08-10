//
//  BotResponse.swift
//  ChatBot Demo
//
//  Created by Daniel Alarcón S on 13/07/23.
//

import Foundation

func getBotResponse (message: String) -> String {
    let tempMessage = message.lowercased()
    
    if tempMessage.contains("hola"){
        return "¡Hola! ¿Cómo estás?"
    } else if tempMessage.contains("adios"){
        return "Fue un placer hablar conntigo. Cuidate mucho!"
    } else if tempMessage.contains("que eres"){
        return "Soy un pequeño demo desarrollado para conversar contigo. Mi ideal es llegar ser un buen consejero para tu vida."
    } else {
        return "Eso suena bastante interesante... ¿Quisieras compartir más detalles conmigo?"
    }
}

// codigo Carlos. Primo aqui le dejo un codigo para que lo revise. 10 de agosto 2023.
import Foundation

class EnhancedChatBot {

  // Singleton para acceder al chatbot
  private static let sharedInstance = EnhancedChatBot()
  static func getInstance() -> EnhancedChatBot {
    return sharedInstance
  }

  private init() {
    conditionsRepository.loadConditions(from: "conditions.json")
  }

  private let conditionsRepository = ConditionsRepository()

  private let gptAPIEndpoint = "https://api.openai.com/v1/engines/gpt-3.5-turbo/completions"
  private let gptAPIKey = "TU_LLAVE_DE_API"

  func getResponse(message: String, completion: @escaping (Result<String, Error>) -> Void) {
    let formattedMessage = conditionsRepository.formatMessage(message: message)
    getGPT3Response(message: formattedMessage, completion: completion)
  }

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
// el codigo hace esto: 1. EnhancedChatBot Class:
//private static let sharedInstance = EnhancedChatBot():

//Aquí se crea una instancia estática de la clase EnhancedChatBot. Esto es parte del patrón Singleton, que asegura que solo haya una instancia de esta clase en todo el programa.
//static func getInstance() -> EnhancedChatBot:

//Es un método estático que permite acceder a la única instancia de la clase (la que se creó arriba). Es parte del patrón Singleton.
//private init():

//Es el constructor privado de la clase. Es privado para asegurarse de que no se puedan crear otras instancias de EnhancedChatBot fuera de la clase. Al inicializar, carga las condiciones desde un archivo JSON llamado conditions.json.
//private let conditionsRepository = ConditionsRepository():

//Crea una instancia del repositorio de condiciones. Este repositorio se encargará de cargar, guardar, agregar y eliminar condiciones.
//private let gptAPIEndpoint = "https://api.openai.com/v1/engines/gpt-3.5-turbo/completions":

//s una constante que almacena la URL de la API de OpenAI.
//private let gptAPIKey = "TU_LLAVE_DE_API":

//Aquí es donde debes colocar tu llave de API de OpenAI para poder hacer solicitudes.
//func getResponse(message: String, completion: @escaping (Result<String, Error>) -> Void):

//Este método se encarga de obtener una respuesta de la API de OpenAI. Primero formatea el mensaje utilizando el repositorio de condiciones y luego envía ese mensaje a la API.
//private func getGPT3Response(message: String, completion: @escaping (Result<String, Error>) -> Void):

//Esta es una función que realiza la llamada a la API de OpenAI. Utiliza la clase URLSession para hacer la solicitud.
//private func createGPT3Request(message: String) -> URLRequest?:

//Crea y configura una solicitud HTTP para enviar a la API de OpenAI.
//func addCondition(key: String, value: String) y func removeCondition(key: String):

//Métodos para agregar y eliminar condiciones usando el repositorio de condiciones.
//2. ConditionsRepository Class:
//private var conditions: [String: String] = [:]:

//Un diccionario que almacena las condiciones. La clave es una palabra o frase, y el valor es la condición correspondiente.
//func loadConditions(from file: String):

//Carga las condiciones desde un archivo JSON especificado.
//func saveConditions(to file: String):

//Guarda las condiciones actuales en un archivo JSON especificado.
//func addCondition(key: String, value: String) y func removeCondition(key: String):

//Métodos para agregar y eliminar condiciones del diccionario.
//func formatMessage(message: String) -> String:

//Busca en el mensaje si alguna de las claves del diccionario de condiciones está presente. Si es así, retorna el valor correspondiente. Si no, simplemente retorna el mensaje original.
//En resumen, el código define un chatbot mejorado (EnhancedChatBot) que utiliza la API de OpenAI para obtener respuestas. Este chatbot tiene la capacidad de formatear mensajes según ciertas condiciones almacenadas en un archivo JSON antes de enviarlos a OpenAI. La gestión de estas condiciones se realiza a través de la clase ConditionsRepository.
