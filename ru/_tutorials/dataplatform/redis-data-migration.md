# Миграция базы данных в {{ mrd-name }}

Для миграции данных в {{ RD }} используется _логический дамп_ — файл с набором команд, последовательное выполнение которых восстанавливает состояние баз данных в кластере. Его можно создать разными способами, далее для примера используется [redis-dump-go](https://github.com/yannh/redis-dump-go/).

{% note info %}

Для миграции нельзя использовать бинарный дамп в формате RDB, т. к. {{ mrd-name }} не предоставляет доступ к файловой системе на хостах кластера.

{% endnote %}

Чтобы мигрировать базы данных {{ RD }} из _кластера-источника_ в _кластер-приемник_:

1. [Подключитесь к кластеру-источнику и создайте логический дамп](#create-dump).
1. [Настройте промежуточную виртуальную машину](#setup-vm).
1. [Восстановите дамп в кластере-приемнике](#restore-dump).
1. [Убедитесь, что дамп полностью восстановлен](#check-data).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

### Подготовьте инфраструктуру {#deploy-infrastructure}

{% list tabs %}

- Вручную

    1. [Создайте кластер](../../managed-redis/operations/cluster-create.md) {{ mrd-name }} любой подходящей конфигурации.

    1. {% if audience != "internal" %}[Создайте промежуточную виртуальную машину Linux](../../compute/operations/vm-create/create-linux-vm.md){% else %}Создайте промежуточную виртуальную машину Linux{% endif %} в {{ compute-full-name }} в той же сети, что и кластер {{ mrd-name }} в следующей конфигурации:

        * В блоке **Выбор образа/загрузочного диска** выберите **Операционные системы** → `Ubuntu 20.04`.
        * В блоке **Сетевые настройки**:

            * **Публичный адрес** — `Автоматически`.
            * **Внутренний адрес** — `Автоматически`.
            * **Группы безопасности** — выберите ту же группу безопасности, что и для кластера {{ mrd-name }}.

    1. [Настройте группу безопасности {{ vpc-name }}](../../managed-redis/operations/connect/index.md#configuring-security-groups).

- С помощью {{ TF }}

    1. Если у вас еще нет {{ TF }}, {% if audience != "internal" %}[установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform){% else %}установите его{% endif %}.
        1. Скачайте [файл с настройками провайдера](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Поместите его в отдельную рабочую директорию и {% if audience != "internal" %}[укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider){% else %}укажите значения параметров{% endif %}.
        1. Скачайте в ту же рабочую директорию файл конфигурации для подходящего типа кластера:

            * [redis-cluster-non-sharded.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/redis-migration/redis-cluster-non-sharded.tf) — для нешардированного кластера.
            * [redis-cluster-sharded.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/redis-migration/redis-cluster-sharded.tf) — для [шардированного](../../managed-redis/concepts/sharding.md) кластера.

            В каждом файле описаны:

            * сеть;
            * подсеть;
            * кластер {{ mrd-name }};
            * виртуальная машина;
            * группа безопасности по умолчанию и правила, необходимые для подключения к кластеру и виртуальной машине из интернета:
                * подключение к ВМ из интернета по SSH;
                * подключение из ВМ к кластеру {{ mrd-name }} через порты {{ RD }}.


        1. Укажите в файле конфигурации:

            * Пароль для доступа к кластеру {{ mrd-name }}.
            * Идентификатор публичного {% if audience != "internal" %}[образа](../../compute/operations/images-with-pre-installed-software/get-list){% else %}образа{% endif %} виртуальной машины. Например, для [Ubuntu 20.04 LTS]{% if lang == "ru" %}(https://cloud.yandex.ru/marketplace/products/yc/ubuntu-20-04-lts){% endif %}{% if lang == "en" %}(https://cloud.yandex.com/en-ru/marketplace/products/yc/ubuntu-20-04-lts){% endif %}).
            * Логин и путь к {% if audience != "internal" %}[публичной части SSH-ключа](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys){% else %}публичной части SSH-ключа{% endif %}, которые будут использоваться для доступа к виртуальной машине.

        1. Выполните команду `terraform init` в директории с конфигурационными файлами. Эта команда инициализирует провайдеров, указанных в конфигурационных файлах, и позволяет работать с ресурсами и источниками данных провайдера.
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

1. (Опционально) Установите на локальный компьютер утилиты для скачивания и загрузки файлов по протоколу SSH, например:

    * [WinSCP]{% if lang == "ru" %}(https://winscp.net/eng/docs/lang:ru){% endif %}{% if lang == "en" %}(https://winscp.net/eng/index.php){% endif %}
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
    export REDISDUMPGO_AUTH="<пароль {{ RD }}>"
    ```

1. Запустите интерактивную сессию `screen`:

    ```bash
    screen
    ```

1. Запустите процесс создания логического дампа:

    ```bash
    ./redis-dump-go \
        -host <IP-адрес или FQDN хоста-мастера в кластере {{ RD }}> \
        -port <порт {{ RD }}> > <файл дампа>
    ```

    {% note tip %}

    В процессе создания дампа на экран будет выводиться количество обработанных ключей. Запомните или запишите последнее выведенное значение, оно понадобится при проверке полноты восстановления дампа в кластере-приемнике.

    {% endnote %}

1. Когда дамп будет создан, скачайте его на свой компьютер.

1. Завершите интерактивную сессию `screen`:

    ```bash
    exit
    ```

## Настройте промежуточную виртуальную машину {#setup-vm}

{% if audience == "external" %}

1. [Подключитесь к промежуточной виртуальной машине по SSH](../../compute/operations/vm-connect/ssh.md).

{% else %}

1. Подключитесь к промежуточной виртуальной машине по SSH.

{% endif %}

1. Если ваш кластер {{ mrd-name }} развернут с включенной поддержкой TLS:

    1. [Получите SSL сертификат](../../managed-redis/operations/connect/index.md#get-ssl-cert).

    1. Добавьте в список репозиториев официальный репозиторий {{ RD }}:

        ```bash
        sudo apt-add-repository ppa:redislabs/redis
        ```

        {% note info %}

        Пакеты в этом репозитории собраны с флагом `BUILD_TLS=yes`, поэтому пересобирать их из исходного кода вручную не нужно.

        {% endnote %}

1. Обновите список доступных пакетов и установите необходимые утилиты:

    ```bash
    sudo apt update && sudo apt install redis-tools screen --yes
    ```

## Восстановите дамп в кластере-приемнике {#restore-dump}

1. Загрузите дамп со своего компьютера на промежуточную виртуальную машину любым удобным способом.

1. {% if audience != "internal" %}[Подключитесь к промежуточной ВМ по SSH](../../compute/operations/vm-connect/ssh.md){% else %}Подключитесь к промежуточной ВМ по SSH{% endif %} и запустите интерактивную сессию `screen`:

    ```bash
    screen
    ```

1. Запустите процесс восстановления дампа:

    {% list tabs %}

    - Подключение без TLS

        **Подключение с помощью Sentinel**

        ```bash
        host=$(redis-cli \
          -h <FQDN любого хоста {{ RD }}> \
          -p {{ port-mrd-sentinel }} \
          sentinel \
          get-master-addr-by-name \
          no-shards-no-tls | head -n 1)
        redis-cli \
          -h ${host} \
          -p {{ port-mrd }} \
          -a <пароль кластера-приемника> \
          --pipe < <файл дампа>
        ```

        **Подключение напрямую к мастеру**

        ```bash
        redis-cli \
          -h <FQDN хоста-мастера> \
          -p {{ port-mrd }} \
          -a <пароль кластера-приемника> \
          --pipe < <файл дампа>
        ```

        {% include [use-special-fqdn](../../_includes/mdb/mrd/conn-strings-fqdn.md) %}

        **Подключение к шардированному кластеру**

        1. Создайте скрипт с командами загрузки дампа:

            `load-dump.sh`

            ```bash
            shards=('<FQDN хоста-мастера в шарде 1>' \
                    ...
                    '<FQDN хоста-мастера в шарде N>')

            for shard in "${shards[@]}" ; do
              redis-cli -h "${shard}" \
                        -p {{ port-mrd }} \
                        -a "<пароль кластера-приемника>" \
                        --pipe < <файл дампа>
            done
            ```

        1. Запустите скрипт:

            ```bash
            bash ./load-dump.sh
            ```

            Во время работы скрипта будут выводиться сообщения об ошибках вставки данных. Это нормальное поведение команды `redis-cli`, связанное с тем, что в шардированном кластере каждый шард хранит только часть данных. Подробнее см. в разделе [{#T}](../../managed-redis/concepts/sharding.md).

    - Подключение с TLS

        **Подключение с помощью Sentinel**

        ```bash
        host=$(redis-cli \
               -h <FQDN любого хоста {{ RD }}> \
               -p {{ port-mrd-sentinel }} \
               sentinel \
               get-master-addr-by-name \
               no-shards-tls | head -n 1)
        redis-cli \
            -h ${host} \
            -p {{ port-mrd-tls }} \
            -a <пароль кластера-приемника> \
            --tls \
            --cacert ~/.redis/{{ crt-local-file }} \
            --pipe < <файл дампа>
        ```

        **Подключение напрямую к мастеру**

        ```bash
        redis-cli \
            -h c-<идентификатор кластера>.rw.{{ dns-zone }} \
            -p {{ port-mrd-tls }} \
            -a <пароль кластера-приемника> \
            --tls \
            --cacert ~/.redis/{{ crt-local-file }} \
            --pipe < <файл дампа>
        ```

        {% include [use-special-fqdn](../../_includes/mdb/mrd/conn-strings-fqdn.md) %}

        **Подключение к шардированному кластеру**

        1. Создайте скрипт с командами загрузки дампа:

            `load-dump.sh`

            ```bash
            shards=('<FQDN хоста-мастера в шарде 1>' \
                    ...
                    '<FQDN хоста-мастера в шарде N>')

            for shard in "${shards[@]}" ; do
              redis-cli -h "${shard}" \
                        -p {{ port-mrd-tls }} \
                        -a "<пароль кластера-приемника>" \
                        --tls \
                        --cacert ~/.redis/{{ crt-local-file }} \
                        --pipe < <файл дампа>
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
1. В списке сервисов выберите **{{ mrd-name }}**.
1. Нажмите на имя нужного кластера и выберите вкладку [Мониторинг](../../managed-redis/operations/monitoring.md).

Обратите внимание на график **DB Keys**, отображающий количество ключей, хранящихся в кластере. Если кластер [шардированный](../../managed-redis/concepts/sharding.md), на графике будет выводиться количество ключей в каждом шарде. В этом случае количество ключей в кластере равно суммарному количеству ключей в шардах.

Общее количество ключей в кластере должно совпадать с числом ключей, обработанных утилитой `redis-dump-go` при создании дампа.

## Удалите созданные ресурсы {#clear-out}

{% list tabs %}

- Вручную

    Если созданные ресурсы вам больше не нужны, удалите их:

    * [Удалите кластер {{ mrd-full-name }}](../../managed-redis/operations/cluster-delete.md).
    * {% if audience != "internal" %}[Удалите виртуальную машину](../../compute/operations/vm-control/vm-delete.md){% else %}Удалите виртуальную машину{% endif %}.
    * Если вы зарезервировали публичные статические IP-адреса, освободите и {% if audience != "internal" %}[удалите их](../../vpc/operations/address-delete.md){% else %}удалите их{% endif %}.

- С помощью {{ TF }}

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
