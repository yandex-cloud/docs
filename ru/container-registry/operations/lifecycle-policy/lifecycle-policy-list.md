# Получить информацию о политиках удаления

Узнайте, как получить:
* [Список политик удаления в репозитории или в реестре](#lifecycle-policy-list).
* [Подробную информацию о политике удаления](#lifecycle-policy-get).

## Получить список политик удаления в репозитории или в реестре {#lifecycle-policy-list}

{% list tabs %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  * Получите список [политик удаления](../../concepts/lifecycle-policy.md) в репозитории:

    ```bash
    yc container repository lifecycle-policy list --repository-name crp2hlbs67tj4ggrfodb/ubuntu
    ```

    Результат:

    ```bash
    +----------------------+-------------+----------------------+----------+---------------------+--------------------------------+
    |          ID          |    NAME     |    REPOSITORY ID     |  STATUS  |       CREATED       |          DESCRIPTION           |
    +----------------------+-------------+----------------------+----------+---------------------+--------------------------------+
    | crp6lg1868p3i0emkv1b | test-policy | crp3cpm16edqql0t30s2 | DISABLED | 2020-05-28 15:05:58 | disabled lifecycle-policy for  |
    |                      |             |                      |          |                     | tests                          |
    +----------------------+-------------+----------------------+----------+---------------------+--------------------------------+
    ```

  * Получите список политик удаления в реестре:

    ```bash
    yc container repository lifecycle-policy list --registry-id crp2hlbs67tj4ggrfodb
    ```

    Результат:

    ```bash
    +----------------------+-------------+----------------------+----------+---------------------+--------------------------------+
    |          ID          |    NAME     |    REPOSITORY ID     |  STATUS  |       CREATED       |          DESCRIPTION           |
    +----------------------+-------------+----------------------+----------+---------------------+--------------------------------+
    | crp6lg1868p3i0emkv1b | test-policy | crp3cpm16edqql0t30s2 | DISABLED | 2020-05-28 15:05:58 | disabled lifecycle-policy for  |
    |                      |             |                      |          |                     | tests                          |
    | crpbia0qsdqpi28444jn |             | crpo17tgeemuto888jdh | DISABLED | 2020-05-28 08:06:14 |                                |
    +----------------------+-------------+----------------------+----------+---------------------+--------------------------------+
    ```

- API

  Чтобы получить список политик удаления, воспользуйтесь методом [List](../../api-ref/grpc/lifecycle_policy_service.md#List) для ресурса [LifecyclePolicyService](../../api-ref/grpc/lifecycle_policy_service.md).

{% endlist %}

## Получить информацию о политике удаления {#lifecycle-policy-get}

{% list tabs %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  Получите подробную информацию о политике удаления с помощью `id` из [предыдущего](#lifecycle-policy-list) пункта:

  ```bash
  yc container repository lifecycle-policy get crp6lg1868p3i0emkv1b
  ```

  Результат:

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

  Чтобы получить подробную информацию о политике удаления, воспользуйтесь методом [Get](../../api-ref/grpc/lifecycle_policy_service.md#Get) для ресурса [LifecyclePolicyService](../../api-ref/grpc/lifecycle_policy_service.md). В параметре `lifecycle_policy_id` укажите идентификатор политики.

  Получить список политик удаления можно с помощью метода [List](../../api-ref/grpc/lifecycle_policy_service.md#List) для ресурса [LifecyclePolicyService](../../api-ref/grpc/lifecycle_policy_service.md).

{% endlist %}