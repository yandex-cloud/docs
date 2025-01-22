---
title: Как начать работать с {{ mgp-full-name }}
description: Следуя данной инструкции, вы сможете создать кластер {{ GP }} и начать работу с ним.
---

# Как начать работать с {{ mgp-short-name }}

Чтобы начать работу с сервисом:

1. [Создайте кластер](#create-cluster).
1. [Получите его идентификатор](#get-cluster-id).
1. [Подключитесь к кластеру](#connect).
1. [Создайте базу данных](#create-db).
1. [Выполните несколько запросов](#query-db).

Для подключения к кластеру и работы с базами данных будут использоваться:

* Графическая IDE [DBeaver](https://dbeaver.io/).
* Консольный клиент `psql`.

Некоторые другие инструменты для работы с {{ GP }} описаны в разделе [{#T}](./operations/connect.md).


## Перед началом работы {#before-you-begin}

1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь, если вы еще не зарегистрированы.
1. Если у вас еще нет каталога, создайте его:

    {% include [create-folder](../_includes/create-folder.md) %}

1. [Назначьте](../iam/operations/roles/grant.md) вашему аккаунту в {{ yandex-cloud }} роль [{{ roles-vpc-user }}](../vpc/security/index.md#vpc-user) и роль [{{ roles.mgp.editor }} или выше](security/index.md#roles-list). Эти роли позволяют создать кластер.

    {% include [note-managing-roles](../_includes/mdb/note-managing-roles.md) %}


## Создайте кластер {#create-cluster}

Создайте кластер {{ GP }} с публичным доступом. К такому кластеру можно [подключиться](./operations/connect.md) как с виртуальной машины {{ compute-full-name }}, так и через интернет.

Чтобы создать кластер:

1. В консоли управления выберите каталог, в котором нужно создать кластер БД.
1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
1. Нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_create }}**.


1. Укажите следующие параметры кластера:

    * **{{ ui-key.yacloud.mdb.forms.section_base }}** → **{{ ui-key.yacloud.mdb.forms.base_field_name }}** — имя кластера. Оно должно быть уникальным в рамках каталога.

    * **{{ ui-key.yacloud.mdb.forms.section_network-settings }}**:

        * **Сеть** — укажите [сеть](../vpc/concepts/network.md), в которой нужно разместить [хосты кластера](./concepts/index.md).
        * **{{ ui-key.yacloud.mdb.forms.field_security-group }}** — укажите [группы безопасности](../vpc/concepts/security-groups.md) для сетевого трафика кластера.

            [Настройте эти группы безопасности](./operations/connect.md#configuring-security-groups) так, чтобы можно было подключаться к кластеру через интернет.

        * **{{ ui-key.yacloud.mdb.forms.network_field_zone }}** — укажите зону доступности для хостов кластера.

        * **{{ ui-key.yacloud.mdb.forms.network_field_subnetwork }}** — укажите подсеть для хостов кластера.

        * **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}** — включите опцию.

    * **{{ ui-key.yacloud.mdb.forms.section_user }}**:

        * **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}** — имя пользователя-администратора. Имя может содержать латинские буквы, цифры, дефис и подчеркивание, но не может начинаться с дефиса. Длина от 1 до 32 символов.

            {% include [reserved-usernames-note](../_includes/mdb/mgp/reserved-usernames-note.md) %}

        * **{{ ui-key.yacloud.mdb.forms.database_field_user-password }}** — пароль пользователя-администратора. Длина от 8 до 128 символов.

        Пользователь-администратор — это специальный пользователь, который необходим для управления кластером и не может быть удален. Подробнее см. в разделе [{#T}](./concepts/cluster-users.md).

    * **{{ ui-key.yacloud.greenplum.section_resource-master }}** и **{{ ui-key.yacloud.greenplum.section_resource-segment }}** — конфигурация [хостов-мастеров и хостов-сегментов](./concepts/index.md) в кластере {{ GP }}.

        Измените настройки на этих вкладках, если конфигурация по умолчанию вам не подходит. Дополнительную информацию см. в разделе [{#T}](./operations/calculate-specs.md).

1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_create }}**.


1. Дождитесь, когда кластер будет готов к работе: его статус на панели {{ mgp-short-name }} сменится на **Running**, а состояние — на **Alive**. Это может занять некоторое время.

Подробнее о создании кластера см. в разделе [{#T}](./operations/cluster-create.md).

## Получите идентификатор кластера {#get-cluster-id}

Получите идентификатор кластера, который потребуется при [подключении](#connect):

1. В консоли управления перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
1. Нажмите на имя нужного кластера и выберите вкладку ![image](../_assets/console-icons/flag.svg) **{{ ui-key.yacloud.mdb.cluster.switch_overview }}**.
1. Скопируйте идентификатор кластера из блока **{{ ui-key.yacloud.common.section-base }}**.

## Подключитесь к кластеру {#connect}

После [создания кластера](#create-cluster) подключитесь к нему:

{% list tabs group=mgp-quickstart %}

- DBeaver {#gui}

    1. [Установите DBeaver](https://dbeaver.com/docs/dbeaver/Installation/) на хост, с которого будет выполняться подключение.

        {% note info %}

        Работа с кластером проверялась в DBeaver Community 24.2.3.

        {% endnote %}

    1. Запустите DBeaver.
    1. Выберите в меню **База данных** пункт **Новое соединение**.
    1. Выберите из списка БД **{{ GP }}**.
    1. Нажмите кнопку **Next**.
    1. Укажите основные параметры соединения на вкладке **Главное**:

        * В блоке **Server**:
            * **Connect by** — `Host`.
            * **Хост** — [особый FQDN первичного мастера](./operations/connect.md#fqdn-master): `c-<идентификатор_кластера>.rw.{{ dns-zone }}`.

                Идентификатор кластера [был получен ранее](#get-cluster-id).

            * **База данных** — `postgres`.
            * **Порт** — `{{ port-mgp }}`.
            * **Показать все базы данных** — включите опцию.

        * В блоке **Аутентификация**:
            * **Аутентификация** — `Database Native`.
            * **Пользователь** — имя пользователя-администратора, указанное при [создании кластера](#create-cluster).
            * **Пароль** — пароль пользователя-администратора.

                Если нужно, выключите опцию **Сохранить пароль** — эта опция включена по умолчанию.

    1. Нажмите кнопку **Тест соединения**.

        Если DBeaver предложит скачать файлы драйвера, то нажмите кнопку **Скачать**. Эти файлы могут отсутствовать, если ранее вы никогда не использовали DBeaver для подключения к {{ GP }}.

        {% include [dbeaver-connect](../_includes/mdb/mgp/quickstart/dbeaver-connect.md) %}

        При успешном подключении будет выведена информация о сервере {{ GP }} и о драйвере, который использовался для подключения. Нажмите кнопку **OK**.

        {% note warning %}

        {% include [ssl-default-mode](../_includes/mdb/mgp/quickstart/ssl-default-mode.md) %}

        В промышленной эксплуатации [подключайтесь к кластеру через SSL с проверкой подлинности хоста](./operations/connect.md#connection-ide).

        {% endnote %}

    1. (Опционально) На вкладке **Главное** нажмите кнопку **Описание соединения (название, тип, ...)** и укажите название и описание соединения.

        По умолчанию название соединения совпадает с указанным именем базы данных (`postgres`). Выберите другое название, чтобы избежать путаницы: с помощью этого соединения можно работать и с другими базами данных, а не только с `postgres`.

    1. Нажмите кнопку **Finish**.

        Созданное соединение появится на панели слева во вкладке **Базы данных**.

    1. Раскройте созданное соединение на панели слева во вкладке **Базы данных**.

        {% include [dbeaver-connect](../_includes/mdb/mgp/quickstart/dbeaver-connect.md) %}

    1. Выполните тестовый запрос:

        1. Раскройте папку **Базы данных**, затем раскройте контекстное меню базы данных `postgres` и выберите пункт **Редактор SQL** → **Open SQL console**.

            Откроется консоль, в которой можно выполнять SQL-запросы к базе `postgres`.

        1. Вставьте запрос в консоль:

            ```sql
            SELECT version();
            ```

        1. {% include [dbeaver-how-to-exec-query](../_includes/mdb/mgp/quickstart/dbeaver-how-to-exec-query.md) %}

- psql {#cli}

    1. [Установите](https://www.postgresql.org/download/) клиент `psql` на хост, с которого будет выполняться подключение.

        Например, чтобы установить `psql` на [виртуальную машину Linux](../compute/operations/vm-create/create-linux-vm.md) в {{ yandex-cloud }} c Ubuntu 24.04:

        
        1. Подключитесь к виртуальной машине по [{{ oslogin }}](../compute/operations/vm-connect/os-login.md) или [SSH](../compute/operations/vm-connect/ssh.md).


        1. Установите необходимые зависимости и клиент {{ PG }}:

            ```bash
            sudo apt update && sudo apt install postgresql-client --yes
            ```

    1. Подключитесь к базе данных `postgres` в кластере {{ GP }}. Используйте [особый FQDN первичного мастера](operations/connect.md#fqdn-master):

        ```bash
        psql "host=c-<идентификатор_кластера>.rw.{{ dns-zone }} \
          port={{ port-mgp }} \
          dbname=postgres \
          user=<имя_пользователя>"
        ```

        Идентификатор кластера [был получен ранее](#get-cluster-id).

        После выполнения команды введите пароль пользователя для завершения процедуры подключения.

        {% note warning %}

        {% include [ssl-default-mode](../_includes/mdb/mgp/quickstart/ssl-default-mode.md) %}

        В промышленной эксплуатации [подключайтесь к кластеру через SSL с проверкой подлинности хоста](./operations/connect.md#bash).

        {% endnote %}

    1. Выполните тестовый запрос:

        ```sql
        SELECT version();
        ```

{% endlist %}

При успешном подключении к кластеру и выполнении тестового запроса будет выведена версия {{ GP }}.

## Создайте базу данных {#create-db}

В [созданном ранее](#create-cluster) кластере {{ GP }} есть только одна база данных — служебная база данных `postgres`. Эта база не предназначена для хранения пользовательских данных: например, в такой базе нельзя создавать схемы данных (schemas).

После [подключения к кластеру](#connect) {{ GP }} создайте базу `sample_db` для хранения пользовательских данных:

{% list tabs group=mgp-quickstart %}

- DBeaver {#gui}

    1. Раскройте [созданное ранее соединение](#connect) на панели слева во вкладке **Базы данных**.

        {% include [dbeaver-connect](../_includes/mdb/mgp/quickstart/dbeaver-connect.md) %}

    1. Создайте базу данных:

        1. Раскройте папку **Базы данных**, затем раскройте контекстное меню базы данных `postgres` и выберите пункт **Редактор SQL** → **Open SQL console**.

            Откроется консоль, в которой можно выполнять SQL-запросы к базе `postgres`.

        1. Вставьте запрос в консоль:

            ```sql
            CREATE DATABASE sample_db;
            ```

        1. {% include [dbeaver-how-to-exec-query](../_includes/mdb/mgp/quickstart/dbeaver-how-to-exec-query.md) %}

    1. Обновите список баз данных, чтобы в нем появилась созданная база.

        Для этого раскройте контекстное меню папки **Базы данных** и выберите пункт **Refresh**.

        {% note tip %}

        Если база `sample_db` не появилась в списке, то проверьте, что для соединения [была включена опция](#connect) **Показать все базы данных**.

        {% endnote %}

- psql {#cli}

    1. Выполните запрос:

        ```sql
        CREATE DATABASE sample_db;
        ```

    1. Выведите список баз данных в кластере {{ GP }} и убедитесь, что в нем присутствует база `sample_db`:

        ```sql
        \list
        ```

{% endlist %}

## Выполните несколько запросов к базе данных {#query-db}

Чтобы подтвердить, что база данных [была создана](#create-db) корректно, выполните несколько запросов к ней:

{% list tabs group=mgp-quickstart %}

- DBeaver {#gui}

    1. Раскройте [созданное ранее соединение](#connect) на панели слева во вкладке **Базы данных**.

        {% include [dbeaver-connect](../_includes/mdb/mgp/quickstart/dbeaver-connect.md) %}

    1. Раскройте папку **Базы данных**, затем раскройте контекстное меню базы данных `sample_db` и выберите пункт **Редактор SQL** → **Open SQL console**.

        Откроется консоль, в которой можно выполнять SQL-запросы к базе `sample_db`.

    1. Создайте таблицу и наполните ее данными:

        1. Вставьте запросы в консоль:

            {% include [table-query](../_includes/mdb/mgp/quickstart/table-query.md) %}

        1. {% include [dbeaver-how-to-exec-query](../_includes/mdb/mgp/quickstart/dbeaver-how-to-exec-query.md) %}

        Таблица будет создана, а затем наполнена числами от 1 до 10000.

        Запросы `CREATE TABLE` и `INSERT INTO` не возвращают никаких результатов. DBeaver отобразит статистику по выполненным запросам, которая имеет вид:

        ```sql
        Queries         2
        Updated Rows    10000
        Execute time    ...
        Fetch time      ...
        Total time      ...
        Start time      ...
        Finish time     ...
        ```

    1. Получите сумму всех чисел в таблице. Для этого очистите консоль, вставьте запрос и выполните его:

        {% include [sum-query](../_includes/mdb/mgp/quickstart/sum-query.md) %}

    1. Получите информацию о том, как 10000 строк таблицы распределены по сегментам {{ GP }}. Для этого очистите консоль, вставьте запрос и выполните его:

        {% include [segment-query](../_includes/mdb/mgp/quickstart/segment-query.md) %}

    1. Завершите сеанс работы с соединением. Для этого раскройте контекстное меню соединения и выберите пункт **Отсоединиться**.

- psql {#cli}

    1. Убедитесь, что вы подключены к базе данных `sample_db`:

        ```sql
        SELECT current_database();
        ```

        Если запрос возвращает имя другой базы данных, например, `postgres`, подключитесь к нужной базе:

        ```sql
        \connect sample_db;
        ```

    1. Создайте таблицу и наполните ее данными:

        {% include [table-query](../_includes/mdb/mgp/quickstart/table-query.md) %}

        Таблица будет создана, а затем наполнена числами от 1 до 10000.

        Запросы `CREATE TABLE` и `INSERT INTO` не возвращают никаких результатов.

    1. Получите сумму всех чисел в таблице:

        {% include [sum-query](../_includes/mdb/mgp/quickstart/sum-query.md) %}

    1. Получите информацию о том, как 10000 строк таблицы распределены по сегментам {{ GP }}:

        {% include [segment-query](../_includes/mdb/mgp/quickstart/segment-query.md) %}

    1. Завершите сеанс работы с `psql`:

        ```sql
        \quit
        ```

{% endlist %}

## Что дальше {#whats-next}

* Изучите [концепции сервиса](./concepts/index.md).
* Узнайте подробнее о [создании кластера](./operations/cluster-create.md) и [подключении к кластеру](./operations/connect.md).

{% include [greenplum-trademark](../_includes/mdb/mgp/trademark.md) %}
