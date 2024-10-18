---
title: How to get information about lifecycle policies in {{ container-registry-full-name }}
description: Follow this guide to get information about lifecycle policies.
---

# Getting information about lifecycle policies

Find out how to get:
* [List of lifecycle policies in a repository or registry](#lifecycle-policy-list).
* [Details about a lifecycle policy](#lifecycle-policy-get).

## Getting a list of lifecycle policies in a repository or registry {#lifecycle-policy-list}

{% list tabs group=instructions %}

- Management console {#console}

  {% note info %}

  In the management console, you can only get a list of [lifecycle policies](../../concepts/lifecycle-policy.md) for a [repository](../../concepts/repository.md).

  {% endnote %}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) the [registry](../../concepts/registry.md) was created in.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
  1. Select the registry and click the row with its name.
  1. Select the repository and click the row with its name.
  1. In the left-hand panel, click ![lifecycle](../../../_assets/console-icons/arrows-rotate-right.svg) **{{ ui-key.yacloud.cr.registry.label_lifecycle }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  * Retrieve a list of [lifecycle policies](../../concepts/lifecycle-policy.md) in a repository:

    ```bash
    yc container repository lifecycle-policy list --repository-name crp2hlbs67tj********/ubuntu
    ```

    Result:

    ```text
    +----------------------+-------------+----------------------+----------+---------------------+-------------------------------+
    |          ID          |    NAME     |    REPOSITORY ID     |  STATUS  |       CREATED       |          DESCRIPTION          |
    +----------------------+-------------+----------------------+----------+---------------------+-------------------------------+
    | crp6lg1868p3******** | test-policy | crp3cpm16edq******** | DISABLED | 2020-05-28 15:05:58 | disabled lifecycle-policy for |
    |                      |             |                      |          |                     | tests                         |
    +----------------------+-------------+----------------------+----------+---------------------+-------------------------------+
    ```

  * Retrieve a list of lifecycle policies in a registry:

    ```bash
    yc container repository lifecycle-policy list --registry-id crp2hlbs67tj********
    ```

    Result:

    ```text
    +----------------------+-------------+----------------------+----------+---------------------+-------------------------------+
    |          ID          |    NAME     |    REPOSITORY ID     |  STATUS  |       CREATED       |          DESCRIPTION          |
    +----------------------+-------------+----------------------+----------+---------------------+-------------------------------+
    | crp6lg1868p3******** | test-policy | crp3cpm16edq******** | DISABLED | 2020-05-28 15:05:58 | disabled lifecycle-policy for |
    |                      |             |                      |          |                     | tests                         |
    | crpbia0qsdqp******** |             | crpo17tgeemu******** | DISABLED | 2020-05-28 08:06:14 |                               |
    +----------------------+-------------+----------------------+----------+---------------------+-------------------------------+
    ```

- API {#api}

  To retrieve a list of lifecycle policies, use the [List](../../api-ref/grpc/LifecyclePolicy/list.md) method for the [LifecyclePolicyService](../../api-ref/grpc/LifecyclePolicy/index.md) resource.

{% endlist %}

## Getting information about a lifecycle policy {#lifecycle-policy-get}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) the registry was created in.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
  1. Select the registry and click the row with its name.
  1. Select the repository and click the row with its name.
  1. In the left-hand panel, click ![lifecycle](../../../_assets/console-icons/arrows-rotate-right.svg) **{{ ui-key.yacloud.cr.registry.label_lifecycle }}**.
  1. Click the name of the lifecycle policy you need.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  Get detailed information about a lifecycle policy using the `id` from the [previous](#lifecycle-policy-list) item:

  ```bash
  yc container repository lifecycle-policy get crp6lg1868p3********
  ```

  Result:

  ```text
  id: crp6lg1868p3********
  name: test-policy
  repository_id: crp3cpm16edq********
  ...
    expire_period: 172800s
    tag_regexp: test.*
    untagged: true
  ```

- API {#api}

  To get detailed information about a lifecycle policy, use the [Get](../../api-ref/grpc/LifecyclePolicy/get.md) method for the [LifecyclePolicyService](../../api-ref/grpc/LifecyclePolicy/index.md) resource. Specify the policy ID in the `lifecycle_policy_id` parameter.

  You can retrieve a list of policies using the [List](../../api-ref/grpc/LifecyclePolicy/list.md) method for the [LifecyclePolicyService](../../api-ref/grpc/LifecyclePolicy/index.md) resource.

{% endlist %}