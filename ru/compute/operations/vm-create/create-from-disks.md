# Создать виртуальную машину из набора дисков

Создать виртуальную машину можно из существующих дисков. Диски должны находиться в одной из зон доступности и не быть добавленными к другим виртуальным машинам.

{% include [disk-auto-delete](../../_includes_service/disk-auto-delete.md) %}

Чтобы создать виртуальную машину из набора дисков:

{% list tabs %}

- Консоль управления
  
  1. В консоли управления выберите каталог, в котором нужно создать виртуальную машину.
  1. Выберите сервис **{{ compute-name }}**.
  1. На странице **Виртуальные машины** нажмите кнопку **Создать ВМ**.
  1. В блоке **Базовые параметры** введите имя и описание ВМ.
  
      {% include [name-format](../../../_includes/name-format.md) %}
  
      {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}
  
  1. В блоке **Зона доступности** выберите нужную зону доступности. [Подробнее о географии {{ yandex-cloud }}](../../../overview/concepts/geo-scope.md).
  1. Выберите один из публичных [образов](../../operations/images-with-pre-installed-software/get-list.md).
  1. В блоке **Диски** нажмите **Добавить диск**:
      - Введите имя диска.
      - Укажите нужный размер диска.
      - Выберите [тип диска](../../concepts/disk.md#disks_types).
      - В поле **Наполнение** выберите **Диск**. Если диска нет, [создайте](../disk-create/empty.md) его.
  1. В блоке **Вычислительные ресурсы**:
      - Выберите [платформу](../../concepts/vm-platforms.md).
      - Выберите [уровень производительности](../../concepts/performance-levels.md) и необходимое количество vCPU, а также объем RAM.
  1. В блоке **Сетевые настройки** выберите сеть из списка или создайте новую, нажав кнопку **Создать новую сеть**.
  1. Выберите нужную подсеть из списка или создайте новую, нажав кнопку **Создать новую подсеть**.
  1. Выберите нужный вариант публичного IP-адреса.
  1. Выберите [подходящие группы безопасности](../../../vpc/concepts/security-groups.md) (если соответствующего поля нет, для виртуальной машины будет разрешен любой входящий и исходящий трафик).
  1. В блоке **Доступ** укажите данные для доступа на виртуальную машину:
      - В поле **Логин** введите имя пользователя.
      - В поле **SSH-ключ** вставьте содержимое файла открытого ключа. Пару ключей для подключения по SSH необходимо [создать](../vm-connect/ssh.md#creating-ssh-keys) самостоятельно.
  1. Нажмите кнопку **Создать ВМ**.
  
- CLI
  
  {% include [cli-install](../../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
  
  1. Посмотрите описание команды CLI для создания виртуальной машины:
  
      ```
      $ yc compute instance create --help
      ```
  
  1. Получите список дисков в каталоге по умолчанию:
  
      {% include [compute-disk-list](../../../_includes/compute/disk-list.md) %}
  
  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужных дисков.
  1. Создайте виртуальную машину в каталоге по умолчанию:
  
      ```
      $ yc compute instance create \
          --name first-instance \
          --zone ru-central1-a \
          --network-interface subnet-name=default-a,nat-ip-version=ipv4 \
          --use-boot-disk disk-name=first-disk \
          --attach-disk disk-name=second-disk \
          --ssh-key ~/.ssh/id_rsa.pub
      ```
  
      Данная команда создаст виртуальную машину:
  
      - С именем `first-instance`.
      - В зоне доступности `ru-central1-a`.
      - В подсети `default-a`.
      - С публичным IP и двумя дисками.
  
      Чтобы создать виртуальную машину без публичного IP, исключите флаг `--public-ip`.
  
      {% include [name-format](../../../_includes/name-format.md) %}
  
      {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}
  
      Чтобы указать необходимость удаления диска при удалении машины, установите флаг `--auto-delete`:
  
      ```
      yc compute instance create \
      --name first-instance \
      --zone ru-central1-a \
      --network-interface subnet-name=default-a,nat-ip-version=ipv4 \
      --use-boot-disk disk-name=first-disk,auto-delete=yes \
      --attach-disk disk-name=second-disk,auto-delete=yes \
      --ssh-key ~/.ssh/id_rsa.pub
      ```
  
- API
  
  Воспользуйтесь методом [Create](../../api-ref/Instance/create.md) для ресурса `Instance`.

- Terraform

  Если у вас ещё нет Terraform, [установите его и настройте провайдер {{ yandex-cloud }}](../../../solutions/infrastructure-management/terraform-quickstart.md#install-terraform).  

  Чтобы создать виртуальную машину из набора дисков:

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

       {% note info %}

       Если у вас уже есть подходящие ресурсы (облачная сеть и подсеть), описывать их повторно не нужно. Используйте их имена и идентификаторы в соответствующих параметрах.

       {% endnote %}

     * `yandex_compute_instance` — описание [виртуальной машины](../../concepts/vm.md):
       * `name` — имя виртуальной машины.
       * `platform_id` — [платформа](../../concepts/vm-platforms.md).
       * `resources` — количество ядер vCPU и объем RAM, доступные виртуальной машине. Значения должны соответствовать выбранной [платформе](../../concepts/vm-platforms.md).
       * `boot_disk` — настройки загрузочного диска. Укажите идентификатор диска. Если у вас нет готового загрузочного диска, укажите [идентификатор публичного образа](../images-with-pre-installed-software/get-list.md) с помощью параметра `image_id`.
       * `secondary_disk` — дополнительный диск для подключения к виртуальной машине. Укажите идентификатор дополнительного диска. Если диска нет, [создайте](../disk-create/empty.md) его.
       * `network_interface` — настройка сети. Укажите идентификатор выбранной подсети. Чтобы автоматически назначить виртуальной машине публичный IP-адрес, укажите `nat = true`.
       * `metadata` — в метаданных необходимо передать открытый ключ для SSH-доступа на виртуальную машину. Подробнее в разделе [{#T}](../../concepts/vm-metadata.md). 
     * `yandex_vpc_network` — описание [облачной сети](../../../vpc/concepts/network.md#network).
     * `yandex_vpc_subnet` — описание [подсети](../../../vpc/concepts/network.md#network), к которой будет подключена виртуальная машина.

     Пример структуры конфигурационного файла:

     ```
     resource "yandex_compute_instance" "vm-1" {

       name        = "vm-from-disks"
       platform_id = "standard-v3"

       resources {
         cores  = <количество ядер vCPU>
         memory = <объем RAM в ГБ>
       }

       boot_disk {
         initialize_params {
           disk_id = "<идентификатор загрузочного диска>"
         }
       }

       secondary_disk {
         disk_id = "<идентификатор дополнительного диска>"
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
