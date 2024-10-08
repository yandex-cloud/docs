---
title: Как встроить {{ captcha-name }} в приложение для Android на платформе Flutter
description: Следуя данной инструкции, вы сможете добавить капчу в Android-приложение на Flutter.
---

# {{ captcha-full-name }} в приложении Android на Flutter

[Flutter](https://ru.wikipedia.org/wiki/Flutter) — это фреймворк Google для разработки мобильных приложений. Он позволяет создавать приложения для Android и iOS на основе единого кода. Это упрощает процесс разработки и ускоряет выпуск продукта. Flutter использует язык программирования [Dart](https://ru.wikipedia.org/wiki/Dart), в котором есть набор готовых виджетов и инструментов для создания пользовательского интерфейса.

В этом руководстве вы создадите проект, который включает серверное и мобильное приложения:
* Серверное приложение будет предоставлять HTML-страницу для загрузки {{ captcha-name }} и проверять результат выполнения капчи пользователем мобильного приложения.
* Мобильное приложение покажет страницу с капчей и отправит запрос на проверку результата.

Порядок создания проекта:
1. [Создайте капчу](#create-captcha).
1. [Подготовьте инструменты разработки](#prepare-tools).
1. [Создайте и запустите серверное приложение](#run-server-app).
1. [Создайте мобильное приложение](#create-mobile-app).
1. [Запустите мобильное приложение в эмуляторе и проверьте работу {{ captcha-name }}](#test-app).

## Перед началом работы {#before-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

## Создайте капчу {#create-captcha}

1. [Создайте капчу](../../smartcaptcha/operations/create-captcha.md).
1. На вкладке **{{ ui-key.yacloud.common.overview }}** [получите ключи капчи](../../smartcaptcha/operations/get-keys.md):
   * **{{ ui-key.yacloud.smartcaptcha.label_client-key }}** — для загрузки страницы с капчей;
   * **{{ ui-key.yacloud.smartcaptcha.label_server-key }}** — для получения результата прохождения капчи.

## Подготовьте инструменты разработки {#prepare-tools}

Далее в руководстве предполагается, что все действия выполняются на вашем компьютере.

1. [Установите Python](https://www.python.org/downloads).
1. [Установите Flask](https://pypi.org/project/Flask).
1. [Установите Flutter SDK](https://docs.flutter.dev/get-started/install).
1. [Установите Android Studio](https://developer.android.com/studio).
1. В Android Studio подключите плагины Dart и Flutter:
   1. Откройте меню **File → Settings → Plugins**.
   1. На вкладке **Marketplace** в поле поиска введите `Dart`.
   1. Нажмите **Install**, чтобы установить плагин. 
   1. Таким же образом найдите и установите плагин `Flutter`.
1. Настройте путь к Flutter SDK:
   1. Откройте меню **File → Settings → Languages & Frameworks → Flutter**.
   1. В поле **Flutter SDK path** выберите папку, в которую вы установили Flutter SDK.

## Создайте и запустите серверное приложение {#run-server-app}

1. Создайте новую папку, например, `web-captcha-app`.
1. В папке `web-captcha-app` создайте файл `app.py`:

   {% cut "Код серверного приложения" %}

   ```python
   from flask import Flask, request, jsonify, render_template
   import requests

   app = Flask(__name__)

   SMARTCAPTCHA_SERVER_KEY = "<ключ_сервера>"

   # тестовый эндпоинт
   @app.route('/', methods=['GET'])
   def helo():
       return "Hello from CAPTCHA App", 200
   
   # эндпоинт, возвращающий страницу для встраивания капчи
   @app.route('/captcha', methods=['GET'])
   def render_captcha():
       return render_template("captcha.html")

   # эндпоинт валидации результата прохождения капчи
   @app.route('/validate-captcha', methods=['POST'])
   def validate_captcha():
       data = request.json
       token = data.get('token')

       if not token:
           return jsonify({"status": "error", "message": "Missing CAPTCHA token"}), 400

       # валидация ответа
       response = requests.post(
           "https://smartcaptcha.yandexcloud.net/validate",
           data={
               "secret": SMARTCAPTCHA_SERVER_KEY,
               "token": token,
               "ip": request.remote_addr  # Optional: get user's IP
           },
           timeout=2
       )

       if response.status_code != 200:
           return jsonify({"status": "error", "message": "Captcha validation error"}), 500

       # обработка ответа
       captcha_result = response.json()
       if captcha_result.get("status") == "ok":
           return jsonify({"status": "ok"}), 200
       else:
           return jsonify({"status": "robot"}), 200

   if __name__ == '__main__':
       app.run(debug=True, port=5000)
   ```

   {% endcut %}

1. В папке `web-captcha-app` создайте папку `templates` и в ней создайте файл `captcha.html`:

   {% cut "HTML-страница с кодом капчи" %}

   ```html
   <!DOCTYPE html>
   <html lang="en">
     <head>
       <title>SmartCaptcha Mobile</title>
       <meta charset="UTF-8" />
       <meta
         name="viewport"
         content="width=device-width, initial-scale=1, shrink-to-fit=no"
       />
       <script>
         function onSmartCaptchaReady() {
           if (!window.smartCaptcha) {
             throw new Error("SmartCaptcha is not present");
           }

           const params = getParameters();

           const widgetId = window.smartCaptcha.render(
             "captcha-container",
             params
           );

           window.smartCaptcha.subscribe(
             widgetId,
             "challenge-visible",
             handleChallengeVisible
           );

           window.smartCaptcha.subscribe(
             widgetId,
             "challenge-hidden",
             handleChallengeHidden
           );

           window.smartCaptcha.subscribe(widgetId, "success", handleSuccess);

           if (params.invisible) {
             window.smartCaptcha.execute(widgetId);
           }
         }

         function handleSuccess(token) {
           // Send the CAPTCHA token to Flutter using postMessage for webview_flutter
           if (window.jsBridge) {
             window.jsBridge.postMessage(token);
           }
         }

         function handleChallengeVisible() {
           console.log("Challenge became visible");
         }

         function handleChallengeHidden() {
           console.log("Challenge hidden");
         }

         function getParameters() {
           const result = {};

           if (!window.location.search) {
             return result;
           }

           const queryParams = new URLSearchParams(window.location.search);

           queryParams.forEach((value, key) => {
             result[key] = value;
           });

           result.test = result.test === "true";
           result.invisible = result.invisible === "true";
           result.hideShield = result.hideShield === "true";
           result.webview = true;

           return result;
         }
       </script>
    
       <script>
           function reloadPage() {
             if (window.jsBridge) {
               window.jsBridge.postMessage('pageReloaded');
             }
             window.location.reload();
           }
       </script>

       <script
         src="https://smartcaptcha.yandexcloud.net/captcha.js?render=onload&onload=onSmartCaptchaReady"
         defer
       ></script>
     </head>

     <body>
       <noscript>
         You need to enable JavaScript to run this app.
       </noscript>
       <div id="captcha-container" class="smart-captcha"></div>
       <div style="margin:20px"><button onclick="reloadPage()">Reload</a>
     </body>
   </html>
   ```

   {% endcut %}

1. В командной строке перейдите в папку `web-captcha-app` и запустите серверное приложение:

   ```bash
   cd web-captcha-app
   python3 app.py
   ```

## Создайте мобильное приложение {#create-mobile-app}

1. В Android Studio создайте новый проект. Для этого откройте меню **File → New → New Flutter Project**.
1. Проверьте путь к Flutter SDK и нажмите **Next**.
1. В поле **Project name** укажите имя проекта, например, `mobile-captcha-app`.
1. Нажмите **Create**.
1. После загрузки проекта замените содержимое файла `main.dart` на следующий код:

   {% cut "Код мобильного приложения на языке Dart" %}

   ```dart
   import 'package:flutter/material.dart';
   import 'package:webview_flutter/webview_flutter.dart';
   import 'package:http/http.dart' as http;
   import 'dart:convert';

   void main() {
     WidgetsFlutterBinding.ensureInitialized();
     runApp(MyApp());
   }

   class MyApp extends StatelessWidget {
     @override
     Widget build(BuildContext context) {
       return MaterialApp(
         home: Scaffold(
           appBar: AppBar(
             title: Text('SmartCaptcha Example'),
           ),
           body: WebViewExample(),
         ),
       );
     }
   }

   class WebViewExample extends StatefulWidget {
     @override
     _WebViewExampleState createState() => _WebViewExampleState();
   }

   class _WebViewExampleState extends State<WebViewExample> {
     late final WebViewController _controller;
     String result = "";

     @override
     void initState() {
       super.initState();
       _controller = WebViewController()
         ..setJavaScriptMode(JavaScriptMode.unrestricted) // разрешить выполнение скриптов
         ..addJavaScriptChannel(                          // открыть канал для ответов от приложения
           'jsBridge',
           onMessageReceived: (message) {
             if (message.message == 'pageReloaded') {
               _handlePageReload();
             } else {
               String token = message
                   .message; // получение токена от капчи
               print("CAPTCHA token received: $token");
               _sendTokenToServer(token); // отправка токена на валидацию
             }
           },
         );
       _loadCaptchaPageFromServer();
     }

     @override
     Widget build(BuildContext context) {
       return Column(
         children: [
           Expanded(child: WebViewWidget(controller: _controller)),
           SizedBox(height: 20),
           if (result.isNotEmpty)
             Text(
               result,
               style: TextStyle(fontSize: 20, color: result == "Passed" ? Colors.green : Colors.red),
             ),
         ],
       );
     }

     void _loadCaptchaPageFromServer() {
       setState(() {
         result = "Not Done";  // Сброс статуса при первой загрузке страницы
       });
       // Загрузка капчи
       _controller.loadRequest(Uri.parse('<URL_серверного_приложения>:5000/captcha?sitekey=<ключ_клиета>'));  
       // замените плейсхолдер на полученный ключ для клиенсткой части
     }

     void _handlePageReload() {
       setState(() {
         result = "Not Done"; // Сброс статуса при перезагрузке страницы
       });
     }

     Future<void> _sendTokenToServer(String token) async {
       const String serverValidationUrl = '<URL_серверного_приложения>:5000/validate-captcha';  
       // замените плейсхолдер на полученный ключ для клиенсткой части

       try {
         setState(() {
           result = "Checking"; // Выставление статуса валидации токена
         });

         final response = await http.post(
           Uri.parse(serverValidationUrl),
           body: jsonEncode({'token': token}),
           headers: {
             'Content-Type': 'application/json',
           },
         );

         if (response.statusCode == 200) {
           var jsonResponse = jsonDecode(response.body);
           setState(() {
             result = jsonResponse['status'] == 'ok' ? 'Passed' : 'Robot';
           });
         } else {
           setState(() {
             result = 'Error';
           });
         }
       } catch (e) {
         print('Error: $e');
         setState(() {
           result = 'Error';
         });
       }
     }
   }
   ```

   {% note warning %}

   Если вы запустили серверное приложение на компьютере с Flutter и Android Studio, не используйте адрес `http://localhost` в качестве URL сервера. Используйте IP-адрес внутренней подсети, например, `http://10.0.2.2`.

   {% endnote %}

   {% endcut %}


1. Добавьте необходимые зависимости:
   1. Откройте файл `pubspec.yaml` в корне проекта.
   1. В секцию `dependencies` добавьте `webview_flutter` и `http`:

    ```yaml
    dependencies:
    flutter:
        sdk: flutter

        # добавьте webview_flutter и http
        webview_flutter: ^4.0.0
        http: ^0.13.5
    ```

1. Чтобы в тестовых целях использовать незащищенный HTTP-протокол:
   1. Откройте файл `\android\app\src\main\AndroidManifest.xml`.
   1. Добавьте в секцию `application` опцию `android:usesCleartextTraffic="true"`:

    ```
    <application
    android:label="capcha_app"
    android:name="${applicationName}"
    android:icon="@mipmap/ic_launcher"
    <!-- добавьте эту строку -->
    android:usesCleartextTraffic="true"
    >
    ```

## Запустите приложение и проверьте работу {{ captcha-name }} {#test-app}

Чтобы запустить мобильное приложение на эмуляторе:

1. В Android Studio откройте меню **Tools → Device Manager** и активируйте мобильное устройство. Например, предустановленный по умолчанию **Medium Phone API 35**.
1. Запустите файл `main.dart` одним из способов:
   * в верхней панели рядом с именем файла нажмите кнопку запуска;
   * откройте меню **Run → Run 'main.dart'**.
1. Дождитесь, когда завершится процесс компиляции и приложение загрузится в эмулятор.

Чтобы проверить работу {{ captcha-name }}:

1. Выполните задание капчи.
1. Обратите внимание, как красный статус `Not Done` в нижней части экрана приложения кратковременно изменится на статус `Checking`, а затем на зеленый статус `Passed` (если задание было выполнено верно).
1. Чтобы повторить тест, на странице под капчей нажмите **Reload**.
