# Создать прерываемую виртуальную машину

Чтобы создать прерываемую виртуальную машину:

---

**[!TAB Консоль управления]**

1. Откройте каталог, в котором будет создана виртуальная машина.
1. Нажмите кнопку **Создать ресурс**.
1. Выберите **Виртуальная машина**.
1. В поле **Имя** введите имя виртуальной машины.

    [!INCLUDE [name-format](../../../_includes/name-format.md)]

    [!INCLUDE [name-fqdn](../../../_includes/compute/name-fqdn.md)]

1. Выберите [зону доступности](../../../overview/concepts/geo-scope.md), в которой будет находиться виртуальная машина.
1. Выберите один из публичных [образов](../../operations/images-with-pre-installed-software/get-list.md) на базе операционной системы Linux.
1. В блоке **Вычислительные ресурсы**:
    - Выберите [платформу](../../concepts/vm-platforms.md).
    - Укажите необходимое количество vCPU и объем RAM.
    - Установите флажок **Прерываемая**.
1. В блоке **Сетевые настройки** нажмите кнопку **Добавить сеть**.
1. В открывшемся окне выберите, к какой подсети необходимо подключить виртуальную машину при создании.
1. В поле **Публичный адрес** выберите:
    - **Автоматически** — чтобы назначить публичный IP-адрес автоматически. Адрес выделяется из пула адресов Яндекс.Облака.
    - **Список** — чтобы выбрать публичный IP-адрес из списка статических адресов. Подробнее читайте в разделе [[!TITLE]](../../../vpc/operations/set-static-ip.md) документации сервиса [!KEYREF vpc-name].
    - **Без адреса** — чтобы не назначать публичный IP-адрес.
1. Укажите данные для доступа на виртуальную машину:
    - В поле **Логин** введите имя пользователя.
    - В поле **SSH ключ** вставьте содержимое файла открытого ключа.
        Пару ключей для подключения по SSH необходимо создать самостоятельно. Подробнее читайте в разделе [[!TITLE]](../vm-control/vm-connect-ssh.md#creating-ssh-keys).
1. Нажмите кнопку **Создать ВМ**.

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
        --name first-preemptible-instance \
        --zone ru-central1-a \
        --network-interface subnet-name=default-a,nat-ip-version=ipv4 \
        --preemptible \
        --create-boot-disk image-folder-id=standard-images,image-family=centos-7 \
        --ssh-key ~/.ssh/id_rsa.pub
    ```

    Данная команда создаст прерываемую виртуальную машину со следующими характеристиками:

    - С именем `first-preemptible-instance`.
    - С OC CentOS 7.
    - В зоне доступности `ru-central1-a`.
    - В подсети `default-a`.
    - С публичным IP.

    Чтобы создать виртуальную машину без публичного IP, исключите опцию `nat-ip-version=ipv4`.

    [!INCLUDE [name-format](../../../_includes/name-format.md)]

    [!INCLUDE [name-fqdn](../../../_includes/compute/name-fqdn.md)]

**[!TAB API]**

Воспользуйтесь методом [Create](../../api-ref/Instance/create.md) для ресурса `Instance`.

---

[!INCLUDE [ip-fqdn-connection](../../../_includes/ip-fqdn-connection.md)]

#### См. также

- [[!TITLE]](../vm-control/vm-connect-ssh.md)
