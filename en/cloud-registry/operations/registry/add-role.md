---
title: How to assign roles for a registry in {{ cloud-registry-full-name }}
description: Follow this tutorial to assign roles for a registry.
---

# Assigning a role for a registry

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the registry.
  1. [Navigate]({{ link-console-main }}/link/cloud-registry) to **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-registry }}**.
  1. Select the registry.
  1. Navigate to the **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** tab.
  1. Click **{{ ui-key.yacloud_components.acl.action.assign-roles }}**.
  1. In the window that opens, select a group, user, or [service account](../../../iam/concepts/users/service-accounts.md).
  1. Click ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** and select role from the list.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  ```bash
  yc cloud-registry registry add-access-binding <registry_name_or_ID> \
    --role <role> \
    --subject <subject_type>:<subject_ID>
  ```

    Where:

    * `--role`: [Role](../../security/index.md#service-roles) you want to assign.
    * `--subject`: [Subject](../../../iam/concepts/access-control/index.md#subject) getting the role.

        {% cut "Subject designations" %}

        {% include [subjects-designations-cli](../../../_includes/iam/subjects-designations-cli.md) %}

        {% endcut %}

  To revoke all registry roles and assign new ones right away, use the `yc cloud-registry registry set-access-bindings` command.
  
  **Example**

  In the example below, we are assigning the `cloud-registry.admin` role for `my-first-registry` to a user.

  ```bash
  yc cloud-registry registry add-access-binding my-first-registry \
    --role cloud-registry.admin \
    --user-account-id ajeugsk5ubk6********
  ```

  Result:

  ```text
  done (4s)
  ```

- API {#api}

  Use the [updateAccessBindings](../../api-ref/Registry/updateAccessBindings.md) REST API method for the [Registry](../../api-ref/Registry/index.md) resource or the [RegistryService/UpdateAccessBindings](../../api-ref/grpc/Registry/updateAccessBindings.md) gRPC API call. In the request body, set the `action` property to `ADD` and specify the [subject](../../../iam/concepts/access-control/index.md#subject) type and ID under `subject`.

  {% cut "Subject designations" %}

  {% include [subjects-designations-api](../../../_includes/iam/subjects-designations-api.md) %}

  {% endcut %}

{% endlist %}

For more information on role assignment, see [this {{ iam-full-name }} guide](../../../iam/operations/roles/grant.md).
