# {{ captcha-full-name }} в приложении на Android

Чтобы встроить [{{ captcha-name }}](../../smartcaptcha/) в приложение на Android:
1. [Создайте JavaScript Interface](#create-js-interface).
1. [Настройте WebView для работы с капчей](#customize-webview).
1. [Получите результат прохождения капчи](#get-result).

## Перед началом работы {#before-begin}

1. [Разместите HTML-страницу](../../smartcaptcha/tutorials/mobile-app/website.md) на своем сервере или воспользуйтесь страницей на сервере {{ yandex-cloud }} — `{{ captcha-mobile-site }}`).
1. [Создайте капчу](../../smartcaptcha/operations/create-captcha.md).
1. На вкладке **{{ ui-key.yacloud.common.overview }}** [получите ключи капчи](../../smartcaptcha/operations/get-keys.md):
   * **{{ ui-key.yacloud.smartcaptcha.label_client-key }}** — для загрузки страницы с капчей;
   * **{{ ui-key.yacloud.smartcaptcha.label_server-key }}** — для получения результата прохождения капчи.

## Создайте JavaScript Interface {#create-js-interface}

1. Создайте [класс](../../smartcaptcha/concepts/js-interface.md), который будет принимать сообщения с помощью функции обратного вызова от веб-страницы с капчей.
1. Определите метод `onGetToken(token: String)` с аннотацией `@JavascriptInterface`. Он вызывается, когда веб-страница возвращает токен прохождения капчи:

   ```kotlin
   class WebJsInterface {

     @JavascriptInterface
     fun onGetToken(token: String) {
       //Ваш код.
     }
   }
   ```

## Настройте WebView для работы с капчей {#customize-webview}

1. Создайте **WebView** и добавьте его на экран.
1. Загрузите в **WebView** URL веб-страницы с капчей.
1. Вставьте в URL [query-параметр](../../smartcaptcha/concepts/widget-methods.md#methods) `sitekey=<ключ_клиентской_части>`:

   ```kotlin
   val webView = findViewById<WebView>(R.id.webViewCaptcha)
   webView.loadUrl("URL_страницы_с_капчей?sitekey=<ключ_клиентской_части>")
   ```

1. Добавьте в **WebView** созданный JavaScript Interface. Укажите вторым параметром `NativeClient` — это имя, на которое веб-страница будет отправлять сообщения с помощью функции обратного вызова:

   ```kotlin
   settings.javaScriptEnabled = true // Включает выполнение JavaScript.
   addJavascriptInterface(WebJsInterface(), "NativeClient")
   ```

## Получите результат прохождения капчи {#get-result}

1. Сохраните токен прохождения капчи. Он вернется в методе `onGetToken(token: String)`, когда сервис обработает попытку.
1. Для проверки токена отправьте POST-запрос на адрес `https://smartcaptcha.yandexcloud.net/validate`, передав параметры в формате `x-www-form-urlencoded`:

   {% include [query-parameters](../../_includes/smartcaptcha/query-parameters.md) %}

   {% note info %}

   Данная логика должна выполняться на бэкенде. В само Android-приложение секретный ключ `secret` попасть не должен.

   {% endnote %}

   >Пример запроса:
   >
   >```text
   >https://smartcaptcha.yandexcloud.net/validate?secret=<ключ_сервера>&ip=<IP-адрес_пользователя>&token=<токен>
   >```

1. Получите [ответ с сервера](../../smartcaptcha/concepts/validation.md). Он содержит JSON-объект с полями `status` и `message`.

   >Например:
   >
   >* Это человек:
   >
   >  ```json
   >  {
   >    "status": "ok",
   >    "message": ""
   >  }
   >```
   >
   >* Это робот:
   >
   >  ```json
   >  {
   >    "status": "failed",
   >    "message": ""
   >  }