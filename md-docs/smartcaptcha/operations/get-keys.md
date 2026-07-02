[Документация Yandex Cloud](../../index.md) > [Yandex SmartCaptcha](../index.md) > [Пошаговые инструкции](index.md) > Получить ключи

# Получить ключи капчи 

В этом разделе вы узнаете, как получить [ключи капчи](../concepts/keys.md). С помощью клиентского ключа вы можете [добавить виджет](../quickstart.md#add-widget) SmartCaptcha на свою страницу. Серверный ключ потребуется для [проверки ответа](../quickstart.md#check-answer) пользователя.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
    1. Перейдите в сервис **Yandex SmartCaptcha**.
    1. Нажмите на имя капчи или [создайте](../quickstart.md#creat-captcha) новую капчу.
    1. На вкладке **Обзор** скопируйте значения полей **Ключ клиента** и **Ключ сервера**.

       ![step4-get-keys](../../_assets/smartcaptcha/quickstart/step4-get-keys.png)

- API {#api}

  Чтобы получить [серверный ключ](../concepts/keys.md), воспользуйтесь методом REST API [GetSecretKey](../api-ref/Captcha/getSecretKey.md) для ресурса [Captcha](../api-ref/Captcha/index.md) или вызовом gRPC API [CaptchaService/GetSecretKey](../api-ref/grpc/Captcha/getSecretKey.md).

{% endlist %}