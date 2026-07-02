[Документация Yandex Cloud](../../../index.md) > [Yandex Compute Cloud](../../index.md) > [Пошаговые инструкции](../index.md) > Кластеры GPU > Добавить ВМ в кластер GPU

# Добавить виртуальную машину в кластер GPU


В [кластерах GPU](../../concepts/gpus.md#gpu-clusters) можно создавать [ВМ](../../concepts/vm.md) с 8 GPU на одной из следующих [платформ](../../concepts/vm-platforms.md#gpu-platforms):
* AMD EPYC™ with NVIDIA® Ampere® A100 (`gpu-standard-v3`);
* Gen2 (`gpu-standard-v3i`);
* GPU PLATFORM V4 (`gpu-standard-v4`).

ВМ должна быть развернута из [специального образа](../../concepts/gpus.md#os) с драйверами NVIDIA.


{% note info %}

Кластер GPU можно разместить в одной из [зон доступности](../../../overview/concepts/geo-scope.md): `ru-central1-a`, `ru-central1-b` и `ru-central1-d`. Зона доступности, в которой создается ВМ, должна совпадать с зоной доступности кластера.

{% endnote %}


{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы хотите создать ВМ.
  1. Перейдите в сервис **Compute Cloud**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/server.svg) **Виртуальные машины** и нажмите кнопку **Создать виртуальную машину**.
  1. В блоке **Образ загрузочного диска** выберите [образ с предустановленными драйверами NVIDIA](../../concepts/gpus.md#os).
  1. В поле **Зона доступности** выберите [зону доступности](../../../overview/concepts/geo-scope.md), в которой находится кластер GPU.
  1. В блоке **Вычислительные ресурсы** перейдите на вкладку **Своя конфигурация** и укажите:

      * **Платформа** — одну из [платформ](../../concepts/vm-platforms.md#gpu-platforms): `AMD EPYC™ with NVIDIA® Ampere® A100`, `GPU PLATFORM V4` или `Gen2`.
      * **GPU** — `8`.
      * **Кластер GPU** — ранее [созданный](gpu-cluster-create.md) кластер GPU.
  1. В блоке **Общая информация** задайте имя ВМ.
  1. Нажмите кнопку **Создать ВМ**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  В терминале выполните команду:

  ```bash
  export YC_GPU_CLUSTER=$(yc compute gpu-cluster list --format=json | jq -r .[].id)
  export YC_ZONE="ru-central1-a"
  export SUBNET_NAME="my-subnet-name"
  export SUBNET_ID=$(yc vpc subnet get --name=$SUBNET_NAME --format=json | jq -r .id)
  yc compute instance create \
    --name node-gpu-test \
    --create-boot-disk size=64G,image-id=<идентификатор_образа_с_драйверами>,type=network-ssd \
    --ssh-key=$HOME/.ssh/id_rsa.pub \
    --gpus 8 \
    --cores 224 \
    --memory=952G \
    --zone $YC_ZONE \
    --network-interface subnet-id=$SUBNET_ID,nat-ip-version=ipv4 \
    --platform gpu-standard-v3 \
    --gpu-cluster-id=$YC_GPU_CLUSTER
  ```

  Где:
  * `--name` — имя ВМ.
  * `--create-boot-disk` — параметры [диска](../../concepts/disk.md) ВМ.
  * `--ssh-key` — путь к файлу с [открытым SSH-ключом](../vm-connect/ssh.md#creating-ssh-keys).
  * `--gpus` — количество [GPU](../../concepts/gpus.md).
  * `--cores` — количество vCPU.
  * `--memory` — объем RAM.
  * `--zone` — [зона доступности](../../../overview/concepts/geo-scope.md).
  * `--network-interface` — настройки [сетевого интерфейса](../../concepts/network.md) ВМ.
  * `--platform` — идентификатор [платформы](../../concepts/vm-platforms.md).
  * `--gpu-cluster-id` — идентификатор [кластера GPU](../../concepts/gpus.md#gpu-clusters).

- Terraform {#tf}

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  1. Опишите в конфигурационном файле Terraform параметры ресурса, который необходимо создать:

     ```hcl
     provider "yandex" {
       zone = "ru-central1-a"
     }

     resource "yandex_compute_disk" "boot-disk" {
       name     = "<имя_диска>"
       type     = "<тип_диска>"
       zone     = "ru-central1-a"
       size     = "<размер_диска>"
       image_id = "<идентификатор_образа_с_драйверами>"
     }

     resource "yandex_compute_instance" "default" {
       name           = "vm-gpu"
       platform_id    = "gpu-standard-v3"
       zone           = "ru-central1-a"
       gpu_cluster_id = "<идентификатор_кластера_GPU>"

       resources {
         cores  = "224"
         memory = "952"
         gpus   = "8"
       }

       boot_disk {
         disk_id = yandex_compute_disk.boot-disk.id
       }

       network_interface {
         subnet_id = "${yandex_vpc_subnet.subnet-1.id}"
         nat       = true
       }

       metadata = {
         user-data = "#cloud-config\nusers:\n  - name: <имя_пользователя>\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh_authorized_keys:\n      - ${file("<путь_к_открытому_SSH-ключу>")}"
       }
     }

     resource "yandex_vpc_network" "network-1" {
       name = "network1"
     }

     resource "yandex_vpc_subnet" "subnet-1" {
       name           = "subnet1"
       zone           = "<зона_доступности>"
       v4_cidr_blocks = ["192.168.10.0/24"]
       network_id     = "${yandex_vpc_network.network-1.id}"
     }
     ```

     Где:
     * `yandex_compute_disk` — описание загрузочного диска, где `image_id` — идентификатор образа с драйверами.
     * `gpu_cluster_id` — идентификатор кластера GPU. Обязательный параметр.
     * `yandex_vpc_network` — описание [облачной сети](../../../vpc/concepts/network.md#network).
     * `yandex_vpc_subnet` — описание [подсети](../../../vpc/concepts/network.md#subnet), в которой будет создана ВМ.

       {% note info %}

       Если у вас уже есть подходящие ресурсы (облачная сеть и подсеть), описывать их повторно не нужно. Используйте их имена и идентификаторы в соответствующих параметрах.

       {% endnote %}

       Подробную информацию о параметрах ресурса `yandex_compute_instance` читайте в [документации провайдера Terraform](../../../terraform/resources/compute_instance.md).
  1. В блоке `metadata` укажите имя пользователя и путь к открытому [SSH-ключу](../../../glossary/ssh-keygen.md). Подробнее в разделе [Метаданные виртуальной машины](../../concepts/vm-metadata.md).
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

  После этого в указанном кластере GPU будет создана ВМ. Проверить появление ВМ и ее настройки можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../../cli/index.md):

  ```bash
  yc compute instance get <имя_ВМ>
  ```

- API {#api}

  Чтобы создать ВМ в кластере GPU, воспользуйтесь методом REST API [create](../../api-ref/Instance/create.md) для ресурса [Instance](../../api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/Create](../../api-ref/grpc/Instance/create.md). В теле запроса в поле `gpuClusterId` укажите идентификатор кластера GPU.

{% endlist %}

#### Полезные ссылки {#see-also}

* [Создать кластер GPU](gpu-cluster-create.md)
* [Изменить кластер GPU](gpu-cluster-update.md)
* [Удалить кластер GPU](gpu-cluster-delete.md)
* [Графические ускорители GPU](../../concepts/gpus.md)
* [Платформы](../../concepts/vm-platforms.md)