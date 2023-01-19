# Создание виртуальной машины с GPU

В этом разделе приведена инструкция для создания виртуальной машины с GPU. Подробнее с конфигурациями ВМ вы можете ознакомиться в разделе [{#T}](../../concepts/gpus.md).

По умолчанию в облаке установлена нулевая [квота](../../concepts/limits.md#quotas) на создание ВМ с GPU. Чтобы изменить [квоту]({{ link-console-quotas }}), обратитесь в [техническую поддержку]({{ link-console-support }}).
     

{% include [gpu-zones](../../../_includes/compute/gpu-zones.md) %}



{% list tabs %}

- Консоль управления

  {% include [create-vm-with-gpu](../../../_includes/compute/create/create-vm-with-gpu-console.md) %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания ВМ:

     ```bash
     yc compute instance create --help
     ```

  1. Подготовьте [пару ключей](../vm-connect/ssh.md#creating-ssh-keys) (открытый и закрытый) для SSH-доступа на ВМ.
  1. Выберите один из публичных [образов](../images-with-pre-installed-software/get-list.md).

     {% include [gpu-images](../../../_includes/gpu-images.md) %}

     {% include [gpu-os](../../../_includes/compute/gpu-os.md) %}

  1. Создайте ВМ в каталоге по умолчанию:

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
     * `platform` – идентификатор [платформы](../../concepts/vm-platforms.md):
       * `gpu-standard-v1` для платформы {{ v100-broadwell }}.
       * `gpu-standard-v2` для платформы {{ v100-cascade-lake }}.
       * `gpu-standard-v3` для платформы {{ a100-epyc }}.
     * `cores` – [количество vCPU](../../concepts/gpus.md).
     * `memory` – [размер RAM](../../concepts/gpus.md).
     * `gpus` – [количество GPU](../../concepts/gpus.md).
     * `preemptible` – если нужно сделать ВМ [прерываемой](../../concepts/preemptible-vm.md).
     * `create-boot-disk` – [образ](../images-with-pre-installed-software/get-list.md) операционной системы. `ubuntu-1604-lts-gpu` — образ [Ubuntu 16.04 LTS GPU](/marketplace/products/yc/ubuntu-16-04-lts-gpu) с CUDA драйверами.
     * `nat-ip-version=ipv4` – публичный IP. Чтобы создать ВМ без публичного IP, исключите параметр.

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

  Чтобы создать ВМ, воспользуйтесь методом [Create](../../api-ref/Instance/create.md) для ресурса `Instance`.

- {{ TF }}

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

     ```
     resource "yandex_compute_instance" "vm-1" {

       name        = "vm-with-gpu"
       platform_id = "gpu-standard-v3"
       zone        = "<зона доступности>"

       resources {
         cores  = <количество ядер vCPU>
         memory = <объем RAM в ГБ>
         gpus   = <количество GPU>
       }

       boot_disk {
         initialize_params {
           image_id = "fdv4f5kv5cvf3ohu4flt"
         }
       }

       network_interface {
         subnet_id = "${yandex_vpc_subnet.subnet-1.id}"
         nat       = true
       }

       metadata = {
         ssh-keys = "<имя пользователя>:<содержимое SSH-ключа>"
       }
     }

     resource "yandex_vpc_network" "network-1" {
       name = "network1"
     }

     resource "yandex_vpc_subnet" "subnet-1" {
       name       = "subnet1"
       zone       = "<зона доступности>"
       network_id = "${yandex_vpc_network.network-1.id}"
     }
     ```

     Где:

     * `yandex_compute_instance` — описание [ВМ](../../concepts/vm.md):
       * `name` — имя ВМ.
       * `platform_id` — идентификатор [платформы](../../concepts/vm-platforms.md):
         * `gpu-standard-v1` для платформы Intel Broadwell with NVIDIA® Tesla® V100.
         * `gpu-standard-v2` для платформы Intel Cascade Lake with NVIDIA® Tesla® V100.
         * `gpu-standard-v3` для платформы AMD Epyc 7662 with NVIDIA® Ampere® A100.
       * `zone` — идентификатор [зоны доступности](../../../overview/concepts/geo-scope.md), в которой будет находиться виртуальная машина.
       * `resources` — количество ядер vCPU и объем RAM, доступные ВМ. Значения должны соответствовать выбранной [платформе](../../concepts/vm-platforms.md).
       * `boot_disk` — настройки загрузочного диска. Укажите идентификатор выбранного образа. Вы можете получить идентификатор образа из [списка публичных образов](../images-with-pre-installed-software/get-list.md).

         {% include [gpu-os](../../../_includes/compute/gpu-os.md) %}

       * `network_interface` — настройка сети. Укажите идентификатор выбранной подсети. Чтобы автоматически назначить ВМ публичный IP-адрес, укажите `nat = true`.
       * `metadata` — в метаданных необходимо передать открытый ключ для SSH-доступа на ВМ. Подробнее в разделе [{#T}](../../concepts/vm-metadata.md).
     * `yandex_vpc_network` — описание [облачной сети](../../../vpc/concepts/network.md#network).
     * `yandex_vpc_subnet` — описание [подсети](../../../vpc/concepts/network.md#network), к которой будет подключена ВМ.

     {% note info %}

     Если у вас уже есть подходящие ресурсы (облачная сеть и подсеть), описывать их повторно не нужно. Используйте их имена и идентификаторы в соответствующих параметрах.

     {% endnote %}

     Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}/).

  1. Проверьте корректность конфигурационных файлов.
     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```bash
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
  1. Разверните облачные ресурсы.
     1. Если в конфигурации нет ошибок, выполните команду:

        ```bash
        terraform apply
        ```

     1. Подтвердите создание ресурсов.

     После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

{% endlist %}

{% include [ip-fqdn-connection](../../../_includes/ip-fqdn-connection.md) %}

#### См. также {#see-also}

* Узнайте, как [изменить конфигурацию ВМ](../vm-control/vm-update-resources.md).
