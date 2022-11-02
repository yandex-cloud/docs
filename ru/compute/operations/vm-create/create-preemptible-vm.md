# Сделать виртуальную машину прерываемой

Вы можете [создать прерываемую](#create-preemptible) виртуальную машину или [изменить тип](#preemptible-to-regular) существующей ВМ.

## Создать прерываемую ВМ {#create-preemptible}

Чтобы создать [прерываемую](../../concepts/preemptible-vm.md) виртуальную машину:

{% list tabs %}

- Консоль управления

  Чтобы создать виртуальную машину:
  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет создана виртуальная машина.
  1. В списке сервисов выберите **{{ compute-name }}**.
  1. Нажмите кнопку **Создать ВМ**.
  1. В блоке **Базовые параметры**:
      * Введите имя и описание ВМ. Требования к имени:

          {% include [name-format](../../../_includes/name-format.md) %}

          {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}

      * Выберите [зону доступности](../../../overview/concepts/geo-scope.md), в которой будет находиться виртуальная машина.

  1. В блоке **Выбор образа/загрузочного диска** выберите один из [образов](../../operations/images-with-pre-installed-software/get-list.md).

  1. (опционально) В блоке **Диски и файловые хранилища** на вкладке **Диски** настройте загрузочный диск:
      * Выберите [тип диска](../../concepts/disk.md#disks_types).
      * Укажите нужный размер диска.

          Если вы хотите создать виртуальную машину из существующего диска, в блоке **Диски и файловые хранилища** [добавьте диск](./create-from-disks.md):
          * Нажмите кнопку **Добавить диск**.
          * Введите имя диска.
          * Выберите [тип диска](../../concepts/disk.md#disks_types).
          * Укажите нужный размер блока.
          * Укажите нужный размер диска.
          * (опционально) Включите опцию **Удалять вместе с ВМ**, если нужно автоматически удалять диск при удалении ВМ, к которой он будет подключен.
          * Выберите наполнение `Диск`.
          * Нажмите кнопку **Добавить**.

    1. (опционально) В блоке **Диски и файловые хранилища** на вкладке **Файловые хранилища** подключите [файловое хранилище](../../concepts/filesystem.md):
      * Нажмите кнопку **Подключить файловое хранилище**.
      * В открывшемся окне выберите файловое хранилище.
      * Введите имя устройства.
      * Нажмите кнопку **Подключить файловое хранилище**.

  1. В блоке **Вычислительные ресурсы**:
      * Выберите [платформу](../../concepts/vm-platforms.md).
      * Укажите [гарантированную долю](../../../compute/concepts/performance-levels.md) и необходимое количество vCPU, а также объем RAM.
      * Включите опцию **Прерываемая**.
      * (опционально) Включите [программно-ускоренную сеть](../../concepts/software-accelerated-network.md).

  1. В блоке **Сетевые настройки**:

      {% include [network-settings](../../../_includes/compute/network-settings.md) %}

  1. В блоке **Доступ** укажите данные для доступа на виртуальную машину:
      * (опционально) Выберите или создайте [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md). Использование сервисного аккаунта позволяет гибко настраивать права доступа к ресурсам.
      * В поле **Логин** введите имя пользователя.

          {% note alert %}

          Не используйте логин `root` или другие имена, зарезервированные операционной системой. Для выполнения операций, требующих прав суперпользователя, используйте команду `sudo`.

          {% endnote %}

      * В поле **SSH-ключ** вставьте содержимое файла [открытого ключа](../../operations/vm-connect/ssh.md#creating-ssh-keys).
      * Если требуется, разрешите доступ к [серийной консоли](../../operations/serial-console/index.md).

  1. Нажмите кнопку **Создать ВМ**. 

  Виртуальная машина появится в списке.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания виртуальной машины:

      ```
      yc compute instance create --help
      ```

  1. Подготовьте пару ключей (открытый и закрытый) для SSH-доступа на виртуальную машину.
  1. Выберите один из публичных [образов](../images-with-pre-installed-software/get-list.md) {{ marketplace-name }} на базе операционной системы Linux (например, [CentOS 7](/marketplace/products/yc/centos-7)).

      {% include [standard-images](../../../_includes/standard-images.md) %}

  1.  Создайте виртуальную машину в каталоге по умолчанию:

      ```
      yc compute instance create \
        --name first-preemptible-instance \
        --zone {{ region-id }}-a \
        --network-interface subnet-name=default-a,nat-ip-version=ipv4 \
        --preemptible \
        --create-boot-disk image-folder-id=standard-images,image-family=centos-7 \
        --ssh-key ~/.ssh/id_ed25519.pub
      ```


      Данная команда создаст прерываемую виртуальную машину со следующими характеристиками:

      * С именем `first-preemptible-instance`.
      * С OC CentOS 7.
      * В зоне доступности `{{ region-id }}-a`.
      * В подсети `default-a`.
      * С публичным IP.

      Чтобы создать виртуальную машину без публичного IP, исключите опцию `nat-ip-version=ipv4`.

      Требования к имени виртуальной машины:

      {% include [name-format](../../../_includes/name-format.md) %}

      {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}

- API

  Воспользуйтесь методом [Create](../../api-ref/Instance/create.md) для ресурса `Instance`.

- {{ TF }}

  Если у вас ещё нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).  

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

     ```
     resource "yandex_compute_instance" "vm-1" {

       name        = "preemptible-vm"
       platform_id = "standard-v3"
       zone        = "<зона доступности>"

       resources {
         cores  = <количество ядер vCPU>
         memory = <объем RAM в ГБ>
       }

       boot_disk {
         initialize_params {
           image_id = "<идентификатор образа>"
         }
       }

       network_interface {
         subnet_id = "${yandex_vpc_subnet.subnet-1.id}"
         nat       = true
       }

       metadata = {
         ssh-keys = "<имя пользователя>:<содержимое SSH-ключа>}"
       }

       scheduling_policy {
         preemptible = true
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

     * `yandex_compute_instance` — описание [виртуальной машины](../../concepts/vm.md):
       * `name` — имя виртуальной машины.
       * `platform_id` — [платформа](../../concepts/vm-platforms.md).
       * `zone` — идентификатор [зоны доступности](../../../overview/concepts/geo-scope.md), в которой будет находиться виртуальная машина.
       * `resources` — количество ядер vCPU и объем RAM, доступные виртуальной машине. Значения должны соответствовать выбранной [платформе](../../concepts/vm-platforms.md).
       * `boot_disk` — настройки загрузочного диска. Укажите идентификатор выбранного образа. Вы можете получить идентификатор образа из [списка публичных образов](../images-with-pre-installed-software/get-list.md).
       * `network_interface` — настройка сети. Укажите идентификатор выбранной подсети. Чтобы автоматически назначить виртуальной машине публичный IP-адрес, укажите `nat = true`.
       * `metadata` — в метаданных необходимо передать открытый ключ для SSH-доступа на виртуальную машину. Подробнее в разделе [{#T}](../../concepts/vm-metadata.md).
       * `scheduling_policy` — политика планирования. Чтобы создать прерываемую виртуальную машину, укажите `preemptible = true`.
     * `yandex_vpc_network` — описание [облачной сети](../../../vpc/concepts/network.md#network).
     * `yandex_vpc_subnet` — описание [подсети](../../../vpc/concepts/network.md#network), к которой будет подключена виртуальная машина.

     {% note info %}

     Если у вас уже есть подходящие ресурсы (облачная сеть и подсеть), описывать их повторно не нужно. Используйте их имена и идентификаторы в соответствующих параметрах.

     {% endnote %}

     Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}/).

  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет. 

  1. Разверните облачные ресурсы.

     1. Если в конфигурации нет ошибок, выполните команду:

        ```
        terraform apply
        ```

     1. Подтвердите создание ресурсов.

     После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

{% endlist %}

{% include [ip-fqdn-connection](../../../_includes/ip-fqdn-connection.md) %}

## Сменить тип ВМ {#preemptible-to-regular}

Чтобы сменить тип ВМ, например, сделать ВМ непрерываемой:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится виртуальная машина.
  1. В списке сервисов выберите **{{ compute-name }}**.
  1. Напротив имени нужной ВМ нажмите значок ![image](../../../_assets/options.svg) и выберите **Остановить**.
  1. Подтвердите действие. Статус ВМ изменится на `Stopped`.
  1. Напротив имени ВМ нажмите ![image](../../../_assets/options.svg) и выберите **Редактировать**.
  1. В блоке **Вычислительные ресурсы** выключите опцию **Прерываемая**.
  1. Нажмите кнопку **Сохранить изменения**.
  1. Нажмите кнопку ![image](../../../_assets/compute/run-vm.svg) **Запустить**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для остановки виртуальной машины:

      ```
      yc compute instance stop --help
      ```

  1. Получите список всех виртуальных машин в каталоге по умолчанию:

      {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужной машины, например `first-instance`.

  1. Остановите виртуальную машину:

     ```
     yc compute instance stop <идентификатор или имя виртуальной машины>
     ```

     Результат:

     ```
     done (15s)
     ```

  1. Измените параметры виртуальной машины:

     ```
     yc compute instance update <идентификатор или имя виртуальной машины> \
       --preemptible=false
     ```

     Результат:

     ```
     done (1s)
     id: fhm0b28lgfp4tkoa3jl6
     folder_id: b1ghgf288nvg541tgu73
     created_at: "2022-04-12T08:40:09Z"
     name: first-instance
     zone_id: {{ region-id }}-b
     platform_id: standard-v1
     resources:
       memory: "1073741824"
       cores: "2"
       core_fraction: "5"
     status: STOPPED
     boot_disk:
       mode: READ_WRITE
       device_name: epd8gvafrf37dmp5ofg7
       auto_delete: true
       disk_id: epd8gvafrf37dmp5ofg7
     network_interfaces:
     - index: "0"
       mac_address: d0:0d:1e:78:30:77
       subnet_id: e2lu3b6tbdj1cq3oa8ao
       primary_v4_address:
         address: 10.2.0.14
         one_to_one_nat:
           ip_version: IPV4
     fqdn: example-instance.{{ region-id }}.internal
     scheduling_policy: {}
     network_settings:
       type: STANDARD
     placement_policy: {}
     ```

  1. Вновь запустите виртуальную машину:

     ```
     yc compute instance start <идентификатор или имя виртуальной машины>
     ```

     Результат:

     ```
     done (11s)
     id: fhm0b28lgfp4tkoa3jl6
     folder_id: b1ghgf288nvg541tgu73
     created_at: "2022-04-12T08:40:09Z"
     name: first-instance
     zone_id: {{ region-id }}-b
     platform_id: standard-v1
     resources:
       memory: "1073741824"
       cores: "2"
       core_fraction: "5"
     status: RUNNING
     boot_disk:
       mode: READ_WRITE
       device_name: epd8gvafrf37dmp5ofg7
       auto_delete: true
       disk_id: epd8gvafrf37dmp5ofg7
     network_interfaces:
     - index: "0"
       mac_address: d0:0d:1e:78:30:77
       subnet_id: e2lu3b6tbdj1cq3oa8ao
       primary_v4_address:
         address: 10.2.0.14
         one_to_one_nat:
           address: 51.250.97.205
           ip_version: IPV4
     fqdn: example-instance.{{ region-id }}.internal
     scheduling_policy: {}
     network_settings:
       type: STANDARD
     placement_policy: {}
     ```

- API

  Воспользуйтесь методом [update](../../api-ref/Instance/update.md) для ресурса [Instance](../../api-ref/Instance/). В теле запроса в блоке `schedulingPolicy` укажите `"preemptible": false`.

- {{ TF }}

  Если у вас ещё нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).  

  1. Найдите в конфигурационном файле описание политики планирования ВМ, которую нужно сделать непрерываемой:

       ```
       scheduling_policy {
         preemptible = true
       }
       ```

  1. Удалите поле `scheduling_policy` со значением `preemptible = true`:

     Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}/).

  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет. 

  1. Разверните облачные ресурсы.

     1. Если в конфигурации нет ошибок, выполните команду:

        ```
        terraform apply
        ```

     1. Подтвердите создание ресурсов.

     После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

{% endlist %}

Тарификация виртуальной машины после этого изменится. Подробнее о [тарификации виртуальных машин](../../pricing.md#prices-instance-resources).

#### См. также {#see-also}

* [{#T}](../vm-connect/ssh.md)
