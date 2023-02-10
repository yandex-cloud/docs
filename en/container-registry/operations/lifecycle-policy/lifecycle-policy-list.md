# Getting information about lifecycle policies

Find out how to get:
* [A list of lifecycle policies in a repository or registry](#lifecycle-policy-list).
* [Details about a lifecycle policy](#lifecycle-policy-get).

## Retrieving a list of lifecycle policies in a repository or registry {#lifecycle-policy-list}

{% list tabs %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  * Retrieve a list of [lifecycle policies](../../concepts/lifecycle-policy.md) in a repository:

    ```bash
    yc container repository lifecycle-policy list --repository-name crp2hlbs67tj4ggrfodb/ubuntu
    ```

    Command output:

    ```bash
    +----------------------+-------------+----------------------+----------+---------------------+-------------------------------+
    |          ID          |    NAME     |    REPOSITORY ID     |  STATUS  |       CREATED       |          DESCRIPTION          |
    +----------------------+-------------+----------------------+----------+---------------------+-------------------------------+
    | crp6lg1868p3i0emkv1b | test-policy | crp3cpm16edqql0t30s2 | DISABLED | 2020-05-28 15:05:58 | disabled lifecycle-policy for |
    |                      |             |                      |          |                     | tests                         |
    +----------------------+-------------+----------------------+----------+---------------------+-------------------------------+
    ```

  * Retrieve a list of lifecycle policies in a registry:

    ```bash
    yc container repository lifecycle-policy list --registry-id crp2hlbs67tj4ggrfodb
    ```

    Command output:

    ```bash
    +----------------------+-------------+----------------------+----------+---------------------+-------------------------------+
    |          ID          |    NAME     |    REPOSITORY ID     |  STATUS  |       CREATED       |          DESCRIPTION          |
    +----------------------+-------------+----------------------+----------+---------------------+-------------------------------+
    | crp6lg1868p3i0emkv1b | test-policy | crp3cpm16edqql0t30s2 | DISABLED | 2020-05-28 15:05:58 | disabled lifecycle-policy for |
    |                      |             |                      |          |                     | tests                         |
    | crpbia0qsdqpi28444jn |             | crpo17tgeemuto888jdh | DISABLED | 2020-05-28 08:06:14 |                               |
    +----------------------+-------------+----------------------+----------+---------------------+-------------------------------+
    ```

- API

  To retrieve a list of lifecycle policies, use the [List](../../api-ref/grpc/lifecycle_policy_service.md#List) method for the [LifecyclePolicyService](../../api-ref/grpc/lifecycle_policy_service.md) resource.

{% endlist %}

## Getting information about a lifecycle policy {#lifecycle-policy-get}

{% list tabs %}

- CLI

  Get detailed information about a lifecycle policy using the `id` from the [previous](#lifecycle-policy-list) item:

  ```bash
  yc container repository lifecycle-policy get crp6lg1868p3i0emkv1b
  ```

  Command output:

  ```bash
  id: crp6lg1868p3i0emkv1b
  name: test-policy
  repository_id: crp3cpm16edqql0t30s2
  ...
    expire_period: 172800s
    tag_regexp: test.*
    untagged: true
  ```

- API

  To get detailed information about a lifecycle policy, use the [Get](../../api-ref/grpc/lifecycle_policy_service.md#Get) method for the [LifecyclePolicyService](../../api-ref/grpc/lifecycle_policy_service.md) resource. In the `lifecycle_policy_id` parameter, specify a policy ID.

  You can retrieve a list of policies using the [List](../../api-ref/grpc/lifecycle_policy_service.md#List) method for the [LifecyclePolicyService](../../api-ref/grpc/lifecycle_policy_service.md) resource.

{% endlist %}