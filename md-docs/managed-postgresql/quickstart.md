# Как начать работать с Managed Service for PostgreSQL

Сервис Managed Service for PostgreSQL помогает создавать и поддерживать кластеры PostgreSQL в инфраструктуре Yandex Cloud.

Чтобы начать работу с сервисом:


1. [Создайте кластер БД](#cluster-create).
1. [Подключитесь к БД](#connect).
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

1. [Назначьте](../iam/operations/roles/grant.md) вашему аккаунту в Yandex Cloud роли [vpc.user](../vpc/security/index.md#vpc-user) и [managed-postgresql.editor](security/index.md#managed-postgresql-editor) на каталог. Эти роли позволяют создать кластер.

    {% note info %}
    
    Если вы не можете управлять ролями, обратитесь к администратору вашего облака или организации.
    
    {% endnote %}

1. Подключаться к [кластерам](../glossary/cluster.md) БД можно как изнутри, так и извне Yandex Cloud:

   * Чтобы подключиться изнутри Yandex Cloud, создайте виртуальную машину на основе [Linux](../compute/quickstart/quick-create-linux.md) в той же облачной сети, что и кластер БД.

   * Чтобы подключиться к кластеру из интернета, запросите публичный доступ к хостам при [создании кластера](#cluster-create).

   {% note info %}

   Следующий шаг предполагает, что подключение к кластеру производится с ВМ. Если вы собираетесь подключаться к кластеру из интернета, переходите к [созданию кластера](#cluster-create).

   {% endnote %}

1. [Подключитесь](../compute/operations/vm-connect/ssh.md) к ВМ по [SSH](../glossary/ssh-keygen.md).


## Создайте кластер {#cluster-create}

1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором нужно создать кластер БД.
1. [Перейдите](../console/operations/select-service.md#select-service) в сервис **Managed Service for&nbsp;PostgreSQL**.
1. Нажмите кнопку **Создать кластер**.
1. В поле **Имя кластера** введите имя кластера.
1. Выберите окружение `PRODUCTION`.
1. Выберите версию PostgreSQL.
1. Выберите [класс хостов](concepts/instance-types.md). Он определяет технические характеристики [виртуальных машин](../compute/concepts/vm.md), на которых будут развернуты [хосты](concepts/index.md) кластера.
1. В блоке **Хранилище**:

    1. Выберите [тип диска](concepts/storage.md#storage-type-selection).
    1. Задайте размер [хранилища](concepts/storage.md).

1. В блоке **База данных**:

    1. Укажите имя БД. Оно должно быть уникальным в рамках каталога.
    1. Укажите имя пользователя — владельца БД.
    1. Введите пароль или сгенерируйте его с помощью [Connection Manager](../metadata-hub/concepts/connection-manager.md).

1. В блоке **Сетевые настройки**:

    1. Выберите [созданную перед началом работы](#before-you-begin) облачную сеть.
    1. Выберите группу безопасности по умолчанию или создайте новую.

1. В блоке **Хосты** укажите зоны доступности и подсети для хостов, которые будут созданы вместе с кластером.

   Если вы собираетесь подключаться к кластеру из интернета, включите для хостов опцию **Публичный доступ**.

1. Нажмите кнопку **Создать кластер**.

1. Дождитесь, когда кластер будет готов к работе: его статус сменится на **Running**, а состояние — на **Alive**. Чтобы проверить состояние, наведите курсор на статус кластера в столбце **Доступность**.


## Подключитесь к БД {#connect}

{% note warning %}

Если вы используете группы безопасности для облачной сети, [настройте их](operations/connect/index.md#configuring-security-groups) так, чтобы был разрешен весь необходимый трафик между кластером и хостом, с которого выполняется подключение.

{% endnote %}

Чтобы подключиться к БД:

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

    1. Подключитесь к БД:

        ```bash
        psql "host=<список_хостов_кластера> \
              port=6432 \
              sslmode=verify-full \
              dbname=<имя_БД> \
              user=<имя_пользователя> \
              target_session_attrs=read-write"
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](operations/cluster-list.md#list-clusters).

- Windows (PowerShell) {#windows}

    1. Установите [PostgreSQL для Windows](https://www.postgresql.org/download/windows/) той же версии, которая используется в кластере. Выберите только установку _Command Line Tools_.

    1. Получите SSL-сертификат:

        ```powershell
        mkdir $HOME\.postgresql; curl.exe -o $HOME\.postgresql\root.crt https://storage.yandexcloud.net/cloud-certs/CA.pem
        ```

        Сертификат будет сохранен в файле `$HOME\.postgresql\root.crt`.

    1. Установите переменные окружения для подключения:

        ```powershell
        $Env:PGSSLMODE="verify-full"; $Env:PGTARGETSESSIONATTRS="read-write"
        ```

    1. Подключитесь к БД:

        ```powershell
        & "C:\Program Files\PostgreSQL\<мажорная_версия_PostgreSQL>\bin\psql.exe" `
            --host=c-<идентификатор_кластера>.rw.mdb.yandexcloud.net `
            --port=6432 `
            --username=<имя_пользователя> `
            <имя_БД>
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](operations/cluster-list.md#list-clusters).

{% endlist %}

## Отправьте запросы к БД {#query-db}

1. Создайте таблицу `customers` в БД кластера:

    ```sql
    CREATE TABLE IF NOT EXISTS customers (
        name VARCHAR,
        phone VARCHAR,
        acctbal NUMERIC
    );
    ```

1. Наполните таблицу данными:

    ```sql
    INSERT INTO customers (name, phone, acctbal) VALUES
        ('Иван Иванов', '123-45-67', 1500.50),
        ('Мария Смирнова', '222-33-44', 3250.00),
        ('Дмитрий Кузнецов', '555-66-77', -50.75),
        ('Анна Орлова', '111-22-33', 0.00),
        ('Павел Сидоров', '444-55-66', 780.30);
    ```

1. Запросите количество строк в таблице:

    ```sql
    SELECT COUNT(*) FROM customers;
    ```

    Результат:

    ```sql
    count
    -------
        5
    (1 row)
    ```


## Что дальше {#whats-next}

* [Перенесите данные](../data-transfer/tutorials/managed-postgresql.md#quick-transfer) в БД кластера.
* Изучите [концепции сервиса](concepts/index.md).
* Узнайте больше о [создании кластера](operations/cluster-create.md) и [подключении к БД](operations/connect/index.md).
* Ознакомьтесь с [практическими руководствами](tutorials/index.md) по работе с сервисом.
* Ознакомьтесь с [вопросами и ответами](qa/general.md).