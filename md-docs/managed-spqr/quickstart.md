# Как начать работать с Managed Service for Sharded PostgreSQL

{% note info %}

Сервис находится на стадии [Preview](../overview/concepts/launch-stages.md).

{% endnote %}

Сервис Managed Service for Sharded PostgreSQL позволяет создавать и поддерживать кластеры шардированного PostgreSQL ([SPQR](https://pg-sharding.tech/welcome)) в инфраструктуре Yandex Cloud. Sharded PostgreSQL использует протокол PostgreSQL, поэтому настраивать правила шардирования и выполнять запросы к базе данных можно с помощью клиента `psql`. Настройка правил шардирования выполняется через консоль администратора (SPQR router admin console). При подключении к консоли администратора укажите имя пользователя `spqr-console` и имя базы данных `spqr-console`.

Чтобы начать работу с сервисом:

1. [Создайте кластер Sharded PostgreSQL](#cluster-create).
1. [Создайте шарды в кластере Sharded PostgreSQL](#shard-create).
1. [Настройте окружение](#setup_environment).
1. [Настройте правила шардирования](#setting-up-sharding).
1. [Отправьте запросы к БД](#query-db).

## Перед началом работы {#before-you-begin}

1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь, если вы еще не зарегистрированы.

1. Если у вас еще нет каталога, создайте его:

   1. В [консоли управления](https://console.yandex.cloud) на панели сверху нажмите ![image](../_assets/console-icons/layout-side-content-left.svg) или ![image](../_assets/console-icons/chevron-down.svg) и выберите нужное [облако](../resource-manager/concepts/resources-hierarchy.md#cloud).
   1. Справа от названия облака нажмите ![image](../_assets/console-icons/ellipsis.svg).
   1. Выберите ![image](../_assets/console-icons/plus.svg) **Создать каталог**.
   
      ![create-folder1](../_assets/resource-manager/create-folder-1.png)
   
   1. Введите имя [каталога](../resource-manager/concepts/resources-hierarchy.md#folder). Требования к имени:
   
       * длина — от 3 до 63 символов;
       * может содержать строчные буквы латинского алфавита, цифры и дефисы;
       * первый символ — буква, последний — не дефис.
   
   1. (Опционально) Введите описание каталога.
   1. Выберите опцию **Создать сеть по умолчанию**. Будет создана [сеть](../vpc/concepts/network.md#network) с подсетями в каждой зоне доступности. Также в этой сети будет создана [группа безопасности по умолчанию](../vpc/concepts/security-groups.md#default-security-group), внутри которой весь сетевой трафик разрешен.
   1. Нажмите кнопку **Создать**.
   
      ![create-folder2](../_assets/resource-manager/create-folder-2.png)


1. [Назначьте](../iam/operations/roles/grant.md) вашему аккаунту в Yandex Cloud роли [vpc.user](../vpc/security/index.md#vpc-user) и `managed-spqr.editor` на каталог. Эти роли позволяют создать кластер.


   {% note info %}
   
   Если вы не можете управлять ролями, обратитесь к администратору вашего облака или организации.
   
   {% endnote %}

1. Подключаться к [кластерам](../glossary/cluster.md) БД можно как изнутри, так и извне Yandex Cloud:

   * Чтобы подключиться изнутри Yandex Cloud, создайте виртуальную машину на основе [Linux](../compute/quickstart/quick-create-linux.md) в той же облачной сети, что и кластер БД.

   * Чтобы подключиться к кластеру из интернета, включите публичный доступ к хостам при [создании кластера](#cluster-create).

   {% note info %}

    Следующий шаг предполагает, что подключение к кластеру производится с ВМ. Если вы собираетесь подключаться к кластеру из интернета, переходите к [созданию кластера](#cluster-create).

   {% endnote %}

1. [Подключитесь](../compute/operations/vm-connect/ssh.md) к ВМ по [SSH](../glossary/ssh-keygen.md).

## Создайте кластер {#cluster-create}

1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором нужно создать кластер Sharded PostgreSQL.
1. [Перейдите](../console/operations/select-service.md#select-service) в сервис **Yandex Managed Service for Sharded&nbsp;PostgreSQL**.
1. Нажмите кнопку **Создать кластер**.
1. В поле **Имя кластера** введите имя кластера.
1. Выберите окружение `PRODUCTION`.

1. Выберите тип шардирования:

    * **Стандартное** — кластер будет состоять только из инфраструктурных хостов.
    * **Расширенное** — кластер будет состоять только из хостов-роутеров и (опционально) хостов-координаторов.

1. В блоке **Сетевые настройки**:

    * Выберите [созданную перед началом работы](#before-you-begin) облачную сеть.
    * Выберите группу безопасности по умолчанию или создайте новую.

1. Задайте конфигурацию вычислительных ресурсов:

    * Для стандартного шардирования задайте в блоке **Инфраструктура** конфигурацию инфраструктурных хостов.
    * Для расширенного шардирования задайте в блоке **Роутер** конфигурацию хостов-роутеров.

    Чтобы задать конфигурацию вычислительных ресурсов:

      1. Выберите [класс хостов](concepts/instance-types.md). Он определяет технические характеристики [виртуальных машин](../compute/concepts/vm.md), на которых будут развернуты [хосты](concepts/index.md) кластера.
      1. В блоке **Хранилище**:

          1. Выберите [тип диска](concepts/storage.md#storage-type-selection).
          1. Задайте размер [хранилища](concepts/storage.md).

      1. В блоке **Хосты** укажите зоны доступности и подсети для хостов, которые будут созданы вместе с кластером.

         Если вы собираетесь подключаться к кластеру из интернета, включите для хостов опцию **Публичный доступ**.

1. (Опционально) В блоке **Координатор** задайте конфигурацию хостов-координаторов.

1. В блоке **База данных** укажите параметры БД, в которой можно выполнять запросы к таблицам на шардах:

    * Имя БД. Оно должно быть уникальным в рамках каталога.
    * Имя пользователя — владельца БД.
    * Пароль.

1. В блоке **Дополнительные настройки** укажите пароль для консоли Sharded PostgreSQL, в которой можно настраивать правила шардирования. [Подробнее о консоли Sharded PostgreSQL](https://docs.pg-sharding.tech/sharding/console/how_to_connect).
1. Нажмите кнопку **Создать кластер**.
1. Дождитесь, когда кластер будет готов к работе: его статус сменится на **Running**, а состояние — на **Alive**. Чтобы проверить состояние, наведите курсор на статус кластера в столбце **Доступность**.

## Создайте шарды в кластере {#shard-create}

Создайте два шарда в кластере Managed Service for Sharded PostgreSQL. Чтобы создать шард:

1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором [создан](#cluster-create) кластер Sharded PostgreSQL.
1. [Создайте кластер](../managed-postgresql/operations/cluster-create.md#create-cluster) Managed Service for PostgreSQL в той же облачной сети, что и кластер Sharded PostgreSQL.
1. Откройте ваш кластер Sharded PostgreSQL и перейдите на вкладку ![image](../_assets/console-icons/copy-transparent.svg) **Шарды**.
1. В правом верхнем углу страницы нажмите кнопку **Создать шард**.
1. В открывшемся окне:

   1. Задайте **Имя** шарда.
   1. В поле **Кластер Managed Service for PostgreSQL** выберите созданный ранее кластер PostgreSQL.

      Кластер Managed Service for PostgreSQL должен находиться в том же каталоге и в той же облачной сети, что и кластер Managed Service for Sharded PostgreSQL.


{% note warning %}

Убедитесь, что роутер может подключаться к хостам шарда. Для этого шарды и кластер Managed Service for Sharded PostgreSQL должны находиться в одной [группе безопасности](../vpc/concepts/security-groups.md), разрешающей входящие и исходящие TCP-подключения на порт `6432`.

{% endnote %}


## Настройте окружение {#setup_environment}

{% list tabs group=operating_system %}

- Linux (Bash)/macOS (Zsh) {#linux-macos}

    1. Получите SSL-сертификат:

        ```bash
        mkdir -p ~/.postgresql && \
        wget "https://storage.yandexcloud.net/cloud-certs/CA.pem" \
                --output-document ~/.postgresql/root.crt && \
        chmod 0655 ~/.postgresql/root.crt
        ```

        Сертификат будет сохранен в файле `~/.postgresql/root.crt`.

    1. Установите необходимые зависимости и клиент PostgreSQL:

        ```bash
        sudo apt update && sudo apt install -y postgresql-client
        ```

- Windows (PowerShell) {#windows}

    1. Установите [PostgreSQL для Windows](https://www.postgresql.org/download/windows/) последней версии. Выберите только установку _Command Line Tools_.

    1. Получите SSL-сертификат:

        ```powershell
        mkdir $HOME\.postgresql; curl.exe -o $HOME\.postgresql\root.crt https://storage.yandexcloud.net/cloud-certs/CA.pem
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
           port=6432 \
           sslmode=verify-full \
           sslrootcert=~/.postgresql/root.crt \
           dbname=spqr-console \
           user=spqr-console"
      ```

      [Подробнее о подключении к кластеру Managed Service for Sharded PostgreSQL](operations/connect.md).

    - Windows (PowerShell) {#windows}

      ```powershell
      & "C:\Program Files\PostgreSQL\<мажорная_версия_PostgreSQL>\bin\psql.exe" `
          --host=<FQDN_хоста> `
          --port=6432 `
          --username=spqr-console `
          --dbname=spqr-console `
          --set=sslmode=verify-full `
          --set=sslrootcert=$HOME\.postgresql\root.crt
      ```

      [Подробнее о подключении к кластеру Managed Service for Sharded PostgreSQL](operations/connect.md).

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
           port=6432 \
           sslmode=verify-full \
           sslrootcert=~/.postgresql/root.crt \
           dbname=<имя_БД> \
           user=<имя_пользователя> \
           target_session_attrs=read-write"
      ```

      [Подробнее о подключении к кластеру Managed Service for Sharded PostgreSQL](operations/connect.md).

    - Windows (PowerShell) {#windows}

      ```powershell
      & "C:\Program Files\PostgreSQL\<мажорная_версия_PostgreSQL>\bin\psql.exe" `
          --host=<FQDN_хоста> `
          --port=6432 `
          --username=<имя_пользователя> `
          --dbname=<имя_БД> `
          --set=target_session_attrs=read-write `
          --set=sslmode=verify-full `
          --set=sslrootcert=$HOME\.postgresql\root.crt
      ```

      [Подробнее о подключении к кластеру Managed Service for Sharded PostgreSQL](operations/connect.md).

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

    Запрос `SELECT * FROM customers;` приведет к ошибке, так как строки распределены по разным шардам. Одновременно можно получить строки только с одного шарда. Чтобы проверить распределение строк по шардам, [подключитесь к каждому шарду](../managed-postgresql/operations/connect/index.md) и посмотрите добавленные записи.

1. Чтобы выйти из базы данных, выполните команду `\q`.

## Что дальше {#whats-next}

* Изучите [концепции сервиса](concepts/index.md).
* Узнайте подробнее о [создании кластера](operations/cluster-create.md) и [подключении к БД](operations/connect.md).