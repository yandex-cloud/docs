# Deleting a lifecycle policy

To access the [policy](../../concepts/lifecycle-policy.md), use its ID. For information about getting a policy ID, see [{#T}](lifecycle-policy-list.md).

{% list tabs %}

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   1. Delete the policy by specifying its ID:

      ```bash
      yc container repository lifecycle-policy delete crp6lg1868p3i0emkv1b
      ```

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