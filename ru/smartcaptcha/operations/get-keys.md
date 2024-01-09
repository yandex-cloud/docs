# Получить ключи капчи 


В этом разделе вы узнаете, как получить ключи капчи. С помощью клиентского ключа вы можете [добавить виджет](../quickstart.md#add-widget) {{ captcha-name }} на свою страницу. Серверный ключ потребуется для [проверки ответа](../quickstart.md#check-answer) пользователя.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите каталог.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_smartcaptcha_ru }}**.
    1. Нажмите на имя капчи или [создайте](../quickstart.md#creat-captcha) новую капчу.
    1. На вкладке **{{ ui-key.yacloud.common.overview }}** скопируйте значения полей **{{ ui-key.yacloud.smartcaptcha.label_client-key }}** и **{{ ui-key.yacloud.smartcaptcha.label_server-key }}**.

{% endlist %}
