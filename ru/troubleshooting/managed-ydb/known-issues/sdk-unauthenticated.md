# Устранение ошибки `Unauthenticated`


## Описание проблемы {#issue-description}

Попытка установить доступ к {{ ydb-name }} с локальной машины завершается ошибкой `Unauthenticated`.

## Решение {#issue-resolution}

Можно [авторизоваться с помощью {{iam-short-name }}-токена или токена сервисного аккаунта](../../../compute/operations/vm-connect/auth-inside-vm.md#auth-inside-vm). Примеры кода приведены [здесь](https://github.com/ydb-platform/ydb-python-sdk/tree/main/examples/service-account-credentials) и [здесь](https://github.com/ydb-platform/ydb-python-sdk/tree/main/examples/access-token-credentials).

{% cut "Пример работы с `YDB Python SDK`" %}

1. Создайте каталог, например `ydb`, и перейдите в него через PowerShell или Bash: `cd ydb`. Далее команды в этом терминале нужно будет выполнять в этой папке.
1. Создайте авторизованный ключ для сервисного аккаунта: `yc iam key create --service-account-id <id_СА> --output token.json`. Ключ `token.json` будет создан в каталоге `ydb`.
1. Выполните проверку работоспособности ключа: `ydb --endpoint grpcs://ydb.serverless.yandexcloud.net:2135 --database /{{ region-id }}/b1gb4.../etn0fu... --sa-key-file token.json   discovery whoami`. Должен получиться ответ: `User SID: ajei6s...@as` — это значит, что соединение работает.
1. Клонируйте пример из GitHub: `git clone https://github.com/ydb-platform/ydb-python-sdk.git`. Он сохранится в текущем каталоге `ydb` для удобства.
1. Установите библиотеку: `python -m pip install iso8601`.
1. Добавьте в переменную `YDB_SERVICE_ACCOUNT_KEY_FILE_CREDENTIALS` окружения расположение этого файла:
   * Linux: `export YDB_SERVICE_ACCOUNT_KEY_FILE_CREDENTIALS=~/ydb/token.json`;
   * Microsoft Windows®: `$YDB_SERVICE_ACCOUNT_KEY_FILE_CREDENTIALS="C:\Users\<user>\ydb\token.json"`.
1. Выполните скрипт: `python ydb-python-sdk/examples/basic_example_v1/ -e grpcs://ydb.serverless.yandexcloud.net:2135 -d /{{ region-id }}/b1gb4.../etn0fu...`.

{% endcut %}
