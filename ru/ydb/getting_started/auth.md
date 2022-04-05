---
sourcePath: ru/ydb/overlay/getting_started/auth.md
---
# Аутентификация

В статье описан простой способ аутентификации в {{ ydb-full-name }} с помощью IAM-токена. Подробнее о режимах аутентификации читайте в [документации](../concepts/connect.md#auth).

1. С помощью [CLI {{ yandex-cloud }}](../../cli/index.yaml) получите IAM-токен:

    ```bash
    yc iam create-token
    ```

1. Используйте полученный токен одним из следующих методов:

    {% list tabs %}

    - {{ ydb-short-name }} CLI

      * Сохраните токен в файл и указывайте путь к файлу в параметре `--iam-token-file` при каждом вызове команды.
      * Сохраните токен в переменную окружения `IAM_TOKEN`, чтобы не указывать этот параметр при каждом вызове команды.
      * Сохраните токен в файл и укажите путь к файлу, выбрав опцию `[1] Use IAM token (iam-token)` при [настройте профиля](../reference/ydb-cli/profile/create.md) {{ ydb-short-name }} CLI.

    - {{ ydb-short-name }} SDK

      * Сохраните токен в переменную окружения `YDB_ACCESS_TOKEN_CREDENTIALS`.
      * Воспользуйтесь [методом передачи токена](../reference/ydb-sdk/auth.md#auth-provider) в режиме **Access token**, описанном для SDK на вашем языке программирования, передав значение токена параметром.

    {% endlist %}

{% note alert %}

[Время жизни](../../iam/concepts/authorization/iam-token.md#lifetime) IAM-токена не более 12 часов.

{% endnote %}
