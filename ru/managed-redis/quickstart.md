---
title: Начало работы с {{ mrd-full-name }}
description: В этой инструкции вы научитесь создавать кластер {{ VLK }} и подключаться к нему.
---

# Как начать работать с {{ mrd-name }}

Чтобы начать работу с сервисом:
1. [Создайте кластер](#cluster-create).
1. [Подключитесь к кластеру](#connect).


## Перед началом работы {#before-you-begin}

1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь, если вы еще не зарегистрированы.

1. Если у вас еще нет каталога, создайте его:

   {% include [create-folder](../_includes/create-folder.md) %}

1. [Назначьте](../iam/operations/roles/grant.md) вашему аккаунту в {{ yandex-cloud }} роль [{{ roles-vpc-user }}](../vpc/security/index.md#vpc-user) и роль [{{ roles.mrd.editor }} или выше](security/index.md#roles-list). Эти роли позволяют создать кластер.

    {% include [note-managing-roles](../_includes/mdb/note-managing-roles.md) %}

1. [Создайте виртуальную машину Linux](../compute/operations/vm-create/create-linux-vm.md#console_1).

    Укажите следующие параметры:

    * **{{ ui-key.yacloud.compute.instances.create.section_image }}** — `Ubuntu 24.04` из {{ marketplace-short-name }}.
    * **{{ ui-key.yacloud.component.compute.network-select.field_external }}** — `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`.
    * **{{ ui-key.yacloud.compute.instances.create.field_security-groups }}** — оставьте поле пустым.

        Виртуальной машине будет автоматически назначена [группа безопасности по умолчанию](../vpc/concepts/security-groups.md) (с префиксом `default-sg`). Такая группа разрешает подключение к виртуальной машине по SSH, а также разрешает любой исходящий трафик.

    Прочие параметры выберите на свое усмотрение.

1. [Создайте группу безопасности](../vpc/operations/security-group-create.md) в той же сети, в которой находится виртуальная машина. Эта группа безопасности будет назначена кластеру {{ VLK }} при его создании.

    Добавьте в группу [правило](./operations/connect/index.md#configuring-security-groups), разрешающее подключение к [нешардированному кластеру](./concepts/sharding.md) {{ VLK }}. Настройте правило так, чтобы был разрешен входящий трафик из группы безопасности по умолчанию, назначенной виртуальной машине.


## Создайте кластер {#cluster-create}


Создайте нешардированный кластер {{ VLK }} [без публичного доступа](./concepts/network.md#public-access-to-host). К такому кластеру можно [подключиться](#connect) только с виртуальной машины, размещенной в сети кластера.


Чтобы создать кластер:

1. В консоли управления выберите каталог, в котором нужно создать кластер {{ VLK }}.
1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
1. Нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
1. Укажите следующие параметры кластера:

    * **{{ ui-key.yacloud.mdb.forms.section_base }}**:

        * **{{ ui-key.yacloud.mdb.forms.base_field_name }}** — имя кластера. Оно должно быть уникальным в рамках каталога.
        * **{{ ui-key.yacloud.mdb.forms.field_cluster-mode }}** — оставьте опцию выключенной.
        * **{{ ui-key.yacloud.redis.field_tls-support }}** — включите опцию.
        * **{{ ui-key.yacloud.redis.field_announce-hostnames }}** — включите опцию.

    * **{{ ui-key.yacloud.mdb.forms.section_network }}**:

        * **Сеть** — укажите сеть, в которой находится [созданная ранее](#before-you-begin) виртуальная машина.
        * **{{ ui-key.yacloud.mdb.forms.field_security-group }}** — укажите [созданную ранее](#before-you-begin) группу безопасности для кластера.

    * **{{ ui-key.yacloud.mdb.forms.section_host }}** → **{{ ui-key.yacloud.mdb.forms.host_column_assign_public_ip }}** — убедитесь, что эта опция выключена (имеет значение `Нет`) для всех хостов кластера.

    * **{{ ui-key.yacloud.mdb.forms.section_settings }}** → **{{ ui-key.yacloud.mdb.forms.config_field_password }}** — пароль пользователя.

        {% include [requirements-to-password](../_includes/mdb/mrd/requirements-to-password.md) %}

1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_create }}**.
1. Дождитесь, когда кластер будет готов к работе: его статус на панели {{ mrd-name }} сменится на **Running**, а состояние — на **Alive**. Это может занять некоторое время.

Подробнее о создании кластера см. в разделе [{#T}](./operations/cluster-create.md).

## Подключитесь к кластеру {#connect}

1. [Подключитесь](../compute/operations/vm-connect/ssh.md) по SSH к [созданной ранее виртуальной машине](#before-you-begin).

1. Установите утилиту `redis-cli`:

    ```bash
    sudo apt update && sudo apt install --yes redis-tools
    ```

1. Подключитесь напрямую к мастеру:

    {% list tabs group=connection %}

    - Подключение без SSL {#without-ssl}

        ```bash
        redis-cli -h c-<идентификатор_кластера>.rw.{{ dns-zone }} \
          -p {{ port-mrd }} \
          -a <пароль_{{ VLK }}>
        ```

    - Подключение с SSL {#with-ssl}

        1. Получите SSL-сертификат:

            {% include [unix-certificate](../_includes/mdb/mrd/unix-certificate.md) %}

        1. Выполните команду:

            ```bash
            redis-cli -h c-<идентификатор_кластера>.rw.{{ dns-zone }} \
              -p {{ port-mrd-tls }} \
              -a <пароль_{{ VLK }}> \
              --tls \
              --cacert ~/.redis/{{ crt-local-file }}
            ```

    {% endlist %}

    Идентификатор кластера можно запросить со [списком кластеров в каталоге](./operations/cluster-list.md#list-clusters).

    {% include [see-fqdn-in-console](../_includes/mdb/see-fqdn-in-console.md) %}

1. После успешного подключения отправьте команду `PING`. {{ VLK }} должен вернуть ответ `PONG`.

## Что дальше {#whats-next}

* Изучите [концепции сервиса](concepts/index.md).
* Узнайте подробнее о [создании кластера](operations/cluster-create.md) и [подключении к кластеру](operations/connect/index.md).
* Ознакомьтесь с [вопросами и ответами](qa/general.md).
