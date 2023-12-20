# Создание ВМ с {{ coi }} и несколькими Docker-контейнерами

В этой инструкции вы создадите виртуальную машину из образа [{{ coi }}](../concepts/index.md) с несколькими [Docker-контейнерами](/blog/posts/2022/03/docker-containers) внутри. Для создания ВМ будет использована [Docker Compose спецификация](../concepts/coi-specifications.md#compose-spec).

## Перед началом работы {#before-you-begin}

Если нужный Docker-образ загружен в {{ container-registry-full-name }}, то создайте [сервисный аккаунт](../../iam/operations/sa/create.md) с ролью [{{ roles-cr-puller }}](../../container-registry/security/index.md#choosing-roles) на используемый реестр. От его имени ВМ на базе {{ coi }} будет скачивать из реестра Docker-образ.

## Создайте ВМ с несколькими Docker-контейнерами {#docker-compose}

{% list tabs %}

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать ВМ на базе образа {{ coi }} и несколькими Docker-контейнерами.
  1. Посмотрите описание команды CLI для создания ВМ на базе образа {{ coi }}:

     ```bash
     yc compute instance create-with-container --help
     ```

  1. Подготовьте спецификацию Docker-контейнеров. Сохраните следующие данные в файл `docker-compose.yaml`:

     ```yaml
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

  1. Создайте ВМ с несколькими Docker-контейнерами:

     ```bash
     yc compute instance create-with-container \
       --name my-vm \
       --zone {{ region-id }}-a \
       --ssh-key ssh-key.pub \
       --create-boot-disk size=30 \
       --network-interface subnet-name=<имя_подсети>,nat-ip-version=ipv4 \
       --service-account-name default-sa \
       --docker-compose-file docker-compose.yaml
     ```

     Где:
     * `--name` — имя ВМ.
     * `--zone` — зона доступности.
     * `--ssh-key` — путь к файлу и имя файла с [открытым ключом](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
     * `--create-boot-disk size` — размер загрузочного диска. Должен быть не менее 30 ГБ.
     * `--network-interface` — сетевые настройки ВМ.
     * `--service-account-name` — имя сервисного аккаунта.
     * `--docker-compose-file` — YAML-файл со спецификацией контейнеров.

     После создания ВМ появится в списке ВМ в разделе **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}** в [консоли управления]({{ link-console-main }}).
  1. Проверьте результат.
     1. [Подключитесь к ВМ по SSH](../../compute/operations/vm-connect/ssh.md).
     1. Посмотрите список запущенных Docker-контейнеров:

        ```bash
        sudo docker ps -a
        ```

        Результат:

        ```text
        CONTAINER ID  IMAGE  COMMAND                 CREATED         STATUS         PORTS               NAMES
        c79b********  nginx  "nginx -g 'daemon of…"  16 seconds ago  Up 14 seconds  0.0.0.0:80->80/tcp  nginx
        3ac5********  redis  "docker-entrypoint.s…"  2 minutes ago   Up 2 minutes   6379/tcp            redis
        ```

{% endlist %}