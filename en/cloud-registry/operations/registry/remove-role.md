---
title: How to revoke registry roles in {{ cloud-registry-full-name }}
description: Follow this guide to revoke roles for a registry.
---

# Revoking a registry role

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where the registry is located.
  1. [Navigate]({{ link-console-main }}/link/cloud-registry) to **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-registry }}**.
  1. Select the registry.
  1. Navigate to the **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** tab.
  1. Select a user from the list and click ![image](../../../_assets/console-icons/ellipsis.svg) next to the username.
  1. Click **{{ ui-key.yacloud_components.acl.action.edit-roles }}**.
  1. Click ![image](../../../_assets/console-icons/xmark.svg) next to the role to revoke.
  1. Click **{{ ui-key.yacloud_components.acl.AclEditDialogNew.action_apply }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View assigned roles:

     ```bash
     yc cloud-registry registry list-access-bindings <registry_name_or_ID>
     ```

  1. Revoke a role:

     ```bash
     yc cloud-registry registry remove-access-binding <registry_name_or_ID> \
       --role <role> \
       --subject <subject_type>:<subject_ID>
     ```

     Where:

     * `--role`: [Role](../../security/index.md#service-roles) you want to revoke.
     * `--subject`: [Subject](../../../iam/concepts/access-control/index.md#subject) to revoke the role from.

         {% cut "Subject designations" %}

         {% include [subjects-designations-cli](../../../_includes/iam/subjects-designations-cli.md) %}

         {% endcut %}

    To revoke all registry roles and assign new ones right away, use the `yc cloud-registry registry set-access-bindings` command.
     
     **Example**

     The example below revokes the `cloud-registry.admin` role for `my-first-registry` from the user.
     
     ```bash
     yc cloud-registry registry remove-access-binding my-first-registry \
       --role cloud-registry.admin \
       --user-account-id ajeugsk5ubk6********
     ```

     Result:

     ```text
     done (9s)
     ```

- API {#api}

  [View](list-role.md#api) the roles assigned for the registry.
  
  To revoke roles assigned for a registry, use the [updateAccessBindings](../../api-ref/Registry/updateAccessBindings.md) REST API method for the [Registry](../../api-ref/Registry/index.md) resource or the [RegistryService/UpdateAccessBindings](../../api-ref/grpc/Registry/updateAccessBindings.md) gRPC API call. In the request body, set the `action` property to `REMOVE` and specify the [subject](../../../iam/concepts/access-control/index.md#subject) type and ID under `subject`.

  {% cut "Subject designations" %}

  {% include [subjects-designations-api](../../../_includes/iam/subjects-designations-api.md) %}

  {% endcut %}

{% endlist %}

For more information on revoking roles, see [this {{ iam-full-name }} guide](../../../iam/operations/roles/revoke.md).
