---
title: Assigning a role
description: Follow this guide to assign a role for a resource.
---

# Assigning a role

To grant access to a resource, assign a [role](../../concepts/access-control/roles.md) for it. You can assign a role to:

* [Yandex account users](../../concepts/users/accounts.md#passport)
* [Local users](../../concepts/users/accounts.md#local)
* [Federated users](../../concepts/users/accounts.md#saml-federation)
* [Service accounts](../../concepts/users/service-accounts.md)
* [User groups](../../../organization/concepts/groups.md)

You can assign a role not only for the resource itself but also for its parent resource, as the former inherits access permissions from the latter. For example, if a service account gets a role for a cloud, it will also get permissions for all resources across the cloud’s folders. For more information, see [{#T}](../../concepts/access-control/index.md).

{% include [role-for-sa-note](../../../_includes/iam/role-for-sa-note.md) %}

[Learn](../../concepts/access-control/resources-with-access-control.md) which resources you can assign a role for.

Use the [role reference](../../roles-reference.md) to select roles.

{% note info %}

{% include [access-control-vs-roles-notice](../../../_includes/iam/access-control-vs-roles-notice.md) %}

{% endnote %}

## Assigning a role for a cloud {#cloud-or-folder}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), click ![image](../../../_assets/console-icons/layout-side-content-left.svg) or ![image](../../../_assets/console-icons/chevron-down.svg) in the top panel and select the cloud or folder.
   1. Navigate to the **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** tab.
   1. Click **{{ ui-key.yacloud.common.resource-acl.button_configure-access }}**.
   1. Select the group, user, or service account you need to grant access to a cloud or folder.
   1. Click ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** and select the roles.
   1. Click **{{ ui-key.yacloud_components.acl.action.apply }}**.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To assign a role for a cloud or folder:

   1. View the description of the CLI command for assigning roles:

      ```bash
      yc resource-manager <cloud_or_folder> add-access-binding --help
      ```

      Specify `cloud` or `folder` as needed.

   1. Get a list of available clouds or folders with their IDs:

      ```bash
      yc resource-manager <cloud_or_folder> list
      ```

   1. Get the [ID of the user](../../../organization/operations/users-get.md), [service account](../sa/get-id.md), user group, organization, or identity federation to which or the users of which you are assigning a role.
   1. To assign a role, run this command:

      ```bash
      yc resource-manager <cloud_or_folder> add-access-binding \
        --id <cloud_or_folder_ID> \
        --role <role_ID> \
        --subject <subject_type>:<subject_ID>
      ```

      Where:

      * `--id`: ID of the resource to assign the role for.
      * `--role`: ID of the role you need to assign, e.g., `{{ roles-cloud-owner }}`.
      * `--subject`: [Subject](../../concepts/access-control/index.md#subject) getting the role.

          {% cut "Subject designations" %}

          {% include [subjects-designations-cli](../../../_includes/iam/subjects-designations-cli.md) %}

          {% endcut %}

      For example, to assign the `viewer` role for a folder to a service account:

      ```bash
      yc resource-manager folder add-access-binding \
        --id b1g672qpemb4******** \
        --role viewer \
        --subject serviceAccount:aje8m5luj4qf********
      ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Describe the roles you are assigning in the configuration file:

      Here is an example of the configuration file structure:

      ```hcl
      // Assigning a role for the cloud
      resource "yandex_resourcemanager_cloud_iam_member" "cloud_member" {
        cloud_id = "<cloud_ID>"
        role     = "<role>"
        member   = "<subject>"
      }

      // Assigning a role for the folder
      resource "yandex_resourcemanager_folder_iam_member" "folder_member" {
        folder_id = "<folder_ID>"
        role      = "<role>"
        member    = "<subject>"
      }
      ```

      Where:

      * `cloud_id`: Cloud ID. You can get the list of available clouds using the `yc resource-manager cloud list` [CLI](../../../cli/quickstart.md) command. This is a required setting.
      * `folder_id`: Folder ID. You can get the list of available folders using the `yc resource-manager cloud list` [CLI](../../../cli/quickstart.md) command. This is a required setting.
      * `role`: Role you need to assign. You can get the list of roles using the `yc iam role list` [CLI](../../../cli/quickstart.md) command. In one resource, only one role can be assigned. This is a required setting.
      * `member`: [Subject](../../concepts/access-control/index.md#subject) getting the role. This is a required setting.

          {% cut "Subject designations" %}

          {% include [subjects-designations-terraform](../../../_includes/iam/subjects-designations-terraform.md) %}

          {% endcut %}

      For more on the properties of {{ TF }} resources, see [this provider guide]({{ tf-provider-link }}/tf-ref/yandex-cloud/overview).

  1. Create the resources:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      This will create the required resources in the organization.

- API {#api}

   To assign a role for a cloud, use the [updateAccessBindings](../../../resource-manager/api-ref/Cloud/updateAccessBindings.md) REST API method for the [Cloud](../../../resource-manager/api-ref/Cloud/index.md) resource or the [CloudService/UpdateAccessBindings](../../../resource-manager/api-ref/grpc/Cloud/updateAccessBindings.md) gRPC API call.

   To assign a role for a folder, use the [updateAccessBindings](../../../resource-manager/api-ref/Folder/updateAccessBindings.md) REST API method for the [Folder](../../../resource-manager/api-ref/Folder/index.md) resource or the [FolderService/UpdateAccessBindings](../../../resource-manager/api-ref/grpc/Folder/updateAccessBindings.md) gRPC API call.

   Provide the following in the request:

   * `ADD` value in the `accessBindingDeltas[].action` parameter to add a role.
   * Role in the `accessBindingDeltas[].accessBinding.roleId` parameter.
   * ID of the [subject](../../concepts/access-control/index.md#subject) getting the role in the `accessBindingDeltas[].accessBinding.subject.id` parameter.
   * Type of the subject getting the role in the `accessBindingDeltas[].accessBinding.subject.type` parameter.

        {% cut "Subject designations" %}

        {% include [subjects-designations-api](../../../_includes/iam/subjects-designations-api.md) %}

        {% endcut %}

{% endlist %}

## Assigning a role for an organization {#organization}

To grant access permissions for an organization, you need the `{{ roles-organization-admin }}` role or higher. For more information on role sequence, see [this {{ org-full-name }} document](../../../organization/security/index.md#roles-list).

To assign a role for an organization:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}) using an administrator or organization owner account.

  1. In the left-hand panel, select ![persons-lock](../../../_assets/console-icons/persons-lock.svg) **{{ ui-key.yacloud_org.pages.acl }}**.

  1. If the user, service account, or user group already has at least one role assigned, click ![icon-context-menu](../../../_assets/console-icons/ellipsis.svg) in the row with that user, service account, or group and select **{{ ui-key.yacloud_components.acl.action.assign-roles }}**.

      If the user, service account, or user group is not on the list, click **{{ ui-key.yacloud_components.acl.action.assign-roles }}** in the top-right corner of the page. In the window that opens, select the user, service account, or group from the list. Use the search bar if needed.

  1. Click ![plus](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** and select the [role](../../../iam/concepts/access-control/roles.md) to assign. You can assign multiple roles.

      You can find the description of the available roles in the [{{ yandex-cloud }} role reference](../../../iam/roles-reference.md).

  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To assign a role for an organization:

   1. View the description of the CLI command for assigning roles:

      ```bash
      yc organization-manager organization add-access-binding --help
      ```

   1. Get a list of available organizations with their IDs:

      ```bash
      yc organization-manager organization list
      ```

   1. Get the [ID of the user](../../../organization/operations/users-get.md), [service account](../sa/get-id.md), user group, organization, or identity federation to which or the users of which you are assigning a role.
   1. To assign a role, run this command:

      ```bash
      yc organization-manager organization add-access-binding \
        --id <organization_ID> \
        --role <role_ID> \
        --subject <subject_type>:<subject_ID>
      ```

      Where:

      * `--id`: ID of the resource to assign the role for.
      * `--role`: ID of the role you need to assign, e.g., `{{ roles-cloud-owner }}`.
      * `--subject`: [Subject](../../concepts/access-control/index.md#subject) getting the role.

          {% cut "Subject designations" %}

          {% include [subjects-designations-cli](../../../_includes/iam/subjects-designations-cli.md) %}

          {% endcut %}

      For example, to assign a service account the `viewer` role for the organization:

      ```bash
      yc organization-manager organization add-access-binding \
        --id org672qpemb4******** \
        --role viewer \
        --subject serviceAccount:aje8m5luj4qf********
      ```

- {{ TF }} {#tf}

   {% include [terraform-install](../../../_includes/terraform-install.md) %}

   To assign a role for an organization:

   1. Get the [ID of the user](../../../organization/operations/users-get.md), [service account](../sa/get-id.md), or user group you are assigning a role to.
   1. Describe the resource with the role for the organization in the configuration file.

      Here is an example of the configuration file structure:

      ```hcl
      resource "yandex_organizationmanager_organization_iam_binding" "<resource_name>" {
        organization_id = "<organization_ID>"
        role            = "<role>"
        member          = "<subject>"
      }
      ```

      Where:

      * `organization_id`: [Organization ID](../../../organization/operations/organization-get-id.md). This is a required setting.
      * `role`: Role. For each role, you can only use one `yandex_organizationmanager_organization_iam_binding` resource. This is a required setting.
      * `member`: [Subject](../../concepts/access-control/index.md#subject) getting the role. This is a required setting.

          {% cut "Subject designations" %}

          {% include [subjects-designations-terraform](../../../_includes/iam/subjects-designations-terraform.md) %}

          {% endcut %}

      For more information, see [this provider guide]({{ tf-provider-link }}).

  1. Create the resources:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      This will create the required resources in the organization. You can check the new resources using the [management console]({{ link-console-main }}) or this CLI command:

      ```bash
      yc organization-manager organization list-access-bindings <organization_name_or_ID>
      ```

- API {#api}

   To assign a role for an organization, use the [updateAccessBindings](../../../organization/api-ref/Organization/updateAccessBindings.md) REST API method for the [Organization](../../../organization/api-ref/Organization/index.md) resource or the [OrganizationService/UpdateAccessBindings](../../../organization/api-ref/grpc/Organization/updateAccessBindings.md) gRPC API call and provide the following in the request:

   * `ADD` value in the `accessBindingDeltas[].action` parameter to add a role.
   * Role in the `accessBindingDeltas[].accessBinding.roleId` parameter.
   * ID of the [subject](../../concepts/access-control/index.md#subject) getting the role in the `accessBindingDeltas[].accessBinding.subject.id` parameter.
   * Type of the subject getting the role in the `accessBindingDeltas[].accessBinding.subject.type` parameter.

        {% cut "Subject designations" %}

        {% include [subjects-designations-api](../../../_includes/iam/subjects-designations-api.md) %}

        {% endcut %}

{% endlist %}

## Assigning a role for a resource {#resource}

You can assign a role not only for an organization, cloud, or folder but their child resources as well. These are listed in [{#T}](../../concepts/access-control/resources-with-access-control.md).

{% list tabs group=instructions %}

- Management console {#console}

   To assign a role for a resource:

   1. In the [management console]({{ link-console-main }}), click ![image](../../../_assets/console-icons/layout-side-content-left.svg) or ![image](../../../_assets/console-icons/chevron-down.svg) in the top panel and select the folder containing the resource.
   1. Open the resource page.
   1. Navigate to ![image](../../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** and click **{{ ui-key.yacloud_components.acl.action.assign-roles }}**.
   1. Select the group, user, or service account you need to grant access to the resource.
   1. Click ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** and select the roles.
   1. Click **{{ ui-key.yacloud_components.acl.action.apply }}**.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To assign a role for a resource:

   1. View the description of the CLI command for assigning roles:

      ```bash
      yc <service_name> <resource> add-access-binding --help
      ```

      Here is an example for a [{{ compute-full-name }} VM](../../../compute/concepts/vm.md):

      ```bash
      {{ yc-compute-instance }} add-access-binding --help
      ```

   1. Get a list of resources with their IDs:

      ```bash
      yc <service_name> <resource> list
      ```

   1. Get the [ID of the user](../../../organization/operations/users-get.md), [service account](../sa/get-id.md), user group, organization, or identity federation to which or the users of which you are assigning a role.
   1. To assign a role, run this command:

      ```bash
      yc <service_name> <resource> add-access-binding \
        --id <resource_ID> \
        --role <role_ID> \
        --subject <subject_type>:<subject_ID>
      ```

      Where:

      * `--id`: ID of the resource to assign the role for.
      * `--role`: ID of the role you need to assign, e.g., `{{ roles-cloud-owner }}`.
      * `--subject`: [Subject](../../concepts/access-control/index.md#subject) getting the role.

          {% cut "Subject designations" %}

          {% include [subjects-designations-cli](../../../_includes/iam/subjects-designations-cli.md) %}

          {% endcut %}

      For example, to assign a service account the `viewer` role for the VM:

      ```bash
      yc compute instance add-access-binding \
        --id ins672qpemb4******** \
        --role viewer \
        --subject serviceAccount:aje8m5luj4qf********
      ```

- {{ TF }} {#tf}

   {% include [terraform-install](../../../_includes/terraform-install.md) %}

   To assign a role for an organization:

   1. Get the [ID of the user](../../../organization/operations/users-get.md), [service account](../sa/get-id.md), or user group you are assigning a role to.
   1. Describe the resource with the role for the organization in the configuration file.

      Here is an example of the configuration file structure for assigning a role for a folder:

      ```hcl
      resource "yandex_resourcemanager_folder_iam_member" "admin-account-iam" {
        folder_id   = "<folder_ID>"
        role        = "<role>"
        member      = "<subject>"
      }
      ```

      Where:

      * `folder_id`: [Folder ID](../../../resource-manager/operations/folder/get-id.md). This is a required setting.
      * `role`: Role. For each role, you can only use one `yandex_organizationmanager_organization_iam_binding` resource. This is a required setting.
      * `member`: [Subject](../../concepts/access-control/index.md#subject) getting the role. This is a required setting.

          {% cut "Subject designations" %}

          {% include [subjects-designations-terraform](../../../_includes/iam/subjects-designations-terraform.md) %}

          {% endcut %}

      For more information, see [this provider guide]({{ tf-provider-link }}).

  1. Create the resources:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      This will create the required resources in the organization. You can check the new resources using the [management console]({{ link-console-main }}) or CLI commands.

- API {#api}

   To assign a role for a resource, use the `updateAccessBindings` REST API method or gRPC API call for the resource and provide the following in the request:

   * `ADD` value in the `accessBindingDeltas[].action` parameter to add a role.
   * Role in the `accessBindingDeltas[].accessBinding.roleId` parameter.
   * ID of the [subject](../../concepts/access-control/index.md#subject) getting the role in the `accessBindingDeltas[].accessBinding.subject.id` parameter.
   * Type of the subject getting the role in the `accessBindingDeltas[].accessBinding.subject.type` parameter.

        {% cut "Subject designations" %}

        {% include [subjects-designations-api](../../../_includes/iam/subjects-designations-api.md) %}

        {% endcut %}

{% endlist %}

## Assigning multiple roles {#multiple-roles}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder containing your resource.
   1. Open the resource page.
   1. Navigate to ![image](../../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** and click **{{ ui-key.yacloud_components.acl.action.assign-roles }}**.
   1. Select the group, user, or service account you need to grant access to the resource.
   1. Click ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** and select the roles.
   1. Click **{{ ui-key.yacloud_components.acl.action.apply }}**.

- CLI {#cli}

   {% include [set-access-bindings-cli](../../../_includes/iam/set-access-bindings-cli.md) %}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To assign multiple roles for a resource:

   1. Make sure the resource has no roles assigned that you would not want to lose:

      ```bash
      yc <service_name> <resource> list-access-bindings \
         --id <resource_ID>
      ```

      Here is an example for a [{{ compute-full-name }} VM](../../../compute/concepts/vm.md):

      ```bash
      {{ yc-compute-instance }} list-access-bindings \
         --id <VM_ID>
      ```

   1. View the description of the CLI command for assigning roles:

      ```bash
      yc <service_name> <resource> set-access-bindings --help
      ```

   1. Get a list of resources with their IDs:

      ```bash
      yc <service_name> <resource> list
      ```

   1. Get the [ID of the user](../../../organization/operations/users-get.md), [service account](../sa/get-id.md), user group, organization, or identity federation to which or the users of which you are assigning a role.

   1. To assign a role, run this command:

      ```bash
      yc <service_name> <resource> set-access-bindings \
        --id <resource_ID> \
        --access-binding role=<role>,subject=<subject_type>:<subject_ID>
      ```

      Where:

      * `--id`: ID of the resource to assign the role for.
      * `role`: ID of the role you need to assign, e.g., `{{ roles-cloud-owner }}`.
      * `subject`: [Subject](../../concepts/access-control/index.md#subject) getting the role.

          {% cut "Subject designations" %}

          {% include [subjects-designations-cli](../../../_includes/iam/subjects-designations-cli.md) %}

          {% endcut %}

      Provide a separate `--access-binding` parameter for each role. For example, to assign a service account multiple roles for a VM:

      ```bash
      yc compute instance set-access-bindings \
         --id ins672qpemb4******** \
         --access-binding role=compute.disks.user,subject=<subject_type>:aje8m5luj4qf******** \
         --access-binding role=compute.images.user,subject=<subject_type>:aje8m5luj4qf******** \
         --access-binding role=compute.operator,subject=<subject_type>:aje8m5luj4qf********
      ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Describe the roles you are assigning in the configuration file:

      Here is an example of the configuration file structure for assigning multiple roles for a cloud:

      ```hcl
      resource "yandex_resourcemanager_cloud_iam_member" "cloud_member_1" {
        cloud_id = "<cloud_ID>"
        role     = "<role_1>"
        members  = ["<subject_1>","<subject_2>,...,<subject_n>"]
      }

      resource "yandex_resourcemanager_cloud_iam_member" "cloud_member_2" {
        cloud_id  = "<cloud_ID>"
        role      = "<role_2>"
        members   = ["<subject_1>","<subject_2>,...,<subject_n>"]
      }
      ```

      Where:

      * `cloud_id`: Cloud ID. You can get the list of available clouds using the `yc resource-manager cloud list` [CLI](../../../cli/quickstart.md) command. This is a required setting.
      * `role`: Role you need to assign. You can get a list of roles using the [CLI](../../../cli/quickstart.md) command: `yc iam role list`. In one `yandex_resourcemanager_cloud_iam_member` resource, only one role can be assigned. This is a required setting.
      * `members`: List of [subjects](../../concepts/access-control/index.md#subject) getting the role. This is a required setting.

          {% cut "Subject designations" %}

          {% include [subjects-designations-terraform](../../../_includes/iam/subjects-designations-terraform.md) %}

          {% endcut %}

      For more on the properties of {{ TF }} resources, see [this provider guide]({{ tf-provider-link }}/tf-ref/yandex-cloud/overview).

  1. Create the resources:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      This will create the required resources in the organization.

- API {#api}

   {% include [set-access-bindings-api](../../../_includes/iam/set-access-bindings-api.md) %}

   To assign multiple roles for a resource, use the `setAccessBindings` REST API method or gRPC API call for the resource. In your request, provide an array of objects, each one matching a particular role and containing the following data:

   * Role in the `accessBindings[].roleId` parameter.
   * ID of the [subject](../../concepts/access-control/index.md#subject) getting the roles in the `accessBindings[].subject.id` parameter.
   * Type of the subject getting the roles in the `accessBindings[].subject.type` parameter.

        {% cut "Subject designations" %}

        {% include [subjects-designations-api](../../../_includes/iam/subjects-designations-api.md) %}

        {% endcut %}

{% endlist %}
