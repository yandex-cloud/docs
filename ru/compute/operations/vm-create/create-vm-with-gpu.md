---
title: "Как создать виртуальную машину с GPU"
description: "Следуя данной инструкции, вы сможете создать виртуальную машину с GPU."
---

# Создание виртуальной машины с GPU

В этом разделе приведена инструкция для создания [ВМ](../../concepts/vm.md) с GPU. Подробнее с конфигурациями ВМ вы можете ознакомиться в разделе [{#T}](../../concepts/gpus.md).

По умолчанию в [облаке](../../../resource-manager/concepts/resources-hierarchy.md#cloud) установлена нулевая [квота](../../concepts/limits.md#quotas) на создание ВМ с GPU. Чтобы изменить [квоту]({{ link-console-quotas }}), обратитесь в [техническую поддержку]({{ link-console-support }}).


{% include [gpu-zones](../../../_includes/compute/gpu-zones.md) %}


{% list tabs %}

- Консоль управления

  
  @[youtube](https://www.youtube.com/watch?v=1gFAfVA4XRM&list=PL1x4ET76A10bW1KU3twrdm7hH376z8G5R&index=2&pp=iAQB)


  {% include [create-vm-with-gpu](../../../_includes/compute/create/create-vm-with-gpu-console.md) %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания ВМ:

     ```bash
     yc compute instance create --help
     ```

  1. [Подготовьте](../vm-connect/ssh.md#creating-ssh-keys) пару ключей (открытый и закрытый) для [SSH-доступа](../../../glossary/ssh-keygen.md) на ВМ.
  1. Выберите один из публичных [образов](../images-with-pre-installed-software/get-list.md).

     {% include [gpu-images](../../../_includes/gpu-images.md) %}

     {% include [gpu-os](../../../_includes/compute/gpu-os.md) %}

  1. Создайте ВМ в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию:

     
     ```bash
     yc compute instance create \
       --name gpu-instance \
       --zone {{ region-id }}-a \
       --platform=gpu-standard-v3 \
       --cores=8 \
       --memory=96 \
       --gpus=1 \
       --network-interface subnet-name=default-{{ region-id }}-a,nat-ip-version=ipv4 \
       --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1604-lts-gpu \
       --ssh-key ~/.ssh/id_ed25519.pub
     ```



     Где:
     * `name` – имя ВМ.

       {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}

     * `zone` – [зона доступности](../../../overview/concepts/geo-scope.md).

       
       {% include [gpu-zones](../../../_includes/compute/gpu-zones.md) %}

 

     * `platform` – идентификатор [платформы](../../concepts/vm-platforms.md):
       
       {% include [gpu-platforms-api](../../../_includes/compute/gpu-platforms-api.md) %}
       
     * `cores` – [количество vCPU](../../concepts/gpus.md).
     * `memory` – размер RAM.
     * `gpus` – количество GPU.
     * `preemptible` – если нужно сделать ВМ [прерываемой](../../concepts/preemptible-vm.md).

       
     * `create-boot-disk` – [образ](../images-with-pre-installed-software/get-list.md) операционной системы.

       {% include [gpu-os](../../../_includes/compute/gpu-os.md) %}

     * `nat-ip-version=ipv4` – [публичный IP-адрес](../../../vpc/concepts/address.md#public-addresses). Чтобы создать ВМ без публичного IP-адреса, исключите параметр.

     Получите описание созданной ВМ:

     ```bash
     yc compute instance get --full gpu-instance
     ```

     Результат:

     ```bash
     name: gpu-instance
     zone_id: {{ region-id }}-a
     platform_id: gpu-standard-v3
     resources:
       memory: "103079215104"
       cores: "8"
       core_fraction: "100"
       gpus: "1"
     status: RUNNING
     ...
     ```

- API

  Чтобы создать ВМ, воспользуйтесь методом REST API [create](../../api-ref/Instance/create.md) для ресурса [Instance](../../api-ref/Instance/) или вызовом gRPC API [InstanceService/Create](../../api-ref/grpc/instance_service.md#Create).

- {{ TF }}

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

     ```hcl
     resource "yandex_compute_instance" "vm-1" {
       name                      = "vm-with-gpu"
       allow_stopping_for_update = true
       platform_id               = "standard-v3"
       zone                      = "<зона_доступности>"

       resources {
         cores  = <количество_ядер_vCPU>
         memory = <объем_RAM_в_ГБ>
         gpus   = <количество_GPU>
       }

       boot_disk {
         initialize_params {
           image_id = "<идентификатор_образа>"
         }
       }

       network_interface {
         subnet_id = "${yandex_vpc_subnet.subnet-1.id}"
         nat       = true
       }

       metadata = {
         ssh-keys = "<имя_пользователя>:<содержимое_SSH-ключа>"
       }
     }

     resource "yandex_vpc_network" "network-1" {
       name = "network1"
     }

     resource "yandex_vpc_subnet" "subnet-1" {
       name       = "subnet1"
       zone       = "<зона_доступности>"
       network_id = "${yandex_vpc_network.network-1.id}"
     }
     ```

     Где:
     * `yandex_compute_instance` — описание ВМ:
       * `name` — имя ВМ.
       * {% include [terraform-allow-stopping](../../../_includes/compute/terraform-allow-stopping.md) %}
       * `platform_id` — идентификатор [платформы](../../concepts/vm-platforms.md):
       * `zone` — идентификатор [зоны доступности](../../../overview/concepts/geo-scope.md), в которой будет находиться ВМ.

             
         {% include [gpu-zones](../../../_includes/compute/gpu-zones.md) %}
    
    
         
       * `platform_id` — идентификатор [платформы](../../concepts/vm-platforms.md):

         {% include [gpu-platforms-api](../../../_includes/compute/gpu-platforms-api.md) %}


       * `resources` — количество ядер vCPU и объем RAM, доступные ВМ. Значения должны соответствовать выбранной [платформе](../../concepts/vm-platforms.md).
       * `boot_disk` — настройки загрузочного [диска](../../concepts/disk.md). Укажите идентификатор выбранного [образа](../../concepts/image.md). Вы можете получить идентификатор образа из [списка публичных образов](../images-with-pre-installed-software/get-list.md).

         {% include [gpu-os](../../../_includes/compute/gpu-os.md) %}

       * `network_interface` — настройка [сети](../../../vpc/concepts/network.md#network). Укажите идентификатор выбранной [подсети](../../../vpc/concepts/network.md#network). Чтобы автоматически назначить ВМ [публичный IP-адрес](../../../vpc/concepts/address.md#public-addresses), укажите `nat = true`.
       * `metadata` — в метаданных необходимо передать открытый ключ для SSH-доступа на ВМ. Подробнее в разделе [{#T}](../../concepts/vm-metadata.md).
     * `yandex_vpc_network` — описание облачной сети.
     * `yandex_vpc_subnet` — описание подсети, к которой будет подключена ВМ.

     {% note info %}

     Если у вас уже есть подходящие ресурсы (облачная сеть и подсеть), описывать их повторно не нужно. Используйте их имена и идентификаторы в соответствующих параметрах.

     {% endnote %}

     Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}/).

  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../../../_tutorials/terraform-validate-plan-apply.md) %}

     После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

{% endlist %}

{% include [ip-fqdn-connection](../../../_includes/ip-fqdn-connection.md) %}

#### См. также {#see-also}

* Узнайте, как [изменить конфигурацию ВМ](../vm-control/vm-update-resources.md).