# Создать прерываемую виртуальную машину

Чтобы создать прерываемую виртуальную машину:

{% list tabs %}

- Консоль управления

  1. Откройте каталог, в котором будет создана виртуальная машина.
  1. Нажмите кнопку **Создать ресурс**.
  1. Выберите **Виртуальная машина**.
  1. В поле **Имя** введите имя виртуальной машины.

      {% include [name-format](../../../_includes/name-format.md) %}

      {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}

  1. Выберите [зону доступности](../../../overview/concepts/geo-scope.md), в которой будет находиться виртуальная машина.
  1. Выберите один из публичных [образов](../../operations/images-with-pre-installed-software/get-list.md) на базе операционной системы Linux.
  1. В блоке **Вычислительные ресурсы**:
      - Выберите [платформу](../../concepts/vm-platforms.md).
      - Укажите необходимое количество вычислительных ресурсов.
      - Установите флажок **Прерываемая**.
  1. В блоке **Сетевые настройки** нажмите кнопку **Добавить сеть**.
  1. В открывшемся окне выберите, к какой подсети необходимо подключить виртуальную машину при создании.
  1. В поле **Публичный адрес** выберите:
      - **Автоматически** — чтобы назначить публичный IP-адрес автоматически. Адрес выделяется из пула адресов {{ yandex-cloud }}.
      - **Список** — чтобы выбрать публичный IP-адрес из списка статических адресов. Подробнее читайте в разделе [{#T}](../../../vpc/operations/set-static-ip.md) документации сервиса {{ vpc-name }}.
      - **Без адреса** — чтобы не назначать публичный IP-адрес.
  1. Выберите [подходящие группы безопасности](../../../vpc/concepts/security-groups.md) (если соответствующего поля нет, для виртуальной машины будет разрешен любой входящий и исходящий трафик).
  1. Укажите данные для доступа на виртуальную машину:
      - В поле **Логин** введите имя пользователя.
      - В поле **SSH ключ** вставьте содержимое файла открытого ключа.
          Пару ключей для подключения по SSH необходимо создать самостоятельно. Подробнее читайте в разделе [{#T}](../vm-connect/ssh.md#creating-ssh-keys).
  1. Нажмите кнопку **Создать ВМ**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания виртуальной машины:

      ```
      $ yc compute instance create --help
      ```

  1. Подготовьте пару ключей (открытый и закрытый) для SSH-доступа на виртуальную машину.
  1. Выберите один из публичных [образов](../images-with-pre-installed-software/get-list.md) на базе операционной системы Linux (например, CentOS 7).

      {% include [standard-images](../../../_includes/standard-images.md) %}

  1.  Создайте виртуальную машину в каталоге по умолчанию:

      ```
      $ yc compute instance create \
          --name first-preemptible-instance \
          --zone ru-central1-a \
          --network-interface subnet-name=default-a,nat-ip-version=ipv4 \
          --preemptible \
          --create-boot-disk image-folder-id=standard-images,image-family=centos-7 \
          --ssh-key ~/.ssh/id_rsa.pub
      ```

      Данная команда создаст прерываемую виртуальную машину со следующими характеристиками:

      - С именем `first-preemptible-instance`.
      - С OC CentOS 7.
      - В зоне доступности `ru-central1-a`.
      - В подсети `default-a`.
      - С публичным IP.

      Чтобы создать виртуальную машину без публичного IP, исключите опцию `nat-ip-version=ipv4`.

      {% include [name-format](../../../_includes/name-format.md) %}

      {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}

- API

  Воспользуйтесь методом [Create](../../api-ref/Instance/create.md) для ресурса `Instance`.

- Terraform

  Если у вас ещё нет Terraform, [установите его и настройте провайдер {{ yandex-cloud }}](../../../solutions/infrastructure-management/terraform-quickstart.md#install-terraform).  

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

       {% note info %}

       Если у вас уже есть подходящие ресурсы (облачная сеть и подсеть), описывать их повторно не нужно. Используйте их имена и идентификаторы в соответствующих параметрах.

       {% endnote %}

     * `yandex_compute_instance` — описание [виртуальной машины](../../concepts/vm.md):
       * `name` — имя виртуальной машины.
       * `platform_id` — [платформа](../../concepts/vm-platforms.md).
       * `resources` — количество ядер vCPU и объем RAM, доступные виртуальной машине. Значения должны соответствовать выбранной [платформе](../../concepts/vm-platforms.md).
       * `boot_disk` — настройки загрузочного диска. Укажите идентификатор выбранного образа. Вы можете получить идентификатор образа из [списка публичных образов](../images-with-pre-installed-software/get-list.md).
       * `network_interface` — настройка сети. Укажите идентификатор выбранной подсети. Чтобы автоматически назначить виртуальной машине публичный IP-адрес, укажите `nat = true`.
       * `metadata` — в метаданных необходимо передать открытый ключ для SSH-доступа на виртуальную машину. Подробнее в разделе [{#T}](../../concepts/vm-metadata.md).
       * `scheduling_policy` — политика планирования. Чтобы создать прерываемую виртуальную машину, укажите `preemptible = true`.
     * `yandex_vpc_network` — описание [облачной сети](../../../vpc/concepts/network.md#network).
     * `yandex_vpc_subnet` — описание [подсети](../../../vpc/concepts/network.md#network), к которой будет подключена виртуальная машина.

     Пример структуры конфигурационного файла:

     ```
     resource "yandex_compute_instance" "vm-1" {

       name        = "preemptible-vm"
       platform_id = "standard-v3"

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

- [{#T}](../vm-connect/ssh.md)
