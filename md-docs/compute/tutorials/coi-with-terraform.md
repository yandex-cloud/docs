[Документация Yandex Cloud](../../index.md) > [Yandex Compute Cloud](../index.md) > [Практические руководства](index.md) > Container Optimized Image > Создать ВМ и группу ВМ с Container Optimized Image с помощью Terraform

# Создание ВМ и группы ВМ с Container Optimized Image с помощью Terraform

Чтобы с помощью Terraform создать конфигурации и запустить [виртуальную машину](../concepts/vm.md) или [группу виртуальных машин](../concepts/instance-groups/index.md) на базе образа [Container Optimized Image](../../cos/concepts/index.md), выполните следующие действия.

## Перед началом работы {#before-begin}

Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).


Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

В сценарии используется конфигурационный файл с названием `example.tf`, который находится в директории `~/cloud-terraform`.

## Создание и запуск ВМ с образом Container Optimized Image {#creating-vm}

### Создайте файлы конфигурации ВМ {#create-config-vm}

1. Используйте образ Container Optimized Image из [семейства образов](../concepts/image.md#family) Yandex Cloud. Для этого в конфигурационный файл `example.tf` добавьте строки:

   ```
   data "yandex_compute_image" "container-optimized-image" {
     family = "container-optimized-image"
   }
   ```

1. Опишите ВМ, добавив в конфигурационный файл `example.tf` строки:

   ```
   resource "yandex_compute_instance" "instance-based-on-coi" {
     boot_disk {
       initialize_params {
         image_id = data.yandex_compute_image.container-optimized-image.id
       }
     }
     network_interface {
       subnet_id = "<идентификатор_подсети>"
       nat = true
     }
     resources {
       cores = 2
       memory = 2
     }
     metadata = {
       docker-container-declaration = file("${path.module}/declaration.yaml")
       user-data = file("${path.module}/cloud_config.yaml")
     }
   }
   ```

   Где `subnet_id` — идентификатор [подсети](../../vpc/concepts/network.md#subnet).

   Если вы используете [Docker Compose спецификацию](../../cos/concepts/coi-specifications.md#compose-spec), то ключ `docker-container-declaration` в `metadata` необходимо заменить на ключ `docker-compose`:

   ```
   metadata = {
     docker-compose = file("${path.module}/docker-compose.yaml")
     user-data = file("${path.module}/cloud_config.yaml")
   }
   ```

1. Создайте файл спецификации облака `cloud_config.yaml` в директории `~/cloud-terraform`. Опишите спецификацию:

   ```yaml
   #cloud-config
   ssh_pwauth: no
   users:
     - name: yc-user
       sudo: ALL=(ALL) NOPASSWD:ALL
       shell: /bin/bash
       ssh_authorized_keys:
         - "<публичный_SSH-ключ>"
   ```

   Где `ssh_authorized_keys` — значение [публичного SSH-ключа](../operations/vm-connect/ssh.md#creating-ssh-keys).

1. Создайте файл спецификации Container Optimized Image с именем `declaration.yaml` в директории `~/cloud-terraform`. Опишите спецификацию:

   ```yaml
   spec:
     containers:
     - image: cr.yandex/yc/demo/coi:v1
       securityContext:
         privileged: false
       stdin: false
       tty: false
   ```

1. Создайте файл `output.tf` в директории `~/cloud-terraform`, чтобы отобразить [публичный IP-адрес](../../vpc/concepts/address.md#public-addresses) ВМ:

   ```
   output "external_ip" {
     value = yandex_compute_instance.instance-based-on-coi.network_interface.0.nat_ip_address
   }
   ```

### Создайте ВМ с Container Optimized Image {#create-vm-coi}

Запустите ВМ с Container Optimized Image, используя конфигурацию Terraform.

{% list tabs group=instructions %}

- CLI {#cli}

  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в директорию `~/cloud-terraform` с конфигурационными файлами:

        ```bash
        cd /Users/<имя_пользователя>/cloud-terraform
        ```

     1. Выполните проверку с помощью команды:

        ```bash
        terraform plan
        ```

        Результат:

        ```
        Refreshing Terraform state in-memory prior to plan...
        The refreshed state will be used to calculate this plan, but will not be
        persisted to local or remote state storage.
        ...
        Note: You didn't specify an "-out" parameter to save this plan, so Terraform
        can't guarantee that exactly these actions will be performed if
        "terraform apply" is subsequently run.
        ```

  1. Разверните ресурсы в Yandex Cloud.

     1. Выполните команду:

        ```bash
        terraform apply
        ```

        Результат:

        ```text
        data.yandex_compute_image.container-optimized-image: Refreshing state...

        An execution plan has been generated and is shown below.
        Resource actions are indicated with the following symbols:
        ...
          Terraform will perform the actions described above.
          Only 'yes' will be accepted to approve.

          Enter a value:
        ```

     1. Подтвердите создание ресурсов. Для этого введите значение `yes`:

        ```bash
        Enter a value: yes
        ```

        Результат:

        ```text
        yandex_compute_instance.instance-based-on-coi: Creating...
        yandex_compute_instance.instance-based-on-coi: Still creating... [10s elapsed]
        yandex_compute_instance.instance-based-on-coi: Still creating... [20s elapsed]
        ...
        Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

        Outputs:

        external_ip = <публичный_IP-адрес>
        ```

        В каталоге будут созданы требуемые ресурсы. При создании ВМ назначаются публичный IP-адрес и [имя хоста](../../vpc/concepts/address.md#fqdn) (FQDN).

  1. Проверьте ресурсы и их настройки в [консоли управления](https://console.yandex.cloud).

  1. Подключитесь к ВМ с образом Container Optimized Image.

     1. Выполните команду:

        ```bash
        ssh yc-user@<публичный_IP-адрес>
        ```

        Результат:

        ```
        The authenticity of host '<публичный_IP-адрес> (<публичный_IP-адрес>)' can't be established.
        ECDSA key fingerprint is SHA256:JPq....
        Are you sure you want to continue connecting (yes/no/[fingerprint])?
        ```

     1. Подтвердите подключение к ВМ. Для этого введите значение `yes`:

        ```bash
        Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
        ```

        Результат:

        ```text
        Warning: Permanently added '<публичный_IP-адрес>' (ECDSA) to the list of known hosts.
        Welcome to Ubuntu 20.04.1 LTS (GNU/Linux 5.4.0-52-generic x86_64)

         * Documentation: https://help.ubuntu.com
        ...
        Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
        applicable law.
        ```

  1. Выполните HTTP-запрос к ВМ:

     ```html
     curl <публичный_IP-адрес>
     ```

     Результат:

     ```html
     <!DOCTYPE html>
     <html lang="en">
     <head>
      <meta http-equiv="refresh" content="3">
       <title>Yandex.Scale</title>
     </head>
     <body>
     <h1>Hello v1</h1>
     </body>
     </html>
     ```

{% endlist %}

## Создание и запуск группы ВМ с образом Container Optimized Image {#creating-group}

### Создайте файлы конфигурации группы ВМ {#create-config-group}

1. Сохраните конфигурационный файл с именем `example.tf` в директории `~/cloud-terraform`:

   ```hcl
   provider "yandex" {
     cloud_id  = "<идентификатор_облака>"
     folder_id = "<идентификатор_каталога>"
     zone      = "ru-central1-a"
   }
   data "yandex_compute_image" "container-optimized-image" {
     family = "container-optimized-image"
   }
   resource "yandex_compute_instance_group" "ig-with-coi" {
     name = "ig-with-coi"
     folder_id = "<идентификатор_каталога>"
     service_account_id = "<идентификатор_сервисного_аккаунта>"
     instance_template {
       platform_id = "standard-v3"
       resources {
         memory = 2
         cores  = 2
       }
       boot_disk {
         mode = "READ_WRITE"
         initialize_params {
           image_id = data.yandex_compute_image.container-optimized-image.id
         }
       }
       network_interface {
         network_id = "<идентификатор_сети>"
         subnet_ids = ["<идентификаторы_подсетей>"]
         nat = true
       }
       metadata = {
         docker-container-declaration = file("${path.module}/declaration.yaml")
         user-data = file("${path.module}/cloud_config.yaml")
       }
     }
     scale_policy {
       fixed_scale {
         size = 2
       }
     }
     allocation_policy {
       zones = ["<зоны_доступности>"]
     }
     deploy_policy {
       max_unavailable = 2
       max_creating = 2
       max_expansion = 2
       max_deleting = 2
     }
   }
   ```

   Где:

   * `name` — имя группы ВМ.
   * `folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md).
   * `instance_template.network_interface.network_id` — идентификатор [сети](../../vpc/concepts/network.md).
   * `instance_template.network_interface.subnet_ids` — список идентификаторов [подсетей](../../vpc/concepts/network.md#subnet).
   * `instance_template.service_account_id` — идентификатор [сервисного аккаунта](../../iam/concepts/users/service-accounts.md), авторизованного для данной группы ВМ.
   * `allocation_policy.zones` — список [зон доступности](../../overview/concepts/geo-scope.md).

1. Используйте файлы `cloud_config.yaml` и `declaration.yaml` из раздела [Создайте файлы конфигурации ВМ](#create-config-vm).

1. Создайте файл `output.tf` в директории `~/cloud-terraform`, чтобы отобразить публичные IP-адреса каждой ВМ из группы:

   ```
   output "external_ip" {
    value = [yandex_compute_instance_group.ig-with-coi.instances[*].network_interface[0].nat_ip_address]
   }
   ```

### Создайте группу ВМ с Container Optimized Image {#create-group-coi}

Запустите группу ВМ с Container Optimized Image, используя конфигурацию Terraform.

{% list tabs group=instructions %}

- CLI {#cli}

  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в директорию `~/cloud-terraform` с конфигурационными файлами:

        ```bash
        cd /Users/<имя_пользователя>/cloud-terraform
        ```

     1. Выполните проверку с помощью команды:

        ```bash
        terraform plan
        ```

        Результат:

        ```
        Refreshing Terraform state in-memory prior to plan...
        The refreshed state will be used to calculate this plan, but will not be
        persisted to local or remote state storage.
        ...
        Note: You didn't specify an "-out" parameter to save this plan, so Terraform
        can't guarantee that exactly these actions will be performed if
        "terraform apply" is subsequently run.
        ```

  1. Разверните ресурсы в Yandex Cloud.

     1. Выполните команду:

        ```bash
        terraform apply
        ```

        Результат:

        ```text
        data.yandex_compute_image.container-optimized-image: Refreshing state...
        
        An execution plan has been generated and is shown below.
        Resource actions are indicated with the following symbols:
        ...
          Terraform will perform the actions described above.
          Only 'yes' will be accepted to approve.

          Enter a value:
        ```

     1. Подтвердите создание ресурсов. Для этого введите значение `yes`:

        ```bash
        Enter a value: yes
        ```

        Результат:

        ```text
        yandex_compute_instance_group.ig-with-coi: Creating...
        yandex_compute_instance_group.ig-with-coi: Still creating... [10s elapsed]
        yandex_compute_instance_group.ig-with-coi: Still creating... [20s elapsed]
        ...
        external_ip = [
          [
            "<публичный_IP-адрес_ВМ_1>",
            "<публичный_IP-адрес_ВМ_2>",
          ],
        ]
        ```

        В каталоге будут созданы требуемые ресурсы. При создании каждой ВМ назначаются публичный IP-адрес и [имя хоста](../../vpc/concepts/address.md#fqdn) (FQDN).

  1. Проверьте ресурсы и их настройки в [консоли управления](https://console.yandex.cloud).

  1. Подключитесь к одной из ВМ с образом Container Optimized Image.

     1. Выполните команду:

        ```bash
        ssh yc-user@<публичный_IP-адрес_ВМ_1>
        ```

        Результат:

        ```
        The authenticity of host '<публичный_IP-адрес_ВМ_1> (<публичный_IP-адрес_ВМ_1>)' can't be established.
        ECDSA key fingerprint is SHA256:JPq....
        Are you sure you want to continue connecting (yes/no/[fingerprint])?
        ```

     1. Подтвердите подключение к ВМ. Для этого введите значение `yes`:

        ```bash
        Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
        ```

        Результат:

        ```text
        Warning: Permanently added '<публичный_IP-адрес_ВМ_1>' (ECDSA) to the list of known hosts.
        Welcome to Ubuntu 20.04.1 LTS (GNU/Linux 5.4.0-52-generic x86_64)

         * Documentation: https://help.ubuntu.com
        ...
        Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
        applicable law.
        ```

  1. Выполните HTTP-запрос к одной из ВМ группы:

     ```html
     curl <публичный_IP-адрес_ВМ_1>
     ```

     Результат:

     ```html
     <!DOCTYPE html>
     <html lang="en">
     <head>
      <meta http-equiv="refresh" content="3">
       <title>Yandex.Scale</title>
     </head>
     <body>
     <h1>Hello v1</h1>
     </body>
     </html>
     ```

{% endlist %}