---
title: "Changing network load balancer settings"
description: "Follow this guide to change network load balancer settings."
---

# Changing network load balancer settings

{% note info %}

{% include [type-update](../../_includes/network-load-balancer/type-update.md) %}

{% endnote %}

After you create a network load balancer, you can:

* [{#T}](#change-name-and-description)

* [{#T}](#change-labels)

* [{#T}](#change-target-group)

* [{#T}](#add-target-group)

* [{#T}](#add-listener)

## Changing a load balancer's name and description {#change-name-and-description}

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
   1. Select a load balancer and click **{{ ui-key.yacloud.common.edit }}** at the top of the page.
   1. Enter a new name and description for the load balancer.
   1. Click **{{ ui-key.yacloud.common.edit }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To change the name and description of a load balancer:

   1. Find out the ID or name of the load balancer by getting a [list of network load balancers in the folder](load-balancer-list.md#list).

   1. View the current `name` and `description` of the load balancer:

      ```bash
      yc load-balancer network-load-balancer get <load_balancer_name_or_ID>
      ```

   1. View a description of the update load balancer configuration CLI command:

      ```bash
      yc load-balancer network-load-balancer update --help
      ```

   1. Enter a new name and description for the load balancer:

      ```bash
      yc load-balancer network-load-balancer update <load_balancer_name_or_ID> \
         --new-name=<new_load_balancer_name> \
         --description=<new_load_balancer_description>
      ```

- {{ TF }} {#tf}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](load-balancer-create.md).

      For a complete list of updatable configuration fields of a network load balancer, see the [provider documentation]({{ tf-provider-resources-link }}/lb_network_load_balancer).

   1. In the network load balancer description, change the `name` and `description` parameter values:

      ```hcl
      resource "yandex_lb_network_load_balancer" "foo" {
        name        = "<load_balancer_name>"
        description = "<load_balancer_description>"
        ...
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API {#api}

   Use the [update](../api-ref/NetworkLoadBalancer/update.md) API method and include the following in the request:

   * Load balancer ID in the `networkLoadBalancerId` parameter. To find out the ID, [get a list of network load balancers in the folder](load-balancer-list.md#list).
   * A new name in the `name` parameter.
   * A new description in the `description` parameter.
   * List of cluster configuration fields to update in the `updateMask` parameter (in this case, `name` and `description`).

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Changing load balancer labels {#change-labels}

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
   1. Select a load balancer and click **{{ ui-key.yacloud.common.edit }}** at the top of the page.
   1. Change load balancer labels.
   1. Click **{{ ui-key.yacloud.common.edit }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To update the labels of a network load balancer:

   1. View the current load balancer's `labels` and their values:

      ```bash
      yc load-balancer network-load-balancer get <load_balancer_name_or_ID>
      ```

      You can get the load balancer ID and name with a [list of network load balancers in the folder](load-balancer-list.md#list).

   1. View a description of the update load balancer configuration CLI command:

      ```bash
      yc load-balancer network-load-balancer update --help
      ```

   1. Set new values for the load balancer labels:

      ```bash
      yc load-balancer network-load-balancer update <load_balancer_name_or_ID> \
         --labels <key_1>=<value_1>,<key_2>=<value_2>,...
      ```

- {{ TF }} {#tf}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](load-balancer-create.md).

      For a complete list of updatable configuration fields of a network load balancer, see the [provider documentation]({{ tf-provider-resources-link }}/lb_network_load_balancer).

   1. In the network load balancer description, change the `name` and `description` parameter values:

      ```hcl
      resource "yandex_lb_network_load_balancer" "foo" {
        ...
        labels = {
          <key_1> = "<value_1>"
          <key_2> = "<value_2>"
          ...
        }
        ...
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API {#api}

   Use the [update](../api-ref/NetworkLoadBalancer/update.md) API method and include the following in the request:

   * Load balancer ID in the `networkLoadBalancerId` parameter. To find out the ID, [get a list of network load balancers in the folder](load-balancer-list.md#list).
   * New label values in the `labels` parameter.
   * List of cluster configuration fields to update in the `updateMask` parameter (in this case, `labels`).

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Changing a target group or its health check settings {#change-target-group}

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
   1. Select a load balancer and click **{{ ui-key.yacloud.common.edit }}** at the top of the page.
   1. Under **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.section_target-groups }}**, select a new target group from the drop-down list or [create a new one](target-group-create.md).
   1. To change target group health check settings:
      1. In the section of the appropriate target group, click **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_edit-health-check }}**.
      1. Set up new target group health check parameters.
      1. Click **{{ ui-key.yacloud.common.apply }}**.
   1. Click **{{ ui-key.yacloud.common.edit }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To update a target group or its health check settings:

   1. View a description of the update load balancer configuration CLI command:

      ```bash
      yc load-balancer network-load-balancer update --help
      ```

   1. Specify the target group's new ID and health check settings:

      ```bash
      yc load-balancer network-load-balancer update <load_balancer_name_or_ID> \
         --target-group target-group-id=<target_group_ID>,`
                       `healthcheck-name=<health_check_name>,`
                       `healthcheck-interval=<health_check_interval>s,`
                       `healthcheck-timeout=<response_timeout>s,`
                       `healthcheck-unhealthythreshold=<number_of_failed_health_checks_for_Unhealthy_status>,`
                       `healthcheck-healthythreshold=<number_of_successful_health_checks_for_Healthy_status>,`
                       `healthcheck-tcp-port=<TCP_port>,`
                       `healthcheck-http-port=<HTTP_port>,`
                       `healthcheck-http-path=<URL>
      ```

      Where:

      {% include [target-group-cli-description](../../_includes/network-load-balancer/target-group-cli-description.md) %}

      You can get the load balancer ID and name with a [list of network load balancers in the folder](load-balancer-list.md#list).

- {{ TF }} {#tf}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](load-balancer-create.md).

      For a complete list of updatable configuration fields of a network load balancer, see the [provider documentation]({{ tf-provider-resources-link }}/lb_network_load_balancer).

   1. In the network load balancer description, update the target group ID and its health check settings under `attached_target_group`:

      ```hcl
      resource "yandex_lb_network_load_balancer" "foo" {
        name = "<load_balancer_name>"
        ...
        attached_target_group {
          target_group_id = "<target_group_ID>"
          healthcheck {
            name = "<health_check_name>"
            http_options {
              port = <port_number>
              path = "<URL>"
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

            {% include [get-target-group-id](../../_includes/network-load-balancer/get-target-group-id.md) %}

         * `healthcheck`: Health check parameters. Enter a name, a port number ranging from `1` to `32767`, and a path for health checks.

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API {#api}

   Use the [update](../api-ref/NetworkLoadBalancer/update.md) API method and include the following in the request:

   * Load balancer ID in the `networkLoadBalancerId` parameter. To find out the ID, [get a list of network load balancers in the folder](load-balancer-list.md#list).
   * Target group ID and its health check settings in the `attachedTargetGroups` parameter.

      {% include [get-target-group-id](../../_includes/network-load-balancer/get-target-group-id.md) %}

   * List of cluster configuration fields to update in the `updateMask` parameter (in this case, `attachedTargetGroups`).

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Attaching a target group {#add-target-group}

To attach a target group, follow [this guide](target-group-attach.md).

## Adding a listener {#add-listener}

To add a listener, follow [this guide](listener-add.md).
