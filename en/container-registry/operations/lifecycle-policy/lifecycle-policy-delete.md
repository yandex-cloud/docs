# Deleting a lifecycle policy

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where the [registry](../../concepts/registry.md) was created.
  1. In the list of services, select **{{ container-registry-name }}**.
  1. Select the registry and click the row with its name.
  1. Select the repository and click the row with its name.
  1. In the left-hand panel, click ![lifecycle](../../../_assets/container-registry/lifecycle.svg) **Lifecycle**.
  1. Click ![image](../../../_assets/options.svg) for the appropriate [policy](../../concepts/lifecycle-policy.md) and select **Delete**.
  1. In the window that opens, click **Delete**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  1. Delete the policy by specifying its ID:

     ```bash
     yc container repository lifecycle-policy delete <policy ID>
     ```

     To find out the policy ID, get a [list of lifecycle policies in a repository or registry](lifecycle-policy-list.md#lifecycle-policy-list).
  1. Make sure that the policy was deleted:

     ```bash
     yc container repository lifecycle-policy list --repository-name crp2hlbs67tj4ggrfodb/ubuntu
     ```

     Result:

     ```bash
     +----+------+---------------+--------+---------+-------------+
     | ID | NAME | REPOSITORY ID | STATUS | CREATED | DESCRIPTION |
     +----+------+---------------+--------+---------+-------------+
     +----+------+---------------+--------+---------+-------------+
     ```

- API

  To delete a policy, use the [Delete](../../api-ref/grpc/lifecycle_policy_service.md#Delete) method for the [LifecyclePolicyService](../../api-ref/grpc/lifecycle_policy_service.md) resource. In the `lifecycle_policy_id` parameter, specify a policy ID.

  You can retrieve a list of policies using the [List](../../api-ref/grpc/lifecycle_policy_service.md#List) method for the [LifecyclePolicyService](../../api-ref/grpc/lifecycle_policy_service.md) resource.

{% endlist %}