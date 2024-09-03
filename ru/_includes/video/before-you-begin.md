1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь, если вы еще не зарегистрированы.
1. На странице [**{{ ui-key.yacloud_billing.billing.label_service }}**]({{ link-console-billing }}) убедитесь, что у вас подключен [платежный аккаунт](../../billing/concepts/billing-account.md) и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/operations/create-new-account.md).
1. Откройте [главную страницу]({{ link-video-main }}) {{ video-name }}.
1. Выберите [организацию](../../organization/quickstart.md), в которой вы будете работать с {{ video-name }}, или [создайте](../../organization/operations/enable-org.md) новую.
1. {% include [ask-for-turning-on](ask-for-turning-on.md) %}
1. Убедитесь, что у вас есть _минимальная_ [роль](../../video/security/index.md#video-editor) `video.editor` в организации.