# Configuring deletion protection

To prevent accidental deletion of a network load balancer, [enable deletion protection for it](#enable-deletion-protection).

You can [disable](#disable-deletion-protection) protection when you no longer need it.

## Enabling deletion protection {#enable-deletion-protection}

{% note warning %}

Even with balancer deletion protection enabled, one can still delete its listeners and target groups.

{% endnote %}

{% list tabs %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
    1. To the right of your load balancer name, click ![horizontal-ellipsis](../../_assets/horizontal-ellipsis.svg) and select **{{ ui-key.yacloud.common.edit }}**.
    1. Enable the **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_deletion-protection }}** setting.
    1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

    {% include [include](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    1. See the description of the CLI command for updating balancer attributes:

        ```bash
        yc load-balancer network-load-balancer update --help
        ```

    1. Enable deletion protection:

        ```bash
        yc load-balancer network-load-balancer update <load_balancer_name_or_ID> \
            --deletion-protection
        ```

        You can get the load balancer ID and name with the [list of network load balancers in the folder](load-balancer-list.md#list).

- {{ TF }} {#tf}

    {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

    {% include [terraform-install](../../_includes/terraform-install.md) %}

    1. Open the current configuration file describing the infrastructure.

    1. Add the `deletion_protection` parameter to the load balancer description:


       ```hcl
       resource "yandex_lb_network_load_balancer" "foo" {
         ...
         deletion_protection = true
         ...
       }
       ```

    1. Make sure the settings are correct.

       {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Apply the changes.

       {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API {#api}

    To enable deletion protection, use the [update](../api-ref/NetworkLoadBalancer/update.md) REST API method for the [NetworkLoadBalancer](../api-ref/NetworkLoadBalancer/index.md) resource or the [NetworkLoadBalancerService/Update](../api-ref/grpc/NetworkLoadBalancer/update.md) gRPC API call and provide the following in the request:

    * Name of the `deletionProtection` parameter in the `updateMask` parameter.
    * `true` in the `deletionProtection` parameter.

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Disable deletion protection {#disable-deletion-protection}

{% list tabs %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
    1. To the right of your load balancer name, click ![horizontal-ellipsis](../../_assets/horizontal-ellipsis.svg) and select **{{ ui-key.yacloud.common.edit }}**.
    1. Disable the **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_deletion-protection }}** setting.
    1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

    {% include [include](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    1. See the description of the CLI command for updating balancer attributes:

        ```bash
        yc load-balancer network-load-balancer update --help
        ```

    1. Disable deletion protection:

        ```bash
        yc load-balancer network-load-balancer update <load_balancer_name_or_ID> \
            --deletion-protection=false
        ```

        You can get the load balancer ID and name with the [list of network load balancers in the folder](load-balancer-list.md#list).

- {{ TF }} {#tf}

    {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

    {% include [terraform-install](../../_includes/terraform-install.md) %}

    1. Open the current configuration file describing the infrastructure.

    1. In the load balancer description, change the `deletion_protection` value to `false`:


       ```hcl
       resource "yandex_lb_network_load_balancer" "foo" {
         ...
         deletion_protection = false
         ...
       }
       ```

    1. Make sure the settings are correct.

       {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Apply the changes.

       {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API {#api}

    To enable deletion protection, use the [update](../api-ref/NetworkLoadBalancer/update.md) REST API method for the [NetworkLoadBalancer](../api-ref/NetworkLoadBalancer/index.md) resource or the [NetworkLoadBalancerService/Update](../api-ref/grpc/NetworkLoadBalancer/update.md) gRPC API call and provide the following in the request:

    * Name of the `deletionProtection` parameter in the `updateMask` parameter.
    * `false` in the `deletionProtection` parameter.

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}
