# OAuth-токен

OAuth-токен необходим для авторизации в {{ yandex-cloud }} пользователя с аккаунтом на Яндексе: пользователь обменивает OAuth-токен на [{{ iam-name }}-токен](iam-token.md).

Получить OAuth-токен для работы с {{ yandex-cloud }} можно с помощью [запроса]({{ link-cloud-oauth }}) к сервису Яндекс OAuth.

OAuth-токен недоступен для федеративных пользователей и сервисных аккаунтов.

## Время жизни {#lifetime}

{% include [oauth-token-lifetime](../../../_includes/oauth-token-lifetime.md) %}

{% note alert %}

Если кто-то мог узнать ваш OAuth-токен, отзовите его и получите новый по [инструкции](../../operations/compromised-credentials.md#oauth-reissue).

{% endnote %}

## Сервисы и утилиты, поддерживающие аутентификацию c OAuth-токеном {#supported-services}

Эти сервисы и утилиты могут запрашивать IAM-токен автоматически, поэтому для аутентификации можно указывать только OAuth-токен:
* [{{ yandex-cloud }} CLI](../../../cli/quickstart.md#initialize)
* [{{ container-registry-full-name }}](../../../container-registry/operations/authentication.md#user-oauth)
* [{{ TF }}](../../../tutorials/infrastructure-management/terraform-quickstart.md)
* [Packer](../../../tutorials/infrastructure-management/packer-quickstart.md)
* [{{ GL }} CI](../../../tutorials/testing/ci-for-snapshots.md)


#### См. также {#see-also}

* [Подробнее о сервисе Яндекс OAuth](https://yandex.ru/dev/oauth/).
