# Однонодовый файловый сервер с помощью Terraform

Чтобы создать инфраструктуру для [однонодового файлового сервера](index.md) с помощью Terraform:

1. [Подготовьте облако к работе](#before-begin).
1. [Создайте инфраструктуру](#deploy).
1. [Настройте Samba и NFS](#setup-samba-nfs).
1. [Протестируйте работу файлового сервера](#test-file-server).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md) и [привяжите](../../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки однонодового файлового сервера входит:
* плата за постоянно запущенную [ВМ](../../concepts/vm.md) ([тарифы Yandex Compute Cloud](../../pricing.md));
* плата за использование динамического или статического [публичного IP-адреса](../../../vpc/concepts/address.md#public-adresses) ([тарифы Yandex Virtual Private Cloud](../../../vpc/pricing.md));
* плата за исходящий трафик ([тарифы Yandex Virtual Private Cloud](../../../vpc/pricing.md#prices-traffic)).

## Создайте инфраструктуру {#deploy}

[Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).

Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

Для создания инфраструктуры с помощью Terraform:
1. [Установите Terraform](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [получите данные для аутентификации](../../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) и укажите источник для установки провайдера Yandex Cloud (раздел [Настройте провайдер](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).
1. Подготовьте файлы с описанием инфраструктуры:

   {% list tabs group=infrastructure_description %}

   - Готовый архив {#ready}

     1. Создайте папку для файлов.
     1. Скачайте [архив](https://storage.yandexcloud.net/doc-files/single-node-file-server.zip) (1 КБ).
     1. Разархивируйте архив в папку. В результате в ней должны появиться конфигурационный файл `single-node-file-server.tf`.

   - Вручную {#manual}

     1. Создайте папку для файлов.
     1. Создайте в папке конфигурационный файл `single-node-file-server.tf`:

        {% cut "single-node-file-server.tf" %}

        ```hcl
        terraform {
          required_providers {
            yandex = {
              source  = "yandex-cloud/yandex"
              version = ">= 0.47.0"
            }
          }
        }
        
        provider "yandex" {
          zone = "ru-central1-a"
        }
        
        resource "yandex_vpc_network" "network-1" {
          name = "network1"
        }
        
        resource "yandex_vpc_subnet" "subnet-1" {
          name           = "subnet1"
          zone           = "ru-central1-a"
          network_id     = yandex_vpc_network.network-1.id
          v4_cidr_blocks = ["192.168.1.0/24"]
        }
        
        resource "yandex_vpc_security_group" "fileserver-tutorial-sg" {
          name       = "fileserver-tutorial-sg"
          network_id = yandex_vpc_network.network-1.id
        
          egress {
            protocol       = "ANY"
            description    = "any"
            v4_cidr_blocks = ["0.0.0.0/0"]
          }
        
          ingress {
            protocol       = "TCP"
            description    = "ext-http"
            v4_cidr_blocks = ["0.0.0.0/0"]
            port           = 80
          }
        
          ingress {
            protocol       = "TCP"
            description    = "ext-ssh"
            v4_cidr_blocks = ["0.0.0.0/0"]
            port           = 22
          }
        
          ingress {
            protocol       = "TCP"
            description    = "ext-https"
            v4_cidr_blocks = ["0.0.0.0/0"]
            port           = 443
          }
        
          ingress {
            protocol       = "TCP"
            description    = "ext-msql"
            v4_cidr_blocks = ["0.0.0.0/0"]
            port           = 3306
          }
        
          ingress {
            protocol       = "TCP"
            description    = "nfs"
            v4_cidr_blocks = ["0.0.0.0/0"]
            port           = 2049
          }
        }
        
        resource "yandex_compute_image" "ubuntu-1804-lts" {
          source_family = "ubuntu-1804-lts"
        }
        
        resource "yandex_compute_disk" "boot-disk-ubuntu" {
          name     = "fileserver-tutorial-disk"
          type     = "network-ssd"
          zone     = "ru-central1-a"
          size     = "100"
          image_id = yandex_compute_image.ubuntu-1804-lts.id
        }
        
        resource "yandex_compute_instance" "fileserver-tutorial" {
          name        = "fileserver-tutorial"
          platform_id = "standard-v3"
          zone        = "ru-central1-a"
        
          resources {
            core_fraction = 100
            cores         = 8
            memory        = 56
          }
        
          boot_disk {
            disk_id = yandex_compute_disk.boot-disk-ubuntu.id
          }
        
          network_interface {
            subnet_id          = yandex_vpc_subnet.subnet-1.id
            security_group_ids = [yandex_vpc_security_group.fileserver-tutorial-sg.id]
            nat                = true
          }
        
          metadata = {
            user-data = "#cloud-config\nusers:\n  - name: <имя_пользователя>\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh_authorized_keys:\n      - ${file("<путь_к_открытому_SSH-ключу>")}"
          }
        }
        ```

        {% endcut %}

   {% endlist %}

   Подробнее о параметрах используемых ресурсов в Terraform смотрите в документации провайдера:
   * [Сеть](../../../vpc/concepts/network.md#network) — [yandex_vpc_network](../../../terraform/resources/vpc_network.md).
   * [Подсети](../../../vpc/concepts/network.md#subnet) — [yandex_vpc_subnet](../../../terraform/resources/vpc_subnet.md).
   * [Группы безопасности](../../../vpc/concepts/security-groups.md) — [yandex_vpc_security_group](../../../terraform/resources/vpc_security_group.md).
   * [Образ ВМ](../../concepts/image.md) — [yandex_compute_image](../../../terraform/resources/compute_image.md).
   * [Диск](../../concepts/disk.md) — [yandex_compute_disk](../../../terraform/resources/compute_disk.md).
   * [Виртуальная машина](../../concepts/vm.md) — [yandex_compute_instance](../../../terraform/resources/compute_instance.md).

1. В блоке `metadata` укажите имя пользователя и содержимое SSH-ключа. Подробнее в разделе [Метаданные виртуальной машины](../../concepts/vm-metadata.md).
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

После создания инфраструктуры, [настройте Samba и NFS](#setup-samba-nfs).

## Настройте Samba и NFS {#setup-samba-nfs}

После того как виртуальная машина `fileserver-tutorial` перейдет в статус `RUNNING`, выполните:

1. В блоке **Сеть** на странице виртуальной машины в [консоли управления](https://console.yandex.cloud) найдите публичный IP-адрес виртуальной машины.

1. [Подключитесь](../../operations/vm-connect/ssh.md) к виртуальной машине по протоколу SSH.

   Рекомендуемый способ аутентификации при подключении по SSH — с помощью пары ключей. Не забудьте настроить использование созданной пары ключей: закрытый ключ должен соответствовать открытому ключу, переданному на виртуальную машину.

1. Настройте Samba и NFS:

   {% list tabs group=operating_system %}

   - Ubuntu {#ubuntu}

     1. Скачайте и установите Samba:

        ```bash
        sudo apt-get update
        sudo apt-get install nfs-kernel-server samba
        ```

     1. Подготовьте и смонтируйте файловую систему на диске:

        ```bash
        sudo mkfs -t ext4 -L data /dev/vdb
        ```

     1. Подготовьте и смонтируйте папку `my_folder` для хранения данных на диске:

        ```bash
        sudo mkdir /my_folder
        echo "LABEL=data /my_folder ext4 defaults 0 0" | sudo tee -a /etc/fstab
        sudo mount /my_folder
        ```

     1. Задайте конфигурацию NFS в файле `/etc/exports`. Вы можете отредактировать файл с помощью утилиты `nano`:

        ```bash
        sudo nano /etc/exports
        ```

        Добавьте в файл следующие строки:

        ```bash
        /my_folder <IP-адрес>(rw,no_subtree_check,fsid=100)
        /my_folder 127.0.0.1(rw,no_subtree_check,fsid=100)
        ```

        Где `<IP-адрес>` – IP-адрес компьютера, к которому вы будете подключать по NFS сетевой диск с данными.

     1. Задайте конфигурацию Samba в файле `/etc/samba/smb.conf`. Вы можете отредактировать файл с помощью утилиты `nano`:

        ```bash
        sudo nano /etc/samba/smb.conf
        ```

        Приведите файл к виду:

        ```bash
        [global]
           workgroup = WORKGROUP
           server string = %h server (Samba)
           dns proxy = no
           log file = /var/log/samba/log.%m
           max log size = 1000
           syslog = 0
           panic action = /usr/share/samba/panic-action %d
           server role = standalone server
           passdb backend = tdbsam
           obey pam restrictions = yes
           unix password sync = yes
           passwd program = /usr/bin/passwd %u
           passwd chat = *Enter\snew\s*\spassword:* %n\n *Retype\snew\s*\spassword:* %n\n *password\supdated\ssuccessfully* .
           pam password change = yes
           map to guest = bad user
           usershare allow guests = yes
        [printers]
           comment = All Printers
           browseable = no
           path = /var/spool/samba
           printable = yes
           guest ok = no
           read only = yes
           create mask = 0700
        [print$]
           comment = Printer Drivers
           path = /var/lib/samba/printers
           browseable = yes
           read only = yes
           guest ok = no
        [data]
           comment = /my_folder
           path = /my_folder
           browseable = yes
           read only = no
           writable = yes
           guest ok = yes
           hosts allow = <IP-адрес> 127.0.0.1
           hosts deny = 0.0.0.0/0
        ```

        Где `<IP-адрес>` в блоке `[data]` – IP-адрес компьютера, к которому вы будете подключать по NFS сетевой диск с данными.

     1. Перезапустите NFS и Samba:

        ```bash
        sudo service nfs-kernel-server restart
        sudo service smbd restart
        ```

   {% endlist %}

## Протестируйте работу файлового сервера {#test-file-server}

1. Установите ACL на виртуальной машине `fileserver-tutorial` и создайте директорию `remote` и файл `test.txt`:

   {% list tabs group=operating_system %}

   - Ubuntu {#ubuntu}

     ```bash
     sudo apt-get install acl
     sudo mkdir /my_folder/remote
     sudo setfacl -m u:<имя_вашего_пользователя>:rwx /my_folder/remote
     echo "Hello world!" > /my_folder/remote/test.txt
     ```

   {% endlist %}

1. Подключите по NFS сетевой диск к вашему компьютеру и проверьте доступность тестового файла:

   {% list tabs group=operating_system %}

   - Linux/macOS {#linux-macos}

     Если необходимо, установите утилиту для работы с сетевыми дисками:

     ```bash
     sudo apt-get install nfs-common
     ```

     Создайте точку монтирования:

     ```bash
     sudo mkdir /remote-test-dir
     ```

     Подключите сетевой диск:

     ```bash
     sudo mount -t nfs <публичный_IP-адрес_ВМ>:/my_folder /remote-test-dir
     ```

     В результате в указанной точке монтирования должны быть доступны тестовая директория и файл.

   - Windows {#windows}

     {% note info %}

     Может потребоваться настройка политик безопасности Windows для доступа к файловому серверу.

     {% endnote %}

     1. Запустите утилиту **cmd.exe**. Для этого нажмите сочетание клавиш **Windows** + **R** и выполните команду `cmd`.
     1. В командной строке выполните команду:

        ```bash
        net use x: \\<публичный_IP-адрес_ВМ>\data
        ```

     В результате появится диск **X** с тестовой директорией и файлом.

   {% endlist %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. Откройте конфигурационный файл `single-node-file-server.tf` и удалите описание создаваемой инфраструктуры из файла.
1. Примените изменения:

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

#### Полезные ссылки {#see-also}

* [Однонодовый файловый сервер с помощью консоли управления](console.md).