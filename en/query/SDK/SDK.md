# SDK

{{ yq-full-name }} is based on [{{ ydb-short-name }} external tables]({{ ydb.docs }}/concepts/datamodel/external_table), hence, you need the [{{ ydb-short-name }} SDK]({{ ydb.docs }}/reference/ydb-sdk/) to work with the service.

The {{ ydb-short-name }} SDK enables you to use {{ yq-full-name }} in various programming languages:
* [Java SDK](https://github.com/ydb-platform/ydb-java-sdk)
* [Python SDK](https://github.com/ydb-platform/ydb-python-sdk)
* [Go SDK](https://github.com/ydb-platform/ydb-go-sdk)
* [C++ SDK](https://github.com/ydb-platform/ydb-cpp-sdk)
* [.NET SDK](https://github.com/ydb-platform/ydb-dotnet-sdk)
* [Rust SDK](https://github.com/ydb-platform/ydb-rs-sdk)

For the full list of the YDB SDKs, see the [ydb-platform page on GitHub](https://github.com/orgs/ydb-platform/repositories?type=all&q=sdk).

All examples below use the Python SDK. SDKs for other development languages work similarly, so you can apply all the approaches to them right down to the implementation of each individual SDK.

## Authentication {#auth}

{{ yq-full-name }} is a fully managed service that uses the [{{ iam-short-name }} mechanisms](../../iam/concepts/authorization/#authentication) for authentication.

You can authenticate using:
* [Authorized keys](../../iam/concepts/authorization/key.md)
* [Static keys](../../iam/concepts/authorization/access-key.md)
* [IAM token](../../iam/concepts/authorization/iam-token.md)
* [VM metadata](../../compute/concepts/vm-metadata.md)

For any of the above-listed authentication methods, you can use the [existing SDK methods](https://github.com/ydb-platform/ydb-python-sdk/blob/main/ydb/driver.py).

In this example, we will use an authorized key. To create an authorized key, follow these steps:

1. [Create a service account](../../iam/operations/sa/create.md) with the `yq.editor` [role](../security/#query-editor).
1. [Create an authorized access key](../../iam/operations/authorized-key/create.md) for the service account you created. Save the authorized access key to a JSON file.

## Connection {#setup}

To connect to {{ yq-full-name }}, you need to create an object named `ydb.Driver` specifying the connection parameters and authentication data:

```python
auth_key_file = "<path_to_auth_key_file>"

with ydb.Driver(endpoint="grpcs://grpc.yandex-query.cloud.yandex.net:2135",
                database="/<folder_id>",
                credentials=ydb.iam.ServiceAccountCredentials.from_file(auth_key_file)) as driver:
        driver.wait(timeout=5, fail_fast=True)
```

Where:
* `endpoint`: Endpoint for connecting to the data source. {{ yq-full-name }} uses a fixed address, `grpcs://grpc.yandex-query.cloud.yandex.net:2135`.
* `database`: [ID of the folder](../../resource-manager/operations/folder/get-id.md) you want to run queries in. You must include the `/` prefix before the folder ID.
* `credentials`: Credentials for authentication in {{ yandex-cloud }}.

## Running a query {#query_execution}

To run a query, you must open a session to {{ yq-full-name }} and run an SQL query in it:

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

{{ ydb-short-name }} supports a number of query execution methods: normal, scripting request, [scan request]({{ ydb.docs }}/concepts/scan_query), and query request.

{% note info %}

Currently, {{ yq-full-name }} supports only scripting requests.

{% endnote %}

## Getting query results {#get_query_results}

You can get return values as follows:

```python
for row in result_sets[0].rows:
    print(row.message)

return result_sets[0]
```

{% note info %}

{{ yq-full-name }} supports [getting query results multiple times](../api/methods/get-query-results.md) by its ID. If you use the {{ ydb-short-name }} SDK, such feature is currently not available.

{% endnote %}

## Full example {#full_example}

Below is an example of how to use {{ yq-full-name }} with the {{ ydb-short-name }} Python SDK.

{% cut "Full example" %}

Install the required Python modules:

```shell
python3 -m pip install ydb
python3 -m pip install requests
python3 -m pip install "ydb[yc]"
```

Run the following example, specifying the required parameters:

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
