# Начало работы с Packer

Packer позволяет создавать [образы дисков виртуальных машин](../../compute/concepts/image.md) с заданными в конфигурационном файле параметрами. Сценарий описывает создание образа диска с помощью Packer.

Packer создаст и запустит виртуальную машину с ОС [Debian 9](/marketplace/products/yc/debian-9) из {{ marketplace-name }}, на которую будет установлен веб-сервер nginx. Затем ВМ будет удалена и будет создан образ ее загрузочного диска. После этого диск тоже будет удален.

Чтобы создать образ:

1. [Установите Packer](#install-packer).
1. [Подготовьте конфигурацию образа](#prepare-image-config).
1. [Создайте образ](#create-image).
1. [Проверьте образ](#check-image).

Если созданный образ больше не нужен, [удалите его](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

* Установите [интерфейс командной строки](../../cli/quickstart.md#install) {{ yandex-cloud }}.
* [Создайте](../../vpc/quickstart.md) в вашем каталоге облачную сеть с одной подсетью.
{% if product == "yandex-cloud" %}
* [Получите](../../iam/concepts/authorization/oauth-token.md) OAuth-токен.
{% endif %}
{% if product == "cloud-il" %}
* [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт и [получите](../../iam/operations/sa/create-access-key.md) статический ключ для него.
{% endif %}

{% if product == "yandex-cloud" %}

### Необходимые платные ресурсы {#paid-resources}

Оплачивается хранение созданных образов (см. [тарифы {{ compute-full-name }}](../../compute/pricing#prices-storage)).

{% endif %}

## Установите Packer {#install-packer}

{% note info %}

Для работы с {{ yandex-cloud }} требуется Packer версии не ниже 1.5.

{% endnote %}

Скачайте дистрибутив Packer и установите его по [инструкции на официальном сайте](https://www.packer.io/intro/getting-started/install.html#precompiled-binaries).

Также вы можете скачать дистрибутив Packer для вашей платформы из [зеркала](https://hashicorp-releases.yandexcloud.net/packer/). После загрузки добавьте путь к папке, в которой находится исполняемый файл, в переменную `PATH`: 

```
export PATH=$PATH:/path/to/packer
```

## Подготовьте конфигурацию образа {#prepare-image-config}

1. Подготовьте идентификатор каталога, выполнив команду `yc config list`.
1. Подготовьте идентификатор подсети, выполнив команду `yc vpc subnet list`. 
1. Создайте JSON-файл с любым именем, например, `image.json`. Запишите туда следующую конфигурацию:

{% if product == "yandex-cloud" %}

```json
{
  "builders": [
    {
      "type":      "yandex",
      "token":     "<OAuth-токен>",
      "folder_id": "<идентификатор каталога>",
      "zone":      "{{ region-id }}-a",

      "image_name":        "debian-11-nginx-not_var{{isotime | clean_resource_name}}",
      "image_family":      "debian-web-server",
      "image_description": "my custom debian with nginx",

      "source_image_family": "debian-11",
      "subnet_id":           "<идентификатор подсети>",
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

{% endif %}

{% if product == "cloud-il" %}

```json
{
  "builders": [
    {
      "type":                     "yandex",
      "endpoint":                 "{{ api-host }}:443",
      "service_account_key_file": "<путь к файлу со статическим ключом сервисного аккаунта>",
      "folder_id":                "<идентификатор каталога>",
      "zone":                     "{{ region-id }}-a",

      "image_name":        "debian-11-nginx-not_var{{isotime | clean_resource_name}}",
      "image_family":      "debian-web-server",
      "image_description": "my custom debian with nginx",

      "source_image_family": "debian-11",
      "subnet_id":           "<идентификатор подсети>",
      "platform_id":         "standard-v3",
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

{% endif %}


## Создайте образ {#create-image}

Запустите сборку образа с указанными в конфигурации параметрами:

```
packer build image.json
```

## Проверьте созданный образ {#check-image}

Убедитесь, что образ создан:

1. Перейдите в [консоль управления]({{ link-console-main }}).
1. Откройте сервис **Compute Cloud**.
1. Откройте раздел **Образы**. Убедитесь, что там появился новый образ диска.

### Удалите созданные ресурсы {#clear-out}

Если созданный образ вам больше не нужен, [удалите его](../../compute/operations/image-control/delete.md).

Удалите [подсеть](../../vpc/operations/subnet-delete.md) и [облачную сеть](../../vpc/operations/network-delete.md), если вы их создавали специально для выполнения сценария.
