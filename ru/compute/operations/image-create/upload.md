# Загрузить свой образ диска в Яндекс.Облако

Эта инструкция описывает, как загрузить файл с образом диска в [!KEYREF objstorage-name] и создать из него [образ](../../concepts/images.md) в сервисе [!KEYREF compute-name]. Поддерживаемые форматы образов: Qcow2, VMDK, VHD. На данный момент нельзя загрузить свой образ с операционной системой Windows.

## 1. Загрузите файл образа в [!KEYREF objstorage-name]

Загрузите файл с образом в сервис [!KEYREF objstorage-full-name] и получите ссылку на загруженный образ:

1. Если у вас еще нет бакета в [!KEYREF objstorage-name], [создайте](../../../storage/operations/buckets/create.md) его.
1. [Загрузите образ](../../../storage/operations/objects/upload.md) в ваш бакет. В терминах [!KEYREF objstorage-name] загружаемый файл образа будет называться _объектом_.
1. [Получите ссылку](../../../storage/operations/objects/link-for-download.md) на загруженный образ. Используйте эту ссылку при создании образа в [!KEYREF compute-name].

## 2. Создайте образ в [!KEYREF compute-name]

Создайте новый образ по ссылке, полученной в [!KEYREF objstorage-name]:

---

**[!TAB Консоль управления]**

1. В консоли управления выберите каталог, в котором нужно создать образ.
1. Выберите сервис **[!KEYREF compute-name]**.
1. На странице **Виртуальные машины** перейдите на вкладку **Образы**.
1. Нажмите кнопку **Загрузить образ**.
1. Введите имя образа.

    [!INCLUDE [name-format](../../../_includes/name-format.md)]

1. Если требуется, добавьте произвольное описание образа.
1. Вставьте ссылку на образ, полученную в [!KEYREF objstorage-name].
1. Нажмите кнопку **Загрузить**.

**[!TAB CLI]**

Чтобы создать новый образ по ссылке, воспользуйтесь флагом `--source-uri`.

```
$ yc compute image create --name <IMAGE-NAME> --source-uri <IMAGE-URL>
```

где:

- `<IMAGE-NAME>` — имя, которое будет присвоено образу.
- `<IMAGE-URL>` — ссылка на образ, полученная в [!KEYREF objstorage-name].

Если необходимо, добавьте описание и укажите [семейство](../../concepts/images.md#family), к которому относится этот образ:

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

[!INCLUDE [min-disk-size](../../_includes_service/min-disk-size.md)]

**[!TAB API]**

Чтобы создать новый образ по ссылке, воспользуйтесь методом [Create](../../api-ref/Image/create.md) для ресурса `Image`. Ссылку на образ передайте в элементе `uri`.

---

После создания образ перейдет в статус `CREATING`. Дождитесь, когда образ перейдет в статус `READY`, прежде чем его использовать.

## 3. Удалите образ из [!KEYREF objstorage-name]

Если образ был успешно создан, вы можете [удалить файл образа](../../../storage/operations/objects/delete.md) из сервиса [!KEYREF objstorage-name]. Также можно [удалить бакет](../../../storage/operations/buckets/delete.md), если в нем не осталось объектов.

О стоимости использования [!KEYREF objstorage-name] читайте в разделе [[!TITLE]](../../../storage/pricing.md).
