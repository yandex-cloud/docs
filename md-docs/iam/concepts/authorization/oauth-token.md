# OAuth-токен


{% note warning "Аутентификация по OAuth-токенам больше не поддерживается" %}

С 1 июня 2026 года сервис аутентификации не принимает **новые** OAuth‑токены, полученные через Яндекс ID. Токены, **выданные до 1 июня 2026 года**, продолжают действовать до истечения срока жизни.

{% endnote %}

OAuth-токен необходим для аутентификации в Yandex Cloud пользователя с аккаунтом на Яндексе: пользователь обменивает OAuth-токен на [IAM-токен](iam-token.md).

Получить OAuth-токен для работы с Yandex Cloud можно с помощью [запроса](https://oauth.yandex.ru/authorize?response_type=token&client_id=1a6990aa636648e9b2ef855fa7bec2fb) к сервису Яндекс OAuth.

OAuth-токен недоступен для федеративных пользователей и сервисных аккаунтов.

## Формат OAuth-токена {#oauth-token-format}

Токен всегда начинается с буквы `y`, случайной цифры в диапазоне `0-3` и символа `_`. Остальными символами могут быть:

* буквы латинского алфавита;
* цифры;
* символы `_`, `-`.

Пример OAuth-токена: `y3_Vdheub7w9bIut67GHeL345gfb5GAnd3dZnf08FRbvjeUFvetYiohGvc`.

## Время жизни {#lifetime}

Срок жизни OAuth-токена — 1 год. После этого необходимо [получить новый OAuth-токен](https://oauth.yandex.ru/authorize?response_type=token&client_id=1a6990aa636648e9b2ef855fa7bec2fb) и повторить процедуру аутентификации.

{% note alert %}

Если кто-то мог узнать ваш OAuth-токен, отзовите его и получите новый по [инструкции](../../operations/compromised-credentials.md#oauth-reissue).

{% endnote %}

## Сервисы и утилиты, поддерживающие аутентификацию с OAuth-токеном {#supported-services}

Эти сервисы и утилиты могут запрашивать IAM-токен автоматически, поэтому для аутентификации можно указывать только OAuth-токен:
* [Yandex Cloud CLI](../../../cli/quickstart.md#initialize)
* [Yandex Container Registry](../../../container-registry/operations/authentication.md#user)
* [Terraform](../../../tutorials/infrastructure-management/terraform-quickstart.md)
* [Packer](../../../tutorials/infrastructure-management/packer-quickstart.md)
* [GitLab CI](../../../tutorials/testing/ci-for-snapshots.md)

## Примеры использования {#examples}

* [Запуск Docker-образа на виртуальной машине](../../../tutorials/infrastructure-management/run-docker-on-vm/index.md)
* [Разработка CRUD API для сервиса фильмов](../../../serverless-containers/tutorials/movies-database.md)

#### См. также {#see-also}

* [Подробнее о сервисе Яндекс OAuth](https://yandex.ru/dev/oauth/).
* [Изменения в поддержке OAuth‑токенов Яндекс ID в Yandex Cloud с 1 июня](https://yandex.cloud/ru/blog/oauth-deprecation).