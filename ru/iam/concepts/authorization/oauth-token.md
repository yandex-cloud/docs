# OAuth-токен

В {{ yandex-cloud }} OAuth-токен используется в процедуре аутентификации для [получения IAM-токена](../../operations/iam-token/create.md).

Получить OAuth-токен для работы с {{ yandex-cloud }} можно с помощью [запроса]({{ link-cloud-oauth }}) к сервису Яндекс.OAuth.

## Время жизни {#lifetime}

{% include [oauth-token-lifetime](../../../_includes/oauth-token-lifetime.md) %}

{% note alert %}

Если кто-то мог узнать ваш OAuth-токен, [отзовите его](https://yandex.ru/dev/oauth/doc/dg/reference/token-invalidate-docpage/) и запросите новый.

{% endnote %}

## Сервисы и утилиты, поддерживающие аутентификацию c OAuth-токеном {#supported-services}

Эти сервисы и утилиты могут запрашивать IAM-токен автоматически, поэтому для аутентификации можно указывать только OAuth-токен:

* [CLI](../../../cli/quickstart.md#initialize)
* [Container Registry](../../../container-registry/operations/authentication.md#oauth)
* [Terraform](../../../solutions/infrastructure-management/terraform-quickstart.md)
* [Packer](../../../solutions/infrastructure-management/packer-quickstart.md)
* [GitLab CI](../../../solutions/testing/ci-for-snapshots.md)

#### См. также {#see-also}

* [Подробнее о сервисе Яндекс.OAuth](https://yandex.ru/dev/oauth/).