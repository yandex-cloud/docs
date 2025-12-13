# Получить ключи капчи 

В этом разделе вы узнаете, как получить [ключи капчи](../concepts/keys.md). С помощью ключа клиента вы можете [добавить виджет](../quickstart.md#add-widget) {{ captcha-name }} на свою страницу. Ключ сервера потребуется для [проверки ответа](../quickstart.md#check-answer) пользователя.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите каталог.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_smartcaptcha_ru }}**.
    1. Нажмите на имя капчи или [создайте](../quickstart.md#creat-captcha) новую капчу.
    1. На вкладке **{{ ui-key.yacloud.common.overview }}** скопируйте значения полей **{{ ui-key.yacloud.smartcaptcha.label_client-key }}** и **{{ ui-key.yacloud.smartcaptcha.label_server-key }}**.

{% note warning %}

Никогда не пересылайте ключ сервера от {{ captcha-name }}. Храните его в надежном месте. Если ключ стал известен третьим лицам, [создайте](../operations/create-captcha.md) новую капчу и замените ею старую.

{% endnote %}

- API {#api}

  Чтобы получить [серверный ключ](../concepts/keys.md), воспользуйтесь методом REST API [GetSecretKey](../api-ref/Captcha/getSecretKey.md) для ресурса [Captcha](../api-ref/Captcha/index.md) или вызовом gRPC API [CaptchaService/GetSecretKey](../api-ref/grpc/Captcha/getSecretKey.md).

{% endlist %}
