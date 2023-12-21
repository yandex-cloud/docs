# {{ captcha-full-name }} в приложении на iOS

Чтобы встроить [{{ captcha-name }}](../../smartcaptcha/) в приложение на iOS:
1. [Настройте JS часть сайта](#customize-js-part).
1. [Настройте нативную часть сайта](#customize-native-part).

## Перед началом работы {#before-begin}

1. [Разместите HTML-код](../../smartcaptcha/tutorials/mobile-app/website.md) для работы {{ captcha-name }} (или воспользуйтесь готовым `{{ captcha-mobile-site }}`).
1. Создайте капчу по [инструкции](../../smartcaptcha/operations/create-captcha.md).
1. [Получите ключи](../../smartcaptcha/operations/get-keys.md) капчи. Скопируйте значения полей **{{ ui-key.yacloud.smartcaptcha.label_client-key }}** и **{{ ui-key.yacloud.smartcaptcha.label_server-key }}** на вкладке **{{ ui-key.yacloud.common.overview }}** созданной вами капчи. **{{ ui-key.yacloud.smartcaptcha.label_client-key }}** понадобится для загрузки страницы с капчей, **{{ ui-key.yacloud.smartcaptcha.label_server-key }}** — для получения результата прохождения капчи.

## Настройте JS часть сайта {#customize-js-part}

Если вы не используете `{{ captcha-mobile-site }}`, то выполните следующие действия:
1. [Добавьте виджет](../../smartcaptcha/quickstart.md#add-widget) {{ captcha-name }} на страницу сайта.
1. Создайте метод для взаимодействия с нативной частью приложения:

   ```js
   function sendIos(...args) {
     if (args.length == 0) {
       return;
     }
     const message = {
       method: args[0],
       data: args[1] !== undefined ? args[1] : ""
     };

     // Проверка на вызов из WKWebView.
     if (window.webkit) {
       window.webkit.messageHandlers.NativeClient.postMessage(message);
     }
   }
   ```

   С форматом сообщения:

   ```js
   {
     method: "captchaDidFinish" | "challengeDidAppear" | "challengeDidDisappear"
     data: "tokenName" | ""
   }
   ```

   Метод возвращает:
   * `success` — успешная валидации пользователя.
   * `challenge-visible` — открытие всплывающего окна с заданием.
   * `challenge-hidden` — закрытие всплывающего окна с заданием.

## Настройте нативную часть сайта {#customize-native-part}

1. В **WKUserContentController** зарегистрируйте обработчик `WKScriptMessageHandler` для ключа `NativeClient`.
1. В обработчике реализуйте метод:

   ```swift
   func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
     guard let jsData = message.body as? [String: String] else { return }
       guard let methodName = jsData["method"] else { return }
         doSomething(name: methodName, params: jsData["data"])
   }
   ```

1. После получения токена из метода `captchaDidFinish` отправьте GET-запрос на сервер для проверки `https://smartcaptcha.yandexcloud.net/validate` со следующими параметрами:

   {% include [query-parameters](../../_includes/smartcaptcha/query-parameters.md) %}

### Метод challengeDidAppear для невидимой капчи {#challengeDidAppear-method}

Капча [не будет отображаться в HTML-коде страницы](../../smartcaptcha/concepts/invisible-captcha.md), если она была вызвана с параметром `invisible`. **WKWebView** должен быть загружен, но недоступен пользователю до момента вызова метода `challengeDidAppear`. Один из способов сделать это:

```swift
UIApplication.shared.windows.first?.addSubview(webControllerView)
```

Если в результате проверки появляется `captchaDidFinish`, удалите `webControllerView` из иерархии. Если в результате нет `captchaDidFinish`, переместите `webControllerView` в иерархию для показа пользователю.

### Метод challengeDidDisappear для невидимой капчи {#challengeDidDisappear-method}

Если пользователь "смахнул" капчу с экрана, восстановить самостоятельно ее не получится. Вызовите перезагрузку контента в **WKWebView** по событию `challengeDidDisappear`:

```swift
webControllerView.reload()
```

## Пример реализации на Swift с использованием {{ captcha-mobile-site }} {#ios-example}

В этой секции описаны шаги, необходимые для создания приложения с капчей для iOS. См. пример готового приложения, содержащего все настроенные компоненты: [{{ captcha-full-name }} for iOS](https://github.com/yandex-cloud-examples/yc-smartcaptcha-ios-example/tree/main).
1. Создайте класс, который будет хранить **WKWebView**:

   ```swift
   final class WebNativeBridge: NSObject {

     private(set) var view: WKWebView?
     private var userContentController = WKUserContentController()

     func load(_ request: URLRequest?) {
       guard let request = request else { return }
       view?.load(request)
     }

     func reload() {
       view?.reload()
     }

     private func close() {
       view?.removeFromSuperview()
     }

     private func getConfiguration() -> WKWebViewConfiguration {
       let configuration = WKWebViewConfiguration()
       configuration.userContentController = userContentController
       return configuration
     }
   }
   ```

1. Добавьте свойство, где будет храниться обработчик для **WKUserContentController**:

   ```swift
   private var handlers = [String: WebContentHandlerBase]()

     func setup(handlers: [String: WebContentHandlerBase]) {
       handlers.forEach { userContentController.add($1, name: $0) }
       view = WKWebView(frame: .zero, configuration: getConfiguration())
     }
   ```

1. Создайте реализацию обработчика для методов страницы {{ captcha-name }}:

   ```swift
   class WebContentHandlerBase: NSObject, WKScriptMessageHandler {
     var handlerName: String { "" }
     func execMethod(name: String, params: Any?...) {}

     func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
       guard let jsData = message.body as? [String: String] else { return }
       guard let methodName = jsData["method"] else { return }
       execMethod(name: methodName, params: jsData["data"])
     }
   }

   final class CaptchaHandler: WebContentHandlerBase {
     private enum Methods: String {
       case captchaDidFinish
       case challengeDidAppear
       case challengeDidDisappear
     }

     override var handlerName: String {
       "NativeClient"
     }

     weak var delegate: CaptchaHandlerDelegate?
     private var validator: CaptchaValidatorProtocol

     init(_ validator) {
       self.validator = validator
     }

     override func execMethod(name: String, params: Any?...) {
       guard let method = Methods(rawValue: name) else { return }
       switch method {
         case .captchaDidFinish:
           guard let token = params.first as? String else { return }
           onSuccess(token: token)
         case .challengeDidDisappear:
           onChallengeHide()
         case .challengeDidAppear:
           onChallengeVisible()
       }
     }

     private func onSuccess(token: String) {
       validator.validateCaptcha(token: token) { result in
         DispatchQueue.main.async {
           switch result {
             case .success(_):
               self.delegate?.onSuccess()
             case .failure(let err):
               self.delegate?.onError(err)
           }
         }
       }
     }

     private func onChallengeVisible() {
       delegate?.onShow()
     }

     private func onChallengeHide() {
       delegate?.onHide()
     }
   }
   ```

1. Создайте класс для валидации токена от {{ captcha-name }}:

   ```swift
   final class CaptchaValidator: CaptchaValidatorProtocol {
     private var host: String
     private var secret: String
     private var session: URLSession

     init(host: String, secret: String) {
       self.host = host
       self.secret = secret
       session = URLSession(configuration: .default)
     }

     func validateCaptcha(token: String, callback: @escaping (Result<String, Error>) -> Void) {
       guard let url = URL(string: host),
         var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else
       { return }
       components.queryItems = [
         URLQueryItem(name: "secret", value: secret),
         URLQueryItem(name: "token", value: token),
         URLQueryItem(name: "ip", value: getIPAddress()),
       ]
       let task = session.dataTask(with: URLRequest(url: components.url!)) { data, response, error in
         guard let code = (response as? HTTPURLResponse)?.statusCode, code == 200 else { return }
         guard let data = data,
           let result = try? JSONDecoder().decode(YACValidationResponse.self, from: data) else { return }
         if result.status == "ok" {
           callback(.success("ok"))
         } else {
           callback(.failure(NSError(domain: result.message ?? "", code: code)))
         }
       }
       task.resume()
     }

     private func getIPAddress() -> String {
       var address: String = ""
       var ifaddr: UnsafeMutablePointer<ifaddrs>? = nil
       if getifaddrs(&ifaddr) == 0 {
         var ptr = ifaddr
         while ptr != nil {
           defer {
             ptr = ptr?.pointee.ifa_next
           }

           let interface = ptr?.pointee
           let addrFamily = interface?.ifa_addr.pointee.sa_family
           if addrFamily == UInt8(AF_INET) {

             if String(cString: (interface?.ifa_name)!) == "en0" {
               var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
               getnameinfo(interface?.ifa_addr, socklen_t((interface?.ifa_addr.pointee.sa_len)!), &hostname, socklen_t(hostname.count), nil, socklen_t(0), NI_NUMERICHOST)
               address = String(cString: hostname)
               print(address)
             }
           }
         }
         freeifaddrs(ifaddr)
       }
       return address
     }
   }
   ```