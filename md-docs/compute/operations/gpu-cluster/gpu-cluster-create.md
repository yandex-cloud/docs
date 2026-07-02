[Документация Yandex Cloud](../../../index.md) > [Yandex Compute Cloud](../../index.md) > [Пошаговые инструкции](../index.md) > Кластеры GPU > Создать кластер GPU

# Создать кластер GPU


{% note info %}

По умолчанию в [облаке](../../../resource-manager/concepts/resources-hierarchy.md#cloud) установлена нулевая [квота](../../concepts/limits.md#compute-quotas) на создание кластеров GPU. Чтобы изменить [квоту](https://console.yandex.cloud/cloud?section=quotas), обратитесь в [техническую поддержку](https://center.yandex.cloud/support).

{% endnote %}

В этом разделе приведена инструкция для создания кластера GPU. Кластеры GPU можно создавать в [зонах доступности](../../../overview/concepts/geo-scope.md) `ru-central1-a`, `ru-central1-b` и `ru-central1-d`.

После создания кластера GPU вы сможете [добавлять](gpu-add-to-cluster.md) к нему [виртуальные машины](../../concepts/vm.md) из той же зоны доступности.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы хотите создать кластер GPU.
  1. Перейдите в сервис **Compute Cloud**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/cpus.svg) **Кластеры GPU**.
  1. Нажмите кнопку **Создать кластер GPU**.
  1. В открывшемся окне:

      1. В поле **Имя** задайте имя кластера GPU.

          * длина — от 3 до 63 символов;
          * может содержать строчные буквы латинского алфавита, цифры и дефисы;
          * первый символ — буква, последний — не дефис.

      1. (Опционально) В поле **Описание** добавьте описание кластера GPU.
      1. В поле **Зона доступности** выберите зону доступности, в которой будет размещен кластер.
      1. (Опционально) Добавьте [метки](../../../resource-manager/concepts/labels.md) кластеру.
  1. Нажмите кнопку **Создать кластер GPU**.

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
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

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

     Подробную информацию о параметрах ресурса `yandex_compute_gpu_cluster` читайте в [документации провайдера Terraform](../../../terraform/resources/compute_gpu_cluster.md).
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

- API {#api}

  Чтобы создать кластер GPU, воспользуйтесь методом REST API [create](../../api-ref/GpuCluster/create.md) для ресурса [GpuCluster](../../api-ref/GpuCluster/index.md) или вызовом gRPC API [GpuClusterService/Create](../../api-ref/grpc/GpuCluster/create.md).

{% endlist %}

#### Полезные ссылки {#see-also}

* [Добавить виртуальную машину в кластер GPU](gpu-add-to-cluster.md)
* [Изменить кластер GPU](gpu-cluster-update.md)
* [Удалить кластер GPU](gpu-cluster-delete.md)
* [Графические ускорители GPU](../../concepts/gpus.md)
* [Платформы](../../concepts/vm-platforms.md)