[Документация Yandex Cloud](../../../index.md) > [Практические руководства](../../index.md) > Базовая инфраструктура > Отказоустойчивость и масштабирование > [Отказоустойчивый сайт с балансировкой нагрузки через Network Load Balancer](index.md) > Terraform

# Отказоустойчивый сайт с балансировкой нагрузки через Yandex Network Load Balancer с помощью Terraform


Чтобы создать [отказоустойчивый сайт с балансировкой нагрузки через Yandex Network Load Balancer](index.md) с помощью Terraform:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте инфраструктуру](#deploy).
1. [Загрузите файлы сайта](#upload-files).
1. [Протестируйте отказоустойчивость](#test).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md) и [привяжите](../../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../../resource-manager/concepts/resources-hierarchy.md).


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки сайта входит:

* плата за [диски](../../../compute/concepts/disk.md) и постоянно запущенные [ВМ](../../../compute/concepts/vm.md) ([тарифы Yandex Compute Cloud](../../../compute/pricing.md));
* плата за использование динамических или статических [внешних IP-адресов](../../../vpc/concepts/address.md#public-addresses) ([тарифы Yandex Virtual Private Cloud](../../../vpc/pricing.md));
* плата за [сетевой балансировщик](../../../network-load-balancer/concepts/index.md) и балансировку трафика ([тарифы Network Load Balancer](../../../network-load-balancer/pricing.md)).


## Создайте инфраструктуру {#deploy}

[Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).

Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

Для создания инфраструктуры c помощью Terraform:

1. [Установите Terraform](../../infrastructure-management/terraform-quickstart.md#install-terraform), [получите данные для аутентификации](../../infrastructure-management/terraform-quickstart.md#get-credentials) и укажите источник для установки провайдера Yandex Cloud (раздел [Настройте провайдер](../../infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).
1. Подготовьте файлы с описанием инфраструктуры:

    {% list tabs group=infrastructure_description %}

    - Готовая конфигурация {#ready}

      1. Склонируйте репозиторий с конфигурационными файлами:

         ```bash
         git clone https://github.com/yandex-cloud-examples/yc-nlb-fault-tolerant-site.git
         ```

      1. Перейдите в директорию с репозиторием. В ней должен появиться файл `load-balancer.tf` с конфигурацией создаваемой инфраструктуры.

    - Вручную {#manual}

      1. Создайте папку для файлов.
      1. Создайте в папке конфигурационный файл `load-balancer.tf`:

          {% cut "load-balancer.tf" %}

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
          
          variable "folder_id" {
            description = "Yandex.Cloud Folder ID where resources will be created"
            default     = "<идентификатор_каталога>"
          }
          
          resource "yandex_iam_service_account" "ig-sa" {
            name        = "ig-sa"
          }
          
          resource "yandex_resourcemanager_folder_iam_member" "editor" {
            folder_id = var.folder_id
            role      = "editor"
            member    = "serviceAccount:${yandex_iam_service_account.ig-sa.id}"
          }
          
          resource "yandex_compute_instance_group" "ig-1" {
            name               = "nlb-vm-group"
            folder_id          = var.folder_id
            service_account_id = "${yandex_iam_service_account.ig-sa.id}"
            instance_template {
              platform_id = "standard-v3"
              resources {
                core_fraction = 20
                memory        = 1
                cores         = 2
              }
          
              boot_disk {
                mode = "READ_WRITE"
                initialize_params {
                  image_id = "<идентификатор_образа>"
                  type     = "network-hdd"
                  size     = 3
                }
              }
          
              network_interface {
                network_id = "${yandex_vpc_network.network-1.id}"
                subnet_ids = ["${yandex_vpc_subnet.subnet-1.id}","${yandex_vpc_subnet.subnet-2.id}" ]
                nat        = true
              }
          
              metadata = {
                user-data = "#cloud-config\nusers:\n  - name: <имя_пользователя>\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh_authorized_keys:\n      - ${file("<путь_к_открытому_SSH-ключу>")}"
              }
            }
          
            scale_policy {
              fixed_scale {
                size = 2
              }
            }
          
            allocation_policy {
              zones = ["ru-central1-a", "ru-central1-b"]
            }
          
            deploy_policy {
              max_unavailable = 1
              max_expansion   = 0
            }
          
            load_balancer {
              target_group_name = "nlb-tg"
            }
          }
          
          resource "yandex_lb_network_load_balancer" "foo" {
            name = "nlb-1"
            listener {
              name = "nlb-listener"
              port = 80
            }
            attached_target_group {
              target_group_id = "${yandex_compute_instance_group.ig-1.load_balancer.0.target_group_id}"
              healthcheck {
                name                = "health-check-1"
                unhealthy_threshold = 5
                healthy_threshold   = 5
                http_options {
                  port = 80
                }
              }
            }
          }
          
          resource "yandex_vpc_network" "network-1" {
            name = "network1"
          }
          
          resource "yandex_vpc_subnet" "subnet-1" {
            name           = "subnet1"
            zone           = "ru-central1-a"
            network_id     = "${yandex_vpc_network.network-1.id}"
            v4_cidr_blocks = ["192.168.1.0/24"]
          }
          
          resource "yandex_vpc_subnet" "subnet-2" {
            name           = "subnet2"
            zone           = "ru-central1-b"
            network_id     = "${yandex_vpc_network.network-1.id}"
            v4_cidr_blocks = ["192.168.2.0/24"]
          }
          ```

          {% endcut %}

    {% endlist %}

    Подробнее о параметрах используемых ресурсов в Terraform смотрите в документации провайдера:

    * [Сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) — [yandex_iam_service_account](../../../terraform/resources/iam_service_account.md).
    * [Роль](../../../iam/concepts/access-control/roles.md) — [yandex_resourcemanager_folder_iam_member](../../../terraform/resources/resourcemanager_folder_iam_member.md).
    * [Группа виртуальных машин](../../../compute/concepts/instance-groups/index.md) — [yandex_compute_instance_group](../../../terraform/resources/compute_instance_group.md)
    * [Сетевой балансировщик нагрузки](../../../network-load-balancer/concepts/index.md) — [yandex_lb_network_load_balancer](../../../terraform/resources/lb_network_load_balancer.md)
    * [Сеть](../../../vpc/concepts/network.md#network) — [yandex_vpc_network](../../../terraform/resources/vpc_network.md)
    * [Подсети](../../../vpc/concepts/network.md#subnet) — [yandex_vpc_subnet](../../../terraform/resources/vpc_subnet.md)


1. В блоке `variable` укажите значение переменной `folder_id` — идентификатор каталога, в котором создаются необходимые ресурсы.
1. В блоке `metadata` укажите [метаданные](../../../compute/concepts/vm-metadata.md) для создания ВМ и содержимое SSH-ключа. Ключ указывается в формате `<любое_имя>:<содержимое_SSH-ключа>`. Указанное имя пользователя не играет роли, ключ будет присвоен пользователю, который задан в конфигурации образа LAMP (LEMP). В разных образах это разные пользователи. Подробнее в разделе [Ключи, обрабатываемые в публичных образах Yandex Cloud](../../../compute/concepts/metadata/public-image-keys.md).

    Пару [SSH-ключей](../../../glossary/ssh-keygen.md) необходимо [создать самостоятельно](../../../compute/operations/vm-connect/ssh.md).

1. В блоке `boot_disk` укажите идентификатор одного из [образов](../../../compute/operations/images-with-pre-installed-software/get-list.md) ВМ с нужным набором компонентов:

    * [LAMP](https://yandex.cloud/ru/marketplace/products/yc/lamp) (Linux, Apache, MySQL®, PHP).
    * [LEMP](https://yandex.cloud/ru/marketplace/products/yc/lemp) (Linux, Nginx, MySQL®, PHP).

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

После создания инфраструктуры, [загрузите файлы сайта](#upload-files).


## Загрузите файлы сайта {#upload-files}

Чтобы проверить работу веб-сервера, необходимо загрузить файлы сайта на каждую ВМ. Для примера вы можете использовать файл `index.html` из [архива](https://storage.yandexcloud.net/doc-files/index.html.zip).

Для каждой ВМ в созданной группе выполните следующее:

1. [Узнайте](../../../compute/operations/vm-info/get-info.md) публичный IP-адрес нужной ВМ.
1. [Подключитесь](../../../compute/operations/vm-connect/ssh.md) к ВМ по протоколу SSH.
1. Выдайте права на запись для вашего пользователя на директорию `/var/www/html`:

    ```bash
    sudo chown -R "$USER":www-data /var/www/html
    ```

1. Загрузите на ВМ файлы сайта с помощью [протокола SCP](https://ru.wikipedia.org/wiki/SCP).

    {% list tabs group=operating_system %}

    - Linux/macOS {#linux-macos}

      Используйте утилиту командной строки `scp`:

      ```bash
      scp -r <путь_до_директории_с_файлами> <имя_пользователя_ВМ>@<IP-адрес_ВМ>:/var/www/html
      ```

    - Windows {#windows}

      С помощью программы [WinSCP](https://winscp.net/eng/download.php) скопируйте локальную директорию с файлами в директорию `/var/www/html` на ВМ.

    {% endlist %}

После загрузки всех файлов, [протестируйте отказоустойчивость](#test).


## Протестируйте отказоустойчивость {#test}

1. [Узнайте](../../../compute/operations/vm-info/get-info.md) публичный IP-адрес любой ВМ из созданной группы.
1. [Подключитесь](../../../compute/operations/vm-connect/ssh.md) к ВМ по протоколу SSH.
1. Остановите веб-сервис, чтобы сымитировать сбой в работе веб-сервера:

    {% list tabs %}

    - LAMP

      ```bash
      sudo service apache2 stop
      ```

    - LEMP

      ```bash
      sudo service nginx stop
      ```

    {% endlist %}

1. [Узнайте](../../../network-load-balancer/operations/load-balancer-list.md#get) IP-адрес обработчика.
1. Откройте сайт в браузере, используя адрес обработчика.

    Несмотря на сбой в работе одного из веб-серверов, подключение должно пройти успешно.

1. После завершения проверки снова запустите веб-сервис:

    {% list tabs %}

    - LAMP

        ```bash
        sudo service apache2 start
        ```

    - LEMP

        ```bash
        sudo service nginx start
        ```

    {% endlist %}


## Как удалить созданные ресурсы {#clear-out}

Чтобы остановить работу сайта и перестать платить за созданные ресурсы:

1. Откройте конфигурационный файл `load-balancer.tf` и удалите описание создаваемой инфраструктуры из файла.
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

* [Отказоустойчивый сайт с балансировкой нагрузки через Yandex Network Load Balancer с помощью консоли управления](console.md)