Для запуска нескольких экземпляров сервиса в Docker-контейнерах вы можете создать группу виртуальных машин на базе образа [{{ coi }}](../../cos/concepts/index.md). В такой группе обновлять Docker-контейнер можно с помощью метаданных ВМ.

{% include [warning.md](warning.md) %}

{% include [sa.md](sa.md) %}

Чтобы создать группу виртуальных машин на базе {{ coi }}:

1. {% include [cli-install.md](../cli-install.md) %}

1. {% include [default-catalogue.md](../default-catalogue.md) %}

1. Посмотрите описание команды CLI для создания группы виртуальных машин:
    ```
    $ {{ yc-compute-ig }} create --help
    ```

1. Проверьте, есть ли в каталоге сети:
    ```
    $ yc vpc network list
    ```

    Если ни одной сети нет, [создайте ее](../../vpc/operations/network-create.md).

1. Создайте YAML-файл с именем, например, `specification.yaml`.

1. Выберите последнюю версию образа {{ coi }} из [публичных образов](../../compute/operations/images-with-pre-installed-software/get-list.md).

    Чтобы узнать идентификатор последней версии образа {{ coi }}, выполните следующую команду:

    ```
    $ yc compute image get-latest-from-family container-optimized-image --folder-id standard-images
    id: <ID образа>
    folder_id: standard-images
    ...
    ```

1. Опишите в YAML-файле `specification.yaml`, который вы создали:
    - Общую информацию о группе:

        ```
        name: container-optimized-group
        service_account_id: aje3932acd8avp6edhbt
        description: "This instance group was created from YAML config"
        ```

        Ключи:

        Ключ | Значение
        ----- | -----
        `name` | Произвольное имя группы виртуальных машин. Имя должно быть уникальным в рамках каталога. Имя может содержать строчные буквы латинского алфавита, цифры и дефисы. Первый символ должен быть буквой. Последний символ не может быть дефисом. Максимальная длина имени — 63 символа.
        `service_account_id` | Идентификатор сервисного аккаунта.
        `description` | Произвольное описание группы виртуальных машин.

    - [Шаблон виртуальной машины](../../compute/concepts/instance-groups/instance-template.md):

        ```
        instance_template:
            platform_id: standard-v1
            resources_spec:
                memory: 4G
                cores: 1
            boot_disk_spec:
                mode: READ_WRITE
                disk_spec:
                    image_id: fd81a49qficqvt0dthu8
                    type_id: network-hdd
                    size: 32G
            network_interface_specs:
                - network_id: c64mknqgnd8avp6edhbt
                  primary_v4_address_spec: {}
            metadata:
                docker-container-declaration: |-
                    spec:
                        containers:
                            - name: nginx
                              image: cr.yandex/mirror/nginx:1.17.4-alpine
                              securityContext:
                                privileged: false
                              tty: false
                              stdin: false
        ```

        {% include [default-unit-size](default-unit-size.md) %}

        Ключи: 

        Ключ | Значение
        ----- | -----
        `platform_id` | Идентификатор платформы.
        `memory` | Количество памяти (RAM).
        `cores` | Количество ядер процессора (vCPU).
        `mode` | Режим доступа к диску. </br> - `READ_ONLY` — доступ на чтение. </br>- `READ_WRITE` — доступ на чтение и запись.
        `image_id` | Идентификатор публичного образа {{ coi }}.
        `type_id` | Тип диска.
        `size` | Размер диска.
        `network_id` | Идентификатор сети `default-net`.
        `primary_v4_address_spec` | Спецификация версии интернет протокола IPv4. На данный момент доступен только протокол IPv4. Вы можете предоставить публичный доступ к виртуальным машинам группы, указав версию IP для публичного IP-адреса. Подробнее читайте в разделе [{#T}](../../compute/concepts/instance-groups/instance-template.md#instance-template).
        `metadata` | Значения, которые будут переданы в метаданные виртуальной машины.
        `docker-container-declaration` | Ключ в метаданных виртуальной машины, по которому доступно [описание Docker-контейнера](../../cos/concepts/index.md#coi-specification).

    - [Политики](../../compute/concepts/instance-groups/policies.md):

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

        Полный код файла `specification.yaml`:

        ```
        name: container-optimized-group
        service_account_id: aje3932acd8avp6edhbt
        description: "This instance group was created from YAML config"
        instance_template:
            platform_id: standard-v1
            resources_spec:
                memory: 4G
                cores: 1
            boot_disk_spec:
                mode: READ_WRITE
                disk_spec:
                    image_id: fd81a49qficqvt0dthu8
                    type_id: network-hdd
                    size: 32G
            network_interface_specs:
                - network_id: c64mknqgnd8avp6edhbt
                  primary_v4_address_spec: {}
            metadata:
                docker-container-declaration: |-
                    spec:
                        containers:
                            - name: nginx
                              image: cr.yandex/mirror/nginx:1.17.4-alpine
                              securityContext:
                                privileged: false
                              tty: false
                              stdin: false
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

1. Создайте группу виртуальных машин в каталоге по умолчанию:

    ```
    $ {{ yc-compute-ig }} create --file specification.yaml
    ```

    Данная команда создаст группу из трех однотипных виртуальных машин со следующими характеристиками:

    - С именем `container-optimized-group`.
    - Из последней версии публичного образа {{ coi }}.
    - С запущенным Docker-контейнером на основе `cr.yandex/mirror/nginx:1.17.4-alpine`.
    - В сети `default-net`.
    - В зоне доступности `ru-central1-a`.
    - С одним vCPU и 4 ГБ RAM.
    - С сетевым HDD-диском объемом 32 ГБ.
