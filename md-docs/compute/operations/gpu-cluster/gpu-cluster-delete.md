# Удалить кластер GPU


Перед удалением [кластера GPU](../../concepts/gpus.md#gpu-clusters) удалите из него все [виртуальные машины](../../concepts/vm.md).

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды [CLI](../../../cli/index.md) для удаления кластера GPU:

     ```bash
     yc compute gpu-cluster delete --help
     ```

  1. Получите список кластеров GPU в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию:

     ```bash
     yc compute gpu-cluster list
     ```

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужного кластера GPU, например `first-gpu-cluster`.
  1. Удалите кластер GPU:

     ```bash
     yc compute gpu-cluster delete first-gpu-cluster
     ```

- Terraform {#tf}

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  1. Откройте файл конфигурации Terraform и удалите фрагмент с описанием кластера GPU:

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

  Проверить удаление кластера GPU можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../../cli/index.md):

    ```bash
    yc compute gpu-cluster list
    ```

{% endlist %}