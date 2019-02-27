# Создать виртуальную машину из набора снимков дисков

Чтобы создать виртуальную машину из набора снимков дисков:

---

**[!TAB CLI]**

[!INCLUDE [cli-install](../../../_includes/cli-install.md)]

[!INCLUDE [default-catalogue](../../../_includes/default-catalogue.md)]

1. Посмотрите описание команды CLI для создания виртуальной машины:

    ```
    $ yc compute instance create --help
    ```

1. Подготовьте снимки нужных дисков, см. раздел [[!TITLE]](../disk-control/create-snapshot.md).
1. Получите список снимков в каталоге по умолчанию:

    [!INCLUDE [compute-snapshot-list](../../_includes_service/compute-snapshot-list.md)]

1. Выберите `ID` или `NAME` нужных снимков.
1. Создайте виртуальную машину в каталоге по умолчанию:

    ```
    $ yc compute instance create \
        --name first-instance \
        --zone ru-central1-a \
        --public-ip \
        --create-boot-disk snapshot-name=first-snapshot \
        --create-disk snapshot-name=second-snapshot \
        --ssh-key ~/.ssh/id_rsa.pub
    ```

    Данная команда создаст виртуальную машину именем `first-instance` в зоне `ru-central1-a`, с публичным IP и дисками из снимков. Чтобы создать виртуальную машину без публичного IP, исключите флаг `--public-ip`.

    [!INCLUDE [name-format](../../../_includes/name-format.md)]

    > [!NOTE]
    >
    > Имя вирутуальной машины используется для генерации имени FQDN, которое в последствии нельзя изменить. Если для вас важно имя FQDN, учитывайте это и задавайте нужное имя виртуальной машины при создании. Подробнее про генерацию имени FQDN читайте в разделе [[!TITLE]](../../concepts/network.md#hostname).

**[!TAB API]**

Воспользуйтесь методом [Create](../../api-ref/Instance/create.md) для ресурса `Instance`.

---
