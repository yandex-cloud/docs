[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Registry](../../index.md) > [Пошаговые инструкции](../index.md) > Управление артефактами > Debian-артефакт > Скачать Debian-пакет из реестра

# Скачать Debian-пакет из реестра

Инструкция описывает, как установить [Debian-пакет](../../concepts/artifacts/debian.md) из реестра Yandex Cloud Registry с помощью [менеджера пакетов `APT`](https://ru.wikipedia.org/wiki/APT) (Advanced Package Tool).

Для скачивания Debian-пакета необходима [роль](../../security/index.md#cloud-registry-artifacts-puller) `cloud-registry.artifacts.puller` или выше.

Перед скачиванием [настройте `APT`](installation.md) для работы с реестром.

## Установка из локального реестра {#local-registry}

[Локальный реестр](../../concepts/registry.md#local-registry) содержит пакеты, созданные и опубликованные внутри вашей организации.

1. Обновите список пакетов:

    ```bash
    apt-get update
    ```

1. Установите пакет:

    ```bash
    apt-get install <имя_пакета>
    ```

    Где `<имя_пакета>` — имя устанавливаемого пакета.

## Установка из удаленного реестра {#remote-registry}

[Удаленный реестр](../../concepts/registry.md#remote-registry) действует как прокси для внешних Debian-репозиториев. Удаленные реестры кешируют пакеты локально после первого обращения.

Кеширование поддерживается только для реестров с одним из следующих форматов хранения пакетов:

* Стандартный формат `/pool/<компонент>/<буква>/<имя_пакета>/...deb` — используется в репозиториях `archive.ubuntu.com` и `deb.debian.org`.
* Формат Cloud Registry.

{% note info %}

Flat-формат репозитория ([Flat Repository Format](https://wiki.debian.org/DebianRepository/Format#Flat_Repository_Format)) в удаленном реестре не поддерживается.

{% endnote %}

1. Обновите список пакетов:

    ```bash
    apt-get update
    ```

1. Установите пакет:

    ```bash
    apt-get install <имя_пакета>
    ```

    Где `<имя_пакета>` — имя устанавливаемого пакета из внешнего репозитория.

    При первом обращении пакет будет загружен из внешнего репозитория и сохранен в кеш. При последующих установках пакет будет загружаться из кеша.

#### Полезные ссылки {#see-also}

* [Настроить менеджер пакетов APT](installation.md)
* [Загрузить Debian-пакет в реестр](push.md)