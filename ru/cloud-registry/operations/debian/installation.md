---
title: Настроить менеджер пакетов APT для работы с реестром {{ cloud-registry-full-name }}
description: Следуя данной инструкции, вы настроите APT для работы с реестром {{ cloud-registry-name }}.
---

# Настроить менеджер пакетов APT

Инструкция описывает, как настроить [менеджер пакетов APT](https://ru.wikipedia.org/wiki/APT) (Advanced Package Tool) для работы с [Debian-реестром](../../concepts/artifacts/debian.md) в {{ cloud-registry-full-name }}.

## Подготовка GPG-ключа {#prepare-gpg-key}

GPG-ключ требуется для реестра с подписью метаданных. Подпись позволяет клиентам проверять подлинность пакетов с помощью GPG-ключа.

1. Сгенерируйте GPG-ключ с помощью утилиты [GnuPG](https://www.gnupg.org/download/index.html):

    ```bash
    gpg --full-generate-key
    ```

    При запросе `passphrase` оставьте поле пустым.

1. Найдите идентификатор созданного GPG-ключа:

    ```bash
    gpg --list-secret-keys --keyid-format=long
    ```

    Результат:

    ```text
    /home/user/.gnupg/secring.gpg
    ------------------------------
    sec   4096R/<идентификатор_GPG-ключа> 2024-01-01 [expires: 2026-01-01]
    uid                          User Name <user@example.com>
    ssb   4096R/XXXXXXXXXXXXXXXX 2024-01-01
    ```

1. Экспортируйте секретную часть GPG-ключа:

    ```bash
    gpg --armor --export-secret-keys <идентификатор_GPG-ключа>
    ```

1. Сохраните секретную часть GPG-ключа в секрет [{{ lockbox-full-name }}](../../../lockbox/) по ключу `gpg_secret_key_value`:

    ```bash
    yc lockbox secret create \
      --name <имя_секрета> \
      --payload "[{'key': 'gpg_secret_key_value', 'text_value': '$(gpg --armor --export-secret-keys <идентификатор_GPG-ключа>)'}]"
    ```

1. Предоставьте сервисному агенту сервиса {{ cloud-registry-name }} доступ к содержимому секрета, назначив ему на этот секрет роль `lockbox.payloadViewer`:

    ```bash
    yc lockbox secret add-access-binding \
      --id <идентификатор_секрета> \
      --role lockbox.payloadViewer \
      --agent cloud-registry:control-plane \
      --cloud-id <идентификатор_облака>
    ```

1. Сохраните публичную часть GPG-ключа — она понадобится пользователям реестра:

    ```bash
    gpg --armor --export <идентификатор_GPG-ключа> > public-key.asc
    ```

## Настройка APT {#configure-apt}

### Локальный реестр {#local-registry}

1. Добавьте реестр в список источников `APT`:

    {% list tabs %}

    - Реестр с подписью метаданных

        1. Скопируйте публичный GPG-ключ в директорию доверенных ключей APT:

            ```bash
            cp /path/to/public-key.asc /usr/share/keyrings/ycr-pub.asc
            ```

            Где `/path/to/public-key.asc` — путь к файлу с публичным GPG-ключом.

        1. Добавьте реестр в список источников `APT`:

            ```bash
            echo "deb [signed-by=/usr/share/keyrings/ycr-pub.asc] https://{{ cloud-registry }}/debian/<идентификатор_реестра> <дистрибутив> <компонент>" \
              >> /etc/apt/sources.list
            ```

    - Реестр без подписи метаданных

        Добавьте реестр с параметром `trusted=yes`:

        ```bash
        echo "deb [trusted=yes] https://{{ cloud-registry }}/debian/<идентификатор_реестра> <дистрибутив> <компонент>" \
          >> /etc/apt/sources.list
        ```

    {% endlist %}

1. {% include [apt-auth-conf](../../../_includes/cloud-registry/apt-auth-conf.md) %}

### Удаленный реестр {#remote-registry}

#### Публичный источник {#apt-remote-debian}

1. Установите пакет с публичными ключами дистрибутива:

    {% list tabs %}

    - Debian

        Выполните команду:

        ```bash
        sudo apt install debian-archive-keyring
        ```

        Ключ будет доступен по пути `/usr/share/keyrings/debian-archive-keyring.gpg`.

    - Ubuntu

        Выполните команду:

        ```bash
        sudo apt install ubuntu-keyring
        ```

        Ключ будет доступен по пути `/usr/share/keyrings/ubuntu-archive-keyring.gpg`.

    {% endlist %}

1. Добавьте реестр в список источников `APT`:

    ```bash
    echo "deb [signed-by=<путь_к_ключу>] https://{{ cloud-registry }}/debian/<идентификатор_реестра> <дистрибутив> <компонент>" \
      >> /etc/apt/sources.list
    ```

    Где:
    * `<путь_к_ключу>` — путь к файлу с ключом дистрибутива, например `/usr/share/keyrings/debian-archive-keyring.gpg` или `/usr/share/keyrings/ubuntu-archive-keyring.gpg`.
    * `<идентификатор_реестра>` — идентификатор реестра.
    * `<дистрибутив>` — дистрибутив, например `bookworm`, `bullseye` или `focal`.
    * `<компонент>` — компонент репозитория, например `main`.

1. {% include [apt-auth-conf](../../../_includes/cloud-registry/apt-auth-conf.md) %}

#### Пользовательский источник {#apt-remote-custom}

1. Добавьте реестр в список источников `APT`:

    {% list tabs %}

    - Источник подписан GPG-ключом

        1. Сохраните его в директорию доверенных ключей:

            ```bash
            cp /path/to/upstream-public-key.asc /usr/share/keyrings/upstream-pub.asc
            ```

            Где `/path/to/upstream-public-key.asc` — путь к файлу с публичным ключом исходного репозитория (`upstream`).

        1. Добавьте реестр в список источников `APT`:

            ```bash
            echo "deb [signed-by=/usr/share/keyrings/upstream-pub.asc] https://{{ cloud-registry }}/debian/<идентификатор_реестра> <дистрибутив> <компонент>" \
              >> /etc/apt/sources.list
            ```

    - Источник не подписан GPG-ключом

        Укажите параметр `trusted=yes`, чтобы APT принимал пакеты без проверки подлинности:

        ```bash
        echo "deb [trusted=yes] https://{{ cloud-registry }}/debian/<идентификатор_реестра> <дистрибутив> <компонент>" \
          >> /etc/apt/sources.list
        ```

    {% endlist %}

1. {% include [apt-auth-conf](../../../_includes/cloud-registry/apt-auth-conf.md) %}

{% include [apt-auth-conf-warning](../../../_includes/cloud-registry/apt-auth-conf-warning.md) %}

#### Полезные ссылки {#see-also}

* [{#T}](push.md)
* [{#T}](pull.md)
