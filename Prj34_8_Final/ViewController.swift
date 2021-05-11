//
//  ViewController.swift
//  Prj34_8_Final
//
//  Created by ИГОРЬ on 10/05/2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var postNNField: UITextField!
    @IBOutlet weak var postTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        view.addGestureRecognizer(tap)
    }
    @IBAction func getBtnPressed(_ sender: UIButton) {
        // все проверим
        guard let postNN = postNNField.text else {return}
        let url = URL(string: "https://jsonplaceholder.typicode.com/comments?postId=" + postNN)
        guard let requestUrl = url else {return}
        // все проверили
        
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        // создаем задачу
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
              // Делаем data неопциональной
              guard let data = data,
                  // Декодируем data в формат .utf8
                  let dataString = String(data: data, encoding: .utf8),
                  // Проверяем, успешно ли выполнился запрос, используя statusCode
                  (response as? HTTPURLResponse)?.statusCode == 200,
                  // Проверяем, нет ли ошибок
                  error == nil else { return }
              // Выводим результат в TextView так чтобы не "повесить" UI
                  DispatchQueue.main.sync {
                        self.postTextView.text = dataString
                  }
          }
          task.resume() // запускаем
    }
    
  
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }

}

