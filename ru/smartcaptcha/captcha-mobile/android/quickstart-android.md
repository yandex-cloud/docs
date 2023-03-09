# Как встроить Yandex SmartCaptcha в приложение на Android


## Перед началом работы {#before-begin}

1. [Создайте сайт](website.md) для размещения капчи (либо воспользуйтесь уже написанным нами `https://captcha-api.yandex.ru/webview`).
1. [Создайте капчу](https://cloud.yandex.ru/docs/smartcaptcha/operations/create-captcha).
1. Добавьте нужный URL в список сайтов для капчи.
1. На вкладке **Обзор** скопируйте `ключ_клиента` и `ключ_сервера`. `Ключ_клиента` понадобится для загрузки страницы с капчей, `ключ_сервера` - для получения результата прохождения капчи.

## Создайте Javascript Interface

1. Создайте класс, который будет принимать коллбеки от веб-страницы с капчей.
1. Определите метод onGetToken(token: String) с аннотацией @JavascriptInterface. Он вызывается, когда веб-страница возвращает токен прохождения капчи:


  ```Kotlin
  class WebJsInterface {

      @JavascriptInterface
      fun onGetToken(token: String) {
          //your code
      }
  }
  ```


## Настройте WebView для работы с капчей

1. Создайте WebView и добавьте его на экран.
1. Загрузите в WebView URL веб-страницы с капчей. Вставьте в URL query-параметр `sitekey=<ключ_клиента, который вы получили ранее>`:


```Kotlin
  val webView = findViewById<WebView>(R.id.webViewCaptcha)
  webView.loadUrl("URL страницы с капчей?sitekey=<ключ_клиента>")
```

  [Список всех параметров]( https://cloud.yandex.ru/docs/smartcaptcha/concepts/widget-methods#methods)


3. Добавьте в WebView созданный Javascript Interface. Укажите вторым параметром "NativeClient" - это имя, на которое веб-страница будет отправлять коллбеки:


  ```Kotlin
    settings.javaScriptEnabled = true   // Enables Javascript execution
    addJavascriptInterface(WebJsInterface(), "NativeClient")
  ```

## Получите результат прохождения капчи

1. Сохраните токен прохождения капчи. Он вернется в методе `onGetToken(token: String)`, когда сервис обработает попытку пользователя.
1. Для проверки токена отправьте GET-запрос на адрес `https://captcha-api.yandex.ru/validate` со следующими параметрами:
  * `secret` — ключ для серверной части;
  * `token` — токен, полученный после прохождения проверки;
  * `ip` — IP-адрес пользователя, от которого пришел запрос на проверку токена.

  **Данная логика должна выполняться на backend'е. В само Android-приложение секретный ключ (`secret`) попасть не должен!**

  Пример запроса:


  ```TEXT
    https://captcha-api.yandex.ru/validate?secret=<ключ_сервера>&ip=<IP_адрес_пользователя>&token=<токен>
  ```      

3. Получите ответ с сервера. Он содержит JSON-объект с полями `status` и `message`. Например:
  * Это человек:

      ```json
      {
          "status": "ok",
          "message": ""
      }
      ```

  * Это робот:

      ```json
      {
          "status": "failed",
          "message": ""
      }
      ```

  [Полная документация по ответам сервера.](https://cloud.yandex.ru/docs/smartcaptcha/concepts/validation)
