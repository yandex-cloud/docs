# Как начать работать с Container Registry

В этой инструкции вы создадите свой первый [реестр](../concepts/registry.md) и попробуете управлять [Docker-образами](../concepts/docker-image.md).

## Подготовка к работе {#before-you-begin}

Для создания реестра вам понадобится каталог в Yandex Cloud. Если каталога еще нет, перед созданием реестра необходимо создать новый каталог:

1. В [консоли управления](https://console.yandex.cloud) на панели сверху нажмите ![image](../../_assets/console-icons/layout-side-content-left.svg) или ![image](../../_assets/console-icons/chevron-down.svg) и выберите нужное [облако](../../resource-manager/concepts/resources-hierarchy.md#cloud).
1. Справа от названия облака нажмите ![image](../../_assets/console-icons/ellipsis.svg).
1. Выберите ![image](../../_assets/console-icons/plus.svg) **Создать каталог**.

   ![create-folder1](../../_assets/resource-manager/create-folder-1.png)

1. Введите имя [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder). Требования к имени:

    * длина — от 3 до 63 символов;
    * может содержать строчные буквы латинского алфавита, цифры и дефисы;
    * первый символ — буква, последний — не дефис.

1. (Опционально) Введите описание каталога.
1. Выберите опцию **Создать сеть по умолчанию**. Будет создана [сеть](../../vpc/concepts/network.md#network) с подсетями в каждой зоне доступности. Также в этой сети будет создана [группа безопасности по умолчанию](../../vpc/concepts/security-groups.md#default-security-group), внутри которой весь сетевой трафик разрешен.
1. Нажмите кнопку **Создать**.

   ![create-folder2](../../_assets/resource-manager/create-folder-2.png)

Чтобы работать с Container Registry и Docker-образами, [установите Yandex Cloud CLI](../../cli/operations/install-cli.md) и [настройте](../operations/configure-docker.md) Docker.

## Создание реестра и базовые операции с Docker-образом {#registry-create}

1. Создайте реестр в Container Registry:

   ```bash
   yc container registry create --name my-first-registry
   ```

   Результат:

   ```text
   ..done
   id: crpc9qeoft23********
   folder_id: b1g0itj57rbj********
   name: my-first-registry
   status: ACTIVE
   created_at: "2018-12-25T12:24:56.286Z"
   ```

   Полученный `ID` далее будет использоваться для обращения к созданному реестру.
1. Аутентифицируйтесь в Container Registry с помощью [Docker Credential helper](../operations/authentication.md#cred-helper):
   1. Сконфигурируйте [Docker](https://yandex.cloud/ru/blog/posts/2022/03/docker-containers) для использования `docker-credential-yc`:

      ```bash
      yc container registry configure-docker
      ```

      Результат:

      ```text
      Credential helper is configured in '/home/<user>/.docker/config.json'
      ```

      При конфигурации сохраняется информация о текущем профиле пользователя.
   1. Проверьте, что Docker сконфигурирован.

      В конфигурационном файле `/home/<user>/.docker/config.json` должна появиться строка:

      ```json
      "cr.yandex": "yc"
      ```

1. Скачайте Docker-образ из репозитория [Docker Hub](https://hub.docker.com):

   ```bash
   docker pull ubuntu
   ```

1. Присвойте скачанному Docker-образу тег вида `cr.yandex/<идентификатор_реестра>/<имя_Docker-образа>:<тег>`:

   ```bash
   docker tag ubuntu \
   cr.yandex/<идентификатор_реестра>/ubuntu:hello
   ```

1. Загрузите Docker-образ в репозиторий Container Registry:

   ```bash
   docker push \
   cr.yandex/<идентификатор_реестра>/ubuntu:hello
   ```

1. Запустите Docker-образ:

   ```bash
   docker run \
   cr.yandex/<идентификатор_реестра>/ubuntu:hello
   ```

#### Смотрите также {#see-also}

* [Создание реестра](../operations/registry/registry-create.md).
* [Аутентификация в Container Registry](../operations/authentication.md).
* [Создание Docker-образа](../operations/docker-image/docker-image-create.md).
* [Загрузка Docker-образа](../operations/docker-image/docker-image-push.md).
* [Скачивание Docker-образа](../operations/docker-image/docker-image-pull.md).
* [Запуск Docker-образа на виртуальной машине](../tutorials/index.md).