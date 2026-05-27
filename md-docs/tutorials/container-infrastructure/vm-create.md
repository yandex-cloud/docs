# Создание ВМ с Container Optimized Image

Создайте виртуальную машину из образа [Container Optimized Image](../../cos/concepts/index.md) и запустите на ней [Docker-контейнер](https://yandex.cloud/ru/blog/posts/2022/03/docker-containers).

## Перед началом работы {#before-you-begin}

Если нужный Docker-образ загружен в Yandex Container Registry, то создайте [сервисный аккаунт](../../iam/operations/sa/create.md) с ролью [container-registry.images.puller](../../container-registry/security/index.md#choosing-roles) на используемый реестр. От его имени ВМ на базе Container Optimized Image будет скачивать из реестра Docker-образ.

## Создайте ВМ с Docker-контейнером на базе образа Container Optimized Image {#create-vm}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создана ВМ.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Compute Cloud**.
  1. На панели слева выберите ![image](../../_assets/console-icons/server.svg) **Виртуальные машины**.
  1. Нажмите кнопку **Создать виртуальную машину**.
  1. В блоке **Образ загрузочного диска** перейдите на вкладку **Container Solution**.
  1. Нажмите кнопку **Настроить**.
  1. В открывшемся окне **Настройка Docker-контейнера** задайте параметры, используя подсказки:

      * (Опционально) Введите **Имя** Docker-контейнера, который будет запущен на ВМ. Требования к имени:

          * длина — от 3 до 63 символов;
          * может содержать строчные буквы латинского алфавита, цифры и дефисы;
          * первый символ — буква, последний — не дефис.

      * Укажите [**Docker-образ**](../../cos/concepts/docker-image.md), на основе которого будет запущен Docker-контейнер на ВМ. Вы можете сделать это одним из способов:

          * Выбрать один из доступных образов. Для этого начните вводить часть имени образа в поисковой строке. Поиск образов осуществляется во всех доступных каталогах облака.
          * Указать имя образа вручную. Для этого нажмите **Укажите ссылку** и введите имя образа. Вы можете указать образ из сервиса Container Registry или любой публично доступной библиотеки Docker-образов (например, [Docker Hub](https://hub.docker.com)).

      * (Опционально) В поле **Команда** укажите исполняемый файл, который будет запущен при старте Docker-контейнера.
      * (Опционально) Задайте **Аргументы команды**.
      * (Опционально) Задайте **Переменные окружения**, которые будут доступны внутри Docker-контейнера, в формате `ключ:значение`.
      * Выберите значение поля [**Политика перезапуска**](../../cos/concepts/restart-policy.md) для Docker-контейнера:

          * `Always` — всегда перезапускать Docker-контейнер при его остановке.
          * `On-Failure` — перезапускать Docker-контейнер, только если он завершил работу с ненулевым кодом возврата.
          * `Never` — не перезапускать Docker-контейнер автоматически.

      * (Опционально) Включите **Выделить TTY для Docker-контейнера**, чтобы использовать командную оболочку внутри Docker-контейнера.
      * (Опционально) Включите **Выделить буфер для потока ввода во время выполнения Docker-контейнера**, чтобы связать поток ввода с запущенным Docker-контейнером.
      * (Опционально) Включите **Запустить Docker-контейнер в привилегированном режиме**, чтобы процессы Docker-контейнера получили доступ ко всем ресурсам ВМ.

  1. Нажмите кнопку **Применить**.
  1. В блоке **Доступ** укажите сервисный аккаунт, созданный [ранее](#before-you-begin).
  1. Настройте остальные параметры ВМ по [инструкции](../../compute/operations/vm-create/create-linux-vm.md).

- CLI с помощью параметров {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы создать ВМ и задать параметры Docker-контейнера через YC CLI:
  1. Посмотрите описание команды:

     ```bash
     yc compute instance create-with-container --help
     ```

  1. Выполните команду:

     ```bash
     yc compute instance create-with-container \
       --name my-vm \
       --zone ru-central1-b \
       --ssh-key ssh-key.pub \
       --service-account-name <имя_сервисного_аккаунта> \
       --create-boot-disk size=30 \
       --public-ip \
       --platform standard-v3 \
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
     * `--ssh-key` — содержимое файла [открытого ключа](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
     * `--service-account-name` — имя сервисного аккаунта, созданного [ранее](#before-you-begin).
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

    После создания ВМ появится в списке ВМ в разделе **Compute Cloud** в [консоли управления](https://console.yandex.cloud). Подробнее о работе с ВМ читайте в [пошаговых инструкциях](../../compute/operations/index.md).

- CLI с помощью файла спецификации {#spec-cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы создать ВМ и задать параметры Docker-контейнера с помощью [файла спецификации](../../cos/concepts/coi-specifications.md#coi-spec):
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
       --zone ru-central1-b \
       --ssh-key ssh-key.pub \
       --create-boot-disk size=30 \
       --service-account-name <имя_сервисного_аккаунта> \
       --public-ip
     ```

     Где:
     * `--coi-spec-file` — путь к [файлу спецификации](../../cos/concepts/coi-specifications.md#coi-spec) Docker-контейнера.
     * `--name` — имя ВМ.
     * `--zone` — зона доступности.
     * `--ssh-key` — содержимое файла [открытого ключа](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
     * `--create-boot-disk size` — размер загрузочного диска.

        Чтобы узнать минимальный размер загрузочного диска, необходимый для установки образа, выполните команду:
        * `yc compute image get-latest-from-family container-optimized-image --folder-id standard-images` — если устанавливаете образ Container Optimized Image;
        * `yc compute image get-latest-from-family container-optimized-image-gpu --folder-id standard-images` — если устанавливаете образ Container Optimized Image GPU.
        
        Минимальный размер загрузочного диска указан в параметре `min_disk_size`.

     * `--service-account-name` — имя сервисного аккаунта, созданного [ранее](#before-you-begin).
     * `--public-ip` — выделение публичного IP-адреса для ВМ.

     Результат:

     ```text
     done (1m40s)
      id: epde18u4mahl********
      folder_id: b1g7gvsi89m3********
      created_at: "2023-03-13T13:50:17Z"
      name: my-vm
      ...
     ```

  После создания ВМ появится в списке ВМ в разделе **Compute Cloud** в [консоли управления](https://console.yandex.cloud). Подробнее о работе с ВМ читайте в [пошаговых инструкциях](../../compute/operations/index.md).

{% endlist %}