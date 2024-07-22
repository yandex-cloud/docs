# Creating a configuration

Create a [configuration](../concepts/glossary.md#configuration) to get [email delivery notifications](../concepts/notification.md).

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder containing the address.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_postbox }}**.
    1. In the left-hand panel, select ![image](../../_assets/console-icons/list-ul.svg) **{{ ui-key.yacloud.postbox.label_configuration-sets }}**.
    1. Click **{{ ui-key.yacloud.postbox.button_create-configuration-set }}**.
    1. Enter a name and (optionally) a description of the configuration.
    1. Under **{{ ui-key.yacloud.postbox.label_event-destinations }}**, click **{{ ui-key.yacloud.common.add }}**:
        1. Enter a name for the [subscription](../concepts/glossary.md#subscription).
        1. Select the {{ yds-full-name }} [data stream](../../data-streams/concepts/glossary.md#stream-concepts) to send email delivery notifications to. If you do not have a data stream, [create one](../../data-streams/operations/manage-streams.md#create-data-stream).
        1. Select the **{{ ui-key.yacloud.common.enabled }}** option to activate the subscription.

        You can add multiple subscriptions.

    1. Click **{{ ui-key.yacloud.postbox.button_create-configuration-set }}**.

- AWS CLI {#aws-cli}

    If you do not have the AWS CLI yet, [install and configure it](../tools/aws-cli.md).

    To create a configuration, assign the [postbox.editor](../security/index.md#postbox-editor) `role` to the service account enabling the AWS CLI.

    1. In the terminal, define these variables:

        ```bash
        ENDPOINT={{ postbox-endpoint }}
        PROFILE=<profile_name>
        CONFIGSET_NAME=<configuration_name>
        IDENTITY=<domain>
        KINESIS_ENDPOINT=https://yds.serverless.yandexcloud.net/{{ region-id }}/<directory_ID>/<{{ ydb-short-name }}_database_ID>
        TOPIC=<data_stream_name>
        ```

    1. Create a [configuration](../concepts/glossary.md#configuration):

        ```bash
        aws sesv2 create-configuration-set \
           --endpoint-url=$ENDPOINT \
           --profile $PROFILE \
           --configuration-set-name $CONFIGSET_NAME
        ```

    1. Add a [subscription](../concepts/glossary.md#subscription) to the configuration:

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

To get notifications, [link](bind-configuration.md) the configuration to an address.
