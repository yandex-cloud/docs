---
title: Как создать виртуальную машину с пользовательским скриптом
description: Следуя данной инструкции, вы сможете использовать скрипты в cloud-init, чтобы установить дополнительное ПО и донастроить ВМ при ее создании.
---

# Создать виртуальную машину с пользовательским скриптом конфигурации

Вы можете создать виртуальную машину с предустановленной конфигурацией программного обеспечения с помощью ключа `user-data` в [метаданных](../../concepts/vm-metadata.md) ВМ.

Заданная в ключе `user-data` конфигурация обрабатываются агентом [cloud-init](https://cloudinit.readthedocs.io/en/latest/), запущенным на ВМ. Cloud-init поддерживает разные форматы передачи метаданных, например [cloud-config](https://cloudinit.readthedocs.io/en/latest/reference/examples.html).

## Создание виртуальной машины с пользовательским скриптом конфигурации {#create-vm-with-user-script}

{% note warning %}

В конфигурации `user-data` обязательно задавайте логин и SSH-ключ пользователя, даже если вы ранее указали эти данные в блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** в консоли управления.

{% endnote %}

Чтобы создать ВМ с пользовательским скриптом конфигурации:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создана ВМ.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.switch_instances }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. [Задайте](create-linux-vm.md) нужные параметры ВМ.
  1. Раскройте блок **{{ ui-key.yacloud.common.metadata }}** и в появившихся полях укажите:

      * **{{ ui-key.yacloud_billing.component.key-values-input.label_key }}** — `user-data`.
      * **{{ ui-key.yacloud_billing.component.key-values-input.label_value }}** — конфигурация `cloud-config` в формате YAML. Примеры конфигурации для `user-data` см. в подразделе [Примеры](#examples).

  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Выполните команду:

  ```bash
  yc compute instance create \
    --name my-sample-instance \
    --zone {{ region-id}}-a \
    --network-interface subnet-name=<имя_подсети>,nat-ip-version=ipv4,security-group-ids=<идентификатор_группы_безопасности> \
    --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-2204-lts \
    --metadata-from-file user-data="<путь_к_файлу_конфигурации>"
  ```

  Где:
  * `subnet-name` — имя [подсети](../../../vpc/concepts/network.md#subnet), расположенной в [зоне доступности](../../../overview/concepts/geo-scope.md), указанной в параметре `--zone`.
  * `security-group-ids` — идентификатор [группы безопасности](../../../vpc/concepts/security-groups.md).
  * `--metadata-from-file` — ключ `user-data` и его значение — путь к файлу с конфигурацией `cloud-config` в формате YAML. Например: `--metadata-from-file user-data="/home/user/metadata.yaml"`.

      Примеры конфигурации для `user-data` см. в подразделе [Примеры](#examples).

  {% include [cli-metadata-variables-substitution-notice](../../../_includes/compute/create/cli-metadata-variables-substitution-notice.md) %}

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Добавьте скрипт конфигурации ВМ в секцию `metadata` ресурса `yandex_compute_instance` конфигурационного файла {{ TF }}:

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
  
      Примеры конфигурации для `user-data` см. в подразделе [Примеры](#examples).

- API {#api}

  Создайте ВМ с помощью метода REST API [create](../../api-ref/Instance/create.md) для ресурса [Instance](../../api-ref/Instance/), передав в поле `metadata` в теле запроса объект, содержащий YAML-конфигурацию `cloud-config`. Если в конфигурации несколько строк, используйте `\n` в качестве разделителя. Например:

  ```json
  {
    "folderId": "b1gvmob95yys********",
    "name": "my-sample-instance",
    "zoneId": "{{ region-id }}-a",
    "platformId": "standard-v3",
    ...
    "metadata": {
      "user-data": "#cloud-config\ndatasource:\n  Ec2:\n    strict_id: false\nssh_pwauth: yes\nusers:\n- name: <имя_пользователя>\n  sudo: 'ALL=(ALL) NOPASSWD:ALL'\n  shell: /bin/bash\n  ssh_authorized_keys:\n  - <публичный_SSH-ключ>\nwrite_files:\n  - path: '/usr/local/etc/startup.sh'\n    permissions: '755'\n    content: |\n      #!/bin/bash\n      apt-get update\n      apt-get install -y nginx\n      service nginx start\n      sed -i -- 's/ nginx/ Yandex Cloud - ${HOSTNAME}/' /var/www/html/index.nginx-debian.html\n    defer: true\nruncmd:\n  - ['/usr/local/etc/startup.sh']"
    },
    ...
  }
  ```

  Примеры конфигурации для `user-data` см. в подразделе [Примеры](#examples).

{% endlist %}

Подробнее о создании ВМ см. в разделе [{#T}](./create-linux-vm.md).

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

  {% include [cli-install](../../../_includes/compute/create/legend-for-creating-user-data-scripts.md) %}

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

  {% include [cli-install](../../../_includes/compute/create/legend-for-creating-user-data-scripts.md) %}

- {{ yandex-cloud }} CLI

  Чтобы установить [{{ yandex-cloud }} CLI](../../../cli/quickstart.md) на создаваемой ВМ, укажите для ключа `user-data` следующее значение:

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
      permissions: "755"
      content: |
        #!/bin/bash

        # YC CLI
        echo "Installing Yandex Cloud CLI"
        curl \
          --silent \
          --show-error \
          --location \
          https://{{ s3-storage-host }}/yandexcloud-yc/install.sh | bash
        VM_ID=$(curl --silent http://169.254.169.254/latest/meta-data/instance-id)

        # Save YC params
        echo "Saving YC params to the ~/.bashrc"
        cat << EOF >> $HOME/.bashrc
      defer: true
  runcmd:
    - [su, <имя_пользователя>, -c, "/usr/local/etc/yc-install.sh"]
  ```

  {% include [cli-install](../../../_includes/compute/create/legend-for-creating-user-data-scripts.md) %}

- {{ TF }}

  Чтобы установить [{{ TF }}](https://www.terraform.io/) на создаваемой ВМ, укажите для ключа `user-data` следующее значение:

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

  {% include [cli-install](../../../_includes/compute/create/legend-for-creating-user-data-scripts.md) %}

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
          https://dl.k8s.io/release/v1.3.0/bin/linux/amd64/kubectl \
          --output /usr/local/etc/kubectl
        sudo install -o root -g root -m 0755 /usr/local/etc/kubectl /usr/local/bin/kubectl
        sudo rm -rf /usr/local/etc/kubectl
      defer: true
  runcmd:
    - [su, <имя_пользователя>, -c, "/usr/local/etc/kubectl-install.sh"]
  ```

  {% include [cli-install](../../../_includes/compute/create/legend-for-creating-user-data-scripts.md) %}

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

  {% include [cli-install](../../../_includes/compute/create/legend-for-creating-user-data-scripts.md) %}

{% endlist %}

#### См. также {#see-also}

Другие примеры конфигураций для ключа `user-data`:

* [Создание группы виртуальных машин с подключением к файловому хранилищу](../instance-groups/create-with-filesystem.md)
* [Создание группы виртуальных машин с подключением к {{ objstorage-full-name }}](../instance-groups/create-with-bucket.md)
* [Восстановление работоспособности сетевых интерфейсов ВМ](../../qa/troubleshooting.md#unable-to-connect-to-new-multi-interface-vm)
* [{#T}](../../../tutorials/archive/vm-with-backup-policy/index.md)
* [Установка агента для сбора метрик и логов {{ unified-agent-short-name }}](../../../monitoring/concepts/data-collection/unified-agent/installation.md#setup)
