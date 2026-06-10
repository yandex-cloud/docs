# Добавить виртуальную машину в кластер GPU


В [кластерах GPU](../../concepts/gpus.md#gpu-clusters) можно создавать только [ВМ](../../concepts/vm.md) на [платформе](../../concepts/vm-platforms.md) [AMD EPYC™ with NVIDIA® Ampere® A100](../../concepts/vm-platforms.md#gpu-platforms) c 8 GPU. Вам понадобится подготовить [образ](../../concepts/image.md) [диска](../../concepts/disk.md) с драйверами [по инструкции](../image-create/custom-image.md) и использовать его при создании ВМ.


{% note info %}

Кластеры GPU сейчас доступны только в [зонах доступности](../../../overview/concepts/geo-scope.md) `ru-central1-a` и `ru-central1-d`. Добавить ВМ в кластер GPU можно только из той же зоны доступности.

{% endnote %}


{% list tabs group=instructions %}

- CLI {#cli}

  ```bash
  export YC_GPU_CLUSTER=$(yc compute gpu-cluster list --format=json | jq -r .[].id)
  export YC_ZONE="ru-central1-a"
  export SUBNET_NAME="my-subnet-name"
  export SUBNET_ID=$(yc vpc subnet get --name=$SUBNET_NAME --format=json | jq -r .id)
  yc compute instance create --name node-gpu-test \
    --create-boot-disk size=64G,image-id=<идентификатор_образа_с_драйверами>,type=network-ssd \
    --ssh-key=$HOME/.ssh/id_rsa.pub \
    --gpus 8 --cores 224 --memory=952G \
    --zone $YC_ZONE \
    --network-interface subnet-id=$SUBNET_ID,nat-ip-version=ipv4 \
    --platform gpu-standard-v3 \
    --gpu-cluster-id=$YC_GPU_CLUSTER
  ```

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

{% endlist %}