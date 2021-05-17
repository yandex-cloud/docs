# Launch a test app

To get acquainted with the {{ ydb-short-name }} SDK you can use test apps in [Python](https://github.com/yandex-cloud/ydb-python-sdk), [Go](https://github.com/yandex-cloud/ydb-go-sdk), [Node.js](https://github.com/yandex-cloud/ydb-nodejs-sdk), [PHP](https://github.com/yandex-cloud/ydb-php-sdk) or [Java](https://github.com/yandex-cloud/ydb-java-sdk). To do this, you need to set up a DB connection and then install and run the appropriate test app.

{% note info %}

For a detailed test app code analysis, see [{#T}](../sdk/index.md).

{% endnote %}

## Setting up a DB connection {#connect-to-db}

To connect to a database:

1. [Create a database](create-db.md) in {{ yandex-cloud }} and allow assigning public IP addresses to DB nodes.

1. For [ database authentication, create a service account](../../iam/operations/sa/create) and [assign](../../iam/operations/sa/assign-role-for-sa.md) it the `viewer` and `editor` roles.

1. Go to the **Service accounts** section of your folder and select a service account from the list. Save the service account ID.

{% note info %}

You can run your test app from a [VM](../../compute/operations/vm-create/create-linux-vm) in {{ yandex-cloud }}.

{% endnote %}

1. Go to the database properties and save the endpoint and database ID values given under **Endpoint**.

1. To connect to the DB server, you need an SSL certificate. You can prepare all the necessary authentication data as follows:

   ```
   mkdir ~/.ydb
   wget "https://storage.yandexcloud.net/cloud-certs/CA.pem" -O ~/.ydb/CA.pem
   ```

## Launch a test app {#run-test}

{% include notitle [run-app](../_includes/run-app.md) %}

