---
title: "How to get a log group ID for an L7 load balancer in {{ alb-full-name }}"
description: "Follow this guide to get the ID of a log group for an L7 balancer."
---

# Getting log group ID of an L7 load balancer

To get the ID of the {{ cloud-logging-full-name }} [log group](../../logging/concepts/log-group.md) to which the L7 load balancer sends its [logs](../concepts/application-load-balancer.md#logging):

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where the load balancer was created.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
   1. Click the name of the load balancer you need.
   1. Under **{{ ui-key.yacloud.alb.section_logs-settings }}**, click the log group name in the **{{ ui-key.yacloud.alb.label_log-group }}** field.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. See the description of the CLI command to get information about the L7 load balancer:

      ```bash
      yc alb load-balancer get --help
      ```

   1. Run the command, specifying the name of the load balancer:

      ```bash
      yc alb load-balancer get <load_balancer_name>
      ```

      Result:

      ```bash
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
        - zone_id: {{ region-id }}-b
          subnet_id: blt6pcatjje6********
        - zone_id: {{ region-id }}-c
          subnet_id: fo2ap2nrhjk9********
      log_group_id: eolul9ap0bv0********
      created_at: "2021-04-26T12:12:13.624832586Z"
      log_options:
        log_group_id: e23ujjda632o********
      ```

      The ID of the {{ cloud-logging-name }} log group will be specified under `log_options` in the `log_group_id` field. Please note that the `log_group_id` field that follows the `subnet_id` field contains a different ID that refers to the outdated logging service.

- API {#api}

   Use the [get](../api-ref/LoadBalancer/get.md) REST API method for the [LoadBalancer](../api-ref/LoadBalancer/index.md) resource or the [LoadBalancerService/Get](../api-ref/grpc/load_balancer_service.md#Get) gRPC API call.

   The ID of the {{ cloud-logging-name }} log group will be specified under `logOptions` in the `logGroupId` field. Please note that the `logGroupId` field that is outside the `logOptions` section contains a different ID that refers to the outdated logging service.

{% endlist %}

If, when creating an L7 load balancer, you kept the **{{ ui-key.yacloud.alb.label_default-log-group }}** value in the **{{ ui-key.yacloud.alb.label_log-group }}** field, do the following to find out its ID:

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), go to the folder where the load balancer was created.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_logging }}**.
   1. Save the ID of the log group named `default`.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get the ID of the default log group, run this command:

   ```bash
   yc logging group get \
     --name=default \
     --folder-id=<folder_ID>
   ```

   Where:
   * `--name`: Name of the default log group: `default`.
   * `--folder-id`: [ID of the folder](../../resource-manager/operations/folder/get-id.md) where the load balancer was created.

   Result:

   ```bash
   id: e23qfbb01na0********
   folder_id: b1gvgqhc5745********
   cloud_id: b1g3clmedscm********
   created_at: "2021-08-07T10:40:55.412Z"
   name: default
   description: Auto-created default group
   ```

{% endlist %}