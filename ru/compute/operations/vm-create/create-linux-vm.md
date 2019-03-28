# Создать виртуальную машину из публичного образа Linux

В этом разделе приведена инструкция для создания виртуальной машины с операционной системой Linux. Для создания виртуальной машины на базе Windows воспользуйтесь инструкцией [[!TITLE]](create-windows-vm.md).

Чтобы создать виртуальную машину:

---

**[!TAB Консоль управления]**

[!INCLUDE [create-instance-via-concole-linux](../../_includes_service/create-instance-via-concole-linux.md)]

**[!TAB CLI]**

[!INCLUDE [cli-install](../../../_includes/cli-install.md)]

[!INCLUDE [default-catalogue](../../../_includes/default-catalogue.md)]

1. Посмотрите описание команды CLI для создания виртуальной машины:

    ```
    $ yc compute instance create --help
    ```

1. Подготовьте пару ключей (открытый и закрытый) для SSH-доступа на виртуальную машину.
1. Выберите один из публичных [образов](../images-with-pre-installed-software/get-list.md) на базе операционной системы Linux (например, CentOS 7).

    [!INCLUDE [standard-images](../../../_includes/standard-images.md)]

1.  Создайте виртуальную машину в каталоге по умолчанию:

    ```
    $ yc compute instance create \
        --name first-instance \
        --zone ru-central1-a \
        --network-interface subnet-name=default-a,nat-ip-version=ipv4 \
        --create-boot-disk image-folder-id=standard-images,image-family=centos-7 \
        --ssh-key ~/.ssh/id_rsa.pub
    ```

    Данная команда создаст виртуальную машину со следующими характеристиками:

    - С именем `first-instance`.
    - С OC CentOS 7.
    - В зоне доступности `ru-central1-a`.
    - В подсети `default-a`.
    - С публичным IP.

    На машине будет создан пользователь `yc-user` с публичным ключом из файла `~/.ssh/id_rsa.pub`. Чтобы создать виртуальную машину без публичного IP, исключите опцию `nat-ip-version=ipv4`.

    [!INCLUDE [name-format](../../../_includes/name-format.md)]

    > [!NOTE]
    >
    > Имя виртуальной машины используется для генерации имени FQDN, которое в последствии нельзя изменить. Если для вас важно имя FQDN, учитывайте это и задавайте нужное имя виртуальной машины при создании. Подробнее про генерацию имени FQDN читайте в разделе [[!TITLE]](../../concepts/network.md#hostname).

**[!TAB API]**

Воспользуйтесь методом [Create](../../api-ref/Instance/create.md) для ресурса `Instance`.

---

[!INCLUDE [ip-fqdn-connection](../../../_includes/ip-fqdn-connection.md)]

#### См. также

- [[!TITLE]](../vm-control/vm-connect-ssh.md)
