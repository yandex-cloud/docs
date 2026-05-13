# Удалить политику удаления

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создан [реестр](../../concepts/registry.md).
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Container Registry**.
  1. Выберите реестр и нажмите на строку с его именем.
  1. Выберите репозиторий и нажмите на строку с его именем.
  1. На панели слева нажмите ![lifecycle](../../../_assets/console-icons/arrows-rotate-right.svg) **Жизненный цикл**.
  1. Нажмите на значок ![image](../../../_assets/console-icons/ellipsis.svg) для нужной [политики](../../concepts/lifecycle-policy.md) и выберите пункт **Удалить**.
  1. В открывшемся окне нажмите кнопку **Удалить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  1. Удалите [политику](../../concepts/lifecycle-policy.md), указав ее идентификатор:

     ```bash
     yc container repository lifecycle-policy delete <идентификатор_политики>
     ```

     Чтобы узнать идентификатор политики, получите [список политик удаления в репозитории или в реестре](lifecycle-policy-list.md#lifecycle-policy-list).
  1. Проверьте, что политика действительно удалена:

     ```bash
     yc container repository lifecycle-policy list --repository-name crp2hlbs67tj********/ubuntu
     ```

     Результат:

     ```text
     +----+------+---------------+--------+---------+-------------+
     | ID | NAME | REPOSITORY ID | STATUS | CREATED | DESCRIPTION |
     +----+------+---------------+--------+---------+-------------+
     +----+------+---------------+--------+---------+-------------+
     ```

- Terraform {#tf}

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  1. Откройте конфигурационный файл и удалите фрагмент с описанием политики:

     {% cut "Пример описания политики в конфигурации Terraform" %}

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

     1. В терминале перейдите в директорию с конфигурационным файлом.
     1. Проверьте корректность конфигурации с помощью команды:
     
        ```bash
        terraform validate
        ```
     
        Если конфигурация является корректной, появится сообщение:
     
        ```bash
        Success! The configuration is valid.
        ```
     
     1. Выполните команду:
     
        ```bash
        terraform plan
        ```
     
        В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
     1. Примените изменения конфигурации:
     
        ```bash
        terraform apply
        ```
     
     1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

  После этого в указанном [репозитории](../../concepts/repository.md) будет удалена политика удаления. Проверить удаление политики можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../../cli/index.md):

  ```bash
  yc container repository lifecycle-policy list --registry-id <идентификатор_реестра>
  ```

- API {#api}

  Чтобы удалить политику, воспользуйтесь методом [Delete](../../api-ref/grpc/LifecyclePolicy/delete.md) для ресурса [LifecyclePolicyService](../../api-ref/grpc/LifecyclePolicy/index.md). В параметре `lifecycle_policy_id` укажите идентификатор политики.

  Получить список политик удаления можно с помощью метода [List](../../api-ref/grpc/LifecyclePolicy/list.md) для ресурса [LifecyclePolicyService](../../api-ref/grpc/LifecyclePolicy/index.md).

{% endlist %}