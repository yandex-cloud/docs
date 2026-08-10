# Creating a configuration

Create a [configuration](../concepts/configuration.md) to set up email processing rules:

* [Email operation notifications](../concepts/notification.md).
* Mandatory TLS encryption.
* Engagement statistics collection.
* [Statistics](../concepts/statistics.md#configuration-filter) breakdown by sending scenarios.

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder containing the address.
    1. [Navigate]({{ link-console-main }}/link/postbox) to **{{ ui-key.yacloud.iam.folder.dashboard.label_postbox }}**.
    1. In the left-hand panel, select ![image](../../_assets/console-icons/list-ul.svg) **{{ ui-key.yacloud.postbox.label_configuration-sets }}**.
    1. Click **{{ ui-key.yacloud.postbox.button_create-configuration-set }}**.
    1. Enter a name and (optionally) a description of the configuration.
    1. To receive email operation notifications, click **{{ ui-key.yacloud.postbox.label_event-destinations }}** under **{{ ui-key.yacloud.common.add }}**:

        1. Enter a name for the [subscription](../concepts/glossary.md#subscription).
        1. Select the {{ yds-full-name }} [data stream](../../data-streams/concepts/glossary.md#stream-concepts) to send email operation notifications to. If you do not have a data stream, [create one](../../data-streams/operations/manage-streams.md#create-data-stream).
        1. Select the types of notifications you want to receive.
        1. Select the **{{ ui-key.yacloud.common.enabled }}** option to activate the subscription.

        You can add multiple subscriptions.
    1. To send emails from {{ postbox-name }} to recipient servers using only TLS encryption, enable **{{ ui-key.yacloud.postbox.label_delivery-options }}** under **{{ ui-key.yacloud.postbox.field_secure-connection }}** and specify the minimum TLS version.

        {% note warning %}

        If the recipient's server does not support the specified TLS version, the email will not be delivered.

        {% endnote %}

    1. To collect statistics on email opens and clicks, enable **Engagement statistics** under **Statistics collection settings**. All other [statistics](../concepts/statistics.md), other than email opens and clicks, are collected by default.

        {% note info %}

        Enabling **Engagement statistics** will modify the email body. For more information, see [{#T}](../concepts/mail-opened.md) and [{#T}](../concepts/click-tracking.md).

        {% endnote %}

    1. Click **{{ ui-key.yacloud.postbox.button_create-configuration-set }}**.

- AWS CLI {#aws-cli}

    If you do not have the AWS CLI yet, [install and configure it](../tools/aws-cli.md).

    To create a configuration, assign the `postbox.editor` [role](../security/index.md#postbox-editor) to the service account used for the AWS CLI.

    1. In the terminal, define these variables:

        ```bash
        ENDPOINT={{ postbox-endpoint }}
        PROFILE=<profile_name>
        CONFIGSET_NAME=<configuration_name>
        IDENTITY=<domain>
        KINESIS_ENDPOINT=https://yds.serverless.yandexcloud.net/{{ region-id }}/<folder_ID>/<{{ ydb-short-name }}_database_ID>
        TOPIC=<data_stream_name>
        ```

    1. Create a [configuration](../concepts/glossary.md#configuration):

        ```bash
        aws sesv2 create-configuration-set \
           --endpoint-url=$ENDPOINT \
           --profile $PROFILE \
           --configuration-set-name $CONFIGSET_NAME
        ```

    1. To receive email operation notifications, add a [subscription](../concepts/glossary.md#subscription) to the configuration:

        ```bash
        aws sesv2 create-configuration-set-event-destination \
           --endpoint-url=$ENDPOINT \
           --profile $PROFILE \
           --configuration-set-name $CONFIGSET_NAME \
           --event-destination-name <subscription_name> \
           --event-destination "{\"Enabled\":true,\"KinesisFirehoseDestination\":{\"DeliveryStreamArn\":\"arn:aws:keenesis:::$KINESIS_ENDPOINT:$TOPIC\",\"IamRoleArn\":\"arn:\"}}"

        ```

        You can add multiple subscriptions.

{% endlist %}

To apply your configuration to all emails sent from a specific address, [associate](bind-configuration.md) the configuration with that address.
