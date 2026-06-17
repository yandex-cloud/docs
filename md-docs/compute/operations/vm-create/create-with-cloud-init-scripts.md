# Создать виртуальную машину с пользовательским скриптом конфигурации

Вы можете создать виртуальную машину с предустановленной конфигурацией программного обеспечения с помощью ключа `user-data` в [метаданных](../../concepts/vm-metadata.md) ВМ.

Заданная в ключе `user-data` конфигурация обрабатываются агентом [cloud-init](https://cloudinit.readthedocs.io/en/latest/), запущенным на ВМ. Cloud-init поддерживает разные форматы передачи метаданных, например [cloud-config](https://cloudinit.readthedocs.io/en/latest/reference/examples.html).

{% note info %}

Чтобы создавать, изменять и редактировать [ВМ](../../concepts/vm.md), необходима _минимальная_ [роль](../../security/index.md#compute-editor) `compute.editor` на [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder). Для создания ВМ с лицензируемым образом дополнительно потребуется [роль](../../../marketplace/security/index.md#license-manager-viewer) `license-manager.viewer`.

Для создания ВМ с [публичным IP-адресом](../../../vpc/concepts/address.md#public-addresses) дополнительно потребуется [роль](../../../vpc/security/index.md#vpc-public-admin) `vpc.publicAdmin`.

{% endnote %}

## Создание виртуальной машины с пользовательским скриптом конфигурации {#create-vm-with-user-script}

{% note warning %}

В конфигурации `user-data` обязательно задавайте логин и SSH-ключ пользователя, даже если вы ранее указали эти данные в блоке **Доступ** в консоли управления.

{% endnote %}

Чтобы создать ВМ с пользовательским скриптом конфигурации:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором будет создана ВМ.
  1. Перейдите в сервис **Compute Cloud**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/server.svg) **Виртуальные машины**.
  1. Нажмите кнопку **Создать виртуальную машину**.
  1. [Задайте](create-linux-vm.md) нужные параметры ВМ.
  1. Раскройте блок **Метаданные** и в появившихся полях укажите:

      * **Ключ** — `user-data`.
      * **Значение** — конфигурация `cloud-config` в формате YAML. Примеры конфигурации для `user-data` приведены в подразделе [Примеры](#examples).

  1. Нажмите кнопку **Создать ВМ**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Выполните команду:

  ```bash
  yc compute instance create \
    --name my-sample-instance \
    --zone ru-central1-a \
    --network-interface subnet-name=<имя_подсети>,nat-ip-version=ipv4,security-group-ids=<идентификатор_группы_безопасности> \
    --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-2204-lts,kms-key-id=<идентификатор_ключа> \
    --metadata-from-file user-data="<путь_к_файлу_конфигурации>"
  ```

  Где:

  * `--name` — имя ВМ. Требования к имени:

      * длина — от 3 до 63 символов;
      * может содержать строчные буквы латинского алфавита, цифры и дефисы;
      * первый символ — буква, последний — не дефис.

      {% note info %}
      
      Имя виртуальной машины используется для генерации [внутреннего FQDN](../../concepts/network.md#hostname) единожды — при создании ВМ. Если для вас важен внутренний FQDN, учитывайте это и задавайте нужное имя ВМ при создании.
      
      {% endnote %}

  * `--zone` — [зона доступности](../../../overview/concepts/geo-scope.md), которая соответствует выбранной подсети.
  * `--network-interface` — настройки [сетевого интерфейса](../../concepts/network.md) ВМ:

      * `subnet-name` — имя [подсети](../../../vpc/concepts/network.md#subnet), расположенной в [зоне доступности](../../../overview/concepts/geo-scope.md), указанной в параметре `--zone`.
      * `security-group-ids` — идентификатор [группы безопасности](../../../vpc/concepts/security-groups.md).

  * `--create-boot-disk` — настройки загрузочного диска ВМ:

      * `image-family` — [семейство образов](../../concepts/image.md#family), например, `ubuntu-2204-lts`. Эта опция позволит установить последнюю версию ОС из указанного семейства.
      * `kms-key-id` — идентификатор [симметричного ключа KMS](../../../kms/concepts/key.md) для создания зашифрованного загрузочного диска. Необязательный параметр.

        Для создания зашифрованного диска нужна [роль](../../../kms/security/index.md#kms-keys-user) `kms.keys.user` или выше.
        
        {% note warning %}
        
        Задать настройки шифрования можно только при создании диска. Шифрование диска нельзя будет отключить или изменить. Также нельзя будет включить шифрование для уже созданного диска.
        
        {% endnote %}

        Если деактивировать ключ, которым были зашифрованы диск, снимок или образ, доступ к данным будет приостановлен, пока ключ не будет снова активирован.
        
        {% note alert %}
        
        Если удалить ключ или его [версию](../../../kms/concepts/version.md), которыми были зашифрованы диск, снимок или образ, то доступ к данным будет безвозвратно потерян. Подробнее смотрите [Удаление версии ключа](../../../kms/concepts/version.md#version-distruct).
        
        {% endnote %}

  * `--metadata-from-file` — ключ `user-data` и его значение — путь к файлу с конфигурацией `cloud-config` в формате YAML. Например: `--metadata-from-file user-data="/home/user/metadata.yaml"`.

      Примеры конфигурации для `user-data` приведены в подразделе [Примеры](#examples).

  {% note info %}
  
  Команды [`yc compute instance create`](../../../cli/cli-ref/compute/cli-ref/instance/create.md) | [`create-with-container`](../../../cli/cli-ref/compute/cli-ref/instance/create-with-container.md) | [`update`](../../../cli/cli-ref/compute/cli-ref/instance/update.md) | [`add-metadata`](../../../cli/cli-ref/compute/cli-ref/instance/add-metadata.md) поддерживают подстановку в метаданные ВМ значений переменных окружения. Эти значения, заданные в ключе `user-data` в формате `$<имя_переменной>`, в момент выполнения команды Yandex Cloud CLI будут подставлены в метаданные ВМ из переменных окружения среды, в которой выполняется команда. 
  
  Чтобы изменить такое поведение, не подставлять значение переменной из среды выполнения команды CLI и передать в метаданные ВМ имя переменной в формате `$<имя_переменной>`, используйте синтаксис с двумя символами доллара. Например: `$$<имя_переменной>`.
  
  Подробнее в разделе [Особенности передачи переменных окружения в метаданных через CLI](../../concepts/metadata/sending-metadata.md#environment-variables).
  
  {% endnote %}

- Terraform {#tf}

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  Добавьте скрипт конфигурации ВМ в секцию `metadata` ресурса `yandex_compute_instance` конфигурационного файла Terraform:

  ```hcl
  resource "yandex_compute_instance" "vm-1" {
    name        = "my-sample-instance"
    ...
    metadata    = {
      user-data = "${file("<путь_к_файлу_конфигурации>")}"
    }
    ...
  }
  ```

  Где:
  * `user-data` — путь к файлу с конфигурацией `cloud-config` в формате YAML. Например: `user-data = "${file("/home/user/metadata.yaml")}"`.
  
      Примеры конфигурации для `user-data` приведены в подразделе [Примеры](#examples).

- API {#api}

  Создайте ВМ с помощью метода REST API [create](../../api-ref/Instance/create.md) для ресурса [Instance](../../api-ref/Instance/index.md), передав в поле `metadata` в теле запроса объект, содержащий YAML-конфигурацию `cloud-config`. Если в конфигурации несколько строк, используйте `\n` в качестве разделителя. Например:

  ```json
  {
    "folderId": "b1gvmob95yys********",
    "name": "my-sample-instance",
    "zoneId": "ru-central1-a",
    "platformId": "standard-v3",
    ...
    "metadata": {
      "user-data": "#cloud-config\ndatasource:\n  Ec2:\n    strict_id: false\nssh_pwauth: yes\nusers:\n- name: <имя_пользователя>\n  sudo: 'ALL=(ALL) NOPASSWD:ALL'\n  shell: /bin/bash\n  ssh_authorized_keys:\n  - <публичный_SSH-ключ>\nwrite_files:\n  - path: '/usr/local/etc/startup.sh'\n    permissions: '755'\n    content: |\n      #!/bin/bash\n      apt-get update\n      apt-get install -y nginx\n      service nginx start\n      sed -i -- 's/ nginx/ Yandex Cloud - ${HOSTNAME}/' /var/www/html/index.nginx-debian.html\n    defer: true\nruncmd:\n  - ['/usr/local/etc/startup.sh']"
    },
    ...
  }
  ```

  Примеры конфигурации для `user-data` приведены в подразделе [Примеры](#examples).

{% endlist %}

Подробнее о создании ВМ читайте в разделе [Создать виртуальную машину из публичного образа Linux](create-linux-vm.md).

Чтобы убедиться в успешном выполнении скриптов конфигурации, [получите вывод последовательного порта](../vm-info/get-serial-port-output.md) ВМ.

## Примеры {#examples}

{% list tabs %}

- Nginx

  Чтобы установить и запустить веб-сервер [Nginx](https://nginx.org/) на создаваемой ВМ, укажите для ключа `user-data` следующее значение:

  ```yaml
  #cloud-config
  datasource:
    Ec2:
      strict_id: false
  ssh_pwauth: no
  users:
  - name: <имя_пользователя>
    sudo: 'ALL=(ALL) NOPASSWD:ALL'
    shell: /bin/bash
    ssh_authorized_keys:
    - <публичный_SSH-ключ>
  write_files:
    - path: "/usr/local/etc/startup.sh"
      permissions: "755"
      content: |
        #!/bin/bash

        apt-get update
        apt-get install -y nginx
        service nginx start
        sed -i -- "s/ nginx/ Yandex Cloud - ${HOSTNAME}/" /var/www/html/index.nginx-debian.html
      defer: true
  runcmd:
    - ["/usr/local/etc/startup.sh"]
  ```

  Где:
  * `<имя_пользователя>` — логин пользователя, который будет использоваться для [подключения](../vm-connect/ssh.md) к ВМ по SSH.
  * `<публичный_SSH-ключ>` — содержимое файла [открытого ключа](../vm-connect/ssh.md#creating-ssh-keys). Пару ключей для подключения по [SSH](../../../glossary/ssh-keygen.md) необходимо [создать](../vm-connect/ssh.md#creating-ssh-keys) самостоятельно.

- Docker

  Чтобы установить [Docker](https://www.docker.com) на создаваемой ВМ, а также загрузить и запустить контейнер, укажите для ключа `user-data` следующее значение:

  ```yaml
  #cloud-config
  datasource:
    Ec2:
      strict_id: false
  ssh_pwauth: no
  users:
  - name: <имя_пользователя>
    sudo: "ALL=(ALL) NOPASSWD:ALL"
    shell: /bin/bash
    ssh_authorized_keys:
    - <публичный_SSH-ключ>
  write_files:
    - path: "/usr/local/etc/docker-start.sh"
      permissions: "755"
      content: |
        #!/bin/bash

        # Docker
        echo "Installing Docker"
        sudo apt update -y && sudo apt install docker.io -y
        echo "Grant user access to Docker"
        sudo usermod -aG docker ${USER}
        newgrp docker

      defer: true
    - path: "/usr/local/etc/docker-main.sh"
      permissions: "755"
      content: |
        #!/bin/bash

        # Docker run container
        docker pull hello-world:latest
        docker run hello-world

      defer: true
  runcmd:
    - [su, <имя_пользователя>, -c, "/usr/local/etc/docker-start.sh"]
    - [su, <имя_пользователя>, -c, "/usr/local/etc/docker-main.sh"]
  ```

  Где:
  * `<имя_пользователя>` — логин пользователя, который будет использоваться для [подключения](../vm-connect/ssh.md) к ВМ по SSH.
  * `<публичный_SSH-ключ>` — содержимое файла [открытого ключа](../vm-connect/ssh.md#creating-ssh-keys). Пару ключей для подключения по [SSH](../../../glossary/ssh-keygen.md) необходимо [создать](../vm-connect/ssh.md#creating-ssh-keys) самостоятельно.

- Yandex Cloud CLI

  Чтобы установить [Yandex Cloud CLI](../../../cli/quickstart.md) на создаваемой ВМ, укажите для ключа `user-data` следующее значение:

  ```yaml
  #cloud-config
  datasource:
    Ec2:
      strict_id: false
  ssh_pwauth: no
  users:
  - name: <имя_пользователя>
    sudo: 'ALL=(ALL) NOPASSWD:ALL'
    shell: /bin/bash
    ssh_authorized_keys:
    - <публичный_SSH-ключ>
  write_files:
    - path: "/usr/local/etc/yc-install.sh"
      permissions: "0755"
      owner: <имя_пользователя>:<имя_пользователя>
      content: |
        #!/bin/bash

        # CLI
        echo "Installing Yandex Cloud CLI"
        curl \
          --silent \
          --show-error \
          --location \
          https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash
        VM_ID=$(curl --silent http://169.254.169.254/latest/meta-data/instance-id)

        # Save YC params
        echo "Saving YC params to the ~/.bashrc"
        cat << EOF >> $HOME/.bashrc
          export PATH="$HOME/yandex-cloud/bin:$PATH"
          export YC_CLI_VM_ID="${VM_ID:-unknown}"
        EOF
      defer: true
  runcmd:
    - [su, <имя_пользователя>, -c, "/usr/local/etc/yc-install.sh"]
  ```

  Где:
  * `<имя_пользователя>` — логин пользователя, который будет использоваться для [подключения](../vm-connect/ssh.md) к ВМ по SSH.
  * `<публичный_SSH-ключ>` — содержимое файла [открытого ключа](../vm-connect/ssh.md#creating-ssh-keys). Пару ключей для подключения по [SSH](../../../glossary/ssh-keygen.md) необходимо [создать](../vm-connect/ssh.md#creating-ssh-keys) самостоятельно.

- Yandex Unified Agent

  {% note info %}

  При создании виртуальной машины с [Yandex Unified Agent](../../../monitoring/concepts/data-collection/unified-agent/index.md) привяжите к ней [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md), которому назначена [роль](../../../monitoring/security/index.md#monitoring-editor) `monitoring.editor` на текущий [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder).

  {% endnote %}

  Чтобы установить Unified Agent на создаваемой ВМ, укажите для ключа `user-data` следующее значение:

  ```yaml
  #cloud-config
  datasource:
    Ec2:
      strict_id: false
  ssh_pwauth: no
  users:
  - name: <имя_пользователя>
    sudo: 'ALL=(ALL) NOPASSWD:ALL'
    shell: /bin/bash
    ssh_authorized_keys:
    - <публичный_SSH-ключ>
  runcmd:
    - wget -O - https://monitoring.api.cloud.yandex.net/monitoring/v2/unifiedAgent/config/install.sh | bash
  ```

  Где:
  * `<имя_пользователя>` — логин пользователя, который будет использоваться для [подключения](../vm-connect/ssh.md) к ВМ по SSH.
  * `<публичный_SSH-ключ>` — содержимое файла [открытого ключа](../vm-connect/ssh.md#creating-ssh-keys). Пару ключей для подключения по [SSH](../../../glossary/ssh-keygen.md) необходимо [создать](../vm-connect/ssh.md#creating-ssh-keys) самостоятельно.

  Чтобы привязать сервисный аккаунт к ВМ при создании ВМ с помощью Terraform, укажите в конфигурации строку:
  
  ```hcl
  resource "yandex_compute_instance" "my-vm" {
    ...
    service_account_id = "ajehka*************"
  }
  ```

  Чтобы Unified Agent записывал метрики в Yandex Managed Service for Prometheus®, укажите в конфигурации идентификатор воркспейса:
  
  ```hcl
  resource "yandex_compute_instance" "my-vm" {
    ...
    metadata    = {
      monitoring_workspaceid = "mon618clr**************"
    }
  }
  ```

- Terraform

  Чтобы установить [Terraform](https://www.terraform.io/) на создаваемой ВМ, укажите для ключа `user-data` следующее значение:

  ```yaml
  #cloud-config
  datasource:
    Ec2:
      strict_id: false
  ssh_pwauth: no
  users:
  - name: <имя_пользователя>
    sudo: 'ALL=(ALL) NOPASSWD:ALL'
    shell: /bin/bash
    ssh_authorized_keys:
    - <публичный_SSH-ключ>
  write_files:
    - path: "/usr/local/etc/tf-install.sh"
      permissions: "755"
      content: |
        #!/bin/bash

        # Install Global Ubuntu things
        sudo apt-get update
        echo 'debconf debconf/frontend select Noninteractive' | sudo debconf-set-selections
        sudo apt-get install -y unzip python3-pip

        # Install Terraform
        echo "Installing Terraform"
        sudo curl \
          --silent \
          --show-error \
          --location \
          https://hashicorp-releases.yandexcloud.net/terraform/1.8.5/terraform_1.8.5_linux_amd64.zip \
          --output /usr/local/etc/terraform.zip
        sudo unzip /usr/local/etc/terraform.zip -d /usr/local/etc/
        sudo install -o root -g root -m 0755 /usr/local/etc/terraform /usr/local/bin/terraform
        sudo rm -rf /usr/local/etc/terraform /usr/local/etc/terraform.zip /usr/local/etc/LICENSE.txt
      defer: true
  runcmd:
    - [su, <имя_пользователя>, -c, "/usr/local/etc/tf-install.sh"]
  ```

  Где:
  * `<имя_пользователя>` — логин пользователя, который будет использоваться для [подключения](../vm-connect/ssh.md) к ВМ по SSH.
  * `<публичный_SSH-ключ>` — содержимое файла [открытого ключа](../vm-connect/ssh.md#creating-ssh-keys). Пару ключей для подключения по [SSH](../../../glossary/ssh-keygen.md) необходимо [создать](../vm-connect/ssh.md#creating-ssh-keys) самостоятельно.

- kubectl

  Чтобы установить [утилиту kubectl](https://kubernetes.io/docs/reference/kubectl/) на создаваемой ВМ, укажите для ключа `user-data` следующее значение:

  ```yaml
  #cloud-config
  datasource:
    Ec2:
      strict_id: false
  ssh_pwauth: no
  users:
  - name: <имя_пользователя>
    sudo: 'ALL=(ALL) NOPASSWD:ALL'
    shell: /bin/bash
    ssh_authorized_keys:
    - <публичный_SSH-ключ>
  write_files:
    - path: "/usr/local/etc/kubectl-install.sh"
      permissions: "755"
      content: |
        #!/bin/bash

        # Install kubectl
        echo "Installing kubectl"
        sudo curl \
          --silent \
          --show-error \
          --location \
          https://dl.k8s.io/release/v1.31.0/bin/linux/amd64/kubectl \
          --output /usr/local/etc/kubectl
        sudo install -o root -g root -m 0755 /usr/local/etc/kubectl /usr/local/bin/kubectl
        sudo rm -rf /usr/local/etc/kubectl
      defer: true
  runcmd:
    - [su, <имя_пользователя>, -c, "/usr/local/etc/kubectl-install.sh"]
  ```

  Где:
  * `<имя_пользователя>` — логин пользователя, который будет использоваться для [подключения](../vm-connect/ssh.md) к ВМ по SSH.
  * `<публичный_SSH-ключ>` — содержимое файла [открытого ключа](../vm-connect/ssh.md#creating-ssh-keys). Пару ключей для подключения по [SSH](../../../glossary/ssh-keygen.md) необходимо [создать](../vm-connect/ssh.md#creating-ssh-keys) самостоятельно.

- Helm

  Чтобы установить [Helm](https://helm.sh/) на создаваемой ВМ, укажите для ключа `user-data` следующее значение:

  ```yaml
  #cloud-config
  datasource:
    Ec2:
      strict_id: false
  ssh_pwauth: no
  users:
  - name: <имя_пользователя>
    sudo: 'ALL=(ALL) NOPASSWD:ALL'
    shell: /bin/bash
    ssh_authorized_keys:
    - <публичный_SSH-ключ>
  write_files:
    - path: "/usr/local/etc/helm-install.sh"
      permissions: "755"
      content: |
        #!/bin/bash

        # Install Helm
        echo "Installing Helm"
        sudo curl \
          --silent \
          --show-error \
          --location \
          https://get.helm.sh/helm-v3.15.2-linux-amd64.tar.gz \
          --output /usr/local/etc/helm-v3.15.2-linux-amd64.tar.gz
        sudo tar xf /usr/local/etc/helm-v3.15.2-linux-amd64.tar.gz -C /usr/local/etc/
        sudo install -o root -g root -m 0755 /usr/local/etc/linux-amd64/helm /usr/local/bin/helm
        sudo rm -rf /usr/local/etc/helm-v3.15.2-linux-amd64.tar.gz /usr/local/etc/linux-amd64
      defer: true
  runcmd:
    - [su, <имя_пользователя>, -c, "/usr/local/etc/helm-install.sh"]
  ```

  Где:
  * `<имя_пользователя>` — логин пользователя, который будет использоваться для [подключения](../vm-connect/ssh.md) к ВМ по SSH.
  * `<публичный_SSH-ключ>` — содержимое файла [открытого ключа](../vm-connect/ssh.md#creating-ssh-keys). Пару ключей для подключения по [SSH](../../../glossary/ssh-keygen.md) необходимо [создать](../vm-connect/ssh.md#creating-ssh-keys) самостоятельно.

{% endlist %}

#### Полезные ссылки {#see-also}

Другие примеры конфигураций для ключа `user-data`:

* [Создание группы виртуальных машин с подключением к файловому хранилищу](../instance-groups/create-with-filesystem.md)
* [Создание группы виртуальных машин с подключением к Yandex Object Storage](../instance-groups/create-with-bucket.md)
* [Восстановление работоспособности сетевых интерфейсов ВМ](../../qa/troubleshooting.md#unable-to-connect-to-new-multi-interface-vm)
* [Автоматическая привязка политики резервного копирования Yandex Cloud Backup к ВМ](../../../tutorials/archive/vm-with-backup-policy/index.md)
* [Установка агента для сбора метрик и логов Unified Agent](../../../monitoring/concepts/data-collection/unified-agent/installation.md#setup)
* [Установка агента для сбора метрик в формате Prometheus](../../../monitoring/operations/prometheus/ingestion/prometheus-agent.md)