---
title: Deleting a lifecycle policy
description: Follow this guide to delete a lifecycle policy.
---

# Deleting a lifecycle policy

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where the [registry](../../concepts/registry.md) was created.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
   1. Select the registry and click the row with its name.
   1. Select the repository and click the row with its name.
   1. In the left-hand panel, click ![lifecycle](../../../_assets/console-icons/arrows-rotate-right.svg) **{{ ui-key.yacloud.cr.registry.label_lifecycle }}**.
   1. Click ![image](../../../_assets/console-icons/ellipsis.svg) for the appropriate [policy](../../concepts/lifecycle-policy.md) and select **{{ ui-key.yacloud.common.delete }}**.
   1. In the window that opens, click **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   1. Delete the [policy](../../concepts/lifecycle-policy.md) by specifying its ID:

      ```bash
      yc container repository lifecycle-policy delete <policy_ID>
      ```

      To find out the policy ID, get a [list of lifecycle policies in a repository or registry](lifecycle-policy-list.md#lifecycle-policy-list).
   1. Make sure that the policy was deleted:

      ```bash
      yc container repository lifecycle-policy list --repository-name crp2hlbs67tj********/ubuntu
      ```

      Result:

      ```text
      +----+------+---------------+--------+---------+-------------+
      | ID | NAME | REPOSITORY ID | STATUS | CREATED | DESCRIPTION |
      +----+------+---------------+--------+---------+-------------+
      +----+------+---------------+--------+---------+-------------+
      ```

- {{ TF }} {#tf}

   {% include [terraform-install](../../../_includes/terraform-install.md) %}

   1. Open the configuration file and delete the fragment with the policy description:

      {% cut "Sample policy description in the {{ TF }} configuration" %}

      ```hcl
      resource "yandex_container_repository_lifecycle_policy" "my_lifecycle_policy" {
        name          = "best-policy"
        status        = "active"
        repository_id = "crpfvi6o4ra7********"

        rule {
          description   = "rule for applying policy"
          untagged      = true
          tag_regexp    = ".*"
          retained_top  = 1
          expire_period = "48h"
        }
      }
      ```

      {% endcut %}

   1. Apply the changes:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

   This will delete the lifecycle policy from the specified [repository](../../concepts/repository.md). You can check the deletion of the policy using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/) command:

   ```bash
   yc container repository lifecycle-policy list --registry-id <registry_ID>
   ```

- API {#api}

   To delete a policy, use the [Delete](../../api-ref/grpc/lifecycle_policy_service.md#Delete) method for the [LifecyclePolicyService](../../api-ref/grpc/lifecycle_policy_service.md) resource. In the `lifecycle_policy_id` parameter, specify the policy ID.

   You can retrieve a list of policies using the [List](../../api-ref/grpc/lifecycle_policy_service.md#List) method for the [LifecyclePolicyService](../../api-ref/grpc/lifecycle_policy_service.md) resource.

{% endlist %}