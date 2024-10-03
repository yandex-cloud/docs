---
title: How to get information about a security group in {{ vpc-full-name }}
---

# Getting information about a security group

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) containing the [security group](../concepts/security-groups.md).
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud.vpc.switch_security-groups }}**.
   1. Select the security group you need.
   1. The **{{ ui-key.yacloud.common.overview }}** page will display detailed information about the security group.

- CLI {#cli}

   {% include [include](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View the description of the [CLI](../../cli/) command to get information about a [security group](../concepts/security-groups.md):

      ```bash
      yc vpc security-group get --help
      ```

   1. Get information about your security group by specifying its name or ID:

      ```bash
      yc vpc security-group get <security_group_name>
      ```

      Result:

      ```text
      id: enplgn3uok7u********
      folder_id: b1go3el0d8fs********
      created_at: "2023-03-24T11:56:01Z"
      name: default-sg-enpols3n07b8********
      description: Default security group for network
      network_id: enpols3n07b8********
      status: ACTIVE
      default_for_network: true
      ```

- {{ TF }} {#tf}

   {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   To get information about a [security group](../concepts/security-groups.md) using {{ TF }}:

   1. Add the `data` and `output` sections to the {{ TF }} configuration file:

      ```hcl
      data "yandex_vpc_security_group" "group1" {
        security_group_id = "<security_group_ID>"
      }

      output "group" {
        value = data.yandex_vpc_security_group.group1.ingress
      }
      ```

      Where:
      * `data "yandex_vpc_security_group"`: Description of the security group as a data source:
         * `security_group_id`: Security group ID.
      * `output "group"`: Output variable that contains information about the incoming traffic rules:
         * `value`: Returned value.

      You can replace `ingress` with any other parameter to get the information you need. For more information about the `yandex_vpc_security_group` data source parameters, see the [provider documentation]({{ tf-provider-datasources-link }}/datasource_vpc_security_group).

   1. Create resources:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create the required resources and display the output variable values in the terminal. To check the results, run:

      ```bash
      terraform output
      ```

      Result:

      ```text
      group = toset([
        {
          "description" = ""
          "from_port" = -1
          "id" = "enpt1jlfgv3e*********"
          "labels" = tomap({})
          "port" = 8000
          "predefined_target" = "self_security_group"
          "protocol" = "ANY"
          "security_group_id" = ""
          "to_port" = -1
          "v4_cidr_blocks" = tolist([])
          "v6_cidr_blocks" = tolist([])
        },
      ])
      ```

- API {#api}

   To get detailed information about a [security group](../concepts/security-groups.md), use the [get](../api-ref/SecurityGroup/get) REST API method for the [SecurityGroup](../api-ref/SecurityGroup/index.md) resource or the [SecurityGroupService/Get](../api-ref/grpc/security_group_service.md#Get) gRPC API call.

{% endlist %}

## Getting information about a security group rule {#rule}

{% list tabs group=instructions %}

- {{ TF }} {#tf}

   {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   To get information about a [security group rule](../concepts/security-groups.md#security-groups-structure) using {{ TF }}:

   1. Add the `data` and `output` sections to the {{ TF }} configuration file:

      ```hcl
      data "yandex_vpc_security_group_rule" "rule1" {
        security_group_binding = "<security_group_ID>"
        rule_id                = "<rule_ID>"
      }

      output "rule" {
        value = data.yandex_vpc_security_group_rule.rule1.direction
      }
      ```

      Where:
      * `data "yandex_vpc_security_group_rule"`: Description of the security group rule as a data source:
         * `security_group_binding`: ID of the security group containing the rule.
         * `rule_id`: Rule ID.
      * `output "rule"`: Output variable that contains information about the rule direction:
         * `value`: Returned value.

      You can replace `direction` with any other parameter to get the information you need. For more information about the `datasource_vpc_security_group_rule` data source parameters, see the [provider documentation]({{ tf-provider-datasources-link }}/datasource_vpc_security_group_rule).

   1. Create resources:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create the required resources and display the output variable values in the terminal. To check the results, run:

      ```bash
      terraform output
      ```

      Result:

      ```text
      rule = "ingress"
      ```

{% endlist %}
