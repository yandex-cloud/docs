# Connecting to a {{ ydb-name }} database

To connect to a [{{ ydb-full-name }}](../../../ydb/) database from {{ ml-platform-name }}, you need a service account. {{ ydb-name }} supports the `ServiceAccountCredentials` authentication method.

## Getting started {#before-you-begin}

1. [Create](../../../ydb/security/) a service account with `ydb.viewer` permissions to read data or `ydb.editor` permissions to read and write data.
1. [Specify](../projects/update.md) the service account in the {{ ml-platform-name }} project settings.

### Create a key {#create-key}

To connect to {{ ydb-name }} from your {{ ml-platform-name }} project, you need an [IAM token](../../../iam/concepts/authorization/iam-token.md).

{% list tabs %}

- YC CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Run this command:

     ```bash
     yc iam key create --service-account-name <service_account_name> --output key.json
     ```

     Where `<service_account_name>` is the name of the service account you specified in the project settings.

{% endlist %}

Save the received token to a file named `key.json`.

## Connect to the {{ ydb-short-name }} database {#connect-to-ydb}

1. {% include [before-begin](../../../_includes/datasphere/ui-before-begin.md) %}

1. In the left-hand panel, click ![upload](../../../_assets/datasphere/jupyterlab/upload.svg) **Upload file**. In the window that opens, select the `key.json` file.

1. Install libraries for working with {{ ydb-name }}. To do this, enter the following command in a notebook cell:

    ```python
    %pip install ydb
    %pip install ydb[yc]
    ```

1. Restart the kernel by clicking **Kernel** → **Restart kernel** in the top panel of the project window.

1. Establish a connection to the database. To do this, enter the following command in a notebook cell:

    ```python
    import os
    import ydb
    import ydb.iam

    # Create driver in global space.
    driver = ydb.Driver(
        endpoint='<endpoint>',
        database='<database_location>',
        credentials=ydb.iam.ServiceAccountCredentials.from_file('key.json'),
    )

    # Wait for the driver to become active for requests.
    driver.wait(fail_fast=True, timeout=5)

    # Create the session pool instance to manage YDB sessions.
    pool = ydb.SessionPool(driver)

    def execute_query(session):
        # Create the transaction and execute query.
        return session.transaction().execute(
            'SELECT * FROM <table_name>;',
            commit_tx=True,
            settings=ydb.BaseRequestSettings().with_timeout(3).with_operation_timeout(2)
        )

    def handler():
        # Execute query with the retry_operation helper.
        result = pool.retry_operation_sync(execute_query)
        return {
            'statusCode': 200,
            'body': str(result[0].rows[0]),
        }

    handler()
    ```

1. Configure the environment variables:
    * `<endpoint>`: First part of the **{{ ui-key.yacloud.ydb.overview.label_endpoint }}** field value (preceding `/?database=`), e.g., `{{ ydb.ep-serverless }}`.
    * `<database_location>`: Second part of the **{{ ui-key.yacloud.ydb.overview.label_endpoint }}** field value (following `/?database=`), e.g., `/{{ region-id }}/r1gra875baom********/g5n22e7ejfr1********`.
    * `<table_name>`: Table name.

1. Run the cell.
