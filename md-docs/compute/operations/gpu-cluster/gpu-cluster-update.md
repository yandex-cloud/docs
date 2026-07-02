[Документация Yandex Cloud](../../../index.md) > [Yandex Compute Cloud](../../index.md) > [Пошаговые инструкции](../index.md) > Кластеры GPU > Изменить кластер GPU

# Изменить кластер GPU


После создания [кластера GPU](../../concepts/gpus.md#gpu-clusters) вы можете изменить его имя, описание или метки.

Как добавить [виртуальную машину](../../concepts/vm.md) в кластер GPU, читайте в разделе [Добавить виртуальную машину в кластер GPU](gpu-add-to-cluster.md)

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится кластер GPU.
  1. Перейдите в сервис **Compute Cloud**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/cpus.svg) **Кластеры GPU**.
  1. В строке с нужным кластером GPU нажмите ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../_assets/console-icons/pencil.svg) **Редактировать**.
  1. В открывшемся окне измените имя, описание или [метки](../../../resource-manager/concepts/labels.md) кластера GPU.
  1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды [CLI](../../../cli/index.md) для обновления параметров кластера GPU:

     ```bash
     yc compute gpu-cluster update --help
     ```

  1. Получите список кластеров GPU в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию:

     ```bash
     yc compute gpu-cluster list
     ```

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужного кластера GPU, например `first-gpu-cluster`.
  1. Измените параметры кластера GPU, например, переименуйте его:

     ```bash
     yc compute instance update first-gpu-cluster \
       --new-name updated-gpu-cluster
     ```

- Terraform {#tf}

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  1. Откройте файл конфигурации Terraform и измените фрагмент с описанием кластера GPU:

     {% cut "Пример описания кластера GPU в конфигурации Terraform" %}

     ```hcl
     ...
     resource "yandex_compute_gpu_cluster" "default" {
       name               = "gpu-cluster-name"
       interconnect_type  = "infiniband"
       zone               = "ru-central1-a"

       labels = {
         environment = "test"
       }
     }
     ...
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

  Проверить изменение кластера GPU можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../../cli/index.md):

  ```bash
  yc compute gpu-cluster get <имя_кластера_GPU>
  ```

- API {#api}

  Чтобы изменить кластер GPU, воспользуйтесь методом REST API [update](../../api-ref/GpuCluster/update.md) для ресурса [GpuCluster](../../api-ref/GpuCluster/index.md) или вызовом gRPC API [GpuClusterService/Update](../../api-ref/grpc/GpuCluster/update.md).

{% endlist %}

#### Полезные ссылки {#see-also}

* [Создать кластер GPU](gpu-cluster-create.md)
* [Удалить кластер GPU](gpu-cluster-delete.md)
* [Добавить виртуальную машину в кластер GPU](gpu-add-to-cluster.md)
* [Графические ускорители GPU](../../concepts/gpus.md)
* [Платформы](../../concepts/vm-platforms.md)