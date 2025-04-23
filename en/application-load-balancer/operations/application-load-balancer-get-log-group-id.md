---
title: How to get a log group ID of an L7 load balancer in {{ alb-full-name }}
description: In this tutorial, you will learn how to get a log group ID of an L7 balancer.
---

# Getting a log group ID of an L7 load balancer

To get the ID of the {{ cloud-logging-full-name }} [log group](../../logging/concepts/log-group.md) receiving [logs](../concepts/application-load-balancer.md#logging) from the L7 load balancer:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder with your load balancer.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. Click the load balancer name you need.
  1. Under **{{ ui-key.yacloud.alb.section_logs-settings }}**, click the log group name in the **{{ ui-key.yacloud.alb.label_log-group }}** field.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for getting information about an L7 load balancer:

      ```bash
      yc alb load-balancer get --help
      ```

  1. Run this command with your load balancer name specified:

      ```bash
      yc alb load-balancer get <load_balancer_name>
      ```

      Result:

      ```text
      id: a5d88ep483cm********
      name: test-balancer2
      folder_id: aoe197919j8e********
      status: ACTIVE
      region_id: {{ region-id }}
      network_id: c64l1c06d151********
      allocation_policy:
        locations:
        - zone_id: {{ region-id }}-a
          subnet_id: buc4gsmpj8hv********
      log_group_id: eolul9ap0bv0********
      created_at: "2021-04-26T12:12:13.624832586Z"
      log_options:
        log_group_id: e23ujjda632o********
      ```

      You will see the {{ cloud-logging-name }} log group ID in the `log_group_id` field under `log_options`. Note that the `log_group_id` field following the `subnet_id` field contains a different ID referring to the outdated logging service.

- API {#api}

  Use the [get](../api-ref/LoadBalancer/get.md) REST API method for the [LoadBalancer](../api-ref/LoadBalancer/index.md) resource or the [LoadBalancerService/Get](../api-ref/grpc/LoadBalancer/get.md) gRPC API call.

  You will see the {{ cloud-logging-name }} log group ID in the `logGroupId` field under `logOptions`. Note that the `logGroupId` field outside `logOptions` contains a different ID referring to the outdated logging service.

{% endlist %}

If you kept the **{{ ui-key.yacloud.alb.label_default-log-group }}** value in the **{{ ui-key.yacloud.alb.label_log-group }}** field when creating an L7 load balancer, do the following to get its ID:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the folder with your load balancer.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_logging }}**.
  1. Save the `default` log group ID.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get the default log group ID, run this command:

  ```bash
  yc logging group get \
    --name=default \
    --folder-id=<folder_ID>
  ```

  Where:
  * `--name`: Default log group name, i.e., `default`.
  * `--folder-id`: [ID of the folder](../../resource-manager/operations/folder/get-id.md) with your load balancer.

  Result:

  ```text
  id: e23qfbb01na0********
  folder_id: b1gvgqhc5745********
  cloud_id: b1g3clmedscm********
  created_at: "2021-08-07T10:40:55.412Z"
  name: default
  description: Auto-created default group
  ```

{% endlist %}