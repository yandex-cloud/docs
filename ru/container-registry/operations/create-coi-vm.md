# Создать ВМ с Container Optimized Image

Создайте виртуальную машину из образа Container Optimized Image и запустите на ней Docker-контейнер.

_Container Optimized Image_ — [образ](../../compute/concepts/image.md) виртуальной машины, оптимизированный для запуска Docker-контейнеров. Образ включает в себя: Ubuntu LTS, Docker и демона для запуска Docker-контейнеров.

Образ интегрирован с платформой Яндекс.Облака, это позволяет:
 - Запускать Docker-контейнер, указанный в настройках виртуальной машины, сразу после ее создания из консоли управления или YC CLI.
 - Получать доступ к открытым сетевым портам Docker-контейнера без дополнительных настроек.
 - Обновлять запущенный Docker-контейнер с минимальным временем простоя.

## Перед началом работы {#before-you-begin}

Если нужный Docker-образ загружен в {{ container-registry-name }}, то создайте [сервисный аккаунт](../../iam/operations/sa/create.md) с ролью [{{ roles-cr-puller }}](../../container-registry/security/index.md#required-roles) на используемый реестр. От его имени ВМ на базе Container Optimized Image будет скачивать из реестра Docker-образ.

## Создайте ВМ с Docker-контейнером на базе образа Container Optimized Image {#create-vm}

{% list tabs %}

- Консоль управления

    1. В [консоли управления](https://console.cloud.yandex.ru) выберите каталог, в котором будет создана виртуальная машина.
    1. В списке сервисов выберите **{{ compute-name }}**.
    1. Нажмите кнопку **Создать ВМ**.
    1. В блоке **Публичные образы** выберите образ **Container Optimized Image**.
    1. После этого внизу страницы создания виртуальной машины появится блок **Настройка Docker-контейнера**. Заполните этот блок, используя подсказки возле полей блока:
       1. Укажите имя Docker-контейнера, который будет запущен на виртуальной машине.
       1. Укажите Docker-образ, на основе которого будет запущен Docker-контейнер на виртуальной машине.
       1. Заполните остальные поля при необходимости.
    1. Задайте остальные параметры виртуальной машины по этой [инструкции](../../compute/operations/vm-create/create-linux-vm.md).

- CLI

    1. Посмотрите описание команды CLI для создания ВМ на базе образа Container Optimized Image:

        ```
        $ yc compute instance create-with-container --help
        ```

    1. Создайте ВМ:

        Ознакомьтесь с [описание параметров и флагов](#desc-flags) для создания ВМ.

        ```
        $ yc compute instance create-with-container
        --name my-vm \
        --zone=ru-central1-b \
        --ssh-key ssh-key.pub \
        --service-account-name my-robot \
        --public-ip \
        --container-name=my-app \
        --container-image=vm_ubuntu \
        --container-command=sleep \
        --container-arg="1000" \
        --container-env=KEY1=VAL1,KEY2=VAL2 \
        --container-privileged
        done (17s)
        id: epdbf646ge5qgutfvh43
        folder_id: b1g88tflru0ek1omtsu0
        created_at: "2019-08-07T09:44:03Z"
        name: my-vm
        zone_id: ru-central1-b
        platform_id: standard-v2
        ...
        ```

{% endlist %}

После создания виртуальная машина появится в списке работающих ВМ в разделе **{{ compute-name }}** в [консоли управления]({{ link-console-main }}).

Подробнее о работе с ВМ читайте в [пошаговых инструкциях](../../compute/operations/index.md).

## Обновите виртуальную машину {#update}

{% list tabs %}

- Консоль управления
    1. В [консоли управления](https://console.cloud.yandex.ru) выберите каталог, в котором была создана виртуальная машина.
    1. В списке сервисов выберите **{{ compute-name }}**.
    1. Нажмите на строку с виртуальной машиной, которую вы хотите изменить.
    1. Нажмите кнопку **Изменить ВМ** на верхней панели.
    1. Внесите необходимые изменения в блоке **Настройка Docker-контейнера**.
    1. Нажмите **Сохранить изменения**.
    1. Включите виртуальную машину, нажав кнопку **Запустить** на верхней панели.

- CLI

    1. Посмотрите описание команды CLI для обновления ВМ:

        ```
        yc compute instance update-container --help
        ```

    1. Получите уникальный идентификатор виртуальной машины. Для этого нажмите на строку с ее именем в разделе **{{ compute-name }}** в [консоли управления]({{ link-console-main }}) или воспользуйтесь командой CLI:

        ```
        $ yc compute instance list
        +----------------------+-------+---------------+---------+----------------+-------------+
        |          ID          | NAME  |    ZONE ID    | STATUS  |  EXTERNAL IP   | INTERNAL IP |
        +----------------------+-------+---------------+---------+----------------+-------------+
        | epdbf646ge5qgutfvh43 | my-vm | ru-central1-b | RUNNING | 84.201.155.117 | 172.18.0.21 |
        +----------------------+-------+---------------+---------+----------------+-------------+
        ```

    1. Обновите виртуальную машину:

        Ознакомьтесь с [описание параметров и флагов](#desc-flags) для обновления ВМ.

        ```
        $ yc compute instance update-container epdbf646ge5qgutfvh43 \
        --container-name=my_vm_new_version \
        --container-image=my_vm_ubuntu \
        --container-env=KEY1=VAL1,KEY2=VAL2 \
        --remove-container-env=KEY3 \
        --container-stdin=false \
        --container-restart-policy=never
        done (2s)
        id: epdbf646ge5qgutfvh43
        folder_id: b1g88tflru0ek1omtsu0
        created_at: "2019-08-07T09:44:03Z"
        name: my-vm
        zone_id: ru-central1-b
        platform_id: standard-v2
        ...
        ```

{% endlist %}

## Описание параметров и флагов {#desc-flags}

- `--container-arg` — передать параметры в команду, указанную с помощью `--container-command`.
- `--clear-container-args` — исключить из запуска Docker-контейнера все параметры, переданные в команду с помощью `--container-arg`.
    - Параметр доступен только для команды обновления.
- `--container-command` — указать команду, которая будет выполнена при запуске Docker-контейнера.
- `--clear-container-command` — исключить команду, выполняемую при запуске Docker-контейнера.
    - Параметр доступен только для команды обновления.
- `--container-env` — передать переменные окружения в Docker-контейнер.
    - Если ключ повторяется несколько раз, будет использовано только последнее значение.
    - Имеет приоритет выше, чем у параметра `--container-env-file`.
- `--container-env-file` — передать переменные окружения в Docker-контейнер из файла.
    - Если ключ повторяется несколько раз, будет использовано только последнее значение.
    - Имеет приоритет ниже, чем у параметра `--container-env`.
- `--remove-container-env` — исключить переменные окружения, ключи которых указаны в параметре.
    - Имеет приоритет выше, чем у параметров `--container-env` и `--container-env-file`.
    - Параметр доступен только для команды обновления.
- `--container-image` — указать имя Docker-образа для запуска Docker-контейнера.
    - Обязательный параметр.
- `--container-name` — указать имя Docker-контейнера.
- `--container-privileged` — запустить Docker-контейнер в привилегированном режиме.
    - Значение по умолчанию: `false`.
- `--container-stdin` — выделить буфер для потока ввода во время выполнения Docker-контейнера.
    - Значение по умолчанию: `false`.
- `--container-tty` — выделить TTY для Docker-контейнера.
    - Значение по умолчанию: `false`.
- `--container-restart-policy` — установить политику перезапуска Docker-контейнера.
    - Допустимые значения: `always` (по умолчанию), `never`, `on-failure`.
