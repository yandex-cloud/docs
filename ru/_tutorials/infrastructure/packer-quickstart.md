# Начало работы с Packer

Packer позволяет создавать [образы дисков виртуальных машин](../../compute/concepts/image.md) с заданными в конфигурационном файле параметрами. Сценарий описывает создание образа диска с помощью Packer.

Packer создаст и запустит виртуальную машину с ОС [Debian 11](/marketplace/products/yc/debian-11) из {{ marketplace-name }}, на которую будет установлен веб-сервер nginx. Затем ВМ будет удалена и будет создан образ ее загрузочного диска. После этого диск тоже будет удален.

Чтобы создать образ:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Установите Packer](#install-packer).
1. [Подготовьте конфигурацию образа](#prepare-image-config).
1. [Создайте образ](#create-image).
1. [Проверьте образ](#check-image).

Если созданный образ больше не нужен, [удалите его](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

* Установите [интерфейс командной строки](../../cli/quickstart.md#install) {{ yandex-cloud }}.
* [Создайте](../../vpc/quickstart.md) в вашем каталоге облачную сеть с одной подсетью.
* Получите [OAuth-токен]({{ link-cloud-oauth }}) для [аккаунта на Яндексе](../../iam/concepts/#passport) или [IAM-токен](../../iam/operations/iam-token/create-for-federation.md) для [федеративного аккаунта](../../iam/concepts/federations.md).


### Необходимые платные ресурсы {#paid-resources}

В стоимость создания образа диска с помощью Packer входит:
* плата за хранение созданных образов (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md#prices-storage));
* плата за вычислительные ресурсы ВМ (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md#prices-instance-resources)).


## Установите Packer {#install-packer}

{% note info %}

Для работы с {{ yandex-cloud }} требуется Packer версии не ниже 1.5.

{% endnote %}

Скачайте дистрибутив Packer и установите его по [инструкции на официальном сайте](https://www.packer.io/intro/getting-started/install.html#precompiled-binaries).

Также вы можете скачать дистрибутив Packer для вашей платформы из [зеркала](https://hashicorp-releases.yandexcloud.net/packer/). После загрузки добавьте путь к папке, в которой находится исполняемый файл, в переменную `PATH`: 

```bash
export PATH=$PATH:/path/to/packer
```

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

1. Подготовьте идентификатор каталога, выполнив команду `yc config list`.
1. Подготовьте идентификатор подсети, выполнив команду `yc vpc subnet list`. 
1. Создайте JSON-файл с любым именем, например, `image.json`. Запишите туда следующую конфигурацию:


```json
{
  "builders": [
    {
      "type":      "yandex",
      "token":     "<OAuth-токен_или_IAM-токен>",
      "folder_id": "<идентификатор_каталога>",
      "zone":      "{{ region-id }}-a",

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
  * `token` — OAuth-токен для аккаунта на Яндексе или IAM-токен для федеративного аккаунта.
  * `folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id), в котором будет создана ВМ и ее образ.
  * `subnet_id` — идентификатор подсети, в которой будет создана ВМ и ее образ.

{% include [warning-provisioner-metadata](../../_includes/tutorials/infrastructure-management/warning-provisioner-metadata.md) %}

Подробнее о параметрах конфигурации образа см. в [документации Yandex Compute Builder](https://www.packer.io/docs/builders/yandex).




## Создайте образ {#create-image}

Запустите сборку образа с указанными в конфигурации параметрами:

```
packer build image.json
```

## Проверьте созданный образ {#check-image}

Убедитесь, что образ создан:

1. Перейдите в [консоль управления]({{ link-console-main }}).
1. Выберите сервис **{{ compute-short-name }}**.
1. Откройте раздел **Образы**. Убедитесь, что там появился новый образ диска.

### Удалите созданные ресурсы {#clear-out}

Если созданный образ вам больше не нужен, [удалите его](../../compute/operations/image-control/delete.md).

Удалите [подсеть](../../vpc/operations/subnet-delete.md) и [облачную сеть](../../vpc/operations/network-delete.md), если вы их создавали специально для выполнения сценария.
