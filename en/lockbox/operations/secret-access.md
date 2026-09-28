---
title: Configuring access to a secret
description: Follow this guide to configure access to a secret.
---

# Configuring access to a secret

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder the secret belongs to.
  1. [Navigate]({{ link-console-main }}/link/lockbox) to **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}**.
  1. Click the name of the secret you need.
  1. Navigate to the **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** tab and click **{{ ui-key.yacloud_components.acl.action.assign-roles }}**.
  1. In the **{{ ui-key.yacloud_components.acl.label.subject }}** field of the window that opens, select a group, user, or [service account](../../iam/concepts/users/service-accounts.md) to provide with access to the secret.
  1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** and select the required [roles](../security/index.md#roles-list).
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. {% include [get-secret-id](../../_includes/lockbox/get-secret-id.md) %}

  1. To assign a role for a secret, run this command:

      ```bash
      yc lockbox secret add-access-binding \
        --id <secret_ID> \
        --role <role> \
        --subject <subject_type>:<subject_ID>
      ```

      Where:

      * `--id`: Secret ID.
      * `--role`: [Role](../security/index.md#roles-list).
      * `--subject`: [Subject](../../iam/concepts/access-control/index.md#subject) getting the role.

          {% cut "Subject designations" %}

          {% include [subjects-designations-cli](../../_includes/iam/subjects-designations-cli.md) %}

          {% endcut %}

- {{ TF }} {#tf}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Describe access permissions for the secret in the {{ TF }} configuration file:

      ```hcl
      resource "yandex_lockbox_secret_iam_member" "secret-viewer" {
        secret_id = "<secret_ID>"
        role      = "<role>"
        member    = "<subject_type>:<subject_ID>"
      }
      ```

      Where:

      * `secret_id`: Secret ID.
      * `role`: [Role](../security/index.md#roles-list).
      * `member`: [Subject](../../iam/concepts/access-control/index.md#subject) getting the role.

          {% cut "Subject designations" %}

          {% include [subjects-designations-terraform](../../_includes/iam/subjects-designations-terraform.md) %}

          {% endcut %}

      For more on the properties of the `yandex_lockbox_secret_iam_member` resource, see [this provider guide]({{ tf-provider-resources-link }}/lockbox_secret_iam_member).

  1. Create the resources

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}
      
      {{ TF }} will create all the required resources. You can check the new resources and their settings using the [management console]({{ link-console-main }}) or this [CLI](../../cli/quickstart.md) command:

      ```bash
      yc lockbox secret list-access-binding <secret_ID>
      ```

- API {#api}

  To configure access to a secret, use the [setAccessBindings](../api-ref/Secret/setAccessBindings.md) REST API method for the [Secret](../api-ref/Secret/index.md) resource or the [SecretService/SetAccessBindings](../api-ref/grpc/Secret/setAccessBindings.md) gRPC API call. In the request body, specify the [subject](../../iam/concepts/access-control/index.md#subject) type and ID under `subject`.

  {% cut "Subject designations" %}

  {% include [subjects-designations-api](../../_includes/iam/subjects-designations-api.md) %}

  {% endcut %}

{% endlist %}

{% note warning %}

If you [assign](../../iam/operations/roles/grant.md) a group, user, or service account a role for a [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) or [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) where the secret is stored, all permissions of this role will also apply to the secret.

For more information, see [How access management works](../../iam/concepts/access-control/#inheritance).

{% endnote %}

#### Useful links {#see-also}

* [{#T}](../concepts/secret.md)
* [{#T}](../../iam/concepts/access-control/index.md)
* [{#T}](../security/index.md)
