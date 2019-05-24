# Создать виртуальную машину из набора дисков

Создать виртуальную машину можно из существующих дисков. Диски должны находиться в одной из зон доступности и не быть добавленными к другим виртуальным машинам.

[!INCLUDE [disk-auto-delete](../../_includes_service/disk-auto-delete.md)]

Чтобы создать виртуальную машину из набора дисков:

---

**[!TAB Консоль управления]**

1. В консоли управления выберите каталог, в котором нужно создать виртуальную машину.
1. Выберите сервис **[!KEYREF compute-name]**.
1. На странице **Виртуальные машины** нажмите кнопку **Создать ВМ**.
1. В блоке **Базовые параметры** введите имя и описание группы.

    [!INCLUDE [name-format](../../../_includes/name-format.md)]

    [!INCLUDE [name-fqdn](../../../_includes/compute/name-fqdn.md)]

1. В блоке **Зона доступности** выберите нужную зону доступности. [Подробнее о географии Облака](../../../overview/concepts/geo-scope.md).
1. Выберите один из публичных [образов](../../operations/images-with-pre-installed-software/get-list.md).
1. В блоке **Диски** нажмите **Добавить диск**:
    - Введите имя диска.
    - Укажите нужный размер диска.
    - Выберите [тип диска](../../concepts/disk.md#disks_types).
    - В поле **Наполнение** выберите **Диск**. Если диска нет, [создайте](../disk-create/empty.md) его.
1. В блоке **Вычислительные ресурсы**:
    - Выберите [платформу](../../concepts/vm-platforms.md).
    - Укажите [гарантированную долю](../../concepts/performance-levels.md) и необходимое количество vCPU и объем RAM.
1. В блоке **Сетевые настройки** нажмите кнопку **Добавить сеть**:
    - Выберите [облачную сеть](../../concepts/vm.md#network) и подсеть. Если нужной подсети в списке нет, [создайте ее](../../../vpc/operations/subnet-create.md).
    - Отметьте необходимость в публичном IP-адресе.
1. В блоке **Доступ** укажите данные для доступа на виртуальную машину:
    - В поле **Логин** введите имя пользователя.
    - В поле **SSH-ключ** вставьте содержимое файла открытого ключа. Пару ключей для подключения по SSH необходимо [создать](../vm-control/vm-connect-ssh.md#creating-ssh-keys) самостоятельно.
1. Нажмите кнопку **Создать ВМ**.

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
        --network-interface subnet-name=default-a,nat-ip-version=ipv4 \
        --use-boot-disk disk-name=first-disk \
        --attach-disk disk-name=second-disk \
        --ssh-key ~/.ssh/id_rsa.pub
    ```

    Данная команда создаст виртуальную машину:

    - С именем `first-instance`.
    - В зоне доступности `ru-central1-a`.
    - В подсети `default-a`.
    - С публичным IP и двумя дисками.

    Чтобы создать виртуальную машину без публичного IP, исключите флаг `--public-ip`.

    [!INCLUDE [name-format](../../../_includes/name-format.md)]

    [!INCLUDE [name-fqdn](../../../_includes/compute/name-fqdn.md)]

    Чтобы указать необходимость удаления диска при удалении машины, установите флаг `--auto-delete`:

    ```
    yc compute instance create \
    --name first-instance \
    --zone ru-central1-a \
    --network-interface subnet-name=default-a,nat-ip-version=ipv4 \
    --use-boot-disk disk-name=first-disk,auto-delete=yes \
    --attach-disk disk-name=second-disk,auto-delete=yes \
    --ssh-key ~/.ssh/id_rsa.pub
    ```

**[!TAB API]**

Воспользуйтесь методом [Create](../../api-ref/Instance/create.md) для ресурса `Instance`.

---
