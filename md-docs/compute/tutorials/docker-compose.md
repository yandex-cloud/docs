[Документация Yandex Cloud](../../index.md) > [Yandex Compute Cloud](../index.md) > [Практические руководства](index.md) > Container Optimized Image > Создать ВМ с Container Optimized Image и несколькими Docker-контейнерами

# Создание ВМ с Container Optimized Image и несколькими Docker-контейнерами

В этой инструкции вы создадите виртуальную машину из образа [Container Optimized Image](../../cos/concepts/index.md) с несколькими [Docker-контейнерами](https://yandex.cloud/ru/blog/posts/2022/03/docker-containers) внутри. Для создания ВМ будет использована [Docker Compose спецификация](../../cos/concepts/coi-specifications.md#compose-spec).

## Перед началом работы {#before-you-begin}

Если нужный Docker-образ загружен в Yandex Container Registry, то создайте [сервисный аккаунт](../../iam/operations/sa/create.md) с ролью [container-registry.images.puller](../../container-registry/security/index.md#choosing-roles) на используемый реестр. От его имени ВМ на базе Container Optimized Image будет скачивать из реестра Docker-образ.

## Создайте ВМ с несколькими Docker-контейнерами {#docker-compose}

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы создать ВМ на базе образа Container Optimized Image и несколькими Docker-контейнерами.
  1. Посмотрите описание команды CLI для создания ВМ на базе образа Container Optimized Image:

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
       --zone ru-central1-a \
       --ssh-key ssh-key.pub \
       --create-boot-disk size=30 \
       --network-interface subnet-name=<имя_подсети>,nat-ip-version=ipv4 \
       --service-account-name <имя_сервисного_аккаунта> \
       --docker-compose-file docker-compose.yaml
     ```

     Где:
     * `--name` — имя ВМ.
     * `--zone` — зона доступности.
     * `--ssh-key` — путь к файлу и имя файла с [открытым ключом](../operations/vm-connect/ssh.md#creating-ssh-keys).
     * `--create-boot-disk size` — размер загрузочного диска.

        Чтобы узнать минимальный размер загрузочного диска, необходимый для установки образа, выполните команду:
        * `yc compute image get-latest-from-family container-optimized-image --folder-id standard-images` — если устанавливаете образ Container Optimized Image;
        * `yc compute image get-latest-from-family container-optimized-image-gpu --folder-id standard-images` — если устанавливаете образ Container Optimized Image GPU.
        
        Минимальный размер загрузочного диска указан в параметре `min_disk_size`.

     * `--network-interface` — сетевые настройки ВМ.
     * `--service-account-name` — имя сервисного аккаунта, созданного [ранее](#before-you-begin).
     * `--docker-compose-file` — YAML-файл со спецификацией контейнеров.

     После создания ВМ появится в списке ВМ в разделе **Compute Cloud** в [консоли управления](https://console.yandex.cloud).
  1. Проверьте результат.
     1. [Подключитесь к ВМ по SSH](../operations/vm-connect/ssh.md).
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