# Загрузить свой образ диска в Яндекс.Облако

Эта инструкция описывает, как загрузить файл с образом диска в {{ objstorage-name }} и создать из него [образ](../../concepts/image.md) в сервисе {{ compute-name }}.


## 1. Подготовьте файл с образом {#prepare-file}

Требования к загружаемому файлу с образом диска:

* Поддерживаемые форматы образов: Qcow2, VMDK и VHD.
* ОС на базе Linux.
* Установлены последние обновления ОС.
* Диск смонтирован по UUID, а не по имени.
* Ядро Linux запущено с параметром `console=ttyS0`.
* SSH-сервер запускается автоматически при запуске ВМ.
* Сетевой интерфейс получает IP-адрес по DHCP.

Рекомендации:

* Рекомендуется загружать 64-битные системы с установленным пакетом `cloud-init`, а также драйверами `virtio-net` и `virtio-blk`.
* Образы рекомендуется оптимизировать перед загрузкой с помощью утилиты `qemu-img`, чтобы ускорить импорт:
         
  ```
  qemu-img convert -p -O qcow2 -o cluster_size=2M <имя вашего файла образа> <имя нового файла образа>
  ```

## 2. Загрузите файл образа в {{ objstorage-name }} {#upload-file}

Загрузите файл с образом в сервис {{ objstorage-full-name }} и получите ссылку на загруженный образ:

1. Если у вас еще нет бакета в {{ objstorage-name }}, [создайте](../../../storage/operations/buckets/create.md) его.
1. [Загрузите образ](../../../storage/operations/objects/upload.md) в ваш бакет. В терминах {{ objstorage-name }} загружаемый файл образа будет называться _объектом_.
1. [Получите ссылку](../../../storage/operations/objects/link-for-download.md) на загруженный образ. Используйте эту ссылку при создании образа в {{ compute-name }}.

## 3. Создайте образ в {{ compute-name }} {#create-image}

Создайте новый образ по ссылке, полученной в {{ objstorage-name }}:

{% list tabs %}

- Консоль управления

  1. В консоли управления выберите каталог, в котором нужно создать образ.
  1. Выберите сервис **{{ compute-name }}**.
  1. На странице **Виртуальные машины** перейдите на вкладку **Образы**.
  1. Нажмите кнопку **Загрузить образ**.
  1. Введите имя образа.

      {% include [name-format](../../../_includes/name-format.md) %}

  1. Если требуется, добавьте произвольное описание образа.
  1. Вставьте ссылку на образ, полученную в {{ objstorage-name }}.
  1. Нажмите кнопку **Загрузить**.

- CLI

  Чтобы создать новый образ по ссылке, воспользуйтесь флагом `--source-uri`.

  ```
  $ yc compute image create --name <IMAGE-NAME> --source-uri <IMAGE-URL>
  ```

  где:

  - `<IMAGE-NAME>` — имя, которое будет присвоено образу.
  - `<IMAGE-URL>` — ссылка на образ, полученная в {{ objstorage-name }}.

  Если необходимо, добавьте описание и укажите [семейство](../../concepts/image.md#family), к которому относится этот образ:

  ```
  $ yc compute image create  \
      --name ubuntu-cosmic \
      --description "Ubuntu Server 18.10 (Cosmic Cuttlefish)" \
      --family ubuntu \
      --source-uri "https://storage.yandexcloud.net/mybucket/cosmic-server-cloudimg-amd64.vmdk"
  ```

  Если вы знаете минимальные требования к размеру диска, который будет создан из этого образа, укажите размер в гигабайтах:

  ```
  $ yc compute image create  \
      --name big-image \
      --min-disk-size 20 \
      --source-uri "https://storage.yandexcloud.net/mybucket/cosmic-server-cloudimg-amd64.vmdk"
  ```

  {% include [min-disk-size](../../_includes_service/min-disk-size.md) %}

- API

  Чтобы создать новый образ по ссылке, воспользуйтесь методом [Create](../../api-ref/Image/create.md) для ресурса `Image`. Ссылку на образ передайте в элементе `uri`.

{% endlist %}

После создания образ перейдет в статус `CREATING`. Дождитесь, когда образ перейдет в статус `READY`, прежде чем его использовать.

## 4. Удалите образ из {{ objstorage-name }} {#delete-image}

Если образ был успешно создан, вы можете [удалить файл образа](../../../storage/operations/objects/delete.md) из сервиса {{ objstorage-name }}. Также можно [удалить бакет](../../../storage/operations/buckets/delete.md), если в нем не осталось объектов.

О стоимости использования {{ objstorage-name }} читайте в разделе [{#T}](../../../storage/pricing.md).
