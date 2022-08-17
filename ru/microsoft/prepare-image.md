# Подготовка собственных образов с продуктами Microsoft

Вы можете подготовить свои образы продуктов Microsoft, чтобы использовать их в {{ yandex-cloud }} с [вашей собственной лицензией](byol.md). Обязательно свяжитесь с Microsoft и уточните, что ваша лицензия подходит для использования в облачных средах. Рекомендуем собирать образы на ОС Linux.

## Подготовка образа {#prepare}

Чтобы создать образ, готовый к использованию в {{ yandex-cloud }}:

1. [Установите QEMU](https://www.qemu.org/download/).
1. [Установите Packer](https://cloud.yandex.ru/docs/tutorials/infrastructure-management/packer-quickstart#install-packer).
1. Загрузите архив с [конфигурациями для Packer](https://storage.yandexcloud.net/packer-recipies/windows-packer.zip) и распакуйте его в нужную папку, например `windows-packer`.
1. Склонируйте [репозиторий](https://github.com/virtio-win/kvm-guest-drivers-windows) с драйверами. Переместите папки `NetKVM`, `vioserial` и `viostor` в папку `windows-packer/drivers`.
1. Выберите подходящую для вашего продукта Microsoft конфигурацию и внесите следующие изменения в ее конфигурационный файл:
   1. Укажите в параметре `iso_url` путь к вашему дистрибутиву. 
   1. Узнайте контрольную сумму вашего дистрибутива (например, выполните `openssl dgst -sha256 <путь к дистрибутиву>`). Вставьте полученное значение в параметр `iso_checksum` после `sha256:`.
   1. (опционально) Если вы работаете на MacOS, вам потребуется заменить значение `accelerator  = "kvm"` на `accelerator  = "hvf"`.
1. Перейдите в каталог с нужной конфигурацией образа (например, `external-windows-packer/ws22gui-qemu`) и выполните команду `packer build .`. 

После выполнения команды будет создан дисковый образ в формате `.qcow2`.

## Загрузите образ в {{ objstorage-name }} {#upload-to-storage}

Загрузите созданный образ в {{ objstorage-name }} с помощью одного из [поддерживаемых инструментов](../storage/tools).

## Импортируйте образ в {{ compute-name }} {#import-to-compute-cloud}

С помощью [API {{ compute-name }}](../compute/api-ref/Image/create.md) вы можете импортировать образ в сервис:

```
curl -H "Authorization: Bearer `yc iam create-token`" -H  "accept: application/json" -X POST https://compute.api.cloud.yandex.net/compute/v1/images -d '{"folderId": "<id вашего каталога>", "name": "<название образа>", "description": "<описание образа>", "os": {"type": "WINDOWS"}, "pooled": false, "uri": "<ссылка на образ в Object Storage>"}'
```

Импортированный образ можно использовать при создании загрузочного диска ВМ.
