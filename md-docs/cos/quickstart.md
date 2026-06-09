# Создание ВМ с Container Optimized Image

Создайте виртуальную машину из образа [Container Optimized Image](concepts/index.md) и запустите на ней [Docker-контейнер](https://yandex.cloud/ru/blog/posts/2022/03/docker-containers).

## Перед началом работы {#before-you-begin}

Если нужный Docker-образ загружен в Container Registry, то создайте [сервисный аккаунт](../iam/operations/sa/create.md) с ролью [container-registry.images.puller](../container-registry/security/index.md#choosing-roles) на используемый реестр. От его имени ВМ на базе Container Optimized Image будет скачивать из реестра Docker-образ.

## Создайте ВМ с Docker-контейнером на базе образа Container Optimized Image {#create-vm}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создана ВМ.
  1. В списке сервисов выберите **Compute Cloud**.
  1. На панели слева выберите ![image](../_assets/console-icons/server.svg) **Виртуальные машины**.
  1. Нажмите кнопку **Создать виртуальную машину**.
  1. В блоке **Образ загрузочного диска** перейдите на вкладку **Container Solution**.
  1. Нажмите кнопку **Настроить**.
  1. В открывшемся окне **Настройка Docker-контейнера** задайте параметры, используя подсказки:

      1. Укажите **Docker-образ**, на основе которого будет запущен Docker-контейнер на ВМ.
      1. Выберите значение поля **Политика перезапуска** для Docker-контейнера:

          * `Always` — всегда перезапускать Docker-контейнер при его остановке.
          * `On-Failure` — перезапускать Docker-контейнер, только если он завершил работу с ненулевым кодом возврата.
          * `Never` — не перезапускать Docker-контейнер автоматически.

      1. При необходимости заполните остальные поля.
      1. Нажмите кнопку **Применить**.

  1. Настройте остальные параметры ВМ по [инструкции](../compute/operations/vm-create/create-linux-vm.md).

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для создания ВМ на базе образа Container Optimized Image:

     ```bash
     yc compute instance create-with-container --help
     ```

  1. Создайте ВМ с образом Container Optimized Image:

     ```bash
     yc compute instance create-with-container \
       --name my-vm \
       --zone ru-central1-b \
       --ssh-key ssh-key.pub \
       --service-account-name my-robot \
       --platform standard-v3 \
       --create-boot-disk size=30 \
       --public-ip \
       --container-name=my-app \
       --container-image=cr.yandex/mirror/ubuntu:24.04 \
       --container-command=sleep \
       --container-arg="1000" \
       --container-env='"KEY-GROUP={key1:value1,key2:value2,key3:value3}"',KEY4=VALUE4,KEY5=VALUE5 \
       --container-privileged
     ```

     Где:
     * `--name` — имя ВМ.
     * `--zone` — зона доступности.
     * `--ssh-key` — содержимое файла [открытого ключа](../compute/quickstart/quick-create-linux.md#create-ssh).
     * `--service-account-name` — имя сервисного аккаунта.
     * `--create-boot-disk size` — размер загрузочного диска.

        Чтобы узнать минимальный размер загрузочного диска, необходимый для установки образа, выполните команду:
        * `yc compute image get-latest-from-family container-optimized-image --folder-id standard-images` — если устанавливаете образ Container Optimized Image;
        * `yc compute image get-latest-from-family container-optimized-image-gpu --folder-id standard-images` — если устанавливаете образ Container Optimized Image GPU.
        
        Минимальный размер загрузочного диска указан в параметре `min_disk_size`.

     * `--public-ip` — выделение публичного IP-адреса для ВМ.
     * `--container-name` — имя Docker-контейнера.
     * `--container-image` — имя Docker-образа для запуска Docker-контейнера.
     * `--container-command` — команда, которая будет выполнена при запуске Docker-контейнера.
     * `--container-arg` — параметры для команды, указанной с помощью `--container-command`.
     * `--container-env` — переменные окружения, доступные внутри Docker-контейнера.

        Группы пар `ключ:значение` передавайте одновременно в одинарных и двойных кавычках. Например, `--container-env='"KEY-GROUP={key1:value1,key2:value2,key3:value3}"'`.
     * `--container-privileged` — запуск Docker-контейнера в привилегированном режиме.

     Результат:

     ```text
     done (17s)
      id: epdbf646ge5q********
      folder_id: b1g88tflru0e********
      created_at: "2023-03-13T09:44:03Z"
      name: my-vm
     ...
     ```

     После создания ВМ появится в списке ВМ в разделе **Compute Cloud** в [консоли управления](https://console.yandex.cloud). Подробнее о работе с ВМ читайте в [пошаговых инструкциях](../compute/operations/index.md).

{% endlist %}

#### Что дальше {#what-is-next}

* Прочитайте подробное описание [образа Container Optimized Image](concepts/index.md).
* Посмотрите, что еще можно делать с образом Container Optimized Image в [пошаговых инструкциях](tutorials/index.md).