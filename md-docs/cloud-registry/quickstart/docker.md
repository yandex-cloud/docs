# Как начать работать с Cloud Registry

В этой инструкции вы создадите свой первый [реестр](../concepts/registry.md) и попробуете управлять [Docker-образами](../concepts/artifacts/docker.md).

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

## Создание реестра и загрузка Docker-образа {#create-and-push}

Чтобы работать с Cloud Registry и Docker-образами:

1. [Установите Yandex Cloud CLI](../../cli/operations/install-cli.md) и [настройте](../operations/docker/installation.md) Docker.
1. [Создайте реестр](../operations/registry/create.md) в Cloud Registry.
1. [Аутентифицируйтесь](../operations/docker/authentication.md) в Cloud Registry.
1. Скачайте Docker-образ из репозитория [Docker Hub](https://hub.docker.com):

   ```bash
   docker pull ubuntu
   ```

1. Присвойте скачанному Docker-образу тег вида `registry.yandexcloud.net/<идентификатор_реестра>/<имя_Docker-образа>:<тег>`:

   ```bash
   docker tag ubuntu \
   registry.yandexcloud.net/<идентификатор_реестра>/ubuntu:hello
   ```

1. Загрузите Docker-образ в репозиторий Cloud Registry:

   ```bash
   docker push \
   registry.yandexcloud.net/<идентификатор_реестра>/ubuntu:hello
   ```

1. Запустите Docker-образ:

   ```bash
   docker run \
   registry.yandexcloud.net/<идентификатор_реестра>/ubuntu:hello
   ```

#### Смотрите также {#see-also}

[Поддерживаемые типы артефактов](../concepts/artifacts/index.md#artifacts)