# Linking a configuration to an address

Link a [configuration](../concepts/glossary.md#configuration) to an address to get [email delivery notifications](../concepts/notification.md).

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder with your address and configuration.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_postbox }}**.
    1. In the left-hand panel, select ![image](../../_assets/console-icons/at.svg) **{{ ui-key.yacloud.postbox.label_identities }}**.
    1. Select an address to link the configuration to.
    1. Click **{{ ui-key.yacloud.common.edit }}**.
    1. Select a configuration or [create a new one](create-configuration.md).
    1. Click **{{ ui-key.yacloud.common.save }}**.

- AWS CLI {#aws-cli}

    If you do not have the AWS CLI yet, [install and configure it](../tools/aws-cli.md).

    To link a configuration to an address, assign the `postbox.editor` [role](../security/index.md#postbox-editor) to the service account enabling the AWS CLI.

    1. In the terminal, define these variables:

        ```bash
        ENDPOINT={{ postbox-endpoint }}
        PROFILE=<profile_name>
        CONFIGSET_NAME=<configuration_name>
        IDENTITY=<domain>
        ```

    1. Link the configuration to an address:

        ```bash
        aws sesv2 put-email-identity-configuration-set-attributes \
           --endpoint-url=$ENDPOINT \
           --profile $PROFILE \
           --email-identity $IDENTITY \
           --configuration-set-name $CONFIGSET_NAME
        ```

{% endlist %}

## See also {#see-also}

* [Create a configuration](create-configuration.md)
