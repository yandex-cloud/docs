Чтобы создать виртуальную машину:
1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет создана виртуальная машина.
1. В списке сервисов выберите **{{ compute-name }}**.
1. Нажмите кнопку **Создать ВМ**.
1. В блоке **Базовые параметры**:
    * Введите имя и описание ВМ. Требования к имени:

        {% include [name-format](../../_includes/name-format.md) %}

        {% include [name-fqdn](../../_includes/compute/name-fqdn.md) %}

    * Выберите [зону доступности](../../overview/concepts/geo-scope.md), в которой будет находиться виртуальная машина.

1. В блоке **Выбор образа/загрузочного диска** выберите один из [образов](../operations/images-with-pre-installed-software/get-list.md) и версию операционной системы на базе Windows.

1. (опционально) В блоке **Диски{% if product == "yandex-cloud" %} и файловые хранилища{% endif %}** на вкладке **Диски** настройте загрузочный диск:
    * Выберите [тип диска](../concepts/disk.md#disks_types).
    * Укажите нужный размер диска.

        Если вы хотите создать виртуальную машину из существующего диска, в блоке **Диски{% if product == "yandex-cloud" %} и файловые хранилища{% endif %}** [добавьте диск](../operations/vm-create/create-from-disks.md):
        * Нажмите кнопку **Добавить диск**.
        * Введите имя диска.
        * Выберите [тип диска](../concepts/disk.md#disks_types).
        * Укажите нужный размер блока.
        * Укажите нужный размер диска.
        * (опционально) Включите опцию **Удалять вместе с ВМ**, если нужно автоматически удалять диск при удалении ВМ, к которой он будет подключен.
        * Выберите наполнение `Диск`.
        * Нажмите кнопку **Добавить**.

{% if product == "yandex-cloud" %}
1. (опционально) В блоке **Диски и файловые хранилища** на вкладке **Файловые хранилища** подключите [файловое хранилище](../concepts/filesystem.md):
    * Нажмите кнопку **Подключить файловое хранилище**.
    * В открывшемся окне выберите файловое хранилище.
    * Введите имя устройства.
    * Нажмите кнопку **Подключить файловое хранилище**.
{% endif %}

1. В блоке **Вычислительные ресурсы**:
    * Выберите [платформу](../concepts/vm-platforms.md).
    * Укажите [гарантированную долю](../../compute/concepts/performance-levels.md) и необходимое количество vCPU, а также объем RAM.
    * При необходимости сделайте виртуальную машину [прерываемой](../concepts/preemptible-vm.md).
    * (опционально) Включите [программно-ускоренную сеть](../concepts/software-accelerated-network.md).

1. В блоке **Сетевые настройки**:

    {% include [network-settings](../../_includes/compute/network-settings.md) %}

1. В блоке **Доступ** укажите данные для доступа на виртуальную машину:
    * (опционально) Выберите или создайте [сервисный аккаунт](../../iam/concepts/users/service-accounts.md). Использование сервисного аккаунта позволяет гибко настраивать права доступа к ресурсам.
    * При создании виртуальной машины в операционной системе будет автоматически создан пользователь `Administrator`. В поле **Пароль** задайте пароль для этого пользователя.

        {% note info %}

        Если вы утратили пароль для входа на ВМ, может потребоваться создать новую ВМ с диском из снимка. Подробнее см. в разделе [{#T}](../operations/vm-connect/recovery-access.md).

        {% endnote %}

        {% include [password-requirements](../../_includes/compute/password-requirements.md) %}

    * Если требуется, разрешите доступ к [серийной консоли](../operations/serial-console/index.md).

1. (опционально) В блоке **Размещение** выберите [группу размещения](../concepts/placement-groups.md) ВМ.
1. Нажмите кнопку **Создать ВМ**.

Виртуальная машина появится в списке. При создании виртуальной машине назначаются [IP-адрес](../../vpc/concepts/address.md) и [имя хоста](../../vpc/concepts/address.md#fqdn) (FQDN). Эти данные можно использовать для доступа к виртуальной машине по RDP.