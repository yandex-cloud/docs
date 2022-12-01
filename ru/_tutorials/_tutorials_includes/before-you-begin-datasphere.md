{% if product == "yandex-cloud" %}

Перед началом работы нужно зарегистрироваться в {{ yandex-cloud }}, настроить [сообщество](../../datasphere/concepts/community.md) и привязать к нему [платежный аккаунт](../../billing/concepts/billing-account.md):

1. [На главной странице {{ ml-platform-name }}]({{ link-datasphere-main }}) нажмите **Попробовать бесплатно** и выберите аккаунт для входа — Яндекс ID или рабочий аккаунт в федерации (SSO).
1. Выберите [организацию](../../organization/), в которой вы будете работать в {{ yandex-cloud }}.
1. Перейдите в сообщество организации по умолчанию или [создайте](../../datasphere/operations/community/create.md) новое.
1. [Привяжите платежный аккаунт](../../datasphere/operations/community/link-ba.md) к сообществу {{ ml-platform-name }}, в котором вы будете работать. Убедитесь, что у вас подключен платежный аккаунт, и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, создайте его в интерфейсе {{ ml-platform-name }}.

{% endif %}