# Creating a database

Create a [database](../concepts/databases.md#database) using {{ ydb-full-name }} from the {{ yandex-cloud }} management console.

## Before you start {#before-you-begin}

To get started in {{ yandex-cloud }}:

1. Log in to the [management console]({{ link-console-main }}). If you aren't registered, go to the management console and follow the instructions.
1. [On the billing page]({{ link-console-billing }}) make sure that you enabled a {% if deploy != "arc" %}[billing account](../../billing/concepts/billing-account.md){% else %}billing account{% endif %} and its status is `ACTIVE` or `TRIAL_ACTIVE`. If you don't have a billing account, {% if deploy != "arc" %}[create one](../../billing/quickstart/index.md#create_billing_account){% else %}create one{% endif %}.
1. If you do not have a folder, {% if deploy != "arc" %}[create one](../../resource-manager/operations/folder/create.md){% else %}create one{% endif %}.

## Create a database {#control-plane}

{% if audience == "internal" %}

1. To create a database, go to the [management console](https://ydb.yandex-team.ru).

    {% if deploy != "arc" %}

    {% include [iam](../../_includes/iam/owner-warning.md) %}

    {% endif %}

1. Click **Create database**.

    ![Create database](../_assets/db_ui_create_database_button.png)

1. In the **Cluster** field, select the *ydb-ru* cluster.

    The other fields are populated automatically, for example, the *home* account is selected and your username directory and *mydb* database are created automatically.

    Example of creating a new database:

    ![Create new database](../_assets/db_ui_create_home_database.png)

1. Click **Create**.

    This opens a page that says your database was successfully created.

    ![New database entrance](../_assets/db_ui_entrance_home_database.png)

{% else if audience == "external" %}

You can create a database in a Serverless configuration or with dedicated servers. For more information about differences in configurations, see [{#T}](../concepts/serverless_and_dedicated.md).

{% note info %}

For the Amazon DynamoDB-compatible mode, use a serverless database configuration.

{% endnote %}

{% include [create-db-via-console](../_includes/create-db-via-console.md) %}

{% endif %}
