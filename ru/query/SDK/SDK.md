# SDK

{{ yq-full-name }} построен на основе [внешних таблиц {{ ydb-short-name }}]({{ ydb.docs }}/concepts/datamodel/external_table), поэтому для взаимодействия с сервисом используется [{{ ydb-short-name }} SDK]({{ ydb.docs }}/reference/ydb-sdk/).

C помощью {{ ydb-short-name }} SDK возможно использование {{ yq-full-name }} в различных языках программирования:
* [Java SDK](https://github.com/ydb-platform/ydb-java-sdk).
* [Python SDK](https://github.com/ydb-platform/ydb-python-sdk).
* [Go SDK](https://github.com/ydb-platform/ydb-go-sdk).
* [C++ SDK](https://github.com/ydb-platform/ydb-cpp-sdk).
* [.NET SDK](https://github.com/ydb-platform/ydb-dotnet-sdk).
* [Rust SDK](https://github.com/ydb-platform/ydb-rs-sdk).

Полный перечень SDK платформы YDB см. на странице [ydb-platform на GitHub](https://github.com/orgs/ydb-platform/repositories?type=all&q=sdk).

Все примеры ниже приведены для Python SDK. SDK для других языков разработки устроены аналогично, и все подходы применимы и к ним с точностью до реализации каждого конкретного SDK.

## Аутентификация {#auth}

{{ yq-full-name }} является полностью управляемым сервисом и для аутентификации использует [механизмы {{ iam-short-name }}](../../iam/concepts/authorization/#authentication).

Аутентификация может быть выполнена с помощью:
* [Авторизованных ключей](../../iam/concepts/authorization/key.md).
* [Статических ключей](../../iam/concepts/authorization/access-key.md).
* [IAM-токена](../../iam/concepts/authorization/iam-token.md).
* [Метаданных виртуальной машины](../../compute/concepts/vm-metadata.md).

Для аутентификации любым перечисленным методом можно использовать [существующие методы SDK](https://github.com/ydb-platform/ydb-python-sdk/blob/main/ydb/driver.py).

В данном примере для аутентификации будет использоваться авторизованный ключ. Для создания авторизованного ключа выполните следующие шаги:

1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) с [ролью](../security/#query-editor) `yq.editor`.
1. [Создайте авторизованный ключ доступа](../../iam/operations/authentication/manage-authorized-keys.md#create-authorized-key) для сервисного аккаунта, созданного ранее. Сохраните авторизованный ключ доступа в файл в формате JSON.

## Подключение {#setup}

Для подключения к {{ yq-full-name }} необходимо создать объект `ydb.Driver` с указанием параметров подключения и данных для аутентификации:

```python
auth_key_file = "<path_to_auth_key_file>"

with ydb.Driver(endpoint="grpcs://grpc.yandex-query.cloud.yandex.net:2135",
                database="/<folder_id>",
                credentials=ydb.iam.ServiceAccountCredentials.from_file(auth_key_file)) as driver:
        driver.wait(timeout=5, fail_fast=True)
```

Где:
* `endpoint` — эндпоинт для подключения к источнику данных. {{ yq-full-name }} использует фиксированный адрес `grpcs://grpc.yandex-query.cloud.yandex.net:2135`.
* `database` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md), в котором вы хотите запускать запросы. Перед идентификатором каталога должен содержаться префикс `/`.
* `credentials` — реквизиты для аутентификации в {{ yandex-cloud }}.

## Выполнение запроса {#query_execution}

Для выполнения запроса необходимо открыть сессию к {{ yq-full-name }} и в рамках нее выполнить SQL-запрос:

```python
with ydb.SessionPool(driver) as pool:

    def callee(session):
        result_sets = session.transaction(ydb.SerializableReadWrite()).execute(
            """
            SELECT 'Hello, world!' AS message;
            """,
            commit_tx=True,
        )
        ...

    return pool.retry_operation_sync(callee)
```

{{ ydb-short-name }} поддерживает несколько способов выполнения запроса: обычный, scripting-запрос, [скан-запрос]({{ ydb.docs }}/concepts/scan_query) и query-запрос.

{% note info %}

{{ yq-full-name }} на данный момент поддерживает только scripting-запросы.

{% endnote %}

## Получение результатов запроса {#get_query_results}

Получить возвращаемые значения можно следующим образом:

```python
for row in result_sets[0].rows:
    print(row.message)

return result_sets[0]
```

{% note info %}

{{ yq-full-name }} поддерживает [многократное получение результатов запроса](../api/methods/get-query-results.md) по его идентификатору. При работе через {{ ydb-short-name }} SDK такая возможность в данный момент отсутствует.

{% endnote %}

## Полный пример {#full_example}

Ниже приведен пример работы с {{ yq-full-name }} с помощью {{ ydb-short-name }} Python SDK.

{% cut "Полный пример" %}

Установите необходимые Python-модули:

```shell
python3 -m pip install ydb
python3 -m pip install requests
python3 -m pip install "ydb[yc]"
```

Выполните следующий пример, указав необходимые для работы параметры:

```python
import ydb
import ydb.iam

auth_key_file = "<path_to_auth_key_file>"

def main():
    with ydb.Driver(endpoint="grpcs://grpc.yandex-query.cloud.yandex.net:2135",
                    database="/<folder_id>",
                    credentials=ydb.iam.ServiceAccountCredentials.from_file(auth_key_file)) as driver:
            driver.wait(timeout=5, fail_fast=True)

            with ydb.SessionPool(driver) as pool:

                def callee(session):
                    # New transaction in serializable read write mode.
                    # If query successfully completed you will get result sets.
                    # Otherwise exception will be raised.
                    result_sets = session.transaction(ydb.SerializableReadWrite()).execute(
                        """
                        select 'Hello, world!' as message
                        """,
                        commit_tx=True,
                    )
                    for row in result_sets[0].rows:
                        print(row.message)

                pool.retry_operation_sync(callee)


if __name__ == "__main__":
     main()
```

{% endcut %}
