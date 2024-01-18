# Миграция базы данных из стороннего кластера {{ RD }} в {{ mrd-full-name }}

Для миграции данных в {{ RD }} используется _логический дамп_ — файл с набором команд, последовательное выполнение которых восстанавливает состояние баз данных в кластере. Его можно создать разными способами, далее для примера используется [redis-dump-go](https://github.com/yannh/redis-dump-go/).

{% note info %}

Для миграции нельзя использовать бинарный дамп в формате RDB, т. к. {{ mrd-name }} не предоставляет доступ к файловой системе на хостах кластера.

{% endnote %}

Чтобы мигрировать базы данных {{ RD }} из _кластера-источника_ в _кластер-приемник_:

1. [Подключитесь к кластеру-источнику и создайте логический дамп](#create-dump).
1. (Опционально) [Загрузите дамп на промежуточную виртуальную машину](#load-vm).

    Переносить данные с помощью виртуальной машины в {{ compute-full-name }} нужно, если:

    * К вашему кластеру {{ mrd-name }} нет доступа из интернета.
    * Ваше оборудование или соединение с кластером в {{ yandex-cloud }} недостаточно надежны.

1. [Восстановите дамп в кластере-приемнике](#restore-dump).
1. [Убедитесь, что дамп полностью восстановлен](#check-data).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

### Подготовьте инфраструктуру {#deploy-infrastructure}

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Создайте кластер](../../managed-redis/operations/cluster-create.md) {{ mrd-name }} любой подходящей конфигурации. Для подключения к кластеру с локальной машины пользователя, а не из облачной сети {{ yandex-cloud }}, включите поддержку TLS и публичный доступ для хостов при создании кластера.

    1. (Опционально) [Создайте промежуточную виртуальную машину Linux](../../compute/operations/vm-create/create-linux-vm.md) в {{ compute-full-name }} в той же сети, что и кластер {{ mrd-name }} в следующей конфигурации:

        * В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** выберите **{{ ui-key.yacloud.compute.instances.create.image_value_os-products }}** → [Ubuntu 20.04](/marketplace/products/yc/ubuntu-20-04-lts).
        * В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

            * **{{ ui-key.yacloud.component.compute.network-select.field_external }}** — `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`.
            * **{{ ui-key.yacloud.component.compute.network-select.field_internal-ipv4 }}** — `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`.
            * **{{ ui-key.yacloud.component.compute.network-select.field_security-groups }}** — выберите ту же группу безопасности, что и для кластера {{ mrd-name }}.

    
    1. Если вы используете группы безопасности {{ vpc-name }}, [настройте их](../../managed-redis/operations/connect/index.md#configuring-security-groups).


- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

    1. Скачайте в ту же рабочую директорию файл конфигурации для подходящего типа кластера:

        * [redis-cluster-non-sharded.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/redis-migration/redis-cluster-non-sharded.tf) — для нешардированного кластера.
        * [redis-cluster-sharded.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/redis-migration/redis-cluster-sharded.tf) — для [шардированного](../../managed-redis/concepts/sharding.md) кластера.

        В каждом файле описаны:

        * сеть;
        * подсеть;
        * группа безопасности по умолчанию и правила, необходимые для подключения к кластеру и виртуальной машине;
        * кластер {{ mrd-name }} с публичным доступом из интернета;
        * (опционально) виртуальная машина с публичным доступом из интернета.

    1. Укажите в файле конфигурации:

        * Пароль для доступа к кластеру {{ mrd-name }}.
        * (Опционально) Параметры виртуальной машины:

            * Идентификатор публичного [образа](../../compute/operations/images-with-pre-installed-software/get-list) виртуальной машины. Например, для [Ubuntu 20.04 LTS](/marketplace/products/yc/ubuntu-20-04-lts).
            * Логин и абсолютный путь к [публичной части SSH-ключа](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys), которые будут использоваться для доступа к виртуальной машине. По умолчанию в образе [Ubuntu 20.04 LTS](/marketplace/products/yc/ubuntu-20-04-lts) указанный логин игнорируется, вместо него создается пользователь с логином `ubuntu`. Используйте его для подключения к виртуальной машине.

    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Создайте необходимую инфраструктуру:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

### Установите дополнительное ПО {#install-extra-software}

1. (Опционально) Установите на локальный компьютер утилиты для скачивания и загрузки файлов по протоколу [SSH](../../glossary/ssh-keygen.md), например:

    * [WinSCP](https://winscp.net/eng/docs/lang:ru)
    * [Putty SCP](https://www.putty.org/)

1. Убедитесь, что на кластере-источнике установлена утилита [GNU Screen](https://www.gnu.org/software/screen/).

    Создание и восстановление дампа могут занять длительное время. Чтобы эти процессы не прерывались при закрытии SSH-сессии по таймауту, запускайте их с помощью этой утилиты. Если при создании или восстановлении дампа SSH-соединение будет прервано, подключитесь повторно и восстановите состояние сессии с помощью команды:

    ```bash
    screen -R
    ```

## Подключитесь к кластеру-источнику и создайте логический дамп {#create-dump}

1. Подключитесь к хосту-мастеру кластера-источника по SSH.
1. Загрузите архив с утилитой `redis-dump-go` со [страницы проекта](https://github.com/yannh/redis-dump-go/releases). Далее в примерах используется версия `0.5.1`.

    ```bash
    wget https://github.com/yannh/redis-dump-go/releases/download/v0.5.1/redis-dump-go_0.5.1_linux_amd64.tar.gz
    ```

1. Распакуйте архив в текущий каталог:

    ```bash
    tar xf redis-dump-go_0.5.1_linux_amd64.tar.gz
    ```

1. Изучите параметры запуска утилиты:

    ```bash
    ./redis-dump-go -h
    ```

1. Если для подключения к кластеру {{ RD }} нужен пароль, укажите его в значении переменной окружения `REDISDUMPGO_AUTH`:

    ```bash
    export REDISDUMPGO_AUTH="<пароль_{{ RD }}>"
    ```

1. Запустите интерактивную сессию `screen`:

    ```bash
    screen
    ```

1. Запустите процесс создания логического дампа:

    ```bash
    ./redis-dump-go \
        -host <IP-адрес_или_FQDN_хоста-мастера_в_кластере_{{ RD }}> \
        -port <порт_{{ RD }}> > <файл_дампа>
    ```

    {% note tip %}

    В процессе создания дампа на экран будет выводиться количество обработанных ключей. Запомните или запишите последнее выведенное значение, оно понадобится при проверке полноты восстановления дампа в кластере-приемнике.

    {% endnote %}

1. Когда дамп будет создан, скачайте его на свой компьютер.

1. Завершите интерактивную сессию `screen`:

    ```bash
    exit
    ```

## (Опционально) Загрузите дамп на промежуточную виртуальную машину {#load-vm}


1. [Подключитесь к промежуточной виртуальной машине по SSH](../../compute/operations/vm-connect/ssh.md).


1. Загрузите дамп со своего компьютера на промежуточную виртуальную машину любым удобным способом.

## Восстановите дамп в кластере-приемнике {#restore-dump}

1. [Подключитесь к кластеру](../../managed-redis/operations/connect/index.md) и запустите интерактивную сессию `screen`:

    ```bash
    screen
    ```

1. Запустите процесс восстановления дампа:

    {% list tabs group=connection %}

    - Подключение без TLS {#without-tls}

        {% include [Install requirements](../../_includes/mdb/mrd/connect/bash/install-requirements.md) %}

        **Подключение с помощью Sentinel**

        ```bash
        host=$(redis-cli \
          -h <FQDN_любого_хоста_{{ RD }}> \
          -p {{ port-mrd-sentinel }} \
          sentinel \
          get-master-addr-by-name \
          no-shards-no-tls | head -n 1)
        redis-cli \
          -h ${host} \
          -p {{ port-mrd }} \
          -a <пароль_кластера-приемника> \
          --pipe < <файл_дампа>
        ```

        **Подключение напрямую к мастеру**

        ```bash
        redis-cli \
          -h <FQDN_хоста-мастера> \
          -p {{ port-mrd }} \
          -a <пароль_кластера-приемника> \
          --pipe < <файл_дампа>
        ```

        {% include [use-special-fqdn](../../_includes/mdb/mrd/conn-strings-fqdn.md) %}

        **Подключение к шардированному кластеру**

        1. Создайте скрипт с командами загрузки дампа:

            `load-dump.sh`

            ```bash
            shards=('<FQDN_хоста-мастера_в_шарде_1>' \
                    ...
                    '<FQDN_хоста-мастера_в_шарде_N>')

            for shard in "${shards[@]}" ; do
              redis-cli -h "${shard}" \
                        -p {{ port-mrd }} \
                        -a "<пароль_кластера-приемника>" \
                        --pipe < <файл_дампа>
            done
            ```

        1. Запустите скрипт:

            ```bash
            bash ./load-dump.sh
            ```

            Во время работы скрипта будут выводиться сообщения об ошибках вставки данных. Это нормальное поведение команды `redis-cli`, связанное с тем, что в шардированном кластере каждый шард хранит только часть данных. Подробнее см. в разделе [{#T}](../../managed-redis/concepts/sharding.md).

    - Подключение с TLS {#with-tls}

        {% include [Install requirements SSL](../../_includes/mdb/mrd/connect/bash/install-requirements-ssl.md) %}

        **Подключение с помощью Sentinel**

        ```bash
        host=$(redis-cli \
               -h <FQDN_любого_хоста_{{ RD }}> \
               -p {{ port-mrd-sentinel }} \
               sentinel \
               get-master-addr-by-name \
               no-shards-tls | head -n 1)
        redis-cli \
            -h ${host} \
            -p {{ port-mrd-tls }} \
            -a <пароль_кластера-приемника> \
            --tls \
            --cacert ~/.redis/{{ crt-local-file }} \
            --pipe < <файл_дампа>
        ```

        **Подключение напрямую к мастеру**

        ```bash
        redis-cli \
            -h c-<идентификатор_кластера>.rw.{{ dns-zone }} \
            -p {{ port-mrd-tls }} \
            -a <пароль_кластера-приемника> \
            --tls \
            --cacert ~/.redis/{{ crt-local-file }} \
            --pipe < <файл_дампа>
        ```

        {% include [use-special-fqdn](../../_includes/mdb/mrd/conn-strings-fqdn.md) %}

        **Подключение к шардированному кластеру**

        1. Создайте скрипт с командами загрузки дампа:

            `load-dump.sh`

            ```bash
            shards=('<FQDN_хоста-мастера_в_шарде_1>' \
                    ...
                    '<FQDN_хоста-мастера_в_шарде_N>')

            for shard in "${shards[@]}" ; do
              redis-cli -h "${shard}" \
                        -p {{ port-mrd-tls }} \
                        -a "<пароль_кластера-приемника>" \
                        --tls \
                        --cacert ~/.redis/{{ crt-local-file }} \
                        --pipe < <файл_дампа>
            done
            ```

        1. Запустите скрипт:

            ```bash
            bash ./load-dump.sh
            ```

            Во время работы скрипта будут выводиться сообщения об ошибках вставки данных. Это нормальное поведение команды `redis-cli`, связанное с тем, что в шардированном кластере каждый шард хранит только часть данных. Подробнее см. в разделе [{#T}](../../managed-redis/concepts/sharding.md).

        {% endcut %}

    {% endlist %}

1. Завершите интерактивную сессию `screen`:

    ```bash
    exit
    ```

## Убедитесь, что дамп полностью восстановлен {#check-data}

1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, где нужно восстановить кластер.
1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
1. Нажмите на имя нужного кластера и выберите вкладку [{{ ui-key.yacloud.redis.cluster.switch_monitoring }}](../../managed-redis/operations/monitoring.md).

Обратите внимание на график **DB Keys**, отображающий количество ключей, хранящихся в кластере. Если кластер [шардированный](../../managed-redis/concepts/sharding.md), на графике будет выводиться количество ключей в каждом шарде. В этом случае количество ключей в кластере равно суммарному количеству ключей в шардах.

Общее количество ключей в кластере должно совпадать с числом ключей, обработанных утилитой `redis-dump-go` при создании дампа.

## Удалите созданные ресурсы {#clear-out}

Удалите ресурсы, которые вы больше не будете использовать, чтобы за них не списывалась плата:

{% list tabs group=instructions %}

- Вручную {#manual}

    * [Удалите кластер {{ mrd-full-name }}](../../managed-redis/operations/cluster-delete.md).
    * Если вы создавали промежуточную виртуальную машину, [удалите ее](../../compute/operations/vm-control/vm-delete.md).
    * Если вы зарезервировали публичные статические IP-адреса, освободите и [удалите их](../../vpc/operations/address-delete.md).

- {{ TF }} {#tf}

    Чтобы удалить инфраструктуру, [созданную с помощью {{ TF }}](#deploy-infrastructure):

    1. В терминале перейдите в директорию с планом инфраструктуры.
    1. Удалите конфигурационный файл (`redis-cluster-non-sharded.tf` или `redis-cluster-sharded.tf`).
    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        Все ресурсы, которые были описаны в конфигурационном файле, будут удалены.

{% endlist %}
