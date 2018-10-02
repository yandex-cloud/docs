# Загрузить свой образ диска в Яндекс.Облако

Эта инструкция описывает, как загрузить файл с образом диска в Яндекс.Облако и создать из него [образ](../../concepts/images.md) в сервисе [!KEYREF compute-name]. На данный момент поддерживаются следующие форматы образов: Qcow2, VMDK, VHD.

>[!NOTE]
>
>Создавать образы из внешних источников разрешено по ссылкам на публичные корзины в [!KEYREF objstorage-name].

## 1. Загрузите файл образа в Яндекс.Облако

Загрузите файл с образом в сервис [!KEYREF objstorage-full-name] и получите ссылку на загруженный образ:

1. Если у вас еще нет корзины в [!KEYREF objstorage-name], [создайте](../../../storage/operations/buckets/create.md) ее.
2. [Сделайте корзину публичной](../../../storage/operations/security/bucket-availability.md). На данный момент образы можно создавать образы только из публичных корзин.
3. [Загрузите образ](../../../storage/operations/objects/upload.md) в вашу корзину. В терминах [!KEYREF objstorage-name] загружаемый файл образа будет называться _объектом_.
4. [Получите ссылку](../../../storage/operations/objects/link-for-download.md) на загруженный образ. Используйте эту ссылку при создании образа в [!KEYREF compute-name].

## 2. Создайте образ в [!KEYREF compute-name]

Создайте новый образ по ссылке, полученной в [!KEYREF objstorage-name]:

---

**[!TAB Консоль управления]**

1. В консоли управления выберите каталог, в котором нужно создать образ.
2. Нажмите плитку **Yandex Compute Cloud**.
3. На странице **Виртуальные машины** перейдите на вкладку **Образы**.
4. Нажмите кнопку **Загрузить образ**.
5. Введите имя образа.

    [!INCLUDE [name-format](../../../_includes/name-format.md)]
6. Если требуется, добавьте произвольное описание образа.
7. Вставьте ссылку на образ, полученную в [!KEYREF objstorage-name].
8. Нажмите кнопку **Загрузить**.

**[!TAB CLI]**

Чтобы создать новый образ по ссылке, воспользуйтесь флагом `--source-uri`.

```
yc compute image create --name <IMAGE-NAME> --source-uri <IMAGE-URL>
```

где:

* `<IMAGE-NAME>` — имя, которое будет присвоено образу.
* `<IMAGE-URL>` — ссылка на образ, полученная в [!KEYREF objstorage-name].

Если необходимо, добавьте описание и укажите [семейство](../../concepts/images.md#family), к которому относится этот образ:

```
yc compute image create  \
    --name ubuntu-cosmic \
    --description "Ubuntu Server 18.10 (Cosmic Cuttlefish)" \
    --family ubuntu \
    --source-uri "https://storage.yandexcloud.net/mybucket/cosmic-server-cloudimg-amd64.vmdk"
```

Если вы знаете минимальные требования к размеру диска, который будет создан из этого образа, укажите размер в гигабайтах:

```
yc compute image create  \
    --name big-image \
    --min-disk-size 20 \
    --source-uri "https://storage.yandexcloud.net/mybucket/cosmic-server-cloudimg-amd64.vmdk"
```

**[!TAB API]**

Чтобы создать новый образ по ссылке, воспользуйтесь методом `Create` для ресурса `Image`. Ссылку на образ передайте в элементе `uri`.

---

После создания образ перейдет в статус `CREATING`. Дождитесь, когда образ перейдет в статус `READY`, прежде чем использовать его.


## 3. Удалите образ из [!KEYREF objstorage-name]

Если образ был создан успешно, вы можете [удалить файл образа](../../../storage/operations/objects/delete.md) из сервиса [!KEYREF objstorage-name]. Вы также можете [удалить корзину](../../../storage/operations/buckets/delete.md), если в ней не осталось объектов.

О стоимости использования [!KEYREF objstorage-name] читайте в разделе [[!TITLE]](../../../storage/pricing.md).