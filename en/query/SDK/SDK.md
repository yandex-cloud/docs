---
title: Working with {{ yq-full-name }} via the {{ ydb-short-name }} SDK
description: Authentication, connection, running queries, and getting results.
---

# SDK

Since {{ yq-full-name }} is based on [{{ ydb-short-name }} external tables]({{ ydb.docs }}/concepts/datamodel/external_table), you need the [{{ ydb-short-name }} SDK]({{ ydb.docs }}/reference/ydb-sdk/) to work with it.

The {{ ydb-short-name }} SDK enables you to use {{ yq-full-name }} with various programming languages:
* [Java SDK](https://github.com/ydb-platform/ydb-java-sdk)
* [Python SDK](https://github.com/ydb-platform/ydb-python-sdk)
* [Go SDK](https://github.com/ydb-platform/ydb-go-sdk)
* [C++ SDK](https://github.com/ydb-platform/ydb-cpp-sdk)
* [.NET SDK](https://github.com/ydb-platform/ydb-dotnet-sdk)
* [Rust SDK](https://github.com/ydb-platform/ydb-rs-sdk)

For the full list of YDB SDKs, see the [ydb-platform page on GitHub](https://github.com/orgs/ydb-platform/repositories?type=all&q=sdk).

All examples below use the Python SDK. SDKs for other languages work similarly, so you can use them to implement the same examples with minimal changes to account for their specifics.

## Authentication {#auth}

{{ yq-full-name }} is a fully managed service that uses [{{ iam-short-name }} authentication mechanisms](../../iam/concepts/authorization/index.md).

You can authenticate using:
* [Authorized keys](../../iam/concepts/authorization/key.md)
* [Static keys](../../iam/concepts/authorization/access-key.md)
* [IAM token](../../iam/concepts/authorization/iam-token.md)
* [VM metadata](../../compute/concepts/vm-metadata.md)

Every authentication method listed above has an [SDK implementation](https://github.com/ydb-platform/ydb-python-sdk/blob/main/ydb/driver.py).

In our example, we authenticate using an authorized key. To create an authorized key, follow these steps:

1. [Create a service account](../../iam/operations/sa/create.md) with the `yq.editor` [role](../security/#query-editor).
1. [Create an authorized key](../../iam/operations/authentication/manage-authorized-keys.md#create-authorized-key) for the service account. Save the authorized key as a JSON file.

## Connection {#setup}

To connect to {{ yq-full-name }}, you need to create an `ydb.Driver` object with the connection settings and authentication details:

```python
auth_key_file = "<path_to_auth_key_file>"

with ydb.Driver(endpoint="grpcs://grpc.yandex-query.cloud.yandex.net:2135",
                database="/<folder_id>",
                credentials=ydb.iam.ServiceAccountCredentials.from_file(auth_key_file)) as driver:
        driver.wait(timeout=5, fail_fast=True)
```

Where:
* `endpoint`: Data source connection endpoint. {{ yq-full-name }} uses a static address, `grpcs://grpc.yandex-query.cloud.yandex.net:2135`.
* `database`: [ID of the folder](../../resource-manager/operations/folder/get-id.md) where you want to run queries. Prefix the folder ID with `/`.
* `credentials`: {{ yandex-cloud }} authentication credentials.

## Running a query {#query_execution}

Open a {{ yq-full-name }} session and run the following SQL query within it:

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

{{ ydb-short-name }} supports multiple query types: normal, scripting, [scan]({{ ydb.docs }}/concepts/scan_query), and standard queries.

{% note info %}

Currently, {{ yq-full-name }} supports only scripting queries.

{% endnote %}

## Getting query results {#get_query_results}

You can get query results as follows:

```python
for row in result_sets[0].rows:
    print(row.message)

return result_sets[0]
```

{% note info %}

{{ yq-full-name }} supports [multiple query result retrievals](../api/methods/get-query-results.md) using the query ID. {{ ydb-short-name }} SDK does not currently support this feature.

{% endnote %}

## Full example {#full_example}

Below is an example of working with {{ yq-full-name }} via the {{ ydb-short-name }} Python SDK.

{% cut "Full example" %}

Install the required Python modules:

```shell
python3 -m pip install ydb
python3 -m pip install requests
python3 -m pip install "ydb[yc]"
```

Run the following example, providing the required parameters:

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
