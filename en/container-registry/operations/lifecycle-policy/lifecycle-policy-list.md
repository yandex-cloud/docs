# Getting information about lifecycle policies

Find out how to get:
* [A list of lifecycle policies in a repository or registry](#lifecycle-policy-list).
* [Details about a lifecycle policy](#lifecycle-policy-get).

## Retrieving a list of lifecycle policies in a repository or registry {#lifecycle-policy-list}

{% list tabs %}

- Management console

  {% note info %}

  In the management console, you can only get a list of [lifecycle policies](../../concepts/lifecycle-policy.md) for a [repository](../../concepts/repository.md).

  {% endnote %}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where the [registry](../../concepts/registry.md) was created.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
  1. Select the registry and click the row with its name.
  1. Select the repository and click the row with its name.
  1. In the left-hand panel, click ![lifecycle](../../../_assets/console-icons/arrows-rotate-right.svg) **{{ ui-key.yacloud.cr.registry.label_lifecycle }}**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  * Retrieve a list of [lifecycle policies](../../concepts/lifecycle-policy.md) in a repository:

    ```bash
    yc container repository lifecycle-policy list --repository-name crp2hlbs67tj4ggrfodb/ubuntu
    ```

    Result:

    ```text
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

    Result:

    ```text
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

- Management console

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where the registry was created.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
  1. Select the registry and click the row with its name.
  1. Select the repository and click the row with its name.
  1. In the left-hand panel, click ![lifecycle](../../../_assets/console-icons/arrows-rotate-right.svg) **{{ ui-key.yacloud.cr.registry.label_lifecycle }}**.
  1. Click the name of the lifecycle policy you need.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  Get detailed information about a lifecycle policy using the `id` from the [previous](#lifecycle-policy-list) item:

  ```bash
  yc container repository lifecycle-policy get crp6lg1868p3i0emkv1b
  ```

  Result:

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