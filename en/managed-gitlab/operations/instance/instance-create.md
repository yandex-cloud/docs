---
title: How to create a {{ mgl-full-name }} instance
description: In this tutorial, you will learn how to create a {{ mgl-name }} instance.
---

# Creating and activating a {{ mgl-name }} instance

## Creating a {{ GL }} instance {#create}

To create a {{ mgl-name }} instance, you need the [{{ roles-vpc-user }}](../../../vpc/security/index.md#vpc-user) role and the [{{ roles.gitlab.editor }} role or higher](../../security/index.md#roles-list). For more information on assigning roles, see the [{{ iam-name }} documentation](../../../iam/operations/roles/grant.md).

{% include [warn-subnet](../../../_includes/managed-gitlab/warn-subnet.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  {% include [instance-create-console](../../../_includes/managed-gitlab/instance-create-console.md) %}

- CLI {#cli}

  {% include [instance-create-cli](../../../_includes/managed-gitlab/instance-create-cli.md) %}

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To create a {{ GL }} instance:

  1. In the {{ TF }} configuration file, describe the resources you want to create:

     ```hcl
     resource "yandex_gitlab_instance" "my_gitlab_instance" {
       name                      = "<instance_name>"
       resource_preset_id        = "<host_class>"
       disk_size                 = <disk_size_in_GB>
       admin_login               = "<admin_login>"
       admin_email               = "<admin_email_address>"
       domain                    = "<instance_domain_name>"
       subnet_id                 = "<subnet_ID>"
       approval_rules_id         = "<approval_rule_configuration>"
       backup_retain_period_days = <backup_retention_period>
       deletion_protection       = <true_or_false>
     }
     ```

     Where:
     * `name`: Instance name, unique within {{ yandex-cloud }}. The naming requirements are as follows:

        {% include [name-format](../../../_includes/name-format.md) %}

     * `resource_preset_id`: Host class. Represents the configuration of the virtual machine to host the {{ GL }} instance. The possible values are:
        * `s2.micro`: 2 vCPUs, 8 GB RAM
        * `s2.small`: 4 vCPUs, 16 GB RAM
        * `s2.medium`: 8 vCPUs, 32 GB RAM
        * `s2.large`: 16 vCPUs, 64 GB RAM
     * `disk_size`: Disk size in GB.
     * `admin_login`: {{ GL }} instance admin login.
     * `admin_email`: Instance admin email address. This is the address to receive the email with a link to create a password.
     * `domain`: [Instance domain name](../../../compute/concepts/network.md#hostname) in `<name>.gitlab.yandexcloud.net` format. The system will automatically create the relevant DNS records for it in the `.gitlab.yandexcloud.net` domain.

        {% include [domain-name-format](../../../_includes/managed-gitlab/domain-name-format.md) %}

     * `subnet_id`: ID of the selected subnet.
     * `approval_rules_id`: [Approval rule](../../concepts/approval-rules.md) configuration. The possible values are:
        * `BASIC`
        * `STANDARD`
        * `ADVANCED`

        {% include [note-approval-rules-pricing](../../../_includes/managed-gitlab/note-approval-rules-pricing.md) %}

     * `backup_retain_period_days`: Automatic backup retention period, in days.
     * `deletion_protection`: Instance protection against accidental deletion by the user. The possible values are `true` or `false`.

     For more information about `yandex_gitlab_instance` properties, see the [relevant provider documentation]({{ tf-provider-resources-link }}/gitlab_instance).

  1. Create the resources:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} will create all the required resources. You can check the new resources using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/) command:

     ```bash
     {{ yc-mdb-gl }} instance list
     ```

- API {#api}

  Use the [Create](../../api-ref/Instance/create.md) REST API method for the [Instance](../../api-ref/Instance/index.md) resource or the [InstanceService/Create](../../api-ref/grpc/Instance/create.md) gRPC API call.

{% endlist %}

{% include [HTTPS info](../../../_includes/managed-gitlab/note-https.md) %}

## Activating the {{ GL }} instance {#activate}

After the instance status changes to **Running**, activate the instance:

1. Follow the link you received in your administrator mailbox after creating the instance.

   If you cannot open the {{ GL }} web interface, create a separate security group and [configure it](../configure-security-group.md) so that the rules allow incoming traffic from the required ports and IP addresses.

1. Change the administrator password.
1. Log in using the administrator username and password.

Further on, to open the {{ GL }} web interface, [get detailed information about your instance](instance-list.md#get) and follow the link in **{{ ui-key.yacloud.gitlab.field_domain }}**.
