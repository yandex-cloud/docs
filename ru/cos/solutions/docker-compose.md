# Создание ВМ с {{ coi }} и несколькими Docker-контейнерами с помощью docker-compose.yaml файла

В этой инструкции вы создадите виртуальную из образа [{{ coi }}](../concepts/index.md) с несколькими Docker-контейнерами внутри с помощью [docker-compose.yaml](https://docs.docker.com/compose/) файла.

## Перед началом работы {#before-you-begin}

Если нужный Docker-образ загружен в {{ container-registry-name }}, то создайте [сервисный аккаунт](../../iam/operations/sa/create.md) с ролью [{{ roles-cr-puller }}](../../container-registry/security/index.md#choosing-roles) на используемый реестр. От его имени ВМ на базе {{ coi }} будет скачивать из реестра Docker-образ.

## Создайте ВМ с несколькими Docker-контейнерами {#docker-compose}

{% list tabs %}

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}
    
    {% include [default-catalogue](../../_includes/default-catalogue.md) %}
    
    Чтобы создать ВМ на базе образа {{ coi }} и несколькими Docker-контейнерами:
    1. Посмотрите описание команды CLI для создания ВМ на базе образа {{ coi }}:

        ```
        $ yc compute instance create-with-container --help
        ```
    1. Подготовьте спецификацию Docker-контейнеров. Сохраните следующие данные в файл `docker-compose.yaml`:
    
        ```
        version: '3.7'
        services:
          app1:
            container_name: nginx
            image: "nginx"
            ports:
              - "80:80"
            restart: always
          app2:
            container_name: redis
            image: "redis"
            restart: always
        ```
    1. Создайте ВМ с несколькими Docker-контейнерами.
        
        ```
        yc compute instance create-with-container \
            --name my-vm \
            --zone=ru-central1-a \
            --ssh-key ssh-key.pub \
            --network-interface subnet-name=<имя подсети>,nat-ip-version=ipv4 \
            --service-account-name default-sa \
            --docker-compose-file docker-compose.yaml
        ```
        
        Где:
        - `--name` — имя виртуальной машины.
        - `--zone` — зона доступности.
        - `--ssh-key` — содержимое файла [открытого ключа](../../compute/quickstart/quick-create-linux.md#create-ssh).
        - `--network-interface` — сетевые настройки виртуальной машины.
        - `--service-account-name` — имя сервисного аккаунта. 
        - `--docker-compose-file` — YAML-файл со спецификацией контенеров.
        
        После создания виртуальная машина появится в списке ВМ в разделе **{{ compute-name }}** в [консоли управления]({{ link-console-main }}).
    1. Проверьте результат.
        
        1. [Подключитесь к ВМ по SSH](../../compute/operations/vm-connect/ssh.md).
        1. Посмотрите список запущенных Docker-контейнеров:
        
        ```
        sudo docker ps -a
        CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                NAMES
        c79b1cdc5a3a        nginx               "nginx -g 'daemon of…"   16 seconds ago      Up 14 seconds       0.0.0.0:80->80/tcp   nginx
        3ac5a9844a5d        redis               "docker-entrypoint.s…"   2 minutes ago       Up 2 minutes        6379/tcp             redis
        ```
            
{% endlist %}




