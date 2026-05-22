# Создать кластер GPU


{% note info %}

По умолчанию в [облаке](../../../resource-manager/concepts/resources-hierarchy.md#cloud) установлена нулевая [квота](../../concepts/limits.md#compute-quotas) на создание кластеров GPU. Чтобы изменить [квоту](https://console.yandex.cloud/cloud?section=quotas), обратитесь в [техническую поддержку](https://center.yandex.cloud/support).

{% endnote %}

В этом разделе приведена инструкция для создания кластера GPU. Кластеры GPU сейчас можно создавать только в [зонах доступности](../../../overview/concepts/geo-scope.md) `ru-central1-a` и `ru-central1-d`.

После создания кластера GPU вы сможете [добавлять](gpu-add-to-cluster.md) к нему [виртуальные машины](../../concepts/vm.md) из той же зоны доступности.

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды [CLI](../../../cli/index.md) для создания кластера GPU:

     ```bash
     yc compute gpu-cluster create --help
     ```

     Обратите внимание, что сейчас создаются только кластеры GPU с типом соединения `infiniband`.
  1. Создайте кластер GPU в зоне доступности по умолчанию:

     ```bash
     yc compute gpu-cluster create --interconnect-type infiniband
     ```

- Terraform {#tf}

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  1. Опишите в конфигурационном файле Terraform параметры ресурса, который необходимо создать:

     ```hcl
     provider "yandex" {
       zone = "ru-central1-a"
     }

     resource "yandex_compute_gpu_cluster" "default" {
       name               = "<имя_кластера_GPU>"
       interconnect_type  = "<тип_соединения>"
       zone               = "ru-central1-a"
       labels             = {
         <ключ_метки_1> = "<значение_метки_1>"
         <ключ_метки_2> = "<значение_метки_2>"
       }
     }
     ```

     Где:
     * `name` — имя кластера GPU. Обязательный параметр.
     * `interconnect_type` — тип соединения. Сейчас создаются только кластеры GPU с типом соединения `infiniband`. Обязательный параметр.
     * `labels` — [метка](../../../resource-manager/concepts/labels.md) ресурса в формате `<ключ> = "<значение>"`. Необязательный параметр.

     Подробную информацию о параметрах ресурса `yandex_compute_gpu_cluster` см. в [документации провайдера Terraform](../../../terraform/resources/compute_gpu_cluster.md).
  1. Создайте ресурсы:

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

  После этого в указанном [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) будет создан кластер GPU. Проверить появление кластера GPU и его настройки можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../../cli/index.md):

  ```bash
  yc compute gpu-cluster get <имя_кластера_GPU>
  ```

{% endlist %}