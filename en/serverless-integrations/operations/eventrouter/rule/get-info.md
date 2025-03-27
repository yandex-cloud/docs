---
title: How to get information about a rule
description: Follow this guide to get information about a {{ er-full-name }} rule.
---

# Getting information about a rule

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the [rule](../../../concepts/eventrouter/rule.md).
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. In the left-hand panel, click ![image](../../../../_assets/console-icons/object-align-center-vertical.svg) **{{ ui-key.yacloud.serverless-event-router.label_service }}**.
  1. Select ![image](../../../../_assets/console-icons/target-dart.svg) **{{ ui-key.yacloud.serverless-event-router.label_rules }}** on the left.
  1. Select the rule. The **{{ ui-key.yacloud.common.overview }}** page will display detailed information about the rule.

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command to view information about a [rule](../../../concepts/eventrouter/rule.md):

     ```bash
     yc serverless eventrouter rule get --help
     ```

  1. {% include [get-rules-list](../../../../_includes/serverless-integrations/get-rules-list.md) %}

  1. Get detailed information about the rule by specifying its name or ID:

     ```bash
     yc serverless eventrouter rule get <rule_ID>
     ```

     Result:

     ```text
     id: f66ir9eeie4e********
     bus_id: f662ctjn8vv4********
     folder_id: b1geoelk7fld********
     cloud_id: b1gia87mbaom********
     created_at: "2025-02-20T12:26:40.769479Z"
     name: rule1
     targets:
       - logging:
           folder_id: b1geoelk7fld********
           service_account_id: ajebg060mvrb********
         status: ENABLED
     status: ENABLED
     ```

- API {#api}

  To get information about a [rule](../../../concepts/eventrouter/rule.md), use the [get](../../../../serverless-integrations/eventrouter/api-ref/Rule/get.md) REST API method for the [Rule](../../../../serverless-integrations/eventrouter/api-ref/Rule/index.md) resource or the [RuleService/Get](../../../../serverless-integrations/eventrouter/api-ref/grpc/Rule/get.md) gRPC API call.

{% endlist %}