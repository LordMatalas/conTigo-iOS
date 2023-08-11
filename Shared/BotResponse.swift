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
