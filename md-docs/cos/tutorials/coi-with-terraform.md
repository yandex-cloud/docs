[Документация Yandex Cloud](../../index.md) > [Yandex Container Solution](../index.md) > [Практические руководства](index.md) > Создать ВМ и группу ВМ с Container Optimized Image с помощью Terraform

# Создание ВМ и группы ВМ с Container Optimized Image с помощью Terraform

Чтобы с помощью Terraform создать конфигурации и запустить [виртуальную машину](../../compute/concepts/vm.md) или [группу виртуальных машин](../../compute/concepts/instance-groups/index.md) на базе образа [Container Optimized Image](../concepts/index.md), выполните следующие действия.

## Перед началом работы {#before-begin}

Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).


Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

В сценарии используется конфигурационный файл с названием `example.tf`, который находится в директории `~/cloud-terraform`.

## Создание и запуск ВМ с образом Container Optimized Image {#creating-vm}

В этом разделе вы создадите:

* [облачную сеть](../../vpc/concepts/network.md#network) `sample-network`;
* [подсеть](../../vpc/concepts/network.md#subnet) `sample-network-subnet`;
* [группу безопасности](../../vpc/concepts/security-groups.md) `sample-sg`;
* [виртуальную машину](../../compute/concepts/vm.md) `sample-coi-vm`.

### Создайте файлы конфигурации ВМ {#create-config-vm}

1. Опишите сетевые ресурсы, которые необходимы для работы виртуальной машины, и добавьте эти описания в конфигурационный файл `example.tf`:

    ```hcl
    terraform {
      required_providers {
        yandex = {
          source = "yandex-cloud/yandex"
        }
      }
      required_version = ">= 0.13"
    }

    provider "yandex" {
      cloud_id    = local.cloud_id
      folder_id   = local.folder_id
    }

    locals {
      cloud_id    = "<идентификатор_облака>"
      folder_id   = "<идентификатор_каталога>"
      zone        = "<зона_доступности>"
      cidr        = "<CIDR_подсети>"
    }

    # Создание сети

    resource "yandex_vpc_network" "coi-instance-network" {
      name = "sample-network"
    }

    # Создание подсети

    resource "yandex_vpc_subnet" "coi-instance-subnet-d" {
      name           = "sample-network-subnet"
      zone           = local.zone
      network_id     = yandex_vpc_network.coi-instance-network.id
      v4_cidr_blocks = [local.cidr]
    }

    # Создание группы безопасности

    resource "yandex_vpc_security_group" "coi-instance-sg" {
      name        = "sample-sg"
      network_id  = yandex_vpc_network.coi-instance-network.id

      ingress {
        protocol       = "TCP"
        description    = "http"
        v4_cidr_blocks = ["0.0.0.0/0"]
        port           = 80
      }

      ingress {
        protocol       = "TCP"
        description    = "https"
        v4_cidr_blocks = ["0.0.0.0/0"]
        port           = 443
      }

      ingress {
        protocol       = "TCP"
        description    = "ssh"
        v4_cidr_blocks = ["0.0.0.0/0"]
        port           = 22
      }

      egress {
        protocol       = "ANY"
        description    = "any"
        v4_cidr_blocks = ["0.0.0.0/0"]
        from_port      = 0
        to_port        = 65535
      }
    }
    ```

    Где `locals` — локальные переменные конфигурации, которые необходимо задать для создания инфраструктуры:

    * `cloud_id` — [идентификатор](../../resource-manager/operations/cloud/get-id.md) облака, в котором вы будете создавать инфраструктуру.
    * `folder_id` — [идентификатор](../../resource-manager/operations/folder/get-id.md) каталога, в котором вы будете создавать инфраструктуру.
    * `zone` — [зона доступности](*availability_zone), в которой вы будете создавать инфраструктуру. Например: `ru-central1-a`.
    * `cidr` — [CIDR подсети](../../vpc/concepts/network.md#subnet), в которой вы будете создавать виртуальную машину. Например: `192.168.1.0/24`.
1. Используйте образ Container Optimized Image из [семейства образов](../../compute/concepts/image.md#family) Yandex Cloud. Для этого в конфигурационный файл `example.tf` добавьте строки:

    ```hcl
    data "yandex_compute_image" "container-optimized-image" {
      family = "container-optimized-image"
    }
    ```
1. Опишите виртуальную машину, добавив в конфигурационный файл `example.tf` строки:

    ```hcl
    resource "yandex_compute_instance" "instance-based-on-coi" {
      name        = "sample-coi-vm"
      platform_id = "standard-v3"
      zone        = local.zone

      boot_disk {
        initialize_params {
          image_id = data.yandex_compute_image.container-optimized-image.id
        }
      }
      network_interface {
        subnet_id = yandex_vpc_subnet.coi-instance-subnet-d.id
        nat = true
        security_group_ids = [yandex_vpc_security_group.coi-instance-sg.id]
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

    Если вы используете [спецификацию Docker Compose](../concepts/coi-specifications.md#compose-spec), то ключ `docker-container-declaration` в `metadata` необходимо заменить на ключ `docker-compose`:

    ```hcl
    metadata = {
      docker-compose = file("${path.module}/docker-compose.yaml")
      user-data = file("${path.module}/cloud_config.yaml")
    }
    ```
1. В директории `~/cloud-terraform` создайте файл спецификации облака `cloud_config.yaml`. В нем опишите спецификацию:

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

    Где `ssh_authorized_keys` — значение [публичного SSH-ключа](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
1. В директории `~/cloud-terraform` создайте файл спецификации Container Optimized Image `declaration.yaml`. В нем опишите спецификацию:

    ```yaml
    spec:
      containers:
      - image: cr.yandex/yc/demo/coi:v1
        securityContext:
          privileged: false
        stdin: false
        tty: false
    ```
1. В директории `~/cloud-terraform` создайте файл `output.tf`, чтобы отобразить [публичный IP-адрес](../../vpc/concepts/address.md#public-addresses) ВМ. В него добавьте следующий код:

    ```hcl
    output "external_ip" {
      value = yandex_compute_instance.instance-based-on-coi.network_interface.0.nat_ip_address
    }
    ```
### Создайте ВМ с Container Optimized Image {#create-vm-coi}

Запустите ВМ с Container Optimized Image, используя конфигурацию Terraform.

{% list tabs group=instructions %}

- Terraform {#tf}

  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в директорию `~/cloud-terraform` с конфигурационными файлами:

        ```bash
        cd /Users/<имя_пользователя>/cloud-terraform
        ```
     1. Выполните инициализацию Terraform:

        ```bash
        terraform init
        ```
     1. Выполните проверку с помощью команды:

        ```bash
        terraform plan
        ```

        Результат:

        ```
        data.yandex_compute_image.container-optimized-image: Reading...
        data.yandex_compute_image.container-optimized-image: Read complete after 0s [id=fd83vqe4111j********]

        Terraform used the selected providers to generate the following execution plan.
        Resource actions are indicated with the following symbols:
          + create

        Terraform will perform the following actions:
        ...
        Note: You didn't use the -out option to save this plan, so Terraform 
        can't guarantee to take exactly these actions 
        if you run "terraform apply" now.
        ```
  1. Разверните ресурсы в Yandex Cloud.

      1. Выполните команду:

          ```bash
          terraform apply
          ```

          Результат:

          ```text
          data.yandex_compute_image.container-optimized-image: Reading...
          data.yandex_compute_image.container-optimized-image: Read complete after 1s [id=fd83vqe4111j********]

          Terraform used the selected providers to generate the following execution plan. 
          Resource actions are indicated with the following symbols:
            + create

          Terraform will perform the following actions:
          ...
          Do you want to perform these actions?
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

          external_ip = 51.250.***.***
          ```

          В каталоге будут созданы требуемые ресурсы. При создании ВМ назначаются публичный IP-адрес и [имя хоста](../../vpc/concepts/address.md#fqdn) (FQDN).
  1. Проверьте ресурсы и их настройки в [консоли управления](https://console.yandex.cloud).
  1. Подключитесь к ВМ с образом Container Optimized Image.

      1. Выполните команду:

          ```bash
          ssh yc-user@<публичный_IP-адрес_ВМ>
          ```

          Результат:

          ```
          The authenticity of host '<публичный_IP-адрес_ВМ> (<публичный_IP-адрес_ВМ>)' can't be established.
          ECDSA key fingerprint is SHA256:JPq....
          Are you sure you want to continue connecting (yes/no/[fingerprint])?
          ```
      1. Подтвердите подключение к ВМ. Для этого введите значение `yes`:

          ```bash
          Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
          ```

          Результат:

          ```text
          Warning: Permanently added '178.154.***.**' (ED25519) to the list of known hosts.
          Welcome to Ubuntu 22.04.5 LTS (GNU/Linux 5.15.0-194-generic x86_64)

          * Documentation: https://help.ubuntu.com
          ...
          Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
          applicable law.
          ```
      1. Отключитесь от ВМ:

          ```bash
          exit
          ```
  1. Выполните HTTP-запрос к ВМ:

      ```html
      curl <публичный_IP-адрес_ВМ>
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
  1. Удалите созданные ресурсы. Для этого выполните команду и подтвердите удаление:

      ```bash
      terraform destroy
      ```

      Результат:

      ```text
      ...

      Destroy complete! Resources: 4 destroyed.
      ```

{% endlist %}


## Создание и запуск группы ВМ с образом Container Optimized Image {#creating-group}

В этом разделе вы создадите:

* [облачную сеть](../../vpc/concepts/network.md#network) `sample-network`;
* [подсети](../../vpc/concepts/network.md#subnet) `sample-network-subnet1` и `sample-network-subnet2`;
* [группу безопасности](../../vpc/concepts/security-groups.md) `sample-sg`;
* [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) `instance-group-sa` с назначенными [ролями](../../iam/concepts/access-control/roles.md) `compute.admin` и `vpc.publicAdmin`;
* [группу виртуальных машин](../../compute/concepts/instance-groups/index.md) `ig-with-coi`.

### Создайте файлы конфигурации группы ВМ {#create-config-group}

1. В директории `~/cloud-terraform` сохраните конфигурационный файл с именем `example.tf`:

    ```hcl
    terraform {
      required_providers {
        yandex = {
          source = "yandex-cloud/yandex"
        }
      }
      required_version = ">= 0.13"
    }

    provider "yandex" {
      cloud_id    = local.cloud_id
      folder_id   = local.folder_id
    }

    locals {
      cloud_id    = "<идентификатор_облака>"
      folder_id   = "<идентификатор_каталога>"
      zone1       = "<зона_доступности_1>"
      zone2       = "<зона_доступности_2>"
      cidr1       = "<CIDR_подсети_1>"
      cidr2       = "<CIDR_подсети_2>"
    }

    # Создание сети

    resource "yandex_vpc_network" "coi-instance-network" {
      name = "sample-network"
    }

    # Создание подсетей

    resource "yandex_vpc_subnet" "coi-instance-subnet1" {
      name           = "sample-network-subnet1"
      zone           = local.zone1
      network_id     = yandex_vpc_network.coi-instance-network.id
      v4_cidr_blocks = [local.cidr1]
    }

    resource "yandex_vpc_subnet" "coi-instance-subnet2" {
      name           = "sample-network-subnet2"
      zone           = local.zone2
      network_id     = yandex_vpc_network.coi-instance-network.id
      v4_cidr_blocks = [local.cidr2]
    }

    # Создание группы безопасности

    resource "yandex_vpc_security_group" "coi-instance-sg" {
      name        = "sample-sg"
      network_id  = yandex_vpc_network.coi-instance-network.id

      ingress {
        protocol       = "TCP"
        description    = "http"
        v4_cidr_blocks = ["0.0.0.0/0"]
        port           = 80
      }

      ingress {
        protocol       = "TCP"
        description    = "https"
        v4_cidr_blocks = ["0.0.0.0/0"]
        port           = 443
      }

      ingress {
        protocol       = "TCP"
        description    = "ssh"
        v4_cidr_blocks = ["0.0.0.0/0"]
        port           = 22
      }

      egress {
        protocol       = "ANY"
        description    = "any"
        v4_cidr_blocks = ["0.0.0.0/0"]
        from_port      = 0
        to_port        = 65535
      }
    }

    # Создание сервисного аккаунта

    resource "yandex_iam_service_account" "ig-sa" {
      name = "instance-group-sa"
    }

    # Назначение сервисному аккаунту ролей compute.admin и vpc.publicAdmin

    resource "yandex_resourcemanager_folder_iam_member" "compute-admin" {
      folder_id = local.folder_id
      role      = "compute.admin"
      member    = "serviceAccount:${yandex_iam_service_account.ig-sa.id}"
    }

    resource "yandex_resourcemanager_folder_iam_member" "vpc-public-admin" {
      folder_id = local.folder_id
      role      = "vpc.publicAdmin"
      member    = "serviceAccount:${yandex_iam_service_account.ig-sa.id}"
    }

    # Получение информации об образе Container Optimized Image

    data "yandex_compute_image" "container-optimized-image" {
      family = "container-optimized-image"
    }

    # Создание группы виртуальных машин

    resource "yandex_compute_instance_group" "ig-with-coi" {

      depends_on = [
        yandex_resourcemanager_folder_iam_member.compute-admin
      ]

      name = "ig-with-coi"
      folder_id = local.folder_id
      service_account_id = yandex_iam_service_account.ig-sa.id
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
          network_id = yandex_vpc_network.coi-instance-network.id
          subnet_ids = [yandex_vpc_subnet.coi-instance-subnet1.id,yandex_vpc_subnet.coi-instance-subnet2.id]
          security_group_ids = [yandex_vpc_security_group.coi-instance-sg.id]
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
        zones = [local.zone1,local.zone2]
      }
      deploy_policy {
        max_unavailable = 2
        max_creating = 2
        max_expansion = 2
        max_deleting = 2
      }
    }
    ```

    Где `locals` — локальные переменные конфигурации, которые необходимо задать для создания инфраструктуры:

    * `cloud_id` — [идентификатор](../../resource-manager/operations/cloud/get-id.md) облака, в котором вы будете создавать инфраструктуру.
    * `folder_id` — [идентификатор](../../resource-manager/operations/folder/get-id.md) каталога, в котором вы будете создавать инфраструктуру.
    * `zone1`, `zone2` — [зоны доступности](*availability_zone), в которых вы будете создавать подсети и в которых будут распределяться виртуальные машины группы. Например: `ru-central1-a` и `ru-central1-b`.
    * `cidr1`, `cidr2` — [CIDR подсетей](../../vpc/concepts/network.md#subnet), в которых будут располагаться виртуальные машины группы. Например: `192.168.1.0/24` и `172.16.1.0/24`.
1. Используйте файлы `cloud_config.yaml` и `declaration.yaml` из раздела [Создайте файлы конфигурации ВМ](#create-config-vm).
1. В директории `~/cloud-terraform` создайте файл `output.tf`, чтобы отобразить публичные IP-адреса каждой ВМ из группы:

    ```hcl
    output "external_ip" {
      value = [yandex_compute_instance_group.ig-with-coi.instances[*].network_interface[0].nat_ip_address]
    }
    ```

### Создайте группу ВМ с Container Optimized Image {#create-group-coi}

Запустите группу ВМ с Container Optimized Image, используя конфигурацию Terraform.

{% list tabs group=instructions %}

- Terraform {#tf}

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
          data.yandex_compute_image.container-optimized-image: Reading...
          data.yandex_compute_image.container-optimized-image: Read complete after 0s [id=fd83vqe4111j********]

          Terraform used the selected providers to generate the following 
          execution plan. Resource actions are indicated with the
          following symbols:
            + create

          Terraform will perform the following actions:
          ...
          Note: You didn't use the -out option to save this plan, so Terraform can't 
          guarantee to take exactly these actions if you run "terraform apply" now.
          ```
  1. Разверните ресурсы в Yandex Cloud.

      1. Выполните команду:

          ```bash
          terraform apply
          ```

          Результат:

          ```text
          data.yandex_compute_image.container-optimized-image: Reading...
          data.yandex_compute_image.container-optimized-image: Read complete after 1s [id=fd83vqe4111j********]

          Terraform used the selected providers to generate the following 
          execution plan. Resource actions are indicated with the
          following symbols:
            + create

          Terraform will perform the following actions:
          ...
          Do you want to perform these actions?
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
          yandex_compute_instance_group.ig-with-coi: Creation complete after 1m4s [id=cl1cb44qg33q********]

          Apply complete! Resources: 8 added, 0 changed, 0 destroyed.

          Outputs:

          external_ip = [
            tolist([
              "51.250.***.***",
              "158.160.***.***",
            ]),
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
      1. Отключитесь от ВМ:

          ```bash
          exit
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
  1. Удалите созданные ресурсы. Для этого выполните команду и подтвердите удаление:

      ```bash
      terraform destroy
      ```

      Результат:

      ```text
      ...

      Destroy complete! Resources: 8 destroyed.
      ```

{% endlist %}

[*availability_zone]: Зона доступности — это инфраструктура внутри дата-центра, в котором размещается платформа Yandex Cloud. Подробнее читайте в разделе [Зоны доступности](../../overview/concepts/geo-scope.md).