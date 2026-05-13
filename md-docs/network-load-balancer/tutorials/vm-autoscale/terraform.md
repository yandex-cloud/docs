# Работа с группой виртуальных машин с автоматическим масштабированием с помощью Terraform


Чтобы создать инфраструктуру для [группы ВМ с политикой автоматического масштабирования](index.md) c помощью Terraform:

1. [Подготовьте облако к работе](#before-begin).
1. [Создайте инфраструктуру](#deploy).
1. [Проверьте работу группы ВМ и сетевого балансировщика](#check-service).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md) и [привяжите](../../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../../resource-manager/concepts/resources-hierarchy.md).

1. Если у вас еще нет интерфейса командной строки Yandex Cloud, [установите его](../../../cli/quickstart.md#install).

1. Чтобы скрипты из пошагового руководства работали корректно, скачайте и установите утилиту [jq](https://stedolan.github.io/jq/download/).

1. Чтобы проверить работу автоматического масштабирования, установите утилиту [wrk](https://github.com/wg/wrk) для проведения нагрузочного тестирования.

### Необходимые платные ресурсы {#paid-resources}

В стоимость инфраструктуры входят:
* плата за постоянно запущенные [ВМ](../../../compute/concepts/vm.md) (см. [тарифы Compute Cloud](../../../compute/pricing.md));
* плата за [сетевые балансировщики](../../concepts/index.md) и балансировку трафика (см. [тарифы Network Load Balancer](../../pricing.md)).

## Создайте инфраструктуру {#deploy}

[Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).

Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

Чтобы создать инфраструктуру для автоматического масштабирования группы ВМ с помощью Terraform:
1. [Установите Terraform](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform) и укажите источник для установки провайдера Yandex Cloud (раздел [Настройте провайдер](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).
1. Подготовьте файлы с описанием инфраструктуры:

   {% list tabs group=infrastructure_description %}

   - Готовая конфигурация {#ready}

     1. Склонируйте репозиторий с конфигурационными файлами:

        ```bash
        git clone https://github.com/yandex-cloud-examples/yc-vm-group-with-autoscale.git
        ```

     1. Перейдите в директорию с репозиторием. В ней должны появиться файлы:
        * `vm-autoscale.tf` — конфигурация создаваемой инфраструктуры.
        * `declaration.yaml` — описание Docker-контейнера с веб-сервером, который будет запущен на ВМ для имитации нагрузки на сервис.
        * `config.tpl` — описание параметров пользователя ВМ.
        * `vm-autoscale.auto.tfvars` — пользовательские данные.

   - Вручную {#manual}

     1. Создайте папку для конфигурационных файлов.
     1. Создайте в папке:
        1. Конфигурационный файл `vm-autoscale.tf`:

           {% cut "vm-autoscale.tf" %}

           ```hcl
           # Объявление переменных для конфиденциальных параметров
           
           variable "folder_id" {
             type = string
           }
           
           variable "vm_user" {
             type = string
           }
           
           variable "ssh_key" {
             type      = string
             sensitive = true
           }
           
           # Настройка провайдера
           
           terraform {
             required_providers {
               yandex = {
                 source = "yandex-cloud/yandex"
                 version = ">= 0.47.0"
               }
             }
           }
           
           provider "yandex" {
             zone = "ru-central1-a"
           }
           
           # Создание сервисного аккаунта и назначение ему ролей
           
           resource "yandex_iam_service_account" "for-autoscale" {
             name = "for-autoscale"
           }
           
           resource "yandex_resourcemanager_folder_iam_member" "vm-autoscale-sa-role-compute" {
             folder_id = var.folder_id
             role      = "editor"
             member    = "serviceAccount:${yandex_iam_service_account.for-autoscale.id}"
           }
           
           # Создание облачной сети и подсетей
           
           resource "yandex_vpc_network" "vm-autoscale-network" {
             name = "vm-autoscale-network"
           }
           
           resource "yandex_vpc_subnet" "vm-autoscale-subnet-a" {
             name           = "vm-autoscale-subnet-a"
             zone           = "ru-central1-a"
             v4_cidr_blocks = ["192.168.1.0/24"]
             network_id     = yandex_vpc_network.vm-autoscale-network.id
           }
           
           resource "yandex_vpc_subnet" "vm-autoscale-subnet-b" {
             name           = "vm-autoscale-subnet-b"
             zone           = "ru-central1-b"
             v4_cidr_blocks = ["192.168.2.0/24"]
             network_id     = yandex_vpc_network.vm-autoscale-network.id
           }
           
           # Создание группы безопасности
           
           resource "yandex_vpc_security_group" "sg-1" {
             name                = "sg-autoscale"
             network_id          = yandex_vpc_network.vm-autoscale-network.id
             egress {
               protocol          = "ANY"
               description       = "any"
               v4_cidr_blocks    = ["0.0.0.0/0"]
             }
             ingress {
               protocol          = "TCP"
               description       = "ext-http"
               v4_cidr_blocks    = ["0.0.0.0/0"]
               port              = 80
             }
             ingress {
               protocol          = "TCP"
               description       = "healthchecks"
               predefined_target = "loadbalancer_healthchecks"
               port              = 80
             }
           }
           
           # Указание готового образа ВМ
           
           data "yandex_compute_image" "autoscale-image" {
             family = "container-optimized-image"
           }
           
           # Создание группы ВМ
           
           resource "yandex_compute_instance_group" "autoscale-group" {
             name                = "autoscale-vm-ig"
             folder_id           = var.folder_id
             service_account_id  = yandex_iam_service_account.for-autoscale.id
             instance_template {
           
               platform_id = "standard-v3"
               resources {
                 memory = 2
                 cores  = 2
               }
             
               boot_disk {
                 mode = "READ_WRITE"
                 initialize_params {
                   image_id = data.yandex_compute_image.autoscale-image.id
                   size     = 30
                 }
               }
           
               network_interface {
                 network_id = yandex_vpc_network.vm-autoscale-network.id
                 subnet_ids = [
                   yandex_vpc_subnet.vm-autoscale-subnet-a.id,
                   yandex_vpc_subnet.vm-autoscale-subnet-b.id
                 ]
                 security_group_ids = [ yandex_vpc_security_group.sg-1.id ]
                 nat                = true
               }
           
               metadata = {
                 user-data = templatefile("config.tpl", {
                   VM_USER = var.vm_user
                   SSH_KEY = var.ssh_key
                 })
                 docker-container-declaration = file("declaration.yaml")
               }
             }
           
             scale_policy {
               auto_scale {
                 initial_size           = 2
                 measurement_duration   = 60
                 cpu_utilization_target = 40
                 min_zone_size          = 1
                 max_size               = 6
                 warmup_duration        = 120
               }
             }
           
             allocation_policy {
               zones = [
                 "ru-central1-a",
                 "ru-central1-b"
               ]
             }
           
             deploy_policy {
               max_unavailable = 1
               max_expansion   = 0
             }
           
             load_balancer {
               target_group_name        = "auto-group-tg"
               target_group_description = "load balancer target group"
             }
           }
           
           # Создание сетевого балансировщика
           
           resource "yandex_lb_network_load_balancer" "balancer" {
             name = "group-balancer"
           
             listener {
               name        = "http"
               port        = 80
               target_port = 80
             }
           
             attached_target_group {
               target_group_id = yandex_compute_instance_group.autoscale-group.load_balancer[0].target_group_id
               healthcheck {
                 name = "tcp"
                 tcp_options {
                   port = 80
                 }
               }
             }
           }
           ```

           {% endcut %}

        1. Файл `declaration.yaml` с описанием Docker-контейнера с веб-сервером, который будет запущен на ВМ для имитации нагрузки на сервис:

           {% cut "declaration.yaml" %}

           ```yaml
           spec:
           containers:
           - image: cr.yandex/yc/demo/web-app:v1
             securityContext:
               privileged: false
             tty: false
             stdin: false
           ```

           {% endcut %}

        1. Файл `config.tpl` с параметрами пользователя ВМ:

           {% cut "config.tpl" %}

           ```yaml
           users:
             - name: "${VM_USER}"
               groups: sudo
               shell: /bin/bash
               sudo: 'ALL=(ALL) NOPASSWD:ALL'
               ssh_authorized_keys:
                 - "${SSH_KEY}"
           ```

           {% endcut %}

        1. Файл с пользовательскими данными `vm-autoscale.auto.tfvars`:

           {% cut "vm-autoscale.auto.tfvars" %}

           ```hcl
           folder_id = "<идентификатор_каталога>"
           vm_user   = "<имя_пользователя_ВМ>"
           ssh_key   = "<содержимое_публичного_SSH-ключа>"
           ```

           {% endcut %}

   {% endlist %}

   Более подробную информацию о параметрах используемых ресурсов в Terraform см. в документации провайдера:

   * [Сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) — [yandex_iam_service_account](../../../terraform/resources/iam_service_account.md).
   * [Сеть](../../../vpc/concepts/network.md#network) — [yandex_vpc_network](../../../terraform/resources/vpc_network.md).
   * [Подсети](../../../vpc/concepts/network.md#subnet) — [yandex_vpc_subnet](../../../terraform/resources/vpc_subnet.md).
   * [Группа безопасности](../../../vpc/concepts/security-groups.md) — [yandex_vpc_security_group](../../../terraform/resources/vpc_security_group.md).
   * [Группа ВМ](../../../compute/concepts/instance-groups/index.md) — [yandex_compute_instance_group](../../../terraform/resources/compute_instance_group.md).
   * [Сетевой балансировщик](../../concepts/index.md) — [yandex_lb_network_load_balancer](../../../terraform/resources/lb_network_load_balancer.md).

1. В файле `vm-autoscale.auto.tfvars` задайте пользовательские параметры:
   * `folder_id` — [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md).
   * `vm_user` — имя пользователя ВМ.
   * `ssh_key` — содержимое файла с открытым SSH-ключом для аутентификации пользователя на ВМ. Подробнее см. [Создание пары ключей SSH](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
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

После создания инфраструктуры, [проверьте работу группы ВМ и сетевого балансировщика](#check-service).

## Проверьте работу группы ВМ и сетевого балансировщика {#check-service}

1. Создайте нагрузку на одну из ВМ.

   Для этого сохраните скрипт с именем `request.sh` в домашнюю директорию. Скрипт через балансировщик `group-balancer` отправит на одну из ВМ запрос, который будет создавать нагрузку в 100% CPU в течение 30 секунд.

   ```bash
   EXTERNAL_IP=$(yc load-balancer network-load-balancer get group-balancer --format=json | jq -r .listeners[0].address)

   curl "http://$EXTERNAL_IP/burn-cpu?time=30000&load=100"
   ```

1. Запустите скрипт:

   {% list tabs group=instructions %}

   - CLI {#cli}

     ```bash
     sh request.sh
     ```

     Результат:

     ```text
     projects/b0g12ga82bcv********/zones/ru-central1-b
     ```

   {% endlist %}

1. Посмотрите нагрузку на ВМ:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы создали группу ВМ.
     1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Compute Cloud**.
     1. На панели слева нажмите ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **Группы виртуальных машин**.
     1. Выберите группу ВМ `auto-group`.
     1. Перейдите на вкладку **Мониторинг**.

        Балансировщик направил запрос на одну из ВМ группы. В зоне доступности этой ВМ среднее потребление CPU (график **Average CPU utilization in zone**) выше, чем в других.

   {% endlist %}

### Проверьте работу автоматического масштабирования {#check-highload}

Чтобы проверить работу автоматического масштабирования группы ВМ, нужно создать повышенную нагрузку на CPU каждой ВМ. В файле `specification.yaml` в параметре `scale_policy.auto_scale.cpu_utilization_rule.utilization_target` указано значение `40` — целевой уровень нагрузки 40% CPU. Если превысить целевую нагрузку, количество ВМ в группе увеличится.
1. Создайте повышенную нагрузку на группу ВМ.

   Для этого сохраните скрипт с именем `load.sh` в домашнюю директорию. Скрипт в течение 10 минут в 12 потоков отправляет запросы к группе ВМ. При этом у каждой ВМ используется по 20% CPU на каждое ядро, обрабатывающее запрос. Группа ВМ в каждый момент времени будет загружена на 240% CPU. Скрипт специально выполняет несколько параллельных запросов по 20% CPU, а не один в 240% CPU, чтобы запросы равномерно распределялись между ВМ в группе.

   ```bash
   EXTERNAL_IP=$(yc load-balancer network-load-balancer get group-balancer --format=json | jq -r .listeners[0].address)

   wrk -H "Connection: close" -t12 -c12 -d10m "http://$EXTERNAL_IP/burn-cpu?time=5000&load=20"
   ```

1. Запустите скрипт:

   {% list tabs group=instructions %}

   - CLI {#cli}

     ```bash
     sh load.sh
     ```

     Результат:

     ```text
     Running 10m test @ http://130.193.56.111/burn-cpu?time=5000&load=20
       12 threads and 12 connections
       Thread Stats   Avg      Stdev     Max   +/- Stdev
     ...
     Requests/sec: 15.04
     Transfer/sec: 3.20KB
     ```

   {% endlist %}

1. Посмотрите нагрузку:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы создали группу ВМ `auto-group`.
     1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Compute Cloud**.
     1. На панели слева нажмите ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **Группы виртуальных машин**.
     1. Выберите группу ВМ `auto-group`.
     1. Перейдите на вкладку **Мониторинг**.
        На графике **Number of instance in zone** отображены изменения количества ВМ в каждой зоне доступности. На графике **Average CPU utilization in zone** — средняя CPU-нагрузка в каждой зоне доступности.
     1. Перейдите на вкладку **Логи**.
        На странице отображены сообщения о действиях в рамках автоматического масштабирования группы ВМ.

     Суммарная нагрузка в 240% CPU равномерно распределилась между двумя ВМ в двух зонах доступности и превысила целевой уровень нагрузки в 40% CPU. [Yandex Compute Cloud](../../../compute/index.md) создал по дополнительной ВМ в каждой зоне доступности и в группе стало четыре ВМ. Когда скрипт перестал создавать CPU-нагрузку, Compute Cloud автоматически уменьшил количество ВМ в группе до двух.

   {% endlist %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. Откройте конфигурационный файл `vm-autoscale.tf` и удалите описание создаваемой инфраструктуры из файла.
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

#### См. также {#see-also}

* [Работа с группой виртуальных машин с автоматическим масштабированием с помощью консоли управления, CLI и API](console.md)