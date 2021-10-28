# Running a test application via the YDB SDK

To get acquainted with the {{ ydb-short-name }} SDK, you can use test apps in [Python](https://github.com/yandex-cloud/ydb-python-sdk), [Go](https://github.com/yandex-cloud/ydb-go-sdk), [Node.js](https://github.com/yandex-cloud/ydb-nodejs-sdk), or [Java](https://github.com/yandex-cloud/ydb-java-sdk). To do this, you need to set up a DB connection and then install and run the appropriate test app.

{% note info %}

For a detailed test app code analysis, see [{#T}](../sdk/index.md).

{% endnote %}

## Setting up a DB connection {#connect-to-db}

To connect to a database:

1. [Create a serverless database](create-db.md) in {{ yandex-cloud }}.

1. For database authentication, [create a service account](../../iam/operations/sa/create) and [assign](../../iam/operations/sa/assign-role-for-sa.md) it the `viewer` and `editor` roles.

1. Go to the **Service accounts** section of your folder and select a service account from the list. Save the service account ID.

   {% note info %}

   You can run your test app from a [VM](../../compute/operations/vm-create/create-linux-vm) in {{ yandex-cloud }}.

   {% endnote %}

1. Go to the **Overview** section of your database and save its endpoint and ID values given under **YDB endpoint**.

## Running a test application {#run-test}

{% include notitle [run-app](../_includes/run-app.md) %}

