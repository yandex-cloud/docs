---
title: Добавить виртуальную машину в кластер GPU
description: Следуя данной инструкции, вы сможете добавить виртуальную машину в кластер GPU.
---

# Добавить виртуальную машину в кластер GPU


В [кластерах GPU](../../concepts/gpus.md#gpu-clusters) можно создавать [ВМ](../../concepts/vm.md) с 8 GPU на одной из следующих [платформ](../../concepts/vm-platforms.md#gpu-platforms):
* {{ a100-epyc }} (`gpu-standard-v3`);
* Gen2 (`gpu-standard-v3i`);
* GPU PLATFORM V4 (`gpu-standard-v4`).

ВМ должна быть развернута из [специального образа](../../concepts/gpus.md#os) с драйверами NVIDIA.


{% note info %}

Кластер GPU можно разместить в одной из [зон доступности](../../../overview/concepts/geo-scope.md): `{{ region-id }}-a`, `{{ region-id }}-b` и `{{ region-id }}-d`. Зона доступности, в которой создается ВМ, должна совпадать с зоной доступности кластера.

{% endnote %}


{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы хотите создать ВМ.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}** и нажмите кнопку **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** выберите [образ с предустановленными драйверами NVIDIA](../../concepts/gpus.md#os).
  1. В поле **{{ ui-key.yacloud.compute.instances.create.field_zone }}** выберите [зону доступности](../../../overview/concepts/geo-scope.md), в которой находится кластер GPU.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}** перейдите на вкладку **{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}** и укажите:

      * **{{ ui-key.yacloud.component.compute.resources.field_platform }}** — одну из [платформ](../../concepts/vm-platforms.md#gpu-platforms): `{{ a100-epyc }}`, `GPU PLATFORM V4` или `Gen2`.
      * **{{ ui-key.yacloud.component.compute.resources.field_gpus }}** — `8`.
      * **{{ ui-key.yacloud.component.compute.resources.field_gpu-cluster }}** — ранее [созданный](gpu-cluster-create.md) кластер GPU.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}** задайте имя ВМ.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  В терминале выполните команду:

  ```bash
  export YC_GPU_CLUSTER=$(yc compute gpu-cluster list --format=json | jq -r .[].id)
  export YC_ZONE="{{ region-id }}-a"
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
  * `--ssh-key` — путь к файлу с [открытым SSH-ключом](../../operations/vm-connect/ssh.md#creating-ssh-keys).
  * `--gpus` — количество [GPU](../../concepts/gpus.md).
  * `--cores` — количество vCPU.
  * `--memory` — объем RAM.
  * `--zone` — [зона доступности](../../../overview/concepts/geo-scope.md).
  * `--network-interface` — настройки [сетевого интерфейса](../../concepts/network.md) ВМ.
  * `--platform` — идентификатор [платформы](../../concepts/vm-platforms.md).
  * `--gpu-cluster-id` — идентификатор [кластера GPU](../../concepts/gpus.md#gpu-clusters).

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле {{ TF }} параметры ресурса, который необходимо создать:

     ```hcl
     provider "yandex" {
       zone = "{{ region-id }}-a"
     }

     resource "yandex_compute_disk" "boot-disk" {
       name     = "<имя_диска>"
       type     = "<тип_диска>"
       zone     = "{{ region-id }}-a"
       size     = "<размер_диска>"
       image_id = "<идентификатор_образа_с_драйверами>"
     }

     resource "yandex_compute_instance" "default" {
       name           = "vm-gpu"
       platform_id    = "gpu-standard-v3"
       zone           = "{{ region-id }}-a"
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

       Подробную информацию о параметрах ресурса `yandex_compute_instance` читайте в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/compute_instance).
  1. В блоке `metadata` укажите имя пользователя и путь к открытому [SSH-ключу](../../../glossary/ssh-keygen.md). Подробнее в разделе [{#T}](../../../compute/concepts/vm-metadata.md).
  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  После этого в указанном кластере GPU будет создана ВМ. Проверить появление ВМ и ее настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/):

  ```bash
  yc compute instance get <имя_ВМ>
  ```

- API {#api}

  Чтобы создать ВМ в кластере GPU, воспользуйтесь методом REST API [create](../../api-ref/Instance/create.md) для ресурса [Instance](../../api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/Create](../../api-ref/grpc/Instance/create.md). В теле запроса в поле `gpuClusterId` укажите идентификатор кластера GPU.

{% endlist %}

#### Полезные ссылки {#see-also}

* [{#T}](gpu-cluster-create.md)
* [{#T}](gpu-cluster-update.md)
* [{#T}](gpu-cluster-delete.md)
* [{#T}](../../concepts/gpus.md)
* [{#T}](../../concepts/vm-platforms.md)
