# Создать виртуальную машину из набора дисков

Создать виртуальную машину можно из существующих дисков. Диски должны находиться в одной из зон доступности и не быть добавлены к другим виртуальным машинам.

[!INCLUDE [disk-auto-delete](../../_includes_service/disk-auto-delete.md)]

Чтобы создать виртуальную машину из набора дисков:

---

**[!TAB CLI]**

[!INCLUDE [cli-install](../../../_includes/cli-install.md)]

[!INCLUDE [default-catalogue](../../../_includes/default-catalogue.md)]

1. Посмотрите описание команды CLI для создания виртуальной машины:

    ```
    $ yc compute instance create --help
    ```

1. Получите список дисков в каталоге по умолчанию:

    [!INCLUDE [compute-disk-list](../../_includes_service/compute-disk-list.md)]

1. Выберите `ID` или `NAME` нужных дисков.
1. Создайте виртуальную машину в каталоге по умолчанию:

    ```
    $ yc compute instance create \
        --name first-instance \
        --zone ru-central1-a \
        --public-ip \
        --use-boot-disk disk-name=first-disk \
        --attach-disk disk-name=second-disk \
        --ssh-key ~/.ssh/id_rsa.pub
    ```

    Данная команда создаст виртуальную машину именем `first-instance` в зоне `ru-central1-a`, с публичным IP и двумя дисками. Чтобы создать виртуальную машину без публичного IP, исключите флаг `--public-ip`.

    [!INCLUDE [name-format](../../../_includes/name-format.md)]

    > [!NOTE]
    >
    > Имя виртуальной машины используется для генерации имени FQDN, которое в последствии нельзя изменить. Если для вас важно имя FQDN, учитывайте это и задавайте нужное имя виртуальной машины при создании. Подробнее про генерацию имени FQDN читайте в разделе [[!TITLE]](../../concepts/network.md#hostname).

    Чтобы указать необходимость удаления диска при удалении машины, установите флаг `--auto-delete`:

    ```
    yc compute instance create \
    --name first-instance \
    --zone ru-central1-a \
    --public-ip \
    --use-boot-disk disk-name=first-disk,auto-delete=yes \
    --attach-disk disk-name=second-disk,auto-delete=yes \
    --ssh-key ~/.ssh/id_rsa.pub
    ```

**[!TAB API]**

Воспользуйтесь методом [Create](../../api-ref/Instance/create.md) для ресурса `Instance`.

---
