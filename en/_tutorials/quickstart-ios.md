# {{ captcha-full-name }} in iOS apps

To embed {{ captcha-name }} in an iOS app:

1. [Configure your website's JS part](#customize-js-part).
1. [Configure your website's native part](#customize-native-part).

## Getting started {#before-begin}

1. [Add HTML code](../smartcaptcha/tutorials/mobile-app/website.md) to work with {{ captcha-name }} (or use a ready-made `{{ captcha-mobile-site }}`).
1. Create a CAPTCHA following [this guide](../smartcaptcha/operations/create-captcha.md).
1. [Retrieve the CAPTCHA keys](../smartcaptcha/operations/get-keys.md). Copy the **{{ ui-key.yacloud.smartcaptcha.label_client-key }}** and **{{ ui-key.yacloud.smartcaptcha.label_server-key }}** field values from the **{{ ui-key.yacloud.common.overview }}** tab of the CAPTCHA you created. You will need the **{{ ui-key.yacloud.smartcaptcha.label_client-key }}** to load web pages using CAPTCHA and the **{{ ui-key.yacloud.smartcaptcha.label_server-key }}**, to get the CAPTCHA test results.

## Configure your website's JS part {#customize-js-part}

If you do not use `{{ captcha-mobile-site }}`, follow these steps:

1. [Add a {{ captcha-name }} widget](../smartcaptcha/quickstart.md#add-widget) to the web page.
1. Create a method to communicate with the app's native part:

   ```js
   function sendIos(...args) {
           if (args.length == 0) {
             return;
           }
           const message = {
             method: args[0],
             data: args[1] !== undefined ? args[1] : ""
           };

           // Check for a call from WKWebView
           if (window.webkit) {
             window.webkit.messageHandlers.NativeClient.postMessage(message);
           }
         }
   ```

   With the following message format:

   ```js
   {
       method: "captchaDidFinish" | "challengeDidAppear" | "challengeDidDisappear"
       data: "tokenName" | ""
   }
   ```

   The method returns the following:
   * `success`: Successful user validation.
   * `challenge-visible`: Opening the CAPTCHA challenge pop-up window.
   * `challenge-hidden`: Closing the CAPTCHA challenge pop-up window.

## Configure your website's native part {#customize-native-part}

1. In **WKUserContentController**, register a handler named `WKScriptMessageHandler` for the `NativeClient` key.
1. Implement the following method in the handler:

   ```swift
   func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
       guard let jsData = message.body as? [String: String] else { return }
           guard let methodName = jsData["method"] else { return }
           doSomething(name: methodName, params: jsData["data"])
   }
   ```

1. Once you get the token from the `captchaDidFinish` method, send a GET request to the server for validation (`https://smartcaptcha.yandexcloud.net/validate`) with the following parameters:

   {% include [query-parameters](../_includes/smartcaptcha/query-parameters.md) %}

### challengeDidAppear method for invisible CAPTCHA {#challengeDidAppear-method}

CAPTCHA [will not be shown in the page HTML code](../smartcaptcha/concepts/invisible-captcha.md) if it is called with the `invisible` parameter. Make sure **WKWebView** is uploaded but is not available to the user until the `challengeDidAppear` method is called. Here is one of the ways to ensure this:

```swift
UIApplication.shared.windows.first?.addSubview(webControllerView)
```

If the validation results in `captchaDidFinish`, remove `webControllerView` from the hierarchy. If the result does not contain `captchaDidFinish`, move `webControllerView` to the hierarchy to display to the user.

### challengeDidDisappear method for invisible CAPTCHA {#challengeDidDisappear-method}

If the user swiped CAPTCHA off, they cannot restore it on their own. In this case, call the **WKWebView** content reload method on the `challengeDidDisappear` event:

```swift
webControllerView.reload()
```

## Sample implementation in Swift using {{ captcha-mobile-site }} {#ios-example}

This section describes the steps to follow to create an app with a CAPTCHA for iOS. For more information, refer to an example of a ready-to-use app with all components configured: [Yandex SmartCaptcha for iOS](https://github.com/yandex-cloud-examples/yc-smartcaptcha-ios-example/tree/main).

1. Create a class to store **WKWebView**:

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

1. Add a property to store the **WKUserContentController** handler:

   ```swift
   private var handlers = [String: WebContentHandlerBase]()

       func setup(handlers: [String: WebContentHandlerBase]) {
           handlers.forEach { userContentController.add($1, name: $0) }
           view = WKWebView(frame: .zero, configuration: getConfiguration())
       }
   ```

1. Create a handler implementation for the {{ captcha-name }} page methods:

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

1. Create a class to validate the token from {{ captcha-name }}:

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
