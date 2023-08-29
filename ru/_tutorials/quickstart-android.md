# {{ captcha-full-name }} в приложении на Android

Чтобы встроить {{ captcha-name }} в приложение на Android:

1. [Создайте Javascript Interface](#create-js-interface).
1. [Настройте WebView для работы с капчей](#customize-webview).
1. [Получите результат прохождения капчи](#get-result).

## Перед началом работы {#before-begin}

1. [Разместите HTML-код](../smartcaptcha/tutorials/mobile-app/website.md) для работы {{ captcha-name }} (или воспользуйтесь готовым `{{ captcha-mobile-site }}`).
1. Создайте капчу по [инструкции](../smartcaptcha/operations/create-captcha.md).
1. [Получите ключи](../smartcaptcha/operations/get-keys.md) капчи. Скопируйте **ключ клиента** и **ключ сервера** на вкладке **Обзор** созданной вами капчи. **Ключ клиента** понадобится для загрузки страницы с капчей, **ключ сервера** — для получения результата прохождения капчи.

## Создайте Javascript Interface {#create-js-interface}

1. Создайте [класс](../smartcaptcha/concepts/js-interface.md), который будет принимать сообщения с помощью функции обратного вызова от веб-страницы с капчей.
1. Определите метод `onGetToken(token: String)` с аннотацией `@JavascriptInterface`. Он вызывается, когда веб-страница возвращает токен прохождения капчи:

   ```kotlin
   class WebJsInterface {

       @JavascriptInterface
       fun onGetToken(token: String) {
           //your code
       }
   }
   ```

## Настройте WebView для работы с капчей {#customize-webview}

1. Создайте **WebView** и добавьте его на экран.
1. Загрузите в **WebView** URL веб-страницы с капчей.
1. Вставьте в URL [query-параметр](../smartcaptcha/concepts/widget-methods.md#methods) `sitekey=<ключ_клиентской_части>`:

   ```kotlin
     val webView = findViewById<WebView>(R.id.webViewCaptcha)
     webView.loadUrl("URL страницы с капчей?sitekey=<ключ_клиентской_части>")
   ```

1. Добавьте в **WebView** созданный Javascript Interface. Укажите вторым параметром `NativeClient` — это имя, на которое веб-страница будет отправлять сообщения с помощью функции обратного вызова:

   ```kotlin
     settings.javaScriptEnabled = true   // Enables Javascript execution
     addJavascriptInterface(WebJsInterface(), "NativeClient")
   ```

## Получите результат прохождения капчи {#get-result}

1. Сохраните токен прохождения капчи. Он вернется в методе `onGetToken(token: String)`, когда сервис обработает попытку.
1. Для проверки токена отправьте GET-запрос на адрес `https://smartcaptcha.yandexcloud.net/validate` со следующими параметрами:

   {% include [query-parameters](../_includes/smartcaptcha/query-parameters.md) %}

   {% note info "Примечание" %}

   Данная логика должна выполняться на бэкенде. В само Android-приложение секретный ключ `secret` попасть не должен.

   {% endnote %}

   Пример запроса:

   ```text
     https://smartcaptcha.yandexcloud.net/validate?secret=<ключ_сервера>&ip=<IP_адрес_пользователя>&token=<токен>
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