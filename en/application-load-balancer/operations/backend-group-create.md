---
title: How to create a backend group in {{ alb-full-name }}
description: In this tutorial, you will learn how to create a backend group.
---

# Creating a backend group

To create a [backend group](../concepts/backend-group.md):

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create a backend group.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/cubes-3-overlap.svg) **{{ ui-key.yacloud.alb.label_backend-groups }}**.
  1. Click **{{ ui-key.yacloud.alb.button_backend-group-create }}**.
  1. Specify the backend group name.
  1. Select the [backend group type](../concepts/backend-group.md#group-types):
     * `{{ ui-key.yacloud.alb.label_proto-http }}`: For HTTP or HTTPS traffic.
     * `{{ ui-key.yacloud.alb.label_proto-grpc }}`: For HTTP or HTTPS traffic with [gRPC](https://{{ lang }}.wikipedia.org/wiki/GRPC).
     * `{{ ui-key.yacloud.alb.label_proto-stream }}`: For unencrypted TCP traffic or TCP traffic with TLS encryption support.
  1. Optinally, enable [session affinity](../concepts/backend-group.md#session-affinity). `{{ ui-key.yacloud.alb.label_proto-http-plain }}` and `{{ ui-key.yacloud.alb.label_proto-grpc }}` backend groups support the following session affinity modes:
     * `{{ ui-key.yacloud.alb.label_affinity-connection }}`.
     * `{{ ui-key.yacloud.alb.label_affinity-header }}`.
     * `{{ ui-key.yacloud.alb.label_affinity-cookie }}`.

     `{{ ui-key.yacloud.alb.label_proto-stream }}` backend groups support session affinity by client [IP address](../../vpc/concepts/address.md).

     {% include [session-affinity-prereqs](../../_includes/application-load-balancer/session-affinity-prereqs.md) %}

  1. Under **{{ ui-key.yacloud.alb.label_backends }}**, click **{{ ui-key.yacloud.common.add }}**. Specify the backend settings:

     {% include [backend-settings-console](../../_includes/application-load-balancer/backend-settings-console.md) %}

  1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  {% note info %}

  You can create a `gRPC` backend group in the [management console]({{ link-console-main }}) or using {{ TF }}.

  {% endnote %}

  1. See the description of the [CLI](../../cli/) command for creating a backend group:

     ```bash
     yc alb backend-group create --help
     ```

  1. Create a backend group by running this command:

     ```bash
     yc alb backend-group create <backend_group_name>
     ```

     Result:

     ```text
     id: a5dg2cv4ngne********
     name: test-backend-group
     folder_id: aoerb349v3h4********
     created_at: "2021-02-11T20:46:21.688940670Z"
     ```

  1. Add a backend and a health check to the group.

     {% include [backend-healthcheck](../../_includes/application-load-balancer/backend-healthcheck.md) %}

     All backends within a group must be of the same [type](../concepts/backend-group.md#group-types): `HTTP`, `gRPC`, or `Stream`.

     {% cut "HTTP backend" %}

     Run this command:

     {% include [cli-code-http-backend-create](../../_includes/application-load-balancer/cli-code-http-backend-create.md) %}

     {% include [cli-http-where-legend](../../_includes/application-load-balancer/cli-http-where-legend.md) %}

     Result:

     ```text
     id: a5dqkr2mk3rr********
     name: <backend_group_name>
     folder_id: aoe197919j8e********
     http:
       backends:
       - name: <backend_name>
         backend_weight: "1"
         load_balancing_config:
           panic_threshold: "90"
         port: "80"
         target_groups:
           target_group_ids:
           - a5d2iap3nue9********
         healthchecks:
         - timeout: 10s
           interval: 2s
           healthy_threshold: "10"
           unhealthy_threshold: "15"
           healthcheck_port: "80"
           http:
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
     grpc:
       backends:
         - name: <backend_name>
           backend_weight: "12"
           load_balancing_config:
             panic_threshold: "90"
           port: "80"
           target_groups:
             target_group_ids:
               - a5d2iap3nue9********
           healthchecks:
             - timeout: 10s
               interval: 2s
               healthy_threshold: "10"
               unhealthy_threshold: "15"
               healthcheck_port: "80"
               grpc:
                 service_name: <gRPC_service_name>
     created_at: "2023-06-17T13:04:08.567141292Z"
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
     stream:
       backends:
       - name: <backend_name>
     backend_weight: "1"
         port: "80"
         target_groups:
           target_group_ids:
           - ds7eof3r2cte********
         healthchecks:
           - timeout: 10s
             interval: 2s
             healthy_threshold: "10"
             unhealthy_threshold: "15"
             healthcheck_port: "80"
             stream:
               send:
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

  1. In the {{ TF }} configuration file, describe the resource you want to create:

     ```hcl
     resource "yandex_alb_backend_group" "test-backend-group" {
       name                     = "<backend_group_name>"
       session_affinity {
         connection {
           source_ip = <IP_address_session_affinity_mode>
         }
       }
       stream_backend {
         name                   = "<backend_name>"
         weight                 = 1
         port                   = 80
         target_group_ids       = ["<target_group_ID>"]
         load_balancing_config {
           panic_threshold      = 90
         }
         enable_proxy_protocol  = true
         healthcheck {
           timeout              = "10s"
           interval             = "2s"
           healthy_threshold    = 10
           unhealthy_threshold  = 15
           keep_connections_on_host_health_failure = <true_or_false>
           stream_healthcheck {
             send               = "<data_to_endpoint>"
             receive            = "<data_from_endpoint>"
           }
           http_healthcheck {
             path              = "<path>"
             host              = "<host>"
             expected_statuses = [<HTTP codes>]
           }
         }
       }
     }
     ```

     Where:
     * `yandex_alb_backend_group`: Backend group settings:
       * `name`: Backend group name.
       * `session_affinity`: [Session affinity](../../application-load-balancer/concepts/backend-group.md#session-affinity) settings. This is an optional parameter.

         {% include [session-affinity-prereqs](../../_includes/application-load-balancer/session-affinity-prereqs.md) %}

         * `connection`: Session affinity by the `source_ip` [IP address](../../vpc/concepts/address.md). It can be either `true` or `false`. You can also use `cookie` or `header` session affinity modes, but you can only specify one mode. If the backend group is of the `Stream` type, i.e., it consists of the `stream_backend` resources, you can only use the `connection` mode for session affinity.
       * `http_backend`, `grpc_backend`, and `stream_backend`: [Backend type](../concepts/backend-group.md#group-types). All backends within a group must match the same type: `HTTP`, `gRPC`, or `Stream`.

     {% include [TF-backend-settings](../../_includes/application-load-balancer/TF-backend-settings.md) %}

     For more information about `yandex_alb_backend_group` properties, see the relevant [{{ TF }} article]({{ tf-provider-alb-backendgroup }}).
  1. Create the resources:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} will create all the required resources. You can check new resources in the [management console]({{ link-console-main }}) or using this CLI command:

     ```bash
     yc alb backend-group list
     ```

- API {#api}

  Use the [create](../api-ref/BackendGroup/create.md) REST API method for the [BackendGroup](../api-ref/BackendGroup/index.md) resource or the [BackendGroupService/Create](../api-ref/grpc/BackendGroup/create.md) gRPC API call.

{% endlist %}

### See also {#see-also}

* [{#T}](../concepts/best-practices.md)