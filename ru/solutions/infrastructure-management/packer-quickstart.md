# Начало работы с Packer

Packer позволяет создавать [образы дисков виртуальных машин](../../compute/concepts/image.md) с заданными в конфигурационном файле параметрами. Сценарий описывает создание образа диска с помощью Packer. 

Packer создаст и запустит виртуальную машину с ОС Debian 9, на которую будет установлен веб-сервер nginx. Затем ВМ будет удалена и будет создан образ ее загрузочного диска. После этого диск тоже будет удален.

Чтобы создать образ:

1. [Установите Packer](#install-packer)
1. [Подготовьте конфигурацию образа](#prepare-image-config)
1. [Создайте образ](#create-image)
1. [Проверьте образ](#check-image)

## Подготовка к работе {#prepare}

1. Установите [интерфейс командной строки](../../cli/quickstart.md#install) Яндекс.Облака.
1. [Создайте](../../vpc/quickstart.md) в вашем каталоге облачную сеть с одной подсетью.
1. [Получите](../../iam/concepts/authorization/oauth-token.md) OAuth-токен.

## 1. Установите Packer {#install-packer}

> [!NOTE]
>
> Для работы с Яндекс.Облаком требуется Packer версии не ниже 1.4.1.
>

Скачайте дистрибутив Packer и установите его по [инструкции на официальном сайте](https://www.packer.io/intro/getting-started/install.html#precompiled-binaries).

## 2. Подготовьте конфигурацию образа {#prepare-image-config}

1. Подготовьте идентификатор каталога, выполнив команду `yc config list`.
1. Подготовьте идентификатор подсети, выполнив команду `vpc subnet list`.
1. Создайте JSON-файл с любым именем, например, `image.json`. Запишите туда следующую конфигурацию:

```json
{
  "builders": [
    {
      "type":      "yandex",
      "token":     "<OAuth-токен>",
      "folder_id": "<идентификатор каталога>",
      "zone":      "ru-central1-a",

      "image_name":        "debian-9-nginx-{{isotime | clean_image_name}}",
      "image_family":      "debian-web-server",
      "image_description": "my custom debian with nginx",

      "source_image_family": "debian-9",
      "subnet_id":           "<идентификатор подсети>",
      "use_ipv4_nat":        true,
      "disk_type":           "network-nvme",
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

## 3. Создайте образ {#create-image}

Запустите сборку образа с указанными в конфигурации параметрами:

```
$ packer build image.json
```

## 4. Проверьте созданный образ {#check-image}

Убедитесь, что образ создан:

1. Перейдите в [консоль управления](https://console.cloud.yandex.ru/).
1. Откройте сервис **Compute Cloud**.
1. Откройте раздел **Образы**. Убедитесь, что там появился новый образ диска.
