# Миграция базы данных из стороннего кластера {{ MY }} в кластер {{ mmy-full-name }}

Перенести данные из стороннего _кластера-источника_ в _кластер-приемник_ {{ mmy-name }} можно двумя способами:

* [Перенос данных с использованием сервиса {{ data-transfer-full-name }}](#data-transfer).

    Этот способ прост в настройке, не требует создания промежуточной виртуальной машины и позволяет перенести базу целиком без остановки обслуживания пользователей. Для его использования разрешите подключение к кластеру-источнику из интернета.

    Подробнее см. в разделе [{#T}](../../data-transfer/concepts/use-cases.md).

* [Перенос данных через создание и восстановление логического дампа](#logical-dump).

    _Логический дамп_ — файл с набором команд, последовательное выполнение которых позволяет восстановить состояние базы данных. Чтобы обеспечить полноту логического дампа, перед его созданием кластер-источник следует перевести в режим <q>только чтение</q>.

    Используйте этот способ только в том случае, если перенос данных с помощью {{ data-transfer-name }} по каким-либо причинам невозможен.

## Перенос данных с использованием сервиса {{ data-transfer-name }} {#data-transfer}

{% include notitle [Migration with Data Transfer](../../_tutorials/datatransfer/managed-mysql.md) %}

## Перенос данных через создание и восстановление логического дампа {#logical-dump}

Чтобы перенести данные в кластер {{ mmy-name }}, создайте логический дамп нужной базы и восстановите его в кластере-приемнике. Это можно сделать двумя способами:

* С помощью [утилит](https://github.com/mydumper/mydumper) `mydumper` и `myloader`. Дамп базы создается в виде набора файлов в отдельном каталоге.
* С помощью утилит `mysqldump` и `mysql`. Дамп базы создается в виде одного файла.

Этапы миграции:

1. [Создайте дамп](#dump) переносимой базы.
1. (Опционально) [Загрузите дамп на промежуточную виртуальную машину](#vm-load) в {{ yandex-cloud }}.

    Переносить данные на промежуточную виртуальную машину в {{ compute-full-name }} нужно, если:

    * К вашему кластеру {{ mmy-name }} нет доступа из интернета.
    * Ваше оборудование или соединение с кластером в {{ yandex-cloud }} недостаточно надежны.

    Чем больше объем переносимых данных и необходимая скорость переноса, тем выше требования к виртуальной машине: числу ядер процессора, оперативной памяти и дисковому пространству.

1. [Восстановите данные из дампа](#restore).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

### Перед началом работы {#before-you-begin}

Создайте необходимые ресурсы:

{% list tabs %}

* Вручную

    1. [Создайте кластер-приемник {{ mmy-name }}](../../managed-mysql/operations/cluster-create.md) любой подходящей конфигурации. При этом:

        * Версия {{ MY }} должна быть не ниже чем в кластере-источнике.

            Перенос данных с повышением мажорной версии {{ MY }} возможен, но не гарантируется. Подробнее см. в [документации {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/faqs-migration.html).

            Миграция с понижением версии {{ MY }} [невозможна](https://dev.mysql.com/doc/refman/8.0/en/downgrading.html).

        * [Режим SQL](../../managed-mysql/concepts/settings-list.md#setting-sql-mode) должен быть таким же, как и в кластере-источнике.

    1. (Опционально) {% if audience != "internal" %}[Создайте виртуальную машину](../../compute/operations/vm-create/create-linux-vm.md){% else %}Создайте виртуальную машину{% endif %} на базе [Ubuntu 20.04 LTS](/marketplace/products/yc/ubuntu-20-04-lts) со следующими параметрами:

        * **Диски и файловые хранилища** → **Размер** — достаточный для хранения распакованного и нераспакованного дампов.

            Рекомендуется использовать объем в два или более раза превышающий суммарный объем дампа и архива с ним.

        * **Сетевые настройки**:

            * **Подсеть** — выберите подсеть в той же облачной сети, в которой размещен кластер-приемник.
            * **Публичный адрес** — выберите `Автоматически` или один адрес из списка зарезервированных IP-адресов.

    {% if audience != "internal" %}

    1. Если вы используете группы безопасности для промежуточной виртуальной машины и кластера {{ mmy-name }}, [настройте их](../../managed-mysql/operations/connect.md#configure-security-groups).

        {% include [preview-pp.md](../../_includes/preview-pp.md) %}

    {% endif %}

* С помощью Terraform

    1. Если у вас еще нет {{ TF }}, {% if audience != "internal" %}[установите и настройте его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform){% else %}установите и настройте его{% endif %}.
    1. Скачайте [файл с настройками провайдера](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Поместите его в отдельную рабочую директорию и {% if audience != "internal" %}[укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider){% else %}укажите значения параметров{% endif %}.
    1. Скачайте в ту же рабочую директорию файл конфигурации [data-migration-mysql-mmy.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/data-migration-mysql-mmy/data-migration-mysql-mmy.tf).

        В этом файле описаны:

        * {% if audience != "internal" %}[сеть](../../vpc/concepts/network.md#network){% else %}сеть{% endif %};
        * {% if audience != "internal" %}[подсеть](../../vpc/concepts/network.md#subnet){% else %}подсеть{% endif %};
        * {% if audience != "internal" %}[группа безопасности](../../vpc/concepts/security-groups.md){% else %}группа безопасности{% endif %} и правило, необходимое для подключения к кластеру;
        * кластер {{ mmy-name }} с публичным доступом из интернета;
        * (опционально) виртуальная машина с публичным доступом из интернета.

    1. Укажите в файле `data-migration-mysql-mmy.tf`:

        * параметры кластера-приемника:

            * `target_mysql_version` — версия {{ MY }}, она должна быть не ниже чем в кластере-источнике;
            * `target_sql_mode` — [режим SQL](../../managed-mysql/concepts/settings-list.md#setting-sql-mode), он должен быть таким же, как и в кластере-источнике;
            * `target_db_name` — имя базы данных;
            * `target_user` и `target_password` — имя и пароль пользователя-владельца базы данных.

        * (опционально) параметры виртуальной машины:

            * `vm_image_id` — идентификатор публичного {% if audience != "internal" %}[образа](../../compute/operations/images-with-pre-installed-software/get-list){% else %}образа{% endif %} с Ubuntu без {% if lang == "ru" and audience != "internal" %}[GPU](../../glossary/gpu.md){% else %}GPU{% endif %}. Например, для [Ubuntu 20.04 LTS](/marketplace/products/yc/ubuntu-20-04-lts).
            * `vm_username` и `vm_public_key` — логин и абсолютный путь к {% if audience != "internal" %}[публичному ключу](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys){% else %}публичному ключу{% endif %}, которые будут использоваться для доступа к виртуальной машине. По умолчанию в образе [Ubuntu 20.04 LTS](/marketplace/products/yc/ubuntu-20-04-lts) указанный логин игнорируется, вместо него создается пользователь с логином `ubuntu`. Используйте его для подключения к виртуальной машине.

    1. Выполните команду `terraform init` в директории с конфигурационным файлом. Эта команда инициализирует провайдер, указанный в конфигурационных файлах, и позволяет работать с ресурсами и источниками данных провайдера.
    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Создайте необходимую инфраструктуру:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

### Создание дампа {#dump}

{% list tabs %}

* С использованием утилиты mysqldump

    1. Переключите базу в режим <q>только чтение</q>, чтобы не потерять данные, которые могут появиться во время создания дампа.

    1. Установите утилиту `mysqldump` в кластер-источник, например (для Ubuntu):

        ```bash
        sudo apt update && sudo apt install mysql-client --yes
        ```

    1. Создайте дамп базы данных:

        ```bash
        mysqldump \
            --host=<FQDN или IP-адрес хоста-мастера в кластере-источнике> \
            --user=<имя пользователя> \
            --password \
            --port=<порт> \
            --set-gtid-purged=OFF \
            --quick \
            --single-transaction \
            <имя базы данных> > ~/db_dump.sql
        ```

        При необходимости передайте в команде создания дампа дополнительные параметры:

        * `--events` — если в вашей базе есть периодические события;
        * `--routines` — если в вашей базе есть хранимые процедуры и функции.

        Для таблиц InnoDB используйте опцию `--single-transaction`: она гарантирует целостность данных.

    1. В файле дампа исправьте имена движков таблиц на `InnoDB`:

        ```bash
        sed -i -e 's/MyISAM/InnoDB/g' -e 's/MEMORY/InnoDB/g' db_dump.sql
        ```

    1. Упакуйте дамп в архив:

        ```bash
        tar -cvzf db_dump.tar.gz ~/db_dump.sql
        ```

* С использованием утилиты mydumper

    1. Переключите базу в режим <q>только чтение</q>, чтобы не потерять данные, которые могут появиться во время создания дампа.

    1. Создайте директорию для файлов дампа:

        ```bash
        mkdir db_dump
        ```

    1. Установите утилиту `mydumper` в кластер-источник, например (для Ubuntu):

        ```bash
        sudo apt update && sudo apt install mydumper --yes
        ```

    1. Создайте дамп базы данных:

        ```bash
        mydumper \
            --triggers \
            --events \
            --routines \
            --outputdir=db_dump \
            --rows=10000000 \
            --threads=8 \
            --compress \
            --database=<имя базы данных> \
            --user=<имя пользователя> \
            --ask-password \
            --host=<FDQN или IP-адрес хоста-мастера в кластере-источнике>
        ```

        Где:

        * `--triggers` — дамп триггеров.
        * `--events` — дамп событий.
        * `--routines` — дамп хранимых процедур и функций.
        * `--outputdir` — директория для файлов дампа.
        * `--rows` — количество строк во фрагментах, на которые будут разбиты таблицы. Чем меньше значение, тем больше будет файлов в дампе.
        * `--threads` — количество используемых потоков. Рекомендуется использовать значение, равное половине свободных ядер на сервере.
        * `--compress` — сжатие выходных файлов.

    1. В файлах дампа исправьте имена движков таблиц на `InnoDB`:

        ```bash
        sed -i -e 's/MyISAM/InnoDB/g' -e 's/MEMORY/InnoDB/g' `find /db_dump -name '*-schema.sql'`
        ```

    1. Упакуйте дамп в архив:

        ```bash
        tar -cvzf db_dump.tar.gz ~/db_dump
        ```

{% endlist %}

### (Опционально) Загрузка дампа на виртуальную машину в {{ yandex-cloud }} {#vm-load}

1. {% if audience != "internal" %}[Подключитесь](../../compute/operations/vm-connect/ssh.md) к промежуточной виртуальной машине по {% if lang == "ru" %}[SSH](../../glossary/ssh-keygen.md){% else %}SSH{% endif %}.{% else %}Подключитесь к промежуточной виртуальной машине по SSH.{% endif %}

1. Скопируйте архив с дампом базы данных на промежуточную виртуальную машину, например, используя утилиту `scp`:

    ```bash
    scp ~/db_dump.tar.gz <имя пользователя ВМ>@<публичный IP-адрес ВМ>:~/db_dump.tar.gz
    ```

1. Извлеките дамп из архива:

    ```bash
    tar -xzf ~/db_dump.tar.gz
    ```

### Восстановление данных {#restore}

{% note alert %}

Для кластера {{ mmy-name }} по умолчанию включен [AUTOCOMMIT](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_autocommit). **Не отключайте** AUTOCOMMIT в рамках клиентской сессии при восстановлении базы данных из дампа, иначе возможно переполнение хранилища хоста и нарушение работы кластера.

{% endnote %}

{% list tabs %}

* С использованием утилиты mysql

    Этот способ подходит, если вы создали дамп с помощью утилиты `mysqldump`.

    1. Установите утилиту `mysql` на хост, с которого выполняется восстановление дампа, например (для Ubuntu):

        ```bash
        sudo apt update && sudo apt install mysql-client --yes
        ```

    1. Запустите восстановление базы из дампа:

        * Если вы восстанавливаете дамп с виртуальной машины в {{ yandex-cloud }}:

            ```bash
            mysql \
                --host=c-<идентификатор кластера-приемника>.rw.{{ dns-zone }} \
                --user=<имя пользователя> \
                --port={{ port-mmy }} \
                <имя базы данных> < ~/db_dump.sql
            ```

        * Если вы восстанавливаете дамп с хоста, подключающегося к {{ yandex-cloud }} из интернета, [получите SSL-сертификат](../../managed-mysql/operations/connect.md#get-ssl-cert) и передайте параметры `--ssl-ca` и `--ssl-mode` в команде восстановления:

            ```bash
            mysql \
                --host=c-<идентификатор кластера-приемника>.rw.{{ dns-zone }} \
                --user=<имя пользователя> \
                --port={{ port-mmy }} \
                --ssl-ca=~/.mysql/root.crt \
                --ssl-mode=VERIFY_IDENTITY \
                <имя базы данных> < ~/db_dump.sql
            ```

* С использованием утилиты myloader

    Этот способ подходит, если вы создали дамп с помощью утилиты `mydumper` и используете для восстановления промежуточную виртуальную машину.

    1. Установите утилиту `myloader` на хост, с которого выполняется восстановление дампа, например (для Ubuntu):

        ```bash
        sudo apt update && sudo apt install mydumper --yes
        ```

    1. Запустите восстановление базы из дампа:

        ```bash
        myloader \
            --host=c-<идентификатор кластера-приемника>.rw.{{ dns-zone }} \
            --directory=db_dump/ \
            --overwrite-tables \
            --threads=8 \
            --compress-protocol \
            --user=<имя пользователя> \
            --ask-password
        ```

{% endlist %}

Идентификатор кластера можно получить со [списком кластеров в каталоге](../../managed-mysql/operations/cluster-list.md#list-clusters).

### Удаление созданных ресурсов {#clear-out}

Удалите ресурсы, которые вы больше не будете использовать, во избежание списания средств за них:

{% list tabs %}

* Вручную

    * [Удалите кластер {{ mmy-name }}](../../managed-mysql/operations/cluster-delete.md).
    * Если вы создавали промежуточную виртуальную машину, {% if audience != "internal" %}[удалите ее](../../compute/operations/vm-control/vm-delete.md){% else %}удалите ее{% endif %}.
    * Если вы зарезервировали публичные статические IP-адреса, освободите и {% if audience != "internal" %}[удалите их](../../vpc/operations/address-delete.md){% else %}удалите их{% endif %}.

* С помощью Terraform

    Чтобы удалить инфраструктуру, созданную с помощью {{ TF }}:

    1. В терминале перейдите в директорию с планом инфраструктуры.
    1. Удалите конфигурационный файл `data-migration-mysql-mmy.tf`.
    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        Все ресурсы, которые были описаны в конфигурационном файле `data-migration-mysql-mmy.tf`, будут удалены.

{% endlist %}
