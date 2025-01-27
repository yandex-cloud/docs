---
title: Logging setup and performance analysis guide for businesses
description: In this tutorial, you will learn how to set up logging and analyze performance as a business.
---

# Set up logging and analyze performance

The guide in this checklist item will help you set up operations with logs and analyze performance.

## Create a log group {#log-group}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder where you want to create your [log group](../../logging/concepts/log-group.md).
    1. Open **{{ ui-key.yacloud.iam.folder.dashboard.label_logging }}**.
    1. Click **{{ ui-key.yacloud.logging.button_create-group }}**.
    1. (Optional) Enter a name and description for the log group. The name format is as follows:

        {% include [name-format](../../_includes/name-format.md) %}

    1. Set the log group record retention period.
    1. Click **{{ ui-key.yacloud.logging.button_create-group }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    {% note info %}

    The record retention period can only be specified in hours, minutes, or seconds, such as `1h` or `1440m`.

    {% endnote %}

    To create a log group, run this command:

    ```
    yc logging group create --name=group --retention-period=1h
    ```

    * `--name`: Log group name.
    * `--retention-period`: Retention period for log group records. This is an optional parameter.

    Result:

    ```
    done (1s)
    id: af3flf29t8**********
    folder_id: aoek6qrs8t**********
    cloud_id: aoegtvhtp8**********
    created_at: "2021-06-24T09:56:38.970Z"
    name: group
    status: ACTIVE
    retention_period: 3600s
    ```

- API {#api}

    You can create a custom log group using the [create](../../logging/api-ref/LogGroup/create.md) API method.

{% endlist %}

## Assign roles for a log group {#add-access}

{% list tabs group=instructions %}

- CLI {#cli}

  To assign a [role](../../resource-manager/security/index.md) to a custom log group, run this command:

  * To a user:
        ```
        yc logging group add-access-binding \
            --name <log_group_name> \
            --user-account-id <user_ID> \
            --role <role>
        ```
        Result:
        ```
        done (1s)
        ```
    * To a [service account](../../iam/concepts/users/service-accounts.md):  
        ```
        yc logging group add-access-binding \
            --name <log_group_name> \
            --service-account-id <service_account_ID> \
            --role <role>
        ```
        Result:
        ```
        done (1s)
        ```
    * To all authenticated users (the `All authenticated users` [public group](../../iam/concepts/access-control/public-group.md)):
        ```
        yc logging group add-access-binding \
            --name <log_group_name> \
            --all-authenticated-users \
            --role <role>
        ```
        Result:
        ```
        done (1s)
        ```

- API {#api}

    To assign [roles](../../resource-manager/security/index.md#roles-list) for a [custom log group](../../logging/concepts/log-group.md), use the API [setAccessBindings](../../logging/api-ref/LogGroup/setAccessBindings.md) method.

{% endlist %}

## View charts

1. In the [management console]({{ link-console-main }}), select the folder containing your log group.
1. Open **{{ ui-key.yacloud.iam.folder.dashboard.label_logging }}**.
1. Select a log group.
1. Go to the **{{ ui-key.yacloud.common.monitoring }}** tab.
1. The following charts will open on the page:
    * **Records successfully ingested**: Number of records delivered to the {{ cloud-logging-name }} system. Only user logs are counted.
    * **Records saved**: Number of records saved to the {{ cloud-logging-name }} system. Service and user logs are counted.
    * **Records read**: Number of records read.
    * **Records ingest errors**: Number of errors when adding records.
    * **Records save lag**: Difference between the time of record delivery and its saving to the {{ cloud-logging-name }} system.