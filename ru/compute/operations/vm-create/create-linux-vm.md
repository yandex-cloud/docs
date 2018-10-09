# Создать виртуальную машину из публичного образа Linux

В этом разделе приведена инструкция для создания виртуальной машины с операционной системой Linux. Для создания виртуальной машины на базе Windows воспользуйтесь инструкцией [[!TITLE]](create-windows-vm.md).

---

**[!TAB Консоль управления]**

Чтобы создать виртуальную машину:

[!INCLUDE [create-instance-via-concole-linux](../../_includes_service/create-instance-via-concole-linux.md)]

**[!TAB CLI]**

[!INCLUDE [default-catalogue](../../../_includes/default-catalogue.md)]

Чтобы создать виртуальную машину:

1. Посмотрите описание команд CLI для создания виртуальной машины:

    ```
    yc compute instance create --help
    ```

2. Подготовьте пару ключей (открытый и закрытый) для SSH-доступа на виртуальную машину.
3. Выберите один из публичных образов на базе операционной системы Linux. Получить список доступных образов можно с помощью команды:
    
    ```
    yc compute image list --folder-id standard-images
    ```

4.  Создайте виртуальную машину:

    ```
    yc compute instance create \
        --name my-yc-vm \
        --description "my first vm via yc" \
        --zone ru-central1-a \
        --public-ip \
        --create-boot-disk image-folder-id=standard-images,image-name=centos-7-1537787644 \
        --ssh-key ~/.ssh/id_rsa.pub
    ```

    Данная команда создаст виртуальную машину с OC CentOS 7, именем `my-yc-vm` в зоне `ru-central1-a`.

---

При создании виртуальной машине назначаются IP-адрес и имя хоста (FQDN). Эти данные можно использовать для доступа к виртуальной машине по SSH.

#### См. также
- [[!TITLE]](../vm-control/vm-connect-ssh.md)
