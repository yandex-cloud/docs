### Используется Yandex SmartCaptcha {#use-smartcaptcha}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | low | appsec.use-smartcaptcha ||
|#

#### Описание

{% note tip "**Автоматическая проверка**" %}

Данный контроль автоматически проверяет использование Yandex SmartCaptcha в приложениях.

{% endnote %}

Для снижения рисков, связанных с автоматизированными атаками на приложения, рекомендуем использовать сервис [Yandex SmartCaptcha](https://yandex.cloud/ru/services/smartcaptcha). Сервис проверяет запросы пользователей своими ML-алгоритмами и показывает задание только тем пользователям, запросы которых посчитал подозрительными. При этом на странице необязательно размещать кнопку "Я не робот".

#### Инструкции и решения по выполнению

* [Сервис Yandex SmartCaptcha](https://yandex.cloud/ru/services/smartcaptcha)