---
title: Начало работы с {{ mspqr-full-name }}
description: В этой инструкции вы научитесь создавать кластер {{ SPQR }} и подключаться к нему.
keywords:
  - keyword: первый кластер {{ mspqr-name }}
  - keyword: как создать шардированный кластер для PostgreSQL
  - keyword: SPQR
  - keyword: шардирование в PostgreSQL
  - keyword: шардированный PostgreSQL
  - keyword: шард PostgreSQL
---

# Как начать работать с {{ mspqr-name }}

{% include [preview](../_includes/note-service-preview.md) %}

Сервис {{ mspqr-name }} позволяет создавать и поддерживать кластеры шардированного {{ PG }} ([SPQR](https://pg-sharding.tech/welcome)) в инфраструктуре {{ yandex-cloud }}. {{ SPQR }} использует протокол {{ PG }}, поэтому настраивать правила шардирования и выполнять запросы к базе данных можно с помощью клиента `psql`. Настройка правил шардирования выполняется через консоль администратора (SPQR router admin console). При подключении к консоли администратора укажите имя пользователя `spqr-console` и имя базы данных `spqr-console`.

Чтобы начать работу с сервисом:

1. [Создайте кластер {{ SPQR }}](#cluster-create).
1. [Создайте шарды в кластере {{ SPQR }}](#shard-create).
1. [Настройте окружение](#setup_environment).
1. [Настройте правила шардирования](#setting-up-sharding).
1. [Отправьте запросы к БД](#query-db).

## Перед началом работы {#before-you-begin}

1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь, если вы еще не зарегистрированы.

1. Если у вас еще нет каталога, создайте его:

   {% include [create-folder](../_includes/create-folder.md) %}


1. [Назначьте](../iam/operations/roles/grant.md) вашему аккаунту в {{ yandex-cloud }} роли [{{ roles-vpc-user }}](../vpc/security/index.md#vpc-user) и `managed-spqr.editor` на каталог. Эти роли позволяют создать кластер.


   {% include [note-managing-roles](../_includes/mdb/note-managing-roles.md) %}

1. Подключаться к [кластерам](../glossary/cluster.md) БД можно как изнутри, так и извне {{ yandex-cloud }}:

   * Чтобы подключиться изнутри {{ yandex-cloud }}, создайте виртуальную машину на основе [Linux](../compute/quickstart/quick-create-linux.md) в той же облачной сети, что и кластер БД.

   * Чтобы подключиться к кластеру из интернета, включите публичный доступ к хостам при [создании кластера](#cluster-create).

   {% note info %}

    Следующий шаг предполагает, что подключение к кластеру производится с ВМ. Если вы собираетесь подключаться к кластеру из интернета, переходите к [созданию кластера](#cluster-create).

   {% endnote %}

1. [Подключитесь](../compute/operations/vm-connect/ssh.md) к ВМ по [SSH](../glossary/ssh-keygen.md).

## Создайте кластер {#cluster-create}

1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать кластер {{ SPQR }}.
1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}**.
1. Нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
1. В поле **{{ ui-key.yacloud.mdb.forms.base_field_name }}** введите имя кластера.
1. Выберите окружение `PRODUCTION`.

1. Выберите тип шардирования:

    * **{{ ui-key.yacloud.spqr.section_sharding-type-standard }}** — кластер будет состоять только из инфраструктурных хостов.
    * **{{ ui-key.yacloud.spqr.section_sharding-type-advanced }}** — кластер будет состоять только из хостов-роутеров и (опционально) хостов-координаторов.

1. В блоке **{{ ui-key.yacloud.mdb.forms.section_network }}**:

    * Выберите [созданную перед началом работы](#before-you-begin) облачную сеть.
    * Выберите группу безопасности по умолчанию или создайте новую.

1. Задайте конфигурацию вычислительных ресурсов:

    * Для стандартного шардирования задайте в блоке **{{ ui-key.yacloud.spqr.section_infra }}** конфигурацию инфраструктурных хостов.
    * Для расширенного шардирования задайте в блоке **{{ ui-key.yacloud.spqr.section_router }}** конфигурацию хостов-роутеров.

    Чтобы задать конфигурацию вычислительных ресурсов:

      1. Выберите [класс хостов](concepts/instance-types.md). Он определяет технические характеристики [виртуальных машин](../compute/concepts/vm.md), на которых будут развернуты [хосты](concepts/index.md) кластера.
      1. В блоке **{{ ui-key.yacloud.mdb.forms.section_storage }}**:

          1. Выберите [тип диска](concepts/storage.md#storage-type-selection).
          1. Задайте размер [хранилища](concepts/storage.md).

      1. В блоке **{{ ui-key.yacloud.spqr.section_hosts }}** укажите зоны доступности и подсети для хостов, которые будут созданы вместе с кластером.

         Если вы собираетесь подключаться к кластеру из интернета, включите для хостов опцию **{{ ui-key.yacloud.mdb.forms.host_column_assign_public_ip }}**.

1. (Опционально) В блоке **{{ ui-key.yacloud.spqr.section_coordinator }}** включите опцию **{{ ui-key.yacloud.spqr.field_coordinator }}** и задайте конфигурацию хостов-координаторов.

1. В блоке **{{ ui-key.yacloud.mdb.forms.section_database }}** укажите:

    * Имя БД. Оно должно быть уникальным в рамках каталога.
    * Имя пользователя — владельца БД.
    * Пароль.

1. В блоке **{{ ui-key.yacloud.mdb.forms.section_additional }}** укажите пароль для консоли {{ SPQR }}.
1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_create }}**.
1. Дождитесь, когда кластер будет готов к работе: его статус сменится на **Running**, а состояние — на **Alive**. Чтобы проверить состояние, наведите курсор на статус кластера в столбце **{{ ui-key.yacloud.common.availability }}**.

## Создайте шарды в кластере {#shard-create}

Создайте два шарда в кластере {{ mspqr-name }}. Чтобы создать шард:

1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором [создан](#cluster-create) кластер {{ SPQR }}.
1. [Cоздайте кластер](../managed-postgresql/operations/cluster-create.md#create-cluster) {{ mpg-name }} в той же облачной сети, что и кластер {{ SPQR }}.
1. Откройте ваш кластер {{ SPQR }} и перейдите на вкладку ![image](../_assets/console-icons/copy-transparent.svg) **{{ ui-key.yacloud.mdb.cluster.shards.label_title }}**.
1. В правом верхнем углу страницы нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.shards.action_add-shard }}**.
1. В открывшемся окне:

   1. Задайте **{{ ui-key.yacloud.common.name }}** шарда.
   1. В поле **Кластер Managed Service for PostgreSQL** выберите созданный ранее кластер {{ PG }}.

      Кластер {{ mpg-name }} должен находиться в том же каталоге и в той же облачной сети, что и кластер {{ mspqr-name }}.


{% note warning %}

Убедитесь, что роутер может подключаться к хостам шарда. Для этого шарды и кластер {{ mspqr-name }} должны находиться в одной [группе безопасности](../vpc/concepts/security-groups.md), разрешающей входящие и исходящие TCP-подключения на порт `6432`.

{% endnote %}


## Настройте окружение {#setup_environment}

{% list tabs group=operating_system %}

- Linux (Bash)/macOS (Zsh) {#linux-macos}

    1. Получите SSL-сертификат:

        ```bash
        mkdir -p ~/.postgresql && \
        wget "{{ crt-web-path }}" \
                --output-document ~/.postgresql/root.crt && \
        chmod 0655 ~/.postgresql/root.crt
        ```

        Сертификат будет сохранен в файле `~/.postgresql/root.crt`.

    1. Установите необходимые зависимости и клиент {{ PG }}:

        ```bash
        sudo apt update && sudo apt install -y postgresql-client
        ```

- Windows (PowerShell) {#windows}

    1. Установите [{{ PG }} для Windows](https://www.postgresql.org/download/windows/) последней версии. Выберите только установку _Command Line Tools_.

    1. Получите SSL-сертификат:

        ```powershell
        mkdir $HOME\.postgresql; curl.exe -o $HOME\.postgresql\root.crt {{ crt-web-path }}
        ```

        Сертификат будет сохранен в файле `$HOME\.postgresql\root.crt`.

{% endlist %}

## Настройте правила шардирования {#setting-up-sharding}


{% note warning %}

Если вы используете группы безопасности для облачной сети, [настройте их](operations/connect.md#configuring-security-groups) так, чтобы был разрешен весь необходимый трафик между кластером и хостом, с которого выполняется подключение.

{% endnote %}


1. Подключитесь к консоли администратора:

    {% list tabs group=operating_system %}

    - Linux (Bash)/macOS (Zsh) {#linux-macos}

      ```bash
      psql "host=<FQDN_хоста> \
           port={{ port-mpg }} \
           sslmode=verify-full \
           sslrootcert=~/.postgresql/root.crt \
           dbname=spqr-console \
           user=spqr-console"
      ```

      [Подробнее о подключении к кластеру {{ mspqr-name }}](operations/connect.md).

    - Windows (PowerShell) {#windows}

      ```powershell
      & "C:\Program Files\PostgreSQL\<мажорная_версия_{{ PG }}>\bin\psql.exe" `
          --host=<FQDN_хоста> `
          --port={{ port-mpg }} `
          --username=spqr-console `
          --dbname=spqr-console `
          --set=sslmode=verify-full `
          --set=sslrootcert=$HOME\.postgresql\root.crt
      ```

      [Подробнее о подключении к кластеру {{ mspqr-name }}](operations/connect.md).

    {% endlist %}

1. Создайте правило шардирования:

    ```sql
    CREATE DISTRIBUTION ds1 COLUMN TYPES int;
    ```

    Будет создано правило шардирования с именем `ds1` для столбцов типа `int`.

1. Привяжите таблицу к правилу и укажите [ключ шардирования](concepts/sharding-keys.md):

    ```sql
    ALTER DISTRIBUTION ds1 ATTACH RELATION customers DISTRIBUTION KEY id;
    ```

    Таблица `customers` будет привязана к правилу `ds1`. Ключ шардирования для таблицы `customers` — столбец `id`.

1. Создайте диапазоны значений ключа для распределения данных по шардам:

    ```sql
    CREATE KEY RANGE krid2 FROM 1000 ROUTE TO <имя_шарда_2> FOR DISTRIBUTION ds1;
    CREATE KEY RANGE krid1 FROM 1 ROUTE TO <имя_шарда_1> FOR DISTRIBUTION ds1;
    ```

    {% note warning %}

    Создавайте диапазоны значений ключа, начиная с наибольшего значения. Нарушение этого порядка приведет к ошибке `key range krid2 intersects with key range krid1 in QDB`. Для диапазона с наибольшим значением ключа правая граница будет равна бесконечности.

    {% endnote %}

1. Чтобы выйти из консоли администратора, выполните команду `\q`.

## Отправьте запросы к БД {#query-db}

1. Подключитесь к БД:

    {% list tabs group=operating_system %}

    - Linux (Bash)/macOS (Zsh) {#linux-macos}

      ```bash
      psql "host=<FQDN_хоста> \
           port={{ port-mpg }} \
           sslmode=verify-full \
           sslrootcert=~/.postgresql/root.crt \
           dbname=<имя_БД> \
           user=<имя_пользователя> \
           target_session_attrs=read-write"
      ```

      [Подробнее о подключении к кластеру {{ mspqr-name }}](operations/connect.md).

    - Windows (PowerShell) {#windows}

      ```powershell
      & "C:\Program Files\PostgreSQL\<мажорная_версия_{{ PG }}>\bin\psql.exe" `
          --host=<FQDN_хоста> `
          --port={{ port-mpg }} `
          --username=<имя_пользователя> `
          --dbname=<имя_БД> `
          --set=target_session_attrs=read-write `
          --set=sslmode=verify-full `
          --set=sslrootcert=$HOME\.postgresql\root.crt
      ```

      [Подробнее о подключении к кластеру {{ mspqr-name }}](operations/connect.md).

    {% endlist %}

1. Создайте таблицу `customers`:

    ```sql
    CREATE TABLE customers (
        id INT,
        name VARCHAR,
        phone VARCHAR,
        acctbal NUMERIC
    );
    ```

1. Начните транзакцию:

    ```sql
    BEGIN;
    ```

1. Добавьте строки:

    1. Добавьте строку в шард с диапазоном значений `krid1`:

        ```sql
        INSERT INTO customers (id, name, phone, acctbal) VALUES (28, 'Иван Иванов', '123-45-67', 1500.50);
        ```

    1. Добавьте строку в шард с диапазоном значений `krid2`:

        ```sql
        INSERT INTO customers (id, name, phone, acctbal) VALUES (3200, 'Дмитрий Кузнецов', '555-66-77', -50.75);
        ```

1. Завершите транзакцию:

    ```sql
    COMMIT;
    ```

1. Посмотрите строки, указав значение ключа в запросе, например:

    ```sql
    SELECT * FROM customers WHERE id = 28;
    ```

    Запрос `SELECT * FROM customers;` приведет к ошибке, так как строки распределены по разным шардам. Одновременно можно получить строки только с одного шарда. Чтобы проверить распределение строк по шардам, [подключитесь к каждому шарду](../managed-postgresql/operations/connect.md) и посмотрите добавленные записи.

1. Чтобы выйти из базы данных, выполните команду `\q`.

## Что дальше {#whats-next}

* Изучите [концепции сервиса](concepts/index.md).
* Узнайте подробнее о [создании кластера](operations/cluster-create.md) и [подключении к БД](operations/connect.md).
