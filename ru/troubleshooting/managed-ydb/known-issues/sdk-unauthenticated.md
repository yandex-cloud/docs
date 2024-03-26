# Устранение ошибки Unauthenticated


## Описание проблемы {#issue-description}

При попытке реализовать доступ к {{ ydb-full-name }} с локальной машины возникает ошибка `Unauthenticated`.

## Решение {#issue-resolution}

Можно [авторизоваться с помощью IAM-токена или токена сервисного аккаунта](../../../compute/operations/vm-connect/auth-inside-vm#auth-inside-vm). Примеры кода можно посмотреть [здесь](https://github.com/ydb-platform/ydb-python-sdk/tree/main/examples/service-account-credentials) и [здесь](https://github.com/ydb-platform/ydb-python-sdk/tree/main/examples/access-token-credentials).

{% note info %}

Пример работы с `YDB Python SDK`:

1. Создайте каталог, например, `ydb` и перейдите в него через PowerShell/Bash: `cd ydb`. Далее команды в этом терминале нужно будет выполнять в этой папке;
2. Создайте авторизованный ключ для сервисного аккаунта:
`yc iam key create --service-account-id <id_СА> --output token.json`. Ключ `token.json` будет создан в каталоге `ydb`;
3. Далее выполните проверку работоспособности ключа: `ydb --endpoint grpcs://ydb.serverless.yandexcloud.net:2135 --database /{{ region-id }}/b1gb4.../etn0fu... --sa-key-file token.json   discovery whoami`. Должен получиться ответ: `User SID: ajei6s...@as` — это значит, что соединение работает;
4. Клонируйте пример из GitHub: `git clone https://github.com/ydb-platform/ydb-python-sdk.git`. Он сохранится в текущем каталоге `ydb` для удобства;
5. Установите библиотеку: `python -m pip install iso8601`;
6. Добавьте в переменную `SA_KEY_FILE` окружения расположение этого файла:
   - Linux: `export SA_KEY_FILE=~/ydb/token.json`;
   - Windows: `$SA_KEY_FILE="C:\Users\<user>\ydb\token.json"`;
7. Выполните скрипт: `python ydb-python-sdk/examples/basic_example_v1/ -e grpcs://ydb.serverless.yandexcloud.net:2135 -d /{{ region-id }}/b1gb4.../etn0fu...`.

{% endnote %}