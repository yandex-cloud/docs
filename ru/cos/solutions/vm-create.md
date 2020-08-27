# Создание ВМ с {{ coi }}

Создайте виртуальную машину из образа [{{ coi }}](../concepts/index.md) и запустите на ней Docker-контейнер.

## Перед началом работы {#before-you-begin}

Если нужный Docker-образ загружен в {{ container-registry-name }}, то создайте [сервисный аккаунт](../../iam/operations/sa/create.md) с ролью [{{ roles-cr-puller }}](../../container-registry/security/index.md#choosing-roles) на используемый реестр. От его имени ВМ на базе {{ coi }} будет скачивать из реестра Docker-образ.

## Создайте ВМ с Docker-контейнером на базе образа {{ coi }} {#create-vm}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет создана виртуальная машина.
    1. В списке сервисов выберите **{{ compute-name }}**.
    1. Нажмите кнопку **Создать ВМ**.
    1. В блоке **Образы из {{ marketplace-name }}** выберите образ **{{ coi }}**.
    1. После этого внизу страницы создания виртуальной машины появится блок **Настройка Docker-контейнера**. Заполните этот блок, используя подсказки возле полей блока:
       1. Укажите имя Docker-контейнера, который будет запущен на виртуальной машине.
       1. Укажите Docker-образ, на основе которого будет запущен Docker-контейнер на виртуальной машине.
       1. Заполните остальные поля при необходимости.
    1. Задайте остальные параметры виртуальной машины по этой [инструкции](../../compute/operations/vm-create/create-linux-vm.md).

- CLI с помощью флагов

    {% include [cli-install](../../_includes/cli-install.md) %}
    
    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы создать ВМ и задать параметры Docker-контейнера через YC CLI:
    1. Посмотрите описание команды:

        ```bash
        yc compute instance create-with-container --help
        ```
    1. Выполните команду:
        
        ```bash
        yc compute instance create-with-container
         --name my-vm \
         --zone=ru-central1-b \
         --ssh-key ssh-key.pub \
         --service-account-name my-robot \
         --public-ip \
         --container-name=my-app \
         --container-image=cr.yandex/mirror/ubuntu:16.04 \
         --container-command=sleep \
         --container-arg="1000" \
         --container-env=KEY1=VAL1,KEY2=VAL2 \
         --container-privileged
        ```
       
        Параметры команды:
        - `--name` — имя виртуальной машины.
        - `--zone` — зона доступности.
        - `--ssh-key` — содержимое файла [открытого ключа](../../compute/quickstart/quick-create-linux.md#create-ssh).
        - `--service-account-name` — имя сервисного аккаунта.
        - `--public-ip` — выделение публичного IP-адреса для ВМ.
        - `--container-name` — имя Docker-контейнера.
        - `--container-image` — имя Docker-образа для запуска Docker-контейнера.
        - `--container-command` — команда, которая будет выполнена при запуске Docker-контейнера.
        - `--container-arg` — параметры для команды, указанной с помощью `--container-command`.
        - `--container-env` — переменные окружения, доступные внутри Docker-контейнера.
        - `--container-privileged` — запуск Docker-контейнера в привилегированном режиме.
        
        Результат команды:
        
        ```
        done (17s)
         id: epdbf646ge5qgutfvh43
         folder_id: b1g88tflru0ek1omtsu0
         created_at: "2019-08-07T09:44:03Z"
         name: my-vm
         zone_id: ru-central1-b
         platform_id: standard-v2
        ...
        ```
    
    После создания виртуальная машина появится в списке ВМ в разделе **{{ compute-name }}** в [консоли управления]({{ link-console-main }}). Подробнее о работе с ВМ читайте в [пошаговых инструкциях](../../compute/operations/index.md).

- CLI с помощью файла спецификации
    
    {% include [cli-install](../../_includes/cli-install.md) %}
    
    {% include [default-catalogue](../../_includes/default-catalogue.md) %}
        
    Чтобы создать ВМ и задать параметры Docker-контейнера с помощью [файла спецификации](../concepts/index.md#coi-spec).
    1. Посмотрите описание команды:

        ```bash
        yc compute instance create-with-container --help
        ```
    1. Подготовьте файл спецификации Docker-контейнера. Сохраните следующие данные в файл `docker-spec.yaml`:
        
        ```yaml
        spec:
          containers:
          - command:
            - sleep
            args:
            - 100000
            image: cr.yandex/mirror/ubuntu:20.04
            name: my-container
            securityContext:
              privileged: true
        ```
    1. Выполните команду:
        
        ```bash
        yc compute instance create-with-container \
          --coi-spec-file docker-spec.yaml \
          --name my-vm \
          --zone=ru-central1-b \
          --ssh-key ssh-key.pub \
          --service-account-name my-service-account \
          --public-ip
       ```
       
       Параметры команды: 
       - `--coi-spec-file` — путь к [файлу спецификации](../concepts/index.md#coi-spec) Docker-контейнера.
       - `--name` — имя виртуальной машины.
       - `--zone` — зона доступности.
       - `--ssh-key` — содержимое файла [открытого ключа](../../compute/quickstart/quick-create-linux.md#create-ssh).
       - `--service-account-name` — имя сервисного аккаунта.
       - `--public-ip` — выделение публичного IP-адреса для ВМ.
       
       Результат команды:
       
       ``` 
       done (1m40s)
        id: epde18u4mahl4a8n39ta
        folder_id: b1g7gvsi89m34qmcm3ke
        created_at: "2020-08-10T13:50:17Z"
        name: my-vm
        zone_id: ru-central1-b
        platform_id: standard-v2
        ...
        ```
            
    После создания виртуальная машина появится в списке ВМ в разделе **{{ compute-name }}** в [консоли управления]({{ link-console-main }}). Подробнее о работе с ВМ читайте в [пошаговых инструкциях](../../compute/operations/index.md).
    
{% endlist %}
