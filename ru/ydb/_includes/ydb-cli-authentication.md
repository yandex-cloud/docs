Для выполнения запросов к {{ ydb-full-name }} в {{ yandex-cloud }} с помощью {{ ydb-short-name }} CLI необходимо аутентифицироваться. Выберите один из доступных способов аутентификации.

{% list tabs %}

- OAuth-токен

    При запуске команды {{ ydb-short-name }} CLI в параметре `--yc-token-file` укажите путь к файлу, в котором содержится ваш {% if deploy != "arc" %}[OAuth-токен](../../iam/concepts/authorization/oauth-token.md){%else%}OAuth-токен{% endif %}.

    Чтобы не указывать этот параметр при каждом вызове команды, сохраните значение OAuth-токена в переменную окружения `YC_TOKEN` или [настройте профиль](../ydb-cli/profile/create.md) {{ ydb-short-name }} CLI.

- IAM-токен

    При запуске команды {{ ydb-short-name }} CLI в параметре `--iam-token-file` укажите путь к файлу, в котором содержится ваш {% if deploy != "arc" %}[IAM-токен](../../iam/concepts/authorization/iam-token.md){%else%}IAM-токен{% endif %}.

    Чтобы не указывать эту опцию при каждом вызове команды, сохраните значение IAM-токена в переменную окружения `IAM_TOKEN` или [настройте профиль](../ydb-cli/profile/create.md) {{ ydb-short-name }} CLI.

    {% note alert %}

    [Время жизни](../../iam/concepts/authorization/iam-token.md#lifetime) IAM-токена не более 12 часов.

    {% endnote %}

- Сервис метаданных

    При запуске команды {{ ydb-short-name }} CLI укажите параметр `--use-metadata-credentials`, и {{ ydb-cli }} получит {% if deploy != "arc" %}[IAM-токен](../../iam/concepts/authorization/iam-token.md){%else%}IAM-токен{% endif %} с помощью {% if deploy != "arc" %}[сервиса метаданных](../../compute/operations/vm-connect/auth-inside-vm.md#auth-inside-vm.md){%else%}сервиса метаданных{% endif %} при работе из виртуальной машины в {{ yandex-cloud }}.

    Чтобы не указывать эту опцию при каждом вызове команды, установите значение переменной окружения `USE_METADATA_CREDENTIALS` в  `1` или [настройте профиль](../ydb-cli/profile/create.md) {{ ydb-short-name }} CLI.

- Авторизованный ключ доступа

    При запуске команды {{ ydb-short-name }} CLI в параметре `--sa-key-file` укажите путь к файлу с закрытым {% if deploy != "arc" %}[авторизованным ключом доступа](../../iam/concepts/authorization/key.md){%else%}авторизованным ключом доступа{% endif %} сервисного аккаунта.

    Чтобы не указывать эту опцию при каждом вызове команды, сохраните путь к файлу в переменную окружения `SA_KEY_FILE` или [настройте профиль](../ydb-cli/profile/create.md) {{ ydb-short-name }} CLI.

{% endlist %}
