# Changing network load balancer settings

After you create a network load balancer, you can:

* [{#T}](#change-name-and-description).

* [{#T}](#change-labels).

* [{#T}](#change-target-group).

* [{#T}](#add-target-group).

* [{#T}](#add-listener).

## Changing a load balancer's name and description {#change-name-and-description}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ network-load-balancer-name }}**.
   1. Select a load balancer and click **Edit** at the top of the page.
   1. Enter a new name and description for the load balancer.
   1. Click **Edit**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To change the name and description of a load balancer:

   1. View the current `name` and `description` of the load balancer:

      ```bash
      yc load-balancer network-load-balancer get <load balancer ID or name>
      ```

      You can get the load balancer ID and name with a [list of network load balancers in the folder](load-balancer-list.md#list).

   1. View a description of the update load balancer configuration CLI command:

      ```bash
      yc load-balancer network-load-balancer update --help
      ```

   1. Enter a new name and description for the load balancer:

      ```bash
      yc load-balancer network-load-balancer update <load balancer ID or name> \
         --new-name=<load balancer's new name> \
         --description=<load balancer's new description>
      ```

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](load-balancer-create.md).

      For a complete list of updatable configuration fields of a network load balancer, see the [provider documentation]({{ tf-provider-link }}/lb_network_load_balancer).

   1. In the network load balancer description, change the `name` and `description` parameter values:

      ```hcl
      resource "yandex_lb_network_load_balancer" "foo" {
        name        = "<network load balancer name>"
        description = "<network load balancer description>"
        ...
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the resources have been updated.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API

   Use the [update](../api-ref/NetworkLoadBalancer/update.md) API method and include the following in the request:

   * Load balancer ID in the `networkLoadBalancerId` parameter. To find out the ID, [get a list of network load balancers in the folder](load-balancer-list.md#list).
   * A new name in the `name` parameter.
   * A new description in the `description` parameter.
   * List of cluster configuration fields to update in the `updateMask` parameter (in this case, `name` and `description`).

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Changing load balancer labels {#change-labels}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ network-load-balancer-name }}**.
   1. Select a load balancer and click **Edit** at the top of the page.
   1. Change load balancer labels.
   1. Click **Edit**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To update the labels of a network load balancer:

   1. View the current load balancer's `labels` and their values:

      ```bash
      yc load-balancer network-load-balancer get <load balancer ID or name>
      ```

      You can get the load balancer ID and name with a [list of network load balancers in the folder](load-balancer-list.md#list).

   1. View a description of the update load balancer configuration CLI command:

      ```bash
      yc load-balancer network-load-balancer update --help
      ```

   1. Set new values for the load balancer labels:

      ```bash
      yc load-balancer network-load-balancer update <load balancer ID or name> \
         --labels <key1>=<value1>,<key2>=<value2>,...
      ```

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](load-balancer-create.md).

      For a complete list of updatable configuration fields of a network load balancer, see the [provider documentation]({{ tf-provider-link }}/lb_network_load_balancer).

   1. In the network load balancer description, change the `name` and `description` parameter values:

      ```hcl
      resource "yandex_lb_network_load_balancer" "foo" {
        ...
        labels = {
          <key1> = "value1"
          <key2> = "value2"
          ...
        }
        ...
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the resources have been updated:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API

   Use the [update](../api-ref/NetworkLoadBalancer/update.md) API method and include the following in the request:

   * Load balancer ID in the `networkLoadBalancerId` parameter. To find out the ID, [get a list of network load balancers in the folder](load-balancer-list.md#list).
   * New label values in the `labels` parameter.
   * List of cluster configuration fields to update in the `updateMask` parameter (in this case, `labels`).

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Changing a target group or its health check settings {#change-target-group}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ network-load-balancer-name }}**.
   1. Select a load balancer and click **Edit** at the top of the page.
   1. Under **Target groups**, select a new target group from the drop-down list or [create a new one](target-group-create.md).
   1. To change target group health check settings:
      1. In the section of the appropriate target group, click **Configure**.
      1. Set up new target group health check parameters.
      1. Click **Apply**.
   1. Click **Edit**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To update a target group or its health check settings:

   1. View a description of the update load balancer configuration CLI command:

      ```bash
      yc load-balancer network-load-balancer update --help
      ```

   1. Specify the target group's new ID and health check settings:

      ```bash
      yc load-balancer network-load-balancer update <load balancer ID or name> \
         --target-group target-group-id=<target group ID>,`
                       `healthcheck-name=<health check name>,`
                       `healthcheck-interval=<health check interval>s,`
                       `healthcheck-timeout=<response timeout>s,`
                       `healthcheck-unhealthythreshold=<number of failed health checks for Unhealthy status>,`
                       `healthcheck-healthythreshold=<number of successful health checks for Healthy status>,`
                       `healthcheck-tcp-port=<TCP port>,`
                       `healthcheck-http-port=<HTTP port>,`
                       `healthcheck-http-path=<URL for health checks>
      ```

      Where:

      {% include [target-group-cli-description](../../_includes/network-load-balancer/target-group-cli-description.md) %}

      You can get the load balancer ID and name with a [list of network load balancers in the folder](load-balancer-list.md#list) and the target group ID with a [list of folder target groups](target-group-list.md#list).

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](load-balancer-create.md).

      For a complete list of updatable configuration fields of a network load balancer, see the [provider documentation]({{ tf-provider-link }}/lb_network_load_balancer).

   1. In the network load balancer description, update the target group ID and its health check settings under `attached_target_group`:

      ```hcl
      resource "yandex_lb_network_load_balancer" "foo" {
        name = "<network load balancer name>"
        ...
        attached_target_group {
          target_group_id = "<target group ID>"
          healthcheck {
            name = "<health check name>"
            http_options {
              port = <port number>
              path = "<URL for health checks>"
            }
          }
        }
        ...
      }
      ```

      Where:

      * `name`: Name of the network load balancer.
      * `attached_target_group`: Description of the network load balancer's target group parameters:
         * `target_group_id`: Target group ID.
         * `healthcheck`: Health check parameters. Enter a name, a port number ranging from `1` to `32767`, and a path for health checks.

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the resources have been updated:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API

   Use the [update](../api-ref/NetworkLoadBalancer/update.md) API method and include the following in the request:

   * Load balancer ID in the `networkLoadBalancerId` parameter. To find out the ID, [get a list of network load balancers in the folder](load-balancer-list.md#list).
   * Target group ID and its health check settings in the `attachedTargetGroups` parameter. To find out the ID, [get a list of target groups in the folder](target-group-list.md#list).
   * List of cluster configuration fields to update in the `updateMask` parameter (in this case, `attachedTargetGroups`).

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Attaching a target group {#add-target-group}

To attach a target group, follow [this guide](target-group-attach.md).

## Adding a listener {#add-listener}

To add a listener, follow [this guide](listener-add.md).
