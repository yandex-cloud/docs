# Сборка образа ВМ с набором инфраструктурных инструментов с помощью Packer

{{ compute-full-name }} можно использовать для создания [образа дисков виртуальных машин](../../compute/concepts/image.md) с набором дополнительных инфраструктурных инструментов с помощью утилиты [Packer](https://www.packer.io/).

Соберите с помощью утилиты Packer образ ВМ на основе [Ubuntu Linux 20.04 LTS](/marketplace/products/yc/ubuntu-20-04-lts) с заданными в конфигурационном файле параметрами. Добавьте в образ часто используемые при работе с {{ yandex-cloud }} инструменты:
* [{{ yandex-cloud }} CLI](../../cli/quickstart.md) версии 0.91.0 или выше.
* [{{ TF }}](https://www.terraform.io/) версии 1.1.9.
* [kubectl]({{ k8s-docs }}/reference/kubectl/) версии 1.23.
* [Docker](https://docs.docker.com/get-started/overview/) версии 20.10.16 или выше.
* [Git](https://git-scm.com/about) версии 2.25.1 или выше.
* [Helm]{% if lang == "ru" %}(https://helm.sh/ru/docs/){% endif %}{% if lang == "en" %}(https://helm.sh/docs/){% endif %} версии 3.9.0.
* [jq](https://stedolan.github.io/jq/manual/) версии 1.6 или выше.
* [tree](https://manpages.ubuntu.com/manpages/focal/en/man1/tree.1.html) версии 1.8.0 или выше.
* [gRPCurl](https://github.com/fullstorydev/grpcurl) версии 1.8.6.
* [Pulumi](https://www.pulumi.com/docs/) версии 3.33.2.
* [tmux](https://manpages.ubuntu.com/manpages/focal/man1/tmux.1.html) версии 3.0a или выше.

С помощью Packer будет создана и запущена вспомогательная ВМ, на которую будет установлено необходимое ПО. Затем на основе ее загрузочного диска будет собран образ. После этого вспомогательная ВМ и загрузочный диск будут удалены.

Аналогично вы можете создать собственный образ с необходимым набором ПО.

Чтобы собрать образ и создать на его основе ВМ:
1. [Подготовьте облако к работе](#before-begin).
1. [Подготовьте рабочее окружение](#environment-prepare).
1. [Подготовьте конфигурацию образа](#prepare-image-config).
1. [Соберите образ](#create-image).
1. [Создайте ВМ из образа](#create-vm).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость сборки образа ВМ с последующим созданием ВМ входит: 
* плата за хранение собранных образов (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md#prices-storage));
* плата за вычислительные ресурсы ВМ (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md#prices-instance-resources)).

## Подготовьте рабочее окружение {#environment-prepare}

1. Установите Packer:
    1. Скачайте дистрибутив Packer и установите его по [инструкции на официальном сайте](https://www.packer.io/intro/getting-started/install.html#precompiled-binaries).
   
        {% if product == "yandex-cloud" %}

        Также вы можете скачать дистрибутив Packer для вашей платформы из [зеркала {{ yandex-cloud }}](https://hashicorp-releases.yandexcloud.net/packer/).
   
        {% endif %}

    1. После загрузки добавьте путь к папке, в которой находится исполняемый файл, в переменную `PATH`. Для этого выполните команду: 

        ```bash
        export PATH=$PATH:<путь_к_папке_с_исполняемым_файлом_Packer>
        ```

        {% note info %}

        Для работы с {{ yandex-cloud }} требуется Packer версии не ниже 1.5.

        {% endnote %}

1. [Установите](../../cli/quickstart.md#install) {{ yandex-cloud }} CLI и [создайте](../../cli/quickstart.md#initialize) профиль. 
1. Получите информацию о доступных подсетях и зонах доступности. Если у вас нет подсетей — [создайте](../../vpc/operations/subnet-create.md) новую.

    {% list tabs %}

    - CLI
  
      * Выполните команду:

        ```bash
        yc vpc subnet list
        ```

        Результат:

        ```bash
        +----------------------+----------------------+----------------------+----------------+---------------+-----------------+
        |          ID          |         NAME         |      NETWORK ID      | ROUTE TABLE ID |     ZONE      |      RANGE      |
        +----------------------+----------------------+----------------------+----------------+---------------+-----------------+
        | b0c29k6anelkik7jg5v1 | intro2-{{ region-id }}-c | enp45glgitd6e44dn1fj |                | {{ region-id }}-c | [10.130.0.0/24] |
        | e2ltcj4urgpbsbaq9977 | intro2-{{ region-id }}-b | enp45glgitd6e44dn1fj |                | {{ region-id }}-b | [10.129.0.0/24] |
        | e9bn57jvjnbujnmk3mba | intro2-{{ region-id }}-a | enp45glgitd6e44dn1fj |                | {{ region-id }}-a | [10.128.0.0/24] |
        +----------------------+----------------------+----------------------+----------------+---------------+-----------------+
        ```

      * Запишите идентификатор [подсети](../../vpc/concepts/network.md#subnet) (столбец `ID`), в которой будет размещаться вспомогательная ВМ, на основе которой создается образ, а также соответствующую [зону доступности](../../overview/concepts/geo-scope.md) (столбец `ZONE`). Эти параметры потребуются в дальнейшем.

    - API
    
      Воспользуйтесь методом REST API [list](../../vpc/api-ref/Subnet/list.md) для ресурса [Subnet](../../vpc/api-ref/Subnet/index.md) или вызовом gRPC API [SubnetService/List](../../vpc/api-ref/grpc/subnet_service.md#List).

    {% endlist %}

1. Задайте в командной строке значения переменных, используемых в процессе сборки образа.

    ```bash
    export YC_FOLDER_ID=$(yc config get folder-id)
    export YC_ZONE="<зона_доступности>"
    export YC_SUBNET_ID="<идентификатор_подсети>"
    export YC_TOKEN=$(yc iam create-token)
    ```

    Где:

    * `YC_FOLDER_ID` — идентификатор каталога, в котором будет размещена вспомогательная ВМ, на основе которой создается образ. Заполняется автоматически.
    * `YC_ZONE` — зона доступности, в которой будет размещена вспомогательная ВМ, на основе которой создается образ. Получена ранее.
    * `YC_SUBNET_ID` — идентификатор подсети, в которой будет размещена вспомогательная ВМ, на основе которой создается образ. Получен ранее.
    * `YC_TOKEN` — [IAM-токен](../../iam/concepts/authorization/iam-token.md). Нужен для создания образа ВМ, заполняется автоматически.
1. [Сгенерируйте](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) пару {% if lang == "ru" and audience != "internal" %}[SSH-ключей](../../glossary/ssh-keygen.md){% else %}SSH-ключей{% endif %}. Они понадобятся при создании и подключении к ВМ.

## Подготовьте конфигурацию образа {#prepare-image-config}

1. Создайте конфигурационный файл в формате [HCL](https://github.com/hashicorp/hcl#readme), например `toolbox.pkr.hcl`.
1. Опишите в конфигурационном файле параметры образа, который необходимо создать:

    {% if product == "yandex-cloud" %}

    ```hcl
    # {{ yandex-cloud }} Toolbox VM Image based on Ubuntu 20.04 LTS
    #
    # Provisioner docs:
    # https://www.packer.io/docs/builders/yandex
    #

    variable "YC_FOLDER_ID" {
      type = string
      default = env("YC_FOLDER_ID")
    }

    variable "YC_ZONE" {
      type = string
      default = env("YC_ZONE")
    }

    variable "YC_SUBNET_ID" {
      type = string
      default = env("YC_SUBNET_ID")
    }

    variable "TF_VER" {
      type = string
      default = "1.1.9"
    }

    variable "KCTL_VER" {
      type = string
      default = "1.23.0"
    }

    variable "HELM_VER" {
      type = string
      default = "3.9.0"
    }

    variable "GRPCURL_VER" {
      type = string
      default = "1.8.6"
    }

    variable "GOLANG_VER" {
      type = string
      default = "1.17.2"
    }

    variable "PULUMI_VER" {
      type = string
      default = "3.33.2"
    }

    source "yandex" "yc-toolbox" {
      folder_id           = "${var.YC_FOLDER_ID}"
      source_image_family = "ubuntu-2004-lts"
      ssh_username        = "ubuntu"
      use_ipv4_nat        = "true"
      image_description   = "{{ yandex-cloud }} Ubuntu Toolbox image"
      image_family        = "my-images"
      image_name          = "yc-toolbox"
      subnet_id           = "${var.YC_SUBNET_ID}"
      disk_type           = "network-hdd"
      zone                = "${var.YC_ZONE}"
    }

    build {
      sources = ["source.yandex.yc-toolbox"]
 
      provisioner "shell" {
        inline = [
          # Global Ubuntu things
          "sudo apt-get update",
          "echo 'debconf debconf/frontend select Noninteractive' | sudo debconf-set-selections",
          "sudo apt-get install -y unzip python3-pip python3.8-venv",

          # {{ yandex-cloud }} CLI tool
          "curl -s -O https://{{ s3-storage-host }}{{ yc-install-path }}",
          "chmod u+x install.sh",
          "sudo ./install.sh -a -i /usr/local/ 2>/dev/null",
          "rm -rf install.sh",
          "sudo sed -i '$ a source /usr/local/completion.bash.inc' /etc/profile",
      
          # Docker
          "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-keyring.gpg",
          "echo \"deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable\" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null",
          "sudo apt-get update",
          "sudo apt-get install -y docker-ce containerd.io",
          "sudo usermod -aG docker $USER",
          "sudo chmod 666 /var/run/docker.sock",
          "sudo useradd -m -s /bin/bash -G docker yc-user",

          # Docker Artifacts
          "docker pull hello-world",
          "docker pull -q amazon/aws-cli",
          "docker pull -q golang:${var.GOLANG_VER}",

          # Terraform (classic way)
          #"curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-keyring.gpg",
          #"echo \"deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main\" | sudo tee /etc/apt/sources.list.d/hashicorp.list > /dev/null",
          #"sudo apt-get update",
          #"sudo apt-get install -y terraform",
          #
          # Alternative Option
          "curl -sL {{ terraform-mirror }}${var.TF_VER}/terraform_${var.TF_VER}_linux_amd64.zip -o terraform.zip",
          "unzip terraform.zip",
          "sudo install -o root -g root -m 0755 terraform /usr/local/bin/terraform",
          "rm -rf terraform terraform.zip",
          # Terraform configuration file ?
          #"cat <<EOF > ~/.terraformrc \n provider_installation { network_mirror { url = \"https://terraform-mirror.yandexcloud.net/\" include = [\"registry.terraform.io/*/*\"] } direct { exclude = [\"registry.terraform.io/*/*\"] } } \n EOF",

          # kubectl
          "curl -s -LO https://dl.k8s.io/release/v${var.KCTL_VER}/bin/linux/amd64/kubectl",
          "sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl",
          "rm -rf kubectl",

          # Helm
          "curl -sSLO https://get.helm.sh/helm-v${var.HELM_VER}-linux-amd64.tar.gz",
          "tar zxf helm-v${var.HELM_VER}-linux-amd64.tar.gz",
          "sudo install -o root -g root -m 0755 linux-amd64/helm /usr/local/bin/helm",
          "rm -rf helm-v${var.HELM_VER}-linux-amd64.tar.gz",
          "rm -rf linux-amd64",
          # User can add own repo after login like this:
          # helm repo add stable https://charts.helm.sh/stable

          ## grpccurl
          "curl -sSLO https://github.com/fullstorydev/grpcurl/releases/download/v${var.GRPCURL_VER}/grpcurl_${var.GRPCURL_VER}_linux_x86_64.tar.gz",
          "tar zxf grpcurl_${var.GRPCURL_VER}_linux_x86_64.tar.gz",
          "sudo install -o root -g root -m 0755 grpcurl /usr/local/bin/grpcurl",
          "rm -rf grpcurl_${var.GRPCURL_VER}_linux_x86_64.tar.gz",
          "rm -rf grpcurl",

          # Pulumi
          "curl -sSLO https://get.pulumi.com/releases/sdk/pulumi-v${var.PULUMI_VER}-linux-x64.tar.gz",
          "tar zxf pulumi-v${var.PULUMI_VER}-linux-x64.tar.gz",
          "sudo cp pulumi/* /usr/local/bin/",
          "rm -rf pulumi-v${var.PULUMI_VER}-linux-x64.tar.gz",
          "rm -rf pulumi",

          # Other packages
          "sudo apt-get install -y git jq tree tmux",

          # Clean
          "rm -rf .sudo_as_admin_successful",

          # Test - Check versions for installed components
          "echo '=== Tests Start ==='",
          "yc version",
          "terraform version",
          "docker version",
          "kubectl version --client=true",
          "helm version",
          "grpcurl --version",
          "git --version",
          "jq --version",
          "tree --version",
          "pulumi version",
          "echo '=== Tests End ==='"
        ]
      }
    }
    ```
   
    {% endif %}

    {% if product == "cloud-il" %}

    ```hcl
    # {{ yandex-cloud }} Toolbox VM Image based on Ubuntu 20.04 LTS
    #
    # Provisioner docs:
    # https://www.packer.io/docs/builders/yandex
    #

    variable "YC_FOLDER_ID" {
      type = string
      default = env("YC_FOLDER_ID")
    }

    variable "YC_ZONE" {
      type = string
      default = env("YC_ZONE")
    }

    variable "YC_SUBNET_ID" {
      type = string
      default = env("YC_SUBNET_ID")
    }

    variable "TF_VER" {
      type = string
      default = "1.1.9"
    }

    variable "KCTL_VER" {
      type = string
      default = "1.23.0"
    }

    variable "HELM_VER" {
      type = string
      default = "3.9.0"
    }

    variable "GRPCURL_VER" {
      type = string
      default = "1.8.6"
    }

    variable "GOLANG_VER" {
      type = string
      default = "1.17.2"
    }

    variable "PULUMI_VER" {
      type = string
      default = "3.33.2"
    }

    source "yandex" "yc-toolbox" {
      folder_id           = "${var.YC_FOLDER_ID}"
      source_image_family = "ubuntu-2004-lts"
      ssh_username        = "ubuntu"
      use_ipv4_nat        = "true"
      image_description   = "{{ yandex-cloud }} Ubuntu Toolbox image"
      image_family        = "my-images"
      image_name          = "yc-toolbox"
      subnet_id           = "${var.YC_SUBNET_ID}"
      disk_type           = "network-hdd"
      zone                = "${var.YC_ZONE}"
    }

    build {
      sources = ["source.yandex.yc-toolbox"]
 
      provisioner "shell" {
        inline = [
          # Global Ubuntu things
          "sudo apt-get update",
          "echo 'debconf debconf/frontend select Noninteractive' | sudo debconf-set-selections",
          "sudo apt-get install -y unzip python3-pip python3.8-venv",

          # {{ yandex-cloud }} CLI tool
          "curl -s -O https://{{ s3-storage-host }}{{ yc-install-path }}",
          "chmod u+x install.sh",
          "sudo ./install.sh -a -i /usr/local/ 2>/dev/null",
          "rm -rf install.sh",
          "sudo sed -i '$ a source /usr/local/completion.bash.inc' /etc/profile",
      
          # Docker
          "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-keyring.gpg",
          "echo \"deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable\" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null",
          "sudo apt-get update",
          "sudo apt-get install -y docker-ce containerd.io",
          "sudo usermod -aG docker $USER",
          "sudo chmod 666 /var/run/docker.sock",
          "sudo useradd -m -s /bin/bash -G docker yc-user",

          # Docker Artifacts
          "docker pull hello-world",
          "docker pull -q amazon/aws-cli",
          "docker pull -q golang:${var.GOLANG_VER}",

          # Terraform
          "curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-keyring.gpg",
          "echo \"deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main\" | sudo tee /etc/apt/sources.list.d/hashicorp.list > /dev/null",
          "sudo apt-get update",
          "sudo apt-get install -y terraform",

          # kubectl
          "curl -s -LO https://dl.k8s.io/release/v${var.KCTL_VER}/bin/linux/amd64/kubectl",
          "sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl",
          "rm -rf kubectl",

          # Helm
          "curl -sSLO https://get.helm.sh/helm-v${var.HELM_VER}-linux-amd64.tar.gz",
          "tar zxf helm-v${var.HELM_VER}-linux-amd64.tar.gz",
          "sudo install -o root -g root -m 0755 linux-amd64/helm /usr/local/bin/helm",
          "rm -rf helm-v${var.HELM_VER}-linux-amd64.tar.gz",
          "rm -rf linux-amd64",
          # User can add own repo after login like this:
          # helm repo add stable https://charts.helm.sh/stable

          ## grpccurl
          "curl -sSLO https://github.com/fullstorydev/grpcurl/releases/download/v${var.GRPCURL_VER}/grpcurl_${var.GRPCURL_VER}_linux_x86_64.tar.gz",
          "tar zxf grpcurl_${var.GRPCURL_VER}_linux_x86_64.tar.gz",
          "sudo install -o root -g root -m 0755 grpcurl /usr/local/bin/grpcurl",
          "rm -rf grpcurl_${var.GRPCURL_VER}_linux_x86_64.tar.gz",
          "rm -rf grpcurl",

          # Pulumi
          "curl -sSLO https://get.pulumi.com/releases/sdk/pulumi-v${var.PULUMI_VER}-linux-x64.tar.gz",
          "tar zxf pulumi-v${var.PULUMI_VER}-linux-x64.tar.gz",
          "sudo cp pulumi/* /usr/local/bin/",
          "rm -rf pulumi-v${var.PULUMI_VER}-linux-x64.tar.gz",
          "rm -rf pulumi",

          # Other packages
          "sudo apt-get install -y git jq tree tmux",

          # Clean
          "rm -rf .sudo_as_admin_successful",

          # Test - Check versions for installed components
          "echo '=== Tests Start ==='",
          "yc version",
          "terraform version",
          "docker version",
          "kubectl version --client=true",
          "helm version",
          "grpcurl --version",
          "git --version",
          "jq --version",
          "tree --version",
          "pulumi version",
          "echo '=== Tests End ==='"
        ]
      }
    }
    ```
   
    {% endif %}

## Соберите образ {#create-image}

1. В командной строке перейдите в папку с конфигурационным файлом образа:

    ```bash
    cd <путь_к_папке_с_конфигурационным_файлом>
    ```

1. Проверьте корректность конфигурационного файла образа с помощью команды:

    ```bash
    packer validate yc-toolbox.pkr.hcl
    ```

    Где `yc-toolbox.pkr.hcl` — имя конфигурационного файла.

    Если конфигурация является корректной, появится сообщение:
     
    ```bash
    The configuration is valid.
    ```

1. Запустите сборку образа с помощью команды:

    ```bash
    packer build yc-toolbox.pkr.hcl
    ```

    Где `yc-toolbox.pkr.hcl` — имя конфигурационного файла.
1. После завершения сборки будет выведено сообщение о том, что образ успешно создан:

    ```bash
    ...
    ==> Builds finished. The artifacts of successful builds are:
    --> yandex.yc-toolbox: A disk image was created: yc-toolbox (id: fd83j475posvi0ffmi5b) with family name infra-images
    ```

    Запишите идентификатор собранного образа — параметр `id`. Используйте этот идентификатор в дальнейшем, чтобы создать ВМ.

1. Проверьте наличие собранного образа в {{ yandex-cloud }}.

    {% list tabs %}

    - CLI
  
      Выполните команду:

      ```bash
      yc compute image list
      ```

      Результат:

      ```bash
      +----------------------+------------+-----------+----------------------+--------+
      |          ID          |    NAME    |  FAMILY   |     PRODUCT IDS      | STATUS |
      +----------------------+------------+-----------+----------------------+--------+
      | fd83j475posvi0ffmi5b | yc-toolbox | my-images | f2ek1vhoppg2l2afslmq | READY  |
      +----------------------+------------+-----------+----------------------+--------+
      ```

    - API

      Воспользуйтесь методом REST API [list](../../compute/api-ref/Image/list.md) для ресурса [Image](../../compute/api-ref/Image/) или вызовом gRPC API [ImageService/List](../../compute/api-ref/grpc/image_service.md#List).

    {% endlist %}

## Создайте виртуальную машину из образа {#create-vm}
  
1. Задайте значения переменных, используемых в процессе создания ВМ. Для этого выполните команду:

    ```bash
    export VM_NAME="<имя_ВМ>"
    export YC_IMAGE_ID="<идентификатор_образа>"
    export YC_SUBNET_ID="<идентификатор_подсети>"
    export YC_ZONE="<зона_доступности>"
    ```

    Где:

    * `VM_NAME` — имя создаваемой ВМ.
    * `YC_IMAGE_ID` — идентификатор образа, из которого будет создана ВМ. Получен ранее.
    * `YC_SUBNET_ID` — идентификатор подсети, в которой будет размещена ВМ. Получен ранее.
    * `YC_ZONE` — зона доступности, в которой будет размещена ВМ. Получена ранее.

1. Создайте ВМ из собранного образа.

    {% list tabs %}

    - CLI

      Выполните команду:

      ```bash
      yc compute instance create \
        --name $VM_NAME \
        --hostname $VM_NAME \
        --zone=$YC_ZONE \
        --create-boot-disk size=20GB,image-id=$YC_IMAGE_ID \
        --cores=2 \
        --memory=8G \
        --core-fraction=100 \
        --network-interface subnet-id=$YC_SUBNET_ID,ipv4-address=auto,nat-ip-version=ipv4 \
        --ssh-key <путь_к_публичной_части_SSH-ключа>
      ```

      Где:

      * `name` — имя создаваемой ВМ.
      * `hostname` — имя хоста ВМ.
      * `zone` — зона доступности.
      * `create-boot-disk` — параметры загрузочного диска: `size` — размер, `image-id` — идентификатор используемого образа.
      * `cores` — количество vCPU.
      * `memory` — объем RAM.
      * `core-fraction` — базовая производительность vCPU в %.
      * `network-interface` — параметры сетевого интерфейса: `subnet-id` — идентификатор подсети, `ipv4-address` — внутренний IPv4-адрес, `nat-ip-version` — спецификация IP для NAT в интернет.
      * `ssh-key` — публичная часть SSH-ключа.

      После выполнения команды будет выведена информация о созданной ВМ. Запишите публичный IP-адрес ВМ:

      ```bash
      ...
      one_to_one_nat:
        address: 62.84.122.151
      ...
      ```

      Подробнее о [создании ВМ из пользовательского образа](../../compute/operations/vm-create/create-from-user-image.md).

    - API

      Воспользуйтесь методом REST API [create](../../compute/api-ref/Instance/create.md) для ресурса [Instance](../../compute/api-ref/Instance/) или вызовом gRPC API [InstanceService/Create](../../compute/api-ref/grpc/instance_service.md#Create).

    {% endlist %}

1. Подключитесь к ВМ по протоколу SSH:

    ```bash
    ssh -i <путь_к_закрытой_части_SSH-ключа> yc-user@<публичный_IP-адрес_ВМ>
    ```

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:
* [удалите ВМ](../../compute/operations/vm-control/vm-delete.md);
* [удалите образ](../../compute/operations/image-control/delete.md).