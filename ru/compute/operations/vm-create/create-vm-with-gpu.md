# Создание виртуальной машины с GPU

В этом разделе приведена инструкция для создания виртуальной машины с GPU. Подробнее с конфигурациями виртуальных машин вы можете ознакомиться в разделе [{#T}](../../concepts/gpus.md).

По умолчанию в облаке установлена нулевая [квота](../../concepts/limits.md#quotas) на создание виртуальных машин с GPU. Чтобы изменить квоту, обратитесь в [техническую поддержку]({{ link-console-support }}).
     
{% include [gpu-zones](../../../_includes/compute/gpu-zones.md) %}

{% list tabs %}

- Консоль управления

  {% include [create-vm-with-gpu](../../../_includes/compute/create/create-vm-with-gpu-console.md) %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания виртуальной машины:

      ```
      $ yc compute instance create --help
      ```

  1. Подготовьте [пару ключей](../vm-connect/ssh.md#creating-ssh-keys) (открытый и закрытый) для SSH-доступа на виртуальную машину.
  1. Выберите один из публичных [образов](../images-with-pre-installed-software/get-list.md).

      {% include [gpu-images](../../../_includes/gpu-images.md) %}

      {% include [gpu-os](../../../_includes/compute/gpu-os.md) %}

  1. Создайте виртуальную машину в каталоге по умолчанию. Укажите следующие параметры:

      * Имя виртуальной машины.

          {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}

      * [Зону доступности](../../../overview/concepts/geo-scope.md).
      * Идентификатор [платформы](../../concepts/vm-platforms.md):
        * `gpu-standard-v1` для платформы {{ v100-broadwell }},
        * `gpu-standard-v2` для платформы {{ v100-cascade-lake }},
        * `gpu-standard-v3` для платформы {{ a100-epyc }}.
      * [Количество vCPU](../../concepts/gpus.md).
      * [Размер RAM](../../concepts/gpus.md).
      * [Количество GPU](../../concepts/gpus.md).
      * При необходимости сделайте виртуальную машину [прерываемой](../../concepts/preemptible-vm.md) с помощью опции `--preemptible`.
      * [Образ](../images-with-pre-installed-software/get-list.md) операционной системы. `ubuntu-1604-lts-gpu` — образ Ubuntu 16.04.6 LTS c CUDA драйверами.
      * Публичный IP. Чтобы создать виртуальную машину без публичного IP, исключите опцию `nat-ip-version=ipv4`.

      Например:

      ```
      $ yc compute instance create \
            --name gpu-instance \
            --zone ru-central1-a \
            --platform=gpu-standard-v1 \
            --cores=8 \
            --memory=96 \
            --gpus=1 \
            --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
            --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1604-lts-gpu \
            --ssh-key ~/.ssh/id_rsa.pub
      ```

      Будет создана виртуальная машина `gpu-instance` с одним GPU, 8 vCPU и 96 ГБ RAM:

      ```
      $ yc compute instance get --full gpu-instance
          ...
          name: gpu-instance
          zone_id: ru-central1-a
          platform_id: gpu-standard-v1
          resources:
            memory: "103079215104"
            cores: "8"
            core_fraction: "100"
            gpus: "1"
          status: RUNNING
          ...
      ```

- API

  Чтобы создать виртуальную машину, воспользуйтесь методом [Create](../../api-ref/Instance/create.md) для ресурса `Instance`.

- Terraform

  Если у вас ещё нет Terraform, [установите его и настройте провайдер {{ yandex-cloud }}](../../../solutions/infrastructure-management/terraform-quickstart.md#install-terraform).  

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

       {% note info %}

       Если у вас уже есть подходящие ресурсы (облачная сеть и подсеть), описывать их повторно не нужно. Используйте их имена и идентификаторы в соответствующих параметрах.

       {% endnote %}

     * `yandex_compute_instance` — описание [виртуальной машины](../../concepts/vm.md):
       * `name` — имя виртуальной машины.
       * `platform_id` — идентификатор [платформы](../../concepts/vm-platforms.md):
         * `gpu-standard-v1` для платформы Intel Broadwell with NVIDIA® Tesla® V100,
         * `gpu-standard-v2` для платформы Intel Cascade Lake with NVIDIA® Tesla® V100,
         * `gpu-standard-v3` для платформы AMD Epyc 7662 with NVIDIA® Ampere® A100.
       * `resources` — количество ядер vCPU и объем RAM, доступные виртуальной машине. Значения должны соответствовать выбранной [платформе](../../concepts/vm-platforms.md).
       * `boot_disk` — настройки загрузочного диска. Укажите идентификатор выбранного образа. Вы можете получить идентификатор образа из [списка публичных образов](../images-with-pre-installed-software/get-list.md).

         {% include [gpu-os](../../../_includes/compute/gpu-os.md) %}

       * `network_interface` — настройка сети. Укажите идентификатор выбранной подсети. Чтобы автоматически назначить виртуальной машине публичный IP-адрес, укажите `nat = true`.
       * `metadata` — в метаданных необходимо передать открытый ключ для SSH-доступа на виртуальную машину. Подробнее в разделе [{#T}](../../concepts/vm-metadata.md).
     * `yandex_vpc_network` — описание [облачной сети](../../../vpc/concepts/network.md#network).
     * `yandex_vpc_subnet` — описание [подсети](../../../vpc/concepts/network.md#network), к которой будет подключена виртуальная машина.

     Пример структуры конфигурационного файла:

     ```
     resource "yandex_compute_instance" "vm-1" {

       name        = "vm-with-gpu"
       platform_id = "gpu-standard-v1"

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

     Более подробную информацию о ресурсах, которые вы можете создать с помощью Terraform, см. в [документации провайдера](https://www.terraform.io/docs/providers/yandex/index.html).

  2. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     2. Выполните проверку с помощью команды:

        ```
        $ terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, Terraform на них укажет. 

  3. Разверните облачные ресурсы.

     1. Если в конфигурации нет ошибок, выполните команду:

        ```
        $ terraform apply
        ```

     2. Подтвердите создание ресурсов.

     После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

{% endlist %}

{% include [ip-fqdn-connection](../../../_includes/ip-fqdn-connection.md) %}

#### См. также {#see-also}

- Узнайте, как [изменить конфигурацию виртуальной машины](../vm-control/vm-update-resources.md).
