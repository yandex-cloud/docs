# Создать виртуальную машину из публичного образа Linux

В этом разделе приведена инструкция для создания виртуальной машины с операционной системой Linux. Для создания виртуальной машины на базе Windows воспользуйтесь инструкцией [[!TITLE]](create-windows-vm.md).

---

**[!TAB Консоль управления]**

Чтобы создать виртуальную машину:

[!INCLUDE [create-instance-via-concole-linux](../../_includes_service/create-instance-via-concole-linux.md)]

**[!TAB CLI]**

[!INCLUDE [default-catalogue](../../../_includes/default-catalogue.md)]

Чтобы создать виртуальную машину:

1. Посмотрите описание команды CLI для создания виртуальной машины:

    ```
    $ yc compute instance create --help
    ```

2. Подготовьте пару ключей (открытый и закрытый) для SSH-доступа на виртуальную машину.
3. Выберите один из публичных [образов](../images-with-pre-installed-software/get-list.md) на базе операционной системы Linux (например, CentOS 7).

    [!INCLUDE [standard-images](../../../_includes/standard-images.md)]

4.  Создайте виртуальную машину в каталоге по умолчанию:

    ```
    $ yc compute instance create \
        --name first-instance \
        --zone ru-central1-a \
        --public-ip \
        --create-boot-disk image-folder-id=standard-images,image-name=centos-7-1537787644 \
        --ssh-key ~/.ssh/id_rsa.pub
    ```

    Данная команда создаст виртуальную машину с OC CentOS 7, именем `first-instance` в зоне `ru-central1-a` и с публичным IP. Чтобы создать виртуальную машину без публичного IP, исключите флаг `--public-ip`.

    [!INCLUDE [name-format](../../../_includes/name-format.md)]

---

[!INCLUDE [ip-fqdn-connection](../../../_includes/ip-fqdn-connection.md)]

#### См. также
- [[!TITLE]](../vm-control/vm-connect-ssh.md)
