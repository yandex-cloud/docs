# Невидимая {{ captcha-full-name }} в приложении на Android

Чтобы встроить [невидимую {{ captcha-name }}](../smartcaptcha/concepts/invisible-captcha.md) в приложение на Android:

1. [Создайте Javascript Interface](#create-js-interface).
1. [Настройте WebView для работы с капчей](#customize-webview).
1. [Обработайте событие, при котором капча выдала пользователю задание](#user-task).
1. [Получите результат прохождения капчи](#get-result).

## Перед началом работы {#before-begin}

1. [Создайте сайт](../smartcaptcha/tutorials/mobile-app/website.md) для размещения {{ captcha-name }} (или воспользуйтесь готовым `{{ captcha-mobile-site }}`).
1. Создайте капчу по [инструкции](../smartcaptcha/operations/create-captcha.md).
1. [Получите ключи](../smartcaptcha/operations/get-keys.md) капчи. Скопируйте **ключ клиента** и **ключ сервера** на вкладке **Обзор** созданной вами капчи. **Ключ клиента** понадобится для загрузки страницы с капчей, **ключ сервера** — для получения результата прохождения капчи.

## Создайте Javascript Interface {#create-js-interface}

1. Создайте [класс](../smartcaptcha/concepts/js-interface.md), который будет принимать сообщения с помощью функции обратного вызова от веб-страницы с капчей.
1. Определите методы с аннотациями `@JavascriptInterface`:

   * `onGetToken(token: String)` — веб-страница возвращает токен прохождения капчи;
   * `onChallengeVisible()` — открытие всплывающего окна с заданием;
   * `onChallengeHidden()` — закрытие всплывающего окна с заданием.

   ```kotlin
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

## Настройте WebView для работы с капчей {#customize-webview}

1. Создайте **WebView** и добавьте его на экран.
1. Загрузите в **WebView** URL веб-страницы с капчей.
1. Вставьте в URL [query-параметры](../smartcaptcha/concepts/widget-methods.md#methods):

   ```kotlin
     val webView = findViewById<WebView>(R.id.webViewCaptcha)
     webView.loadUrl("URL страницы с капчей?sitekey=<ключ_клиентской_части>&invisible=true")
   ```

   Где:
   * `sitekey` — ключ клиента, который вы получили ранее;
   * `invisible=true` — капча перейдет в невидимый режим работы.

1. Добавьте в **WebView** созданный Javascript Interface. Укажите вторым параметром `NativeClient` — имя, на которое веб-страница будет отправлять сообщения с помощью функции обратного вызова:

   ```kotlin
     settings.javaScriptEnabled = true   // Enables Javascript execution
     addJavascriptInterface(WebJsInterface(), "NativeClient")
   ```

## Обработайте событие, при котором капча выдала пользователю задание {#user-task}

1. Напишите логику появления **WebView** при помощи метода `onChallengeVisible()`. Он вызывается, когда капча показала задание. Пример реализации с переключением `visibility` — пока капча обрабатывала действие, **WebView** был в состоянии `View.GONE`:

   ```kotlin
     val webView = activity.findViewById<WebView>(R.id.webViewCaptcha)
     webView.visibility = View.VISIBLE
   ```

1. Напишите логику для события, при котором пользователь не прошел задание и свернул его. Тогда будет вызван метод `onChallengeHidden()`, при помощи которого нужно убрать **WebView**. Пример возвращения **WebView** к состоянию `View.GONE`:

   ```kotlin
     val webView = activity.findViewById<WebView>(R.id.webViewCaptcha)
     webView.visibility = View.GONE
   ```

## Получите результат прохождения капчи {#get-result}

1. Сохраните токен прохождения капчи. Он вернется в методе `onGetToken(token: String)`, когда сервис обработает попытку.
1. Для проверки токена отправьте GET-запрос на адрес `https://captcha-api.yandex.ru/validate` со следующими параметрами:

   * `secret` — ключ для серверной части;
   * `token` — токен, полученный после прохождения проверки;
   * `ip` — IP-адрес пользователя, от которого пришел запрос на проверку токена.

   {% note info "Примечание" %}

   Данная логика должна выполняться на бэкенде. В само Android-приложение секретный ключ `secret` попасть не должен.

   {% endnote %}

   Пример запроса:

   ```text
   https://captcha-api.yandex.ru/validate?secret=<ключ_сервера>&ip=<IP_адрес_пользователя>&token=<токен>
   ```

1. Получите [ответ с сервера](../smartcaptcha/concepts/validation.md). Он содержит JSON-объект с полями `status` и `message`. Например:

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

## Особенности {#specifics}

Невидимая капча требует меньше памяти, чем обычная — она не загружает код, который отрисовывает кнопку **Я не робот**.

Однако, у пользователей, которым будет показано задание, время загрузки виджета может варьироваться. Поэтому мы рекомендуем предупреждать пользователей о показе капчи, чтобы не вводить их в замешательство во время ожидания.