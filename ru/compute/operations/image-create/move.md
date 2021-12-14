---
title: Перенос виртуальных машин Linux 
description: Эта инструкция описывает перенос работающей виртуальной машины с ОС Linux в сервисе Compute Cloud в другое облако или каталог через хранилище Object Storage.
keywords:
  - перенос виртуальной машины
  - загрузка в облако
  - образ диска
  - образ ОС Linux
---

# Загрузить свой образ диска в {{ yandex-cloud }}

Эта инструкция описывает, как перенести виртуальную машину с ОС Linux в другое [облако](../../../resource-manager/concepts/resources-hierarchy.md#cloud) или [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder). 

## Подготовьте ВМ к переносу дисков {#prepare-vm}

На время операций переноса рекомендуется остановить все операции, связанные с изменением данных: сервисы приложения, баз данных.

[Подключите](../../../compute/operations/vm-control/vm-attach-disk.md) к ВМ, которую нужно перенести, дополнительный диск с размером, равным суммарному размеру всех клонируемых дисков, и запасом в несколько процентов. Например, если к ВМ подключен один диск размером 20 ГБ, то дополнительный диск должен быть чуть больше — 22 ГБ.

## Сделайте образ дисков {#create-image}

Выведите список дисков и определите (по размеру) подключенный ранее диск:
   ```
#lsblk
NAME   MAJ:MIN RM SIZE RO TYPE MOUNTPOINT
vda    252:0    0  20G  0 disk
├─vda1 252:1    0   1M  0 part
└─vda2 252:2    0  20G  0 part /
vdb    252:16   0  22G  0 disk
   ```
   
 Создайте файловую систему на подключенном диске (в примере это диск /dev/vdb):
 
 ```sh
 sudo gdisk /dev/vdb
 o (y)
 n (4 раза enter)
 w (y)
 
 sudo mkfs.ext4 /dev/vdb1
 ```
 
Создайте папку для монтирования и примонтируйте к ней созданный ранее раздел:
 
 ```sh
sudo mkdir /mnt/backup
sudo mount /dev/vdb1 /mnt/backup/
```
 
Далее скопируем образ диска в эту папку:
```sh
dd if=/dev/vda bs=4M conv=sparse status=progress > /mnt/backup/vm.iso
```

Чтобы сократить размер образа за счёт исключения из него пустого места, его можно передать сразу в формате Qcow2, но потребуется дополнительное место на подключённом ранее диске для хранения образа в Qcow2:
```sh
qemu-img convert -p -O qcow2 -o cluster_size=2M /mnt/backup/vm.iso /mnt/backup/vm.qcow2
```

## Загрузите файл образа в {{ objstorage-name }} {#upload-image}
Загрузите файл с образом в сервис {{ objstorage-name }} и получите ссылку на загруженный образ:
1. Если у вас еще нет бакета в {{ objstorage-name }}, [создайте](../../../storage/operations/buckets/create.md) его.
1. Загрузите образ в ваш бакет, например, через утилиту [s3cmd](../../../storage/tools/s3cmd.md):

   ```sh
   s3cmd put /mnt/backup/vm.iso s3://your-backet/vm.iso
   ```

1. [Получите ссылку](../../../storage/operations/objects/link-for-download.md) на загруженный образ. Используйте эту ссылку при создании образа в {{ compute-name }}.

## Создайте образ в {{ compute-name }} {#create-image}

Создайте новый образ по ссылке, полученной в {{ objstorage-name }}:

{% list tabs %}

- Консоль управления

  1. В консоли управления выберите каталог, в котором нужно создать образ.
  1. Выберите сервис **{{ compute-name }}**.
  1. На странице **Виртуальные машины** перейдите на вкладку **Образы**.
  1. Нажмите кнопку **Загрузить образ**.
  1. Введите имя образа.

     * Длина — от 2 до 63 символов.
     * Может содержать строчные буквы латинского алфавита, цифры и дефисы.
     * Первый символ — буква. Последний символ — не дефис.

  1. Если требуется, добавьте произвольное описание образа.
  1. Вставьте ссылку на образ, полученную в {{ objstorage-name }}.
  1. Чтобы создать [оптимизированный образ](../../../compute/concepts/image.md#images-optimized-for-deployment), включите опцию **Оптимизировать для развертывания**.
  1. Нажмите кнопку **Загрузить**.

- CLI

  Чтобы создать новый образ по ссылке, воспользуйтесь флагом `--source-uri`. Для создания [оптимизированного образа](../../../compute/concepts/image.md#images-optimized-for-deployment) используйте флаг `--pooled`.

  ```bash
  yc compute image create --name <image-name> --source-uri <image-URL> --pooled
  ```

  Где:
  * `<image-name>` — имя, которое будет присвоено образу.
  * `<image-URL>` — ссылка на образ, полученная в {{ objstorage-name }}.

  Если необходимо, добавьте описание и укажите [семейство](../../../compute/concepts/image.md#family), к которому относится этот образ:

  ```bash
  yc compute image create \
    --name ubuntu-cosmic \
    --description "Ubuntu Server 18.10 (Cosmic Cuttlefish)" \
    --family ubuntu \
    --source-uri "https://storage.yandexcloud.net/mybucket/cosmic-server-cloudimg-amd64.vmdk"
  ```

  Если вы знаете минимальные требования к размеру диска, который будет создан из этого образа, укажите размер в гигабайтах:

  ```bash
  yc compute image create \
    --name big-image \
    --min-disk-size 20 \
    --source-uri "https://storage.yandexcloud.net/mybucket/cosmic-server-cloudimg-amd64.vmdk"
  ```

  {% include [min-disk-size](../../../compute/_includes_service/min-disk-size.md) %}

- Terraform

  Если у вас еще нет Terraform, [установите его и настройте провайдер {{ yandex-cloud }}](../../../solutions/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы создать образ:

  1. Опишите в конфигурационном файле параметры ресурса `yandex_compute_image`.

     Пример структуры конфигурационного файла:

     ```
     resource "yandex_compute_image" "image-1" {
       name       = "ubuntu-cosmic"
       os_type    = "LINUX"
       source_url = "<ссылка на образ в {{ objstorage-name }}>"
       pooled     = "false"
     }
     ```

     Более подробную информацию о ресурсах, которые вы можете создать с помощью Terraform, см. в [документации провайдера](https://www.terraform.io/docs/providers/yandex/index.html).

  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```bash
        terraform plan
        ```

       Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, Terraform на них укажет.

  1. Разверните облачные ресурсы.

     1. Выполните команду:

        ```bash
        terraform apply
        ```

     1. Подтвердите создание ресурсов.

     После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

- API

  Создайте новый образ с помощью метода [ImageService/Create](../../../compute/api-ref/grpc/image_service.md#Create) gRPC API или метода [create](../../../compute/api-ref/Image/create.md) ресурса `Image` REST API. В запросе укажите ссылку на образ.

{% endlist %}

После создания образ перейдет в статус `CREATING`. Дождитесь, когда образ перейдет в статус `READY`, прежде чем его использовать.

## Удалите образ из {{ objstorage-name }} {#delete-image}

Если образ был успешно создан, вы можете [удалить файл образа](../../../storage/operations/objects/delete.md) из сервиса {{ objstorage-name }}. Также можно [удалить бакет](../../../storage/operations/buckets/delete.md), если в нем не осталось объектов.

## Создайте виртуальную машину из подготовленного образа {#create-vm-from-user-image}

{% include notitle [Как создать ВМ из своего образа](../../../compute/operations/vm-create/create-from-user-image.md#create-vm-from-image) %}

О стоимости использования {{ objstorage-name }} читайте в разделе [{#T}](../../../storage/pricing.md).

## Удалите вспомогательный диск {#delete-temp-disk}
После успешного переноса отключите новый диск внутри ОС в исходной ВМ: 
```sh
umount /mnt/backup
```

А также [отключите](../../../compute/operations/vm-control/vm-detach-disk.md) его от ВМ и [удалите](../../../compute/operations/disk-control/delete.md) из списка дисков в консоли.
