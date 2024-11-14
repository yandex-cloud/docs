# Начало работы с Packer


[Packer](https://www.packer.io/) позволяет создавать [образы дисков виртуальных машин](../../compute/concepts/image.md) с заданными в конфигурационном файле параметрами. Руководство описывает создание образа диска в [{{ compute-full-name }}](../../compute/) с помощью Packer.

Packer создаст и запустит виртуальную машину с ОС [Debian 11](/marketplace/products/yc/debian-11) из {{ marketplace-name }}, на которую будет установлен веб-сервер [nginx](https://nginx.org/ru/). Затем ВМ будет удалена и будет создан образ ее загрузочного диска. После этого диск тоже будет удален.

Чтобы создать образ:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Установите Packer](#install-packer).
1. [Подготовьте конфигурацию образа](#prepare-image-config).
1. [Создайте образ](#create-image).
1. [Проверьте образ](#check-image).

Если созданный образ больше не нужен, [удалите его](#clear-out).


## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Настройте окружение и инфраструктуру {#prepare-environment}

1. Установите [интерфейс командной строки](../../cli/quickstart.md#install) {{ yandex-cloud }} (CLI).

    {% note tip %}

    Если вы работаете с облаком с помощью [федеративного аккаунта](../../iam/concepts/users/accounts.md#saml-federation) и хотите использовать CLI изнутри ВМ, [аутентифицируйтесь в CLI от имени сервисного аккаунта](../../cli/operations/authentication/service-account.md#vm-auth-as-sa).

    {% endnote %}

1. [Создайте](../../vpc/quickstart.md) в вашем каталоге облачную сеть с одной подсетью.
1. Получите [OAuth-токен]({{ link-cloud-oauth }}) для [аккаунта на Яндексе](../../iam/concepts/users/accounts.md#passport) или [IAM-токен](../../iam/operations/iam-token/create-for-federation.md) для [федеративного аккаунта](../../iam/concepts/users/accounts.md#saml-federation).


### Необходимые платные ресурсы {#paid-resources}

В стоимость создания образа диска с помощью Packer входит:

* плата за хранение созданных образов (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md#prices-storage));
* плата за вычислительные ресурсы ВМ (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md#prices-instance-resources)).


## Установите и настройте Packer {#install-packer}

{% note warning %}

Для работы с {{ yandex-cloud }} требуется Packer версии не ниже 1.5.

Избегайте установки Packer с помощью популярных пакетных менеджеров, например Homebrew или APT. В их репозиториях могут быть размещены устаревшие версии.

{% endnote %}

Вы можете установить Packer [из зеркала](#from-y-mirror) или [с сайта HashiCorp](#from-hashicorp-site).


### Из зеркала {#from-y-mirror}

Установите дистрибутив Packer для вашей платформы из [зеркала](https://hashicorp-releases.yandexcloud.net/packer/):

{% list tabs group=operating_system %}

- Linux {#linux}

  1. Скачайте дистрибутив Packer из [зеркала](https://hashicorp-releases.yandexcloud.net/packer/) и распакуйте в директорию `packer`:

      ```bash
      mkdir packer
      wget https://hashicorp-releases.yandexcloud.net/packer/1.11.2/packer_1.11.2_linux_amd64.zip -P ~/packer
      unzip ~/packer/packer_1.11.2_linux_amd64.zip -d ~/packer
      ```

      В примере указана версия `1.11.2`, актуальную версию Packer см. в [зеркале](https://hashicorp-releases.yandexcloud.net/packer/).

  1. Добавьте Packer в переменную `PATH`: 

      1. Добавьте в файл `.profile` строку:

          ```bash
          export PATH="$PATH:/home/<имя_пользователя>/packer"
          ```

      1. Сохраните изменения.

      1. Перезапустите оболочку:

          ```bash
          exec -l $SHELL
          ```

  1. Убедитесь, что Packer установлен:

      ```bash
      packer --version
      ```

      Результат:
      
      ```text
      Packer v1.11.2
      ```


- Windows {#windows}

  1. Создайте папку `packer`.
  1. Скачайте дистрибутив Packer из [зеркала](https://hashicorp-releases.yandexcloud.net/packer/) и распакуйте в папку `packer`.
  1. Добавьте папку `packer` в переменную `PATH`:

      1. Нажмите кнопку **Пуск** и в строке поиска Windows введите **Изменение системных переменных среды**.
      1. Справа снизу нажмите кнопку **Переменные среды...**.
      1. В открывшемся окне найдите параметр `PATH` и нажмите **Изменить**.
      1. Добавьте путь до папки `packer` в список.
      1. Нажмите кнопку **ОК**.

  1. Запустите новую сессию командной строки и убедитесь, что Packer установлен:

      ```bash
      packer --version
      ```

      Результат:

      ```text
      Packer v1.11.2
      ```

- macOS {#macos}

  1. Скачайте дистрибутив Packer из [зеркала](https://hashicorp-releases.yandexcloud.net/packer/) и распакуйте в директорию `packer`:

      ```bash
      mkdir packer
      curl --location --output ~/packer/packer_1.11.2_darwin_amd64.zip https://hashicorp-releases.yandexcloud.net/packer/1.11.2/packer_1.11.2_darwin_amd64.zip
      unzip ~/packer/packer_1.11.2_darwin_amd64.zip -d ~/packer
      ```

      В примере указана версия `1.11.2`, актуальную версию Packer см. в [зеркале](https://hashicorp-releases.yandexcloud.net/packer/).

  1. Добавьте Packer в переменную `PATH`: 

      ```bash
      echo 'export PATH="$PATH:$HOME/<имя_пользователя>/packer"' >> ~/.bash_profile
      source ~/.bash_profile
      ```

  1. Перезапустите оболочку:

      ```bash
      exec -l $SHELL
      ```

  1. Убедитесь, что Packer установлен:

      ```bash
      packer --version
      ```

      Результат:
      
      ```text
      Packer v1.11.2
      ```

{% endlist %}


### С сайта HashiCorp {#from-hashicorp-site}

Скачайте и установите дистрибутив Packer по [инструкции на официальном сайте](https://www.packer.io/intro/getting-started/install.html#precompiled-binaries).


### Настройте плагин Yandex Compute Builder {#configure-plugin}

Чтобы настроить [плагин](https://developer.hashicorp.com/packer/plugins/builders/yandex):

1. Создайте файл `config.pkr.hcl` со следующим содержанием:

    ```hcl
    packer {
      required_plugins {
        yandex = {
          version = ">= 1.1.2"
          source  = "{{ packer-source-link }}"
        }
      }
    }
    ```

1. Установите плагин:

    ```bash
    packer init <путь_к_файлу_config.pkr.hcl>
    ```

    Результат:

    ```text
    Installed plugin github.com/hashicorp/yandex v1.1.2 in ...
    ```

## Подготовьте конфигурацию образа {#prepare-image-config}

1. [Узнайте](../../resource-manager/operations/folder/get-id.md) идентификатор каталога.
1. [Узнайте](../../vpc/operations/subnet-get-info.md) идентификатор подсети и [зону доступности](../../overview/concepts/geo-scope.md), в которой она расположена.
1. Подготовьте идентификатор подсети, выполнив команду `yc vpc subnet list`.
1. Создайте JSON-файл с любым именем, например, `image.json`. Запишите туда следующую конфигурацию:


    ```json
    {
      "builders": [
        {
          "type":      "yandex",
          "token":     "<OAuth-токен_или_IAM-токен>",
          "folder_id": "<идентификатор_каталога>",
          "zone":      "<зона_доступности>",

          "image_name":        "debian-11-nginx-not_var{{isotime | clean_resource_name}}",
          "image_family":      "debian-web-server",
          "image_description": "my custom debian with nginx",

          "source_image_family": "debian-11",
          "subnet_id":           "<идентификатор_подсети>",
          "use_ipv4_nat":        true,
          "disk_type":           "network-ssd",
          "ssh_username":        "debian"
        }
      ],
      "provisioners": [
        {
          "type": "shell",
          "inline": [
            "echo 'updating APT'",
            "sudo apt-get update -y",
            "sudo apt-get install -y nginx",
            "sudo su -",
            "sudo systemctl enable nginx.service",
            "curl localhost"
          ]
        }
      ]
    }
    ```




    Где:
    * `<зона_доступности>` — [зона доступности](../../overview/concepts/geo-scope.md), в которой будет создана ВМ. Например: `{{ region-id }}-d`.
    * `token` — OAuth-токен для аккаунта на Яндексе или IAM-токен для федеративного аккаунта.
    * `folder_id` — идентификатор каталога, в котором будет создана ВМ и ее образ.
    * `subnet_id` — идентификатор подсети, в которой будет создана ВМ и ее образ.

{% include [warning-provisioner-metadata](../../_includes/tutorials/infrastructure-management/warning-provisioner-metadata.md) %}

Подробнее о параметрах конфигурации образа см. в [документации Yandex Compute Builder](https://www.packer.io/docs/builders/yandex).


## Создайте образ {#create-image}

1. Запустите сборку образа с указанными в конфигурации параметрами:

    ```bash
    packer build image.json
    ```

1. Дождитесь завершения сборки:

    ```bash
    ...
    ==> Wait completed after 2 minutes 43 seconds
    ==> Builds finished. The artifacts of successful builds are:
    --> yandex: A disk image was created: debian-11-nginx-2024-08-26t15-30-39z (id: fd82d63b9bgc********) with family name debian-web-server
    ```


## Проверьте созданный образ {#check-image}

Убедитесь, что образ создан:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите в [консоль управления]({{ link-console-main }}).
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. Откройте раздел ![image](../../_assets/console-icons/layers.svg) **{{ ui-key.yacloud.compute.switch_images }}**. Убедитесь, что там появился новый образ диска.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Выполните команду:

  ```bash
  yc compute image list
  ```

  Результат:

  ```text
  +----------------------+--------------------------------------+-------------------+----------------------+--------+
  |          ID          |                 NAME                 |      FAMILY       |     PRODUCT IDS      | STATUS |
  +----------------------+--------------------------------------+-------------------+----------------------+--------+
  | fd82d63b9bgc******** | debian-11-nginx-2024-08-26t15-30-39z | debian-web-server | f2eerqfup7lg******** | READY  |
  +----------------------+--------------------------------------+-------------------+----------------------+--------+
  ```

{% endlist %}


### Удалите созданные ресурсы {#clear-out}

Если созданный образ вам больше не нужен, [удалите его](../../compute/operations/image-control/delete.md).

Удалите [подсеть](../../vpc/operations/subnet-delete.md) и [облачную сеть](../../vpc/operations/network-delete.md), если вы их создавали специально для выполнения руководства.
