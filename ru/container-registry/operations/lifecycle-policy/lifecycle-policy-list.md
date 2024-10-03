---
title: Как получить информацию о политиках удаления в {{ container-registry-full-name }}
description: Следуя данной инструкции, вы сможете получить информацию о политиках удаления.
---

# Получить информацию о политиках удаления

Узнайте, как получить:
* [Список политик удаления в репозитории или в реестре](#lifecycle-policy-list).
* [Подробную информацию о политике удаления](#lifecycle-policy-get).

## Получить список политик удаления в репозитории или в реестре {#lifecycle-policy-list}

{% list tabs group=instructions %}

- Консоль управления {#console}

  {% note info %}

  С помощью консоли управления можно получить список [политик удаления](../../concepts/lifecycle-policy.md) только для [репозитория](../../concepts/repository.md).

  {% endnote %}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создан [реестр](../../concepts/registry.md).
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
  1. Выберите реестр и нажмите на строку с его именем.
  1. Выберите репозиторий и нажмите на строку с его именем.
  1. На панели слева нажмите ![lifecycle](../../../_assets/console-icons/arrows-rotate-right.svg) **{{ ui-key.yacloud.cr.registry.label_lifecycle }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  * Получите список [политик удаления](../../concepts/lifecycle-policy.md) в репозитории:

    ```bash
    yc container repository lifecycle-policy list --repository-name crp2hlbs67tj********/ubuntu
    ```

    Результат:

    ```text
    +----------------------+-------------+----------------------+----------+---------------------+-------------------------------+
    |          ID          |    NAME     |    REPOSITORY ID     |  STATUS  |       CREATED       |          DESCRIPTION          |
    +----------------------+-------------+----------------------+----------+---------------------+-------------------------------+
    | crp6lg1868p3******** | test-policy | crp3cpm16edq******** | DISABLED | 2020-05-28 15:05:58 | disabled lifecycle-policy for |
    |                      |             |                      |          |                     | tests                         |
    +----------------------+-------------+----------------------+----------+---------------------+-------------------------------+
    ```

  * Получите список политик удаления в реестре:

    ```bash
    yc container repository lifecycle-policy list --registry-id crp2hlbs67tj********
    ```

    Результат:

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

  Чтобы получить список политик удаления, воспользуйтесь методом [List](../../api-ref/grpc/lifecycle_policy_service.md#List) для ресурса [LifecyclePolicyService](../../api-ref/grpc/lifecycle_policy_service.md).

{% endlist %}

## Получить информацию о политике удаления {#lifecycle-policy-get}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создан реестр.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
  1. Выберите реестр и нажмите на строку с его именем.
  1. Выберите репозиторий и нажмите на строку с его именем.
  1. На панели слева нажмите ![lifecycle](../../../_assets/console-icons/arrows-rotate-right.svg) **{{ ui-key.yacloud.cr.registry.label_lifecycle }}**.
  1. Нажмите на имя нужной политики удаления.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  Получите подробную информацию о политике удаления с помощью `id` из [предыдущего](#lifecycle-policy-list) пункта:

  ```bash
  yc container repository lifecycle-policy get crp6lg1868p3********
  ```

  Результат:

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

  Чтобы получить подробную информацию о политике удаления, воспользуйтесь методом [Get](../../api-ref/grpc/lifecycle_policy_service.md#Get) для ресурса [LifecyclePolicyService](../../api-ref/grpc/lifecycle_policy_service.md). В параметре `lifecycle_policy_id` укажите идентификатор политики.

  Получить список политик удаления можно с помощью метода [List](../../api-ref/grpc/lifecycle_policy_service.md#List) для ресурса [LifecyclePolicyService](../../api-ref/grpc/lifecycle_policy_service.md).

{% endlist %}