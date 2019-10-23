# Изменить ВМ с {{ coi }}

Измените параметры Docker-контейнера на виртуальной машине, созданной из образа [{{ coi }}](../../concepts/coi.md).

{% list tabs %}

- Консоль управления
    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором была создана виртуальная машина.
    1. В списке сервисов выберите **{{ compute-name }}**.
    1. Нажмите на строку с виртуальной машиной, которую вы хотите изменить.
    1. Нажмите кнопку **Изменить ВМ** на верхней панели.
    1. Внесите необходимые изменения в блоке **Настройка Docker-контейнера**.
    1. Нажмите **Сохранить изменения**.

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

        - `--container-name` — имя Docker-контейнера.
        - `--container-image` — имя Docker-образа для запуска Docker-контейнера.
        - `--container-env` — переменные окружения, доступные внутри Docker-контейнера.
        - `--remove-container-env` — исключение переменных окружения, ключи которых указаны в параметре.       
        - `--container-command` — команда, которая будет выполнена при запуске Docker-контейнера.
        - `--container-stdin` — выделение буфера для потока ввода во время выполнения Docker-контейнера.
        - `--container-restart-policy` — параметры для команды, указанной с помощью `--container-command`.
        - `--container-privileged` — запуск Docker-контейнера в привилегированном режиме.

        ```
        $ yc compute instance update-container epdbf646ge5qgutfvh43 \
        --container-name=my_vm_new_version \
        --container-image=cr.yandex/mirror/ubuntu:18.04 \
        --container-env=KEY1=VAL1,KEY2=VAL2 \
        --remove-container-env=KEY3 \
        --container-stdin=false \
        --container-restart-policy=Never
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
