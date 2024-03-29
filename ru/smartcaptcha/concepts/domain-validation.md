# Валидация домена

При создании капчи указывается список доменов, на которых она будет размещена. По умолчанию {{ captcha-name }} проверяет имя домена и позволяет использовать капчу только на сайтах, которые входят в этот список.

Проверку можно отключить, но это представляет большой риск для безопасности — капча может быть размещена на любом сайте, и кто угодно сможет использовать ваш [ключ](./keys.md). В этом случае выполняйте проверку самостоятельно на своем сервере. Отключение может быть полезно, когда список имен доменов очень длинный, часто меняется или неизвестен.

Чтобы отключить проверку, при [создании](../operations/create-captcha.md) или редактировании капчи включите опцию **{{ ui-key.yacloud.smartcaptcha.label_no-hostname-check }}**.

Когда проверка отключена, необходимо проверять поле `host` в [ответе сервиса](./validation.md#service-response) и отклонять любые результаты, поступающие из неожиданных источников.

В некоторых случаях сервис может возвращать пустое значение в поле `host`:

* [Облако](../../resource-manager/concepts/resources-hierarchy.md#cloud) заблокировано. В таком случае сервис возвращает `"status": "ok"` даже для запросов от роботов.
* Сервису {{ captcha-name }} не удалось определить имя сайта из-за внутреннего сбоя. Тогда пустой `host` можно рассматривать как доверенный.
