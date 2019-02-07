# Создать группу виртуальных машин фиксированного размера с балансировщиком

Вы можете создать группу виртуальных машин фиксированного размера совместно с сетевым балансировщиком, который будет равномерно распределять нагрузку по облачным ресурсам. Подробнее читайте в разделе [[!TITLE]](../../load-balancer/concepts/index.md) документации сервиса [!KEYREF load-balancer-full-name].

[!INCLUDE [warning.md](../../_includes/instance-groups/warning.md)]

Чтобы создать группу виртуальных машин с балансировщиком нагрузки:

---

**[!TAB Консоль управления]**

1. В консоли управления выберите каталог, в котором нужно создать группу виртуальных машин.
1. Выберите сервис **[!KEYREF compute-full-name]**..
1. На странице **Виртуальные машины** перейдите на вкладку **Группы виртуальных машин**.
1. Нажмите кнопку **Создать группу**.
1. В блоке **Базовые параметры** введите:
    - Имя группы в поле **Имя**. Имя группы должно быть уникальным в Облаке.

        [!INCLUDE [name-format](../../_includes/name-format.md)]

    - Описание группы в поле **Описание**.
1. В блоке **Распределение** выберите зоны доступности. Виртуальные машины кластера могут находиться в разных зонах и регионах доступности. [Подробнее о географии Облака](../../overview/concepts/geo-scope.md).
1. В блоке **Шаблон виртуальной машины** нажмите кнопку **Добавить**:
    - Выберите нужный публичный [образ](../../compute/operations/images-with-pre-installed-software/get-list.md).
    - В блоке **Диски**:
        - Выберите [тип диска](../../compute/concepts/disk.md#concept_z5t_rtr_52b) (HDD или NVME).
        - Укажите размер диска.

            Чтобы добавить дополнительные диски, нажмите **Добавить диск**.
    - В блоке **Вычислительные ресурсы**:
        - Выберите [тип использования ядра](../../compute/concepts/vm-types.md) (частичное или полное).
        - Укажите необходимое количество vCPU и объем RAM.
    - В блоке **Сетевые настройки**:
        - Выберите [облачную сеть](../../compute/concepts/vm.md#network).
        - Отметьте необходимость в публичном IP-адресе.
    - В блоке **Доступ** укажите данные для доступа на виртуальную машину:
        - В поле **Логин** введите имя пользователя.
        - В поле **SSH ключ** вставьте содержимое файла открытого ключа.

            Пару ключей для подключения по SSH необходимо создать самостоятельно. Для создания ключей используйте сторонние инструменты, например утилиты `ssh-keygen` в Linux и macOS или [PuTTygen](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html) в Windows.
    - Нажмите кнопку **Добавить**.
1. В блоке **Развертывание** укажите:
    - Расширение размера группы.
    - Уменьшение размера группы.
    - Максимальное количество виртуальных машин при создании группы.
    - Максимальное количество виртуальных машин при удалении группы.

        Подробнее читайте в разделе [[!TITLE]](../../instance-groups/concepts/instance-group-policies.md#deploy-policy).
1. В блоке **Масштабирование**:
    - Выберите [тип группы](../../instance-groups/concepts/instance-group-types.md). В альфа-версии можно создавать только группы с фиксированным типом.
    - Укажите необходимое количество виртуальных машин.
1. В блоке **Интеграция с [!KEYREF load-balancer-name]** передвиньте переключатель вправо напротив поля **Создать целевую группу**.
1. Нажмите кнопку **Создать**.

**[!TAB CLI]**

[!INCLUDE [cli-install.md](../../_includes/cli-install.md)]

[!INCLUDE [default-catalogue.md](../../_includes/default-catalogue.md)]

1. Посмотрите описание команды CLI для создания группы виртуальных машин:

    ```
    $ [!KEYREF yc-compute-ig] create --help
    ```

1. Проверьте, есть ли в каталоге сети:

    ```
    $ yc vpc network list
    ```

    Если ни одной сети в каталоге нет, [создайте нужные сети](../../vpc/operations/subnet-create.md) в сервисе [!KEYREF vpc-short-name].

1. Выберите один из [публичных образов](../../compute/operations/images-with-pre-installed-software/get-list.md) (например, CentOS 7).

    [!INCLUDE [standard-images.md](../../_includes/standard-images.md)]

1. Создайте YAML-файл с произвольным именем, например `template.yaml`.
1. Опишите в созданном файле:

    - Общую информацию о группе:

        ```
        name: first-instance-group-with-balancer
        description: "This instance group was created from yaml config"
        ```

        Ключи:

        Ключ | Значение
        ----- | -----
        `name` | Произвольное имя группы виртуальных машин. Имя должно быть уникальным в рамках каталога. Имя может содержать строчные буквы латинского алфавита, цифры и дефисы. Первый символ должен быть буквой. Последний символ не может быть дефисом. Максимальная длина имени — 63 символа.
        `description` | Произвольное описание группы виртуальных машин.

    - [Шаблон виртуальной машины](../concepts/instance-group-instance-template.md):

        ```
        instance_template:
            platform_id: standard-v1
            resources_spec:
                memory: 4294967296
                cores: 1
            boot_disk_spec:
                mode: READ_WRITE
                disk_spec:
                    image_id: fdvcl0b1no2hjb423igi
                    type_id: network-hdd
                    size: 34359738368
            network_interface_specs:
                - network_id: c64mknqgnd8avp6edhbt
                    primary_v4_address_spec: {}
        ```

        Ключи (в таблице приведены ключи, которые непосредственно определяют параметры ВМ):

        Ключ | Значение
        ----- | -----
        `platform_id` | Идентификатор платформы.
        `memory` | Количество памяти (RAM).
        `cores` | Количество ядер процессора (vCPU).
        `mode` | Режим доступа к диску. </br> - `READ_ONLY` — доступ на чтение. </br>- `READ_WRITE` — доступ на чтение и запись.
        `image_id` | Идентификатор публичного образа с CentOS 7.
        `type_id` | Тип диска.
        `size` | Размер диска.
        `network_id` | Идентификатор сети `default-net`.
        `primary_v4_address_spec` | Спецификация версии интернет протокола IPv4. На данный момент доступен только протокол IPv4. Вы можете предоставить публичный доступ к виртуальным машинам группы, указав версию IP для публичного IP-адреса. Подробнее читайте в разделе [[!TITLE]](../concepts/instance-group-instance-template.md#instance-template).

    - [Политики](../concepts/instance-group-policies.md):

        ```
        deploy_policy:
            max_unavailable: 1
            max_expansion: 0
        scale_policy:
            fixed_scale:
                size: 3
        allocation_policy:
            zones:
                - zone_id: ru-central1-a
        ```

        Ключи:

        Ключ | Значение
        ----- | -----
        `deploy_policy` | Политика развертывания виртуальных машин в группе.
        `scale_policy` | Политика масштабирования виртуальных машин в группе.
        `allocation_policy` | Политика распределения виртуальных машин по зонам и регионам.

    - Целевую группу [!KEYREF load-balancer-name]:

        ```
        load_balancer_spec:
            target_group_spec:
                name: first-target-group
        ```

        Ключи:

        Ключ | Значение
        ----- | -----
        `target_group_spec` | Спецификация целевой группы [!KEYREF load-balancer-name], связанной с группой виртуальных машин.
        `name` | Произвольное имя целевой группы [!KEYREF load-balancer-name]. Имя должно быть уникальным в рамках каталога. Имя может содержать строчные буквы латинского алфавита, цифры и дефисы. Первый символ должен быть буквой. Последний символ не может быть дефисом. Максимальная длина имени — 63 символа.

        Полный код файла `template.yaml`:

        ```
        name: first-instance-group-with-balancer
        description: "This instance group was created from yaml config"
        instance_template:
            platform_id: standard-v1
            resources_spec:
                memory: 4294967296
                cores: 1
            boot_disk_spec:
                mode: READ_WRITE
                disk_spec:
                    image_id: fdvcl0b1no2hjb423igi
                    type_id: network-hdd
                    size: 34359738368
            network_interface_specs:
                - network_id: c64mknqgnd8avp6edhbt
                    primary_v4_address_spec: {}
        deploy_policy:
            max_unavailable: 1
            max_expansion: 0
        scale_policy:
            fixed_scale:
                size: 3
        allocation_policy:
            zones:
                - zone_id: ru-central1-a
        load_balancer_spec:
            target_group_spec:
                name: first-target-group
        ```

1. Создайте группу виртуальных машин в каталоге по умолчанию:

    ```
    $ [!KEYREF yc-compute-ig] create --file template.yaml
    ```

    Данная команда создаст группу из трех однотипных виртуальных машин со следующими характеристиками:

    - С именем `first-instance-group-with-balancer`.
    - С OC CentOS 7.
    - В сети `default-net`.
    - В зоне доступности `ru-central1-a`.
    - С одним ядром и RAM 4 ГБ.
    - С сетевым HDD-диском объемом 32 ГБ.
    - С целевой группой `first-target-group`.

1. Создайте [балансировщик](../../load-balancer/operations/load-balancer-create.md) и добавьте к нему целевую группу `first-target-group`.

**[!TAB API]**

Воспользуйтесь методом API [create](../../instance-groups/api-ref/InstanceGroup/create.md).

---
