---
title: Managing dedicated IP addresses in {{ postbox-full-name }}
description: Follow this guide to create a pool of dedicated IP addresses, add IPs to it, and link the pool to a configuration.
---

# Managing dedicated IP addresses

{% include [note-preview](../../_includes/note-preview.md) %}

[Dedicated IP addresses](../concepts/dedicated-ip.md) are grouped into pools. If a pool is linked to a [configuration](../concepts/configuration.md), all emails the configuration applies to are sent from the linked pool’s IP addresses.

Dedicated IP addresses are issued to a cloud upon request. To get them, contact [support]({{ link-console-support }}).

{% list tabs group=instructions %}

- AWS CLI {#aws-cli}

    If you do not have the AWS CLI yet, [install and configure it](../tools/aws-cli.md).

    To manage dedicated IP addresses, assign the `postbox.editor` [role](../security/index.md#postbox-editor) to the service account used by the AWS CLI.

    1. In the terminal, define these variables:

        ```bash
        ENDPOINT={{ postbox-endpoint }}
        PROFILE=<profile_name>
        POOL_NAME=<pool_name>
        CONFIGSET_NAME=<configuration_name>
        IP=<dedicated_IP_address>
        ```

    1. View the list of dedicated IP addresses issued to your cloud:

        ```bash
        aws sesv2 get-dedicated-ips \
           --endpoint-url=$ENDPOINT \
           --profile $PROFILE
        ```

        IP addresses not distributed among custom pools are in the default pool named `ses-default-dedicated-pool`.

    1. Create a pool:

        ```bash
        aws sesv2 create-dedicated-ip-pool \
           --endpoint-url=$ENDPOINT \
           --profile $PROFILE \
           --pool-name $POOL_NAME
        ```

        The pool name must be unique within the cloud and may contain lowercase Latin letters, digits, underscores `_`, and hyphens `-`. The name must be 1 to 64 characters long. You cannot use names [reserved](../concepts/dedicated-ip.md#reserved-pools) by the service.

    1. Add a dedicated IP address to the pool:

        ```bash
        aws sesv2 put-dedicated-ip-in-pool \
           --endpoint-url=$ENDPOINT \
           --profile $PROFILE \
           --ip $IP \
           --destination-pool-name $POOL_NAME
        ```

        The same IP address can belong only to one pool at any given time.

    1. Link the pool to a configuration:

        ```bash
        aws sesv2 put-configuration-set-delivery-options \
           --endpoint-url=$ENDPOINT \
           --profile $PROFILE \
           --configuration-set-name $CONFIGSET_NAME \
           --sending-pool-name $POOL_NAME \
           --tls-policy REQUIRE
        ```

        {% note warning %}

        This command completely updates the configuration's delivery settings. If you run it without specifying `--sending-pool-name`, the pool will be unlinked from the configuration, and mail will be sent from the service’s shared IP addresses.

        {% include [no-ip-address-in-pool-note.md](../../_includes/postbox/no-ip-address-in-pool-note.md) %}

        {% endnote %}

    1. Check the pool's composition:

        ```bash
        aws sesv2 get-dedicated-ips \
           --endpoint-url=$ENDPOINT \
           --profile $PROFILE \
           --pool-name $POOL_NAME
        ```

    1. To remove an IP address from the custom pool, move it to the default pool:

        ```bash
        aws sesv2 put-dedicated-ip-in-pool \
           --endpoint-url=$ENDPOINT \
           --profile $PROFILE \
           --ip $IP \
           --destination-pool-name ses-default-dedicated-pool
        ```

    1. Delete the pool:

        ```bash
        aws sesv2 delete-dedicated-ip-pool \
           --endpoint-url=$ENDPOINT \
           --profile $PROFILE \
           --pool-name $POOL_NAME
        ```

        {% include [delete-dedicated-ip-pool-note.md](../../_includes/postbox/delete-dedicated-ip-pool-note.md) %}

{% endlist %}

#### Useful links {#see-also}

* [{#T}](../concepts/dedicated-ip.md)
