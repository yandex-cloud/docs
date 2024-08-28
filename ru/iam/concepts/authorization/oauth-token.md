# OAuth-токен


OAuth-токен необходим для авторизации в {{ yandex-cloud }} пользователя с аккаунтом на Яндексе: пользователь обменивает OAuth-токен на [{{ iam-name }}-токен](iam-token.md).

Получить OAuth-токен для работы с {{ yandex-cloud }} можно с помощью [запроса]({{ link-cloud-oauth }}) к сервису Яндекс OAuth.

OAuth-токен недоступен для федеративных пользователей и сервисных аккаунтов.

## Формат OAuth-токена {#oauth-token-format}

Токен всегда начинается с буквы `y`, случайной цифры в диапазоне `0-3` и символа `_`. Остальными символами могут быть:

* буквы латинского алфавита;
* цифры;
* символы `_`, `-`.

Пример OAuth-токена: `y3_Vdheub7w9bIut67GHeL345gfb5GAnd3dZnf08FRbvjeUFvetYiohGvc`.

## Время жизни {#lifetime}

{% include [oauth-token-lifetime](../../../_includes/oauth-token-lifetime.md) %}

{% note alert %}

Если кто-то мог узнать ваш OAuth-токен, отзовите его и получите новый по [инструкции](../../operations/compromised-credentials.md#oauth-reissue).

{% endnote %}

## Сервисы и утилиты, поддерживающие аутентификацию с OAuth-токеном {#supported-services}

Эти сервисы и утилиты могут запрашивать IAM-токен автоматически, поэтому для аутентификации можно указывать только OAuth-токен:
* [{{ yandex-cloud }} CLI](../../../cli/quickstart.md#initialize)
* [{{ container-registry-full-name }}](../../../container-registry/operations/authentication.md#user)
* [{{ TF }}](../../../tutorials/infrastructure-management/terraform-quickstart.md)
* [Packer](../../../tutorials/infrastructure-management/packer-quickstart.md)
* [{{ GL }} CI](../../../tutorials/testing/ci-for-snapshots.md)


#### См. также {#see-also}

* [Подробнее о сервисе Яндекс OAuth](https://yandex.ru/dev/oauth/).
