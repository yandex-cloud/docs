# Как встроить невидимую Yandex SmartCaptcha в приложение на Android


## Перед началом работы {#before-begin}

1. [Создайте сайт](website.md) для размещения капчи (либо воспользуйтесь уже написанным нами `https://ti6d10.csb.app/`).
1. [Создайте капчу](https://cloud.yandex.ru/docs/smartcaptcha/operations/create-captcha).
1. Добавьте нужный URL в список сайтов для капчи.
1. На вкладке **Обзор** скопируйте `ключ_клиента` и `ключ_сервера`. `Ключ_клиента` понадобится для загрузки страницы с капчей, `ключ_сервера` - для получения результата прохождения капчи.

## Создайте Javascript Interface

1. Создайте класс, который будет принимать коллбеки от веб-страницы с капчей.
1. Определите методы `onGetToken(token: String)`, `onChallengeVisible()`, `onChallengeHidden()` с аннотациями `@JavascriptInterface`:


  ```Kotlin
  class WebJsInterface {

      @JavascriptInterface
      fun onGetToken(token: String) {
          //your code
      }

      @JavascriptInterface
      fun onChallengeVisible() {
          //your code
      }

      @JavascriptInterface
      fun onChallengeHidden() {
          //your code
      }
  }
  ```
  * `onGetToken(token: String)` - вызывается, когда веб-страница возвращает токен прохождения капчи.
  * `onChallengeVisible()` - вызывается, когда невидимая капча показывает задание пользователю.
  * `onChallengeHidden()` - вызывается, когда пользователь не проходит задание от невидимой капчи, а сворачивает его.


## Настройте WebView для работы с капчей

1. Создайте WebView и добавьте его на экран.
1. Загрузите в WebView URL веб-страницы с капчей. Вставьте в URL query-параметры:

```Kotlin
  val webView = findViewById<WebView>(R.id.webViewCaptcha)
  webView.loadUrl("URL страницы с капчей?sitekey=<ключ_клиента>&invisible=true")
```
* `sitekey=<ключ_клиента, который вы получили ранее>`
* `invisible=true` - переведёт капчу в невидимый режим работы

[Список всех параметров]( https://cloud.yandex.ru/docs/smartcaptcha/concepts/widget-methods#methods)

3. Добавьте в WebView созданный Javascript Interface. Укажите вторым параметром "NativeClient" - это имя, на которое веб-страница будет отправлять коллбеки:

```Kotlin
  settings.javaScriptEnabled = true   // Enables Javascript execution
  addJavascriptInterface(WebJsInterface(), "NativeClient")
```

## Обработайте случай, когда капча решила выдать пользователю задание

1. Напишите логику появления WebView при помощи метода `onChallengeVisible()`. Он вызывается, когда капча показала задание. Ниже приведен пример реализации с переключением visibility. Пока капча обрабатывала действие, WebView был в состоянии View.GONE:

```Kotlin
  val webView = activity.findViewById<WebView>(R.id.webViewCaptcha)
  webView.visibility = View.VISIBLE
```

2. Напишите логику для случая, когда пользователь не прошел задание и свернул его. Тогда будет вызван метод `onChallengeHidden()`, при помощи которого нужно убрать WebView. Ниже приведен пример возвращения WebView к состоянию View.GONE:

```Kotlin
  val webView = activity.findViewById<WebView>(R.id.webViewCaptcha)
  webView.visibility = View.GONE
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


## Особенности

  Невидимая капча требует меньше памяти, чем обычная, так как не загружает код, который отрисовывает кнопку **Я не робот**.

  Однако, у пользователей, которым будет показано задание, время загрузки виджета может варьироваться. Поэтому мы рекомендуем предупреждать пользователей о показе капчи, чтобы не приводить их в замешательство во время ожидания.
