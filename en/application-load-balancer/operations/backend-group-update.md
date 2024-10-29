---
title: How to edit a backend group in {{ alb-full-name }}
description: Step-by-step guide for editing a backend group.
---

# Editing a backend group

## Update a group's basic parameters {#update-group}

{% list tabs group=instructions %}

- Management console {#console}

  {% note info %}

  To change the [group type](../concepts/backend-group.md#group-types), you need to use other tools, such as the [CLI](../../cli/), {{ TF }}, and API.

  {% endnote %}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where the [backend group](../concepts/backend-group.md) was created.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/cubes-3-overlap.svg) **{{ ui-key.yacloud.alb.label_backend-groups }}**.
  1. Click the name of the group.
  1. Click ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. Edit the group parameters:
     * **{{ ui-key.yacloud.common.name }}** and **{{ ui-key.yc-ui-datasphere.common.description }}** backend groups.
     * **{{ ui-key.yacloud.alb.label_session-affinity }}**: If you select this option, requests within one user session are processed by the same endpoint.

       {% include [session-affinity-prereqs](../../_includes/application-load-balancer/session-affinity-prereqs.md) %}

       `{{ ui-key.yacloud.alb.label_proto-http }}` and `{{ ui-key.yacloud.alb.label_proto-grpc }}` backend groups support the following modes:
       * `{{ ui-key.yacloud.alb.label_affinity-connection }}`.
       * `{{ ui-key.yacloud.alb.label_affinity-header }}`.
       * `{{ ui-key.yacloud.alb.label_affinity-cookie }}`.

       For the `{{ ui-key.yacloud.alb.label_proto-stream }}` type, session affinity is always by [IP address](../../vpc/concepts/address.md).

       For more information about session affinity and its modes, see [this section](../concepts/backend-group.md#session-affinity).
  1. At the bottom of the page, click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the [CLI](../../cli/) command that changes the [backend group](../concepts/backend-group.md) basic parameters:

     ```bash
     yc alb backend-group update --help
     ```

  1. Run this command:

     ```bash
     yc alb backend-group update \
       --name <backend_group_name> \
       --new-name <new_name_for_backend_group> \
       --description <backend_group_description> \
       --labels key=value[,<key>=<label_value>] \
       --connection-affinity source-ip=<IP_address_session_affinity_mode>
     ```

     Where:
     * `--name`: Backend group name.
     * `--new-name`: New name for the backend group. The naming requirements are as follows:

       {% include [name-format-2](../../_includes/name-format-2.md) %}

     * `--description`: Backend group description. This is an optional parameter.
     * `--labels key=value`: List of labels in `key=value` format. This is an optional parameter.
     * `--connection-affinity`: Mode of [session affinity](../../application-load-balancer/concepts/backend-group.md#session-affinity) by [IP address](../../vpc/concepts/address.md) (`source-ip`). Its possible values are `true` or `false`. This is an optional parameter. The `--cookie-affinity` (by cookie) and `--header-affinity` (by HTTP header) modes are also available. Only one of the modes can be specified. If the backend group is of the [Stream type](../concepts/backend-group#group-types), the you can only use `--connection-affinity`.

       {% include [session-affinity-prereqs](../../_includes/application-load-balancer/session-affinity-prereqs.md) %}

     Result:

     ```text
     id: ds7mi7mlqgct********
     name: <backend_group_name>
     description: update
     folder_id: b1g6hif00bod********
     labels:
       bar: buz
       foo: buz
     http:
       backends:
       - name: <backend_name>
         backend_weight: "2"
         load_balancing_config:
           panic_threshold: "90"
         port: "80"
         target_groups:
           target_group_ids:
           - ds75pc3146dh********
         healthchecks:
         - timeout: 10s
           interval: 2s
           healthy_threshold: "10"
           unhealthy_threshold: "15"
           healthcheck_port: "80"
           http:
             host: <host_address>
             path: <path>
       connection:
         source_ip: true
     created_at: "2022-11-30T17:46:05.599491104Z"
     ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Open the {{ TF }} configuration file and edit the fragment with the [backend group](../concepts/backend-group.md) description:

     ```hcl
     resource "yandex_alb_backend_group" "test-backend-group" {
       name        = "<backend_group_name>"
       description = "<backend_group_description>"
       labels      = {
         new-label = "test-label"
       }
       session_affinity {
         connection {
           source_ip = <IP_address_session_affinity_mode>
         }
       }
     ...
     }
     ```

     Where `yandex_alb_backend_group` specifies the backend group parameters:
     * `name`: Backend group name.
     * `description`: Backend group description. This is an optional parameter.
     * `labels`: List of labels in `key=value` format. This is an optional parameter.
     * `session_affinity`: [Session affinity](../../application-load-balancer/concepts/backend-group.md#session-affinity) settings. This is an optional parameter.

       {% include [session-affinity-prereqs](../../_includes/application-load-balancer/session-affinity-prereqs.md) %}

       * `connection`: Mode of session affinity by [IP address](../../vpc/concepts/address.md) (`source_ip`). It can either be `true` or `false`. The `cookie` and `header` modes are also available. Only one of the modes should be specified. If the backend group is of the `Stream` type (consists of the `stream_backend` resources), you can only use the `connection` mode for session affinity.

     For more information about the `yandex_alb_backend_group` resource parameters, see the [{{ TF }} provider documentation]({{ tf-provider-alb-backendgroup }}).
  1. Apply the changes:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     You can check the backend group updates using the [management console]({{ link-console-main }}) or this [CLI](../../cli/quickstart.md) command:

     ```bash
     yc alb backend-group get --name <backend_group_name>
     ```

- API {#api}

  To change the basic parameters of a [backend group](../concepts/backend-group.md), use the [update](../api-ref/BackendGroup/update.md) REST API method for the [BackendGroup](../api-ref/BackendGroup/index.md) resource or the [BackendGroupService/Update](../api-ref/grpc/BackendGroup/update.md) gRPC API call.

{% endlist %}

## Add a backend to a group {#add-backend}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where the backend was created.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/cubes-3-overlap.svg) **{{ ui-key.yacloud.alb.label_backend-groups }}**.
  1. Click the name of the group.
  1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.alb.button_add-backend }}**.
  1. In the window that opens, set the backend settings:

     {% include [backend-settings-console](../../_includes/application-load-balancer/backend-settings-console.md) %}

  1. Click **{{ ui-key.yacloud.common.add }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Add a backend and health check to the group.

  {% include [backend-healthcheck](../../_includes/application-load-balancer/backend-healthcheck.md) %}

  All backends within the group must be of the same [type](../concepts/backend-group.md#group-types): `HTTP` or `Stream`.

  {% cut "HTTP backend" %}

  Run this command:

  {% include [cli-code-http-backend-create](../../_includes/application-load-balancer/cli-code-http-backend-create.md) %}

  {% include [cli-http-where-legend](../../_includes/application-load-balancer/cli-http-where-legend.md) %}

  Result:

  ```text
  id: a5dqkr2mk3rr********
  name: <backend_group_name>
  folder_id: aoe197919j8e********
  ...
          host: <host_address>
          path: <path>
  created_at: "2021-02-11T20:46:21.688940670Z"
  ```

  {% endcut %}

  {% cut "gRPC backend" %}

  Run this command:

  {% include [cli-code-gRPC-backend-create](../../_includes/application-load-balancer/cli-code-gRPC-backend-create.md) %}

  {% include [cli-gRPC-where-legend](../../_includes/application-load-balancer/cli-gRPC-where-legend.md) %}

  Result:

  ```text
  id: a5dqkr2mk3rr********
  name: <backend_group_name>
  folder_id: aoe197919j8e********
  ...
            grpc:
              service_name: <gRPC_service_name>
  ...
  created_at: "2021-02-11T20:46:21.688940670Z"
  ```

  {% endcut %}

  {% cut "Stream backend" %}

  Run this command:

  {% include [cli-code-Stream-backend-create](../../_includes/application-load-balancer/cli-code-Stream-backend-create.md) %}

  {% include [cli-Stream-where-legend](../../_includes/application-load-balancer/cli-Stream-where-legend.md) %}

  Result:

  ```text
  id: ds77tero4f5********
  name: <backend_group_name>
  folder_id: b1gu6g9ielh6********
  ...
              text: <data_to_endpoint>
            receive:
              text: <data_from_endpoint>
      enable_proxy_protocol: true
  created_at: "2022-04-06T09:17:57.104324513Z"
  ```

  {% endcut %}

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Open the {{ TF }} configuration file and add a section describing the backend (`http_backend`, `grpc_backend`, or `stream_backend`) to the backend group description:

     {% include [TF-update-code](../../_includes/application-load-balancer/TF-update-code.md) %}

     Where `yandex_alb_backend_group` specifies the backend group parameters:
     * `name`: Backend group name.
     * `http_backend`, `grpc_backend`, and `stream_backend`: [Backend type](../concepts/backend-group.md#group-types). All backends within the group must be of the same type: `HTTP`, `gRPC`, or `Stream`.

     {% include [TF-backend-settings](../../_includes/application-load-balancer/TF-backend-settings.md) %}

     For more information about the `yandex_alb_backend_group` resource parameters, see the [{{ TF }} provider documentation]({{ tf-provider-alb-backendgroup }}).
  1. Apply the changes:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     You can check the backend group updates using the [management console]({{ link-console-main }}) or this CLI command:

     ```bash
     yc alb backend-group get --name <backend_group_name>
     ```

- API {#api}

  To change the basic group parameters, use the [addBackend](../api-ref/BackendGroup/addBackend.md) REST API method for the [BackendGroup](../api-ref/BackendGroup/index.md) resource or the [BackendGroupService/Update](../api-ref/grpc/BackendGroup/addBackend.md) gRPC API call.

{% endlist %}

## Update parameters for a backend in a group {#update-backend}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where the backend was created.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/cubes-3-overlap.svg) **{{ ui-key.yacloud.alb.label_backend-groups }}**.
  1. Click the name of the group.
  1. Next to the backend name, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.edit }}**.
  1. In the window that opens, set the backend settings. For more information about the settings, see [above](#add-backend).
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for updating the backend parameters:

     ```bash
     yc alb backend-group update-<backend_type>-backend --help
     ```

  1. Set new parameters for the backend depending on its type:

     {% cut "HTTP backend" %}

     Run this command:

     ```bash
     yc alb backend-group update-http-backend \
       --backend-group-name <backend_group_name> \
       --name <name_of_backend_to_add> \
       --weight <backend_weight> \
       --port <backend_port> \
       --target-group-id=<target_group_ID> \
       --panic-threshold 90 \
       --http-healthcheck port=80,healthy-threshold=10,unhealthy-threshold=15,\
     timeout=10s,interval=2s,host=your-host.com,path=/ping
     ```

     {% include [cli-http-where-legend](../../_includes/application-load-balancer/cli-http-where-legend.md) %}

     Result:

     ```text
     id: a5dqkr2mk3rr********
     name: <backend_group_name>
     folder_id: aoe197919j8e********
     ...
             host: <host_address>
             path: <path>
     created_at: "2021-02-11T20:46:21.688940670Z"
     ```

     {% endcut %}

     {% cut "gRPC backend" %}

     Run this command:

     ```bash
     yc alb backend-group update-grpc-backend \
       --backend-group-name <backend_group_name> \
       --name <name_of_backend_to_add> \
       --weight <backend_weight> \
       --port <backend_port> \
       --target-group-id=<target_group_ID> \
       --panic-threshold 90 \
       --grpc-healthcheck port=80,healthy-threshold=10,unhealthy-threshold=15,\
     timeout=10s,interval=2s,service-name=<gRPC_service_name>
     ```

     {% include [cli-gRPC-where-legend](../../_includes/application-load-balancer/cli-gRPC-where-legend.md) %}

     Result:

     ```text
     id: a5dqkr2mk3rr********
     name: <backend_group_name>
     folder_id: aoe197919j8e********
     ...
               grpc:
                 service_name: <gRPC_service_name>
     ...
     created_at: "2021-02-11T20:46:21.688940670Z"
     ```

     {% endcut %}

     {% cut "Stream backend" %}

     Run this command:

     ```bash
     yc alb backend-group update-stream-backend \
       --backend-group-name <backend_group_name> \
       --name <name_of_backend_to_add> \
       --weight <backend_weight> \
       --port <backend_port> \
       --target-group-id=<target_group_ID> \
       --panic-threshold 90 \
       --enable-proxy-protocol \
       --stream-healthcheck port=80,healthy-threshold=10,unhealthy-threshold=15,\
     timeout=10s,interval=2s,send-text=<data_to_endpoint>,receive-text=<data_from_endpoint>
     ```

     {% include [cli-Stream-where-legend](../../_includes/application-load-balancer/cli-Stream-where-legend.md) %}

     Result:

     ```text
     id: ds77tero4f5********
     name: <backend_group_name>
     folder_id: b1gu6g9ielh6********
     ...
                 text: <data_to_endpoint>
               receive:
                 text: <data_from_endpoint>
         enable_proxy_protocol: true
     created_at: "2022-04-06T09:17:57.104324513Z"
     ```

     {% endcut %}

     {% include [backend-healthcheck](../../_includes/application-load-balancer/backend-healthcheck.md) %}

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Open the {{ TF }} configuration file and edit the parameters of the section describing the backend (`http_backend`, `grpc_backend`, or `stream_backend`) in the backend group description:

     {% include [TF-update-code](../../_includes/application-load-balancer/TF-update-code.md) %}

     Where `yandex_alb_backend_group` specifies the backend group parameters:
     * `name`: Backend group name.
     * `http_backend`, `grpc_backend`, and `stream_backend`: [Backend type](../concepts/backend-group.md#group-types). All backends within the group must be of the same type: `HTTP`, `gRPC`, or `Stream`.

     {% include [TF-backend-settings](../../_includes/application-load-balancer/TF-backend-settings.md) %}

     For more information about the `yandex_alb_backend_group` resource parameters, see the [{{ TF }} provider documentation]({{ tf-provider-alb-backendgroup }}).
  1. Apply the changes:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     You can check the backend group updates using the [management console]({{ link-console-main }}) or this CLI command:

     ```bash
     yc alb backend-group get --name <backend_group_name>
     ```

- API {#api}

  To change the backend parameters in the group, use the [updateBackend](../api-ref/BackendGroup/updateBackend.md) REST API method for the [UpdateBackend](../api-ref/BackendGroup/index.md) resource or the [BackendGroupService/UpdateBackend](../api-ref/grpc/BackendGroup/updateBackend.md) gRPC API call.

{% endlist %}

## Remove a backend from a group {#delete-backend}

To remove a backend from a group:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where the backend was created.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/cubes-3-overlap.svg) **{{ ui-key.yacloud.alb.label_backend-groups }}**.
  1. Click the name of the group.
  1. Next to the backend name, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.delete }}**.
  1. In the window that opens, click **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for removing a backend from a group:

     ```bash
     yc application-load-balancer delete-<backend_type>-backend --help
     ```

  1. Depending on the type of backend, run the command to delete it:
     * HTTP backend:

       ```bash
       yc alb backend-group delete-http-backend \
         --backend-group-name=<backend_group_name> \
         --name=<name_of_backend_to_delete>
       ```

     * gRPC backend:

       ```bash
       yc alb backend-group delete-grpc-backend \
         --backend-group-name=<backend_group_name> \
         --name=<name_of_backend_to_delete>
       ```

     * Stream backend:

       ```bash
       yc alb backend-group delete-stream-backend \
         --backend-group-name=<backend_group_name> \
         --name=<name_of_backend_to_delete>
       ```

     Result:

     ```text
     id: a5dqkr2mk3rr********
     name: <backend_name>
     folder_id: aoe197919j8e********
     created_at: "2021-02-11T20:46:21.688940670Z"
     ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Open the {{ TF }} configuration file and remove the section describing the backend (`http_backend`, `grpc_backend`, or `stream_backend`) from the backend group description.

     Sample backend group description in the {{ TF }} configuration:

     ```hcl
     resource "yandex_alb_backend_group" "test-backend-group" {
       name                     = "<backend_group_name>"

       http_backend {
         name                   = "<backend_name>"
         weight                 = 1
         port                   = 80
         target_group_ids       = ["<target_group_ID>"]
         load_balancing_config {
           panic_threshold      = 90
         }
         healthcheck {
           timeout              = "10s"
           interval             = "2s"
           healthy_threshold    = 10
           unhealthy_threshold  = 15
           http_healthcheck {
             path               = "/"
           }
         }
       }
     }
     ```

     For more information about the `yandex_alb_backend_group` resource parameters, see the [{{ TF }} provider documentation]({{ tf-provider-alb-backendgroup }}).
  1. Apply the changes:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     You can check the backend group updates using the [management console]({{ link-console-main }}) or this CLI command:

     ```bash
     yc alb backend-group get --name <backend_group_name>
     ```

- API {#api}

  Use the [removeBackend](../api-ref/BackendGroup/removeBackend.md) REST API method for the [BackendGroup](../api-ref/BackendGroup/index.md) resource or the [BackendGroupService/RemoveBackend](../api-ref/grpc/BackendGroup/removeBackend.md) gRPC API call.

{% endlist %}

### See also {#see-also}

* [{#T}](../concepts/best-practices.md)