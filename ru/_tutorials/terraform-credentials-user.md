{% note warning %}

Управление ресурсами от имени {% if product == "yandex-cloud" %}[аккаунта на Яндексе](../iam/concepts/index.md#passport){% endif %}{% if product == "cloud-il" %}[аккаунта Google](../iam/concepts/index.md#passport){% endif %} или [федеративного аккаунта](../iam/concepts/index.md#saml-federation) пользователя является менее безопасным, чем использование сервисного аккаунта.

{% endnote %}

{% include [cli-install](../_includes/cli-install.md) %}  

{% include [default-catalogue](../_includes/default-catalogue.md) %}

Если вы используете федеративный аккаунт, [аутентифицируйтесь](../cli/operations/authentication/federated-user.md) в CLI от имени федеративного пользователя.

Добавьте аутентификационные данные в переменные окружения:

{% include [terraform-token-variables](../_includes/terraform-token-variables.md) %}
