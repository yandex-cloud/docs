---
title: "Удалить политику удаления"
description: "Следуя данной инструкции, вы сможете удалить политику удаления."
---

# Удалить политику удаления

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создан [реестр](../../concepts/registry.md).
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
  1. Выберите реестр и нажмите на строку с его именем.
  1. Выберите репозиторий и нажмите на строку с его именем.
  1. На панели слева нажмите ![lifecycle](../../../_assets/console-icons/arrows-rotate-right.svg) **{{ ui-key.yacloud.cr.registry.label_lifecycle }}**.
  1. Нажмите на значок ![image](../../../_assets/console-icons/ellipsis.svg) для нужной [политики](../../concepts/lifecycle-policy.md) и выберите пункт **{{ ui-key.yacloud.common.delete }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.common.delete }}**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  1. Удалите политику, указав ее идентификатор:

     ```bash
     yc container repository lifecycle-policy delete <идентификатор_политики>
     ```

     Чтобы узнать идентификатор политики, получите [список политик удаления в репозитории или в реестре](lifecycle-policy-list.md#lifecycle-policy-list).
  1. Проверьте, что политика действительно удалена:

     ```bash
     yc container repository lifecycle-policy list --repository-name crp2hlbs67tj********/ubuntu
     ```

     Результат:

     ```bash
     +----+------+---------------+--------+---------+-------------+
     | ID | NAME | REPOSITORY ID | STATUS | CREATED | DESCRIPTION |
     +----+------+---------------+--------+---------+-------------+
     +----+------+---------------+--------+---------+-------------+
     ```

- {{ TF }}
  
  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Откройте конфигурационный файл и удалите фрагмент с описанием политики:

      {% cut "Пример описания политики в конфигурации {{ TF }}" %}

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

  1. Примените изменения:

      {% include [terraform-validate-plan-apply](../../../_tutorials/terraform-validate-plan-apply.md) %}

  После этого в указанном репозитории будет удалена политика удаления. Проверить удаление политики можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

    ```bash
     yc container repository lifecycle-policy list --registry-id <идентификатор_реестра>
    ```

- API

  Чтобы удалить политику, воспользуйтесь методом [Delete](../../api-ref/grpc/lifecycle_policy_service.md#Delete) для ресурса [LifecyclePolicyService](../../api-ref/grpc/lifecycle_policy_service.md). В параметре `lifecycle_policy_id` укажите идентификатор политики.

  Получить список политик удаления можно с помощью метода [List](../../api-ref/grpc/lifecycle_policy_service.md#List) для ресурса [LifecyclePolicyService](../../api-ref/grpc/lifecycle_policy_service.md).

{% endlist %}