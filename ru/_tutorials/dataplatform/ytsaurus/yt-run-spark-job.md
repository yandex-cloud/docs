# Запуск PySpark-задания

В кластере {{ ytsaurus-name }} вы можете запускать Spark- и PySpark-задания с помощью скрипта `spark-submit`. Он сохраняет результаты расчета в HDFS. Подробнее о `spark-submit` читайте в [документации Spark](https://spark.apache.org/docs/latest/submitting-applications.html#submitting-applications). Задания запускаются в кластере {{ SPRK }}, работающем на вычислительных ресурсах кластера {{ ytsaurus-name }}, с помощью инструмента [SPYT](https://ytsaurus.tech/docs/ru/user-guide/data-processing/spyt/overview#what-is-spyt).

Ниже рассматривается пример запуска приложения на языке программирования [Python](https://www.python.org/downloads).

Чтобы запустить PySpark-задание:

1. [Подготовьте инфраструктуру](#before-you-begin).
1. [Подготовьте ВМ к работе](#prepare-vm).
1. [Подготовьте тестовые данные](#prepare-data).
1. [Создайте и запустите PySpark-задание](#create-job).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Необходимые платные ресурсы {#paid-resources}

* Кластер {{ ytsaurus-name }}: использование вычислительных ресурсов компонентов кластера и объем хранилища (см. [тарифы {{ ytsaurus-name }}](../../../managed-ytsaurus/pricing.md)).
* Виртуальная машина: использование вычислительных ресурсов, хранилища, публичного IP-адреса и операционной системы (см. [тарифы {{ compute-name }}](../../../compute/pricing.md)).

## Перед началом работы {#before-you-begin}

Подготовьте инфраструктуру:

{% list tabs group=resources %}

- Вручную {#manual}

    1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create) `ytsaurus-sa` с ролью `managed-ytsaurus.editor`.

    1. [Создайте сеть](../../../vpc/operations/network-create.md) с именем `ytsaurus-network`. При создании выключите опцию **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}**.
    1. В сети `ytsaurus-network` [создайте подсеть](../../../vpc/operations/subnet-create.md) со следующими параметрами:

        * Имя — `ytsaurus-subnet-a`.
        * Зона доступности — `{{ region-id }}-a`.
        * CIDR — `10.1.0.0/16`.

    1. В сети `ytsaurus-network` [создайте группы безопасности](../../../vpc/operations/security-group-create.md):

        * Для виртуальной машины — с именем `vm-security-group` и правилами, разрешающими входящий трафик по протоколу TCP на порт 22 со всех адресов и исходящий трафик на все порты и адреса.

        * Для кластера {{ ytsaurus-name }} — с именем `ytsaurus-security-group` и правилом, разрешающим входящий трафик на все порты со всех адресов.

    1. [Создайте виртуальную машину](../../../compute/quickstart/quick-create-linux.md) `vm-ubuntu-24-04` со следующими параметрами:

        * Операционная система — `Ubuntu 24.04`.
        * Зона доступности — `{{ region-id }}-a`.
        * Подсеть — `ytsaurus-subnet-a`.
        * Группа безопасности — `vm-security-group`.
        * Сервисный аккаунт — `ytsaurus-sa`.

    1. [Создайте кластер {{ ytsaurus-name }}](../../../managed-ytsaurus/operations/cluster-create.md) с настройками:

        * Тип кластера — `{{ ui-key.yacloud.managed-ytsaurus.clusters.YTSaurusClusterCreatePage.cluster-kind-card_demo_title_4B7zu }}`.
        * Имя кластера — `ytsaurus-cluster`.
        * Зона доступности — `{{ region-id }}-a`.
        * Подсеть — `ytsaurus-subnet-a`.
        * Группа безопасности — `ytsaurus-security-group`.

- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../../_includes/mdb/terraform/configure-provider.md) %}

    1. Скачайте в ту же рабочую директорию файл конфигурации [ytsaurus-for-spark-jobs.tf](https://github.com/yandex-cloud-examples/yc-yt-run-spark-job/blob/main/ytsaurus-for-spark-jobs.tf).

        В этом файле описаны:

        * сеть;
        * подсеть;
        * группы безопасности;
        * сервисный аккаунт для работы с ресурсами кластера;
        * виртуальная машина;
        * кластер {{ ytsaurus-name }}.

    1. Укажите в файле конфигурации `ytsaurus-for-spark-jobs.tf` необходимые параметры.
    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Создайте необходимую инфраструктуру:

        {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Подготовьте ВМ к работе {#prepare-vm}

1. [Подключитесь к виртуальной машине по SSH](../../../compute/operations/vm-connect/ssh.md#vm-connect).
1. {% include [cli-install](../../../_includes/cli-install.md) %}

1. Установите зависимости:

    ```bash
    sudo apt update && sudo apt install -y python3 python3-pip python3-venv
    ```

1. Создайте и активируйте виртуальное окружение для выполнения Python-скрипта:

    ```bash
    python3 -m venv .venv/yt312 && \
    source .venv/yt312/bin/activate
    ```

1. Установите Java:

    ```bash
    sudo apt install -y openjdk-11-jdk
    ```

1. Установите YTsaurus CLI:

    ```bash
    pip install ytsaurus-client
    ```

1. Создайте IAM-токен:

    ```bash
    yc iam create-token
    ```

1. Получите идентификатор сервисного аккаунта:

    ```bash
    yc iam whoami
    ```

1. Задайте переменные окружения:

    ```bash
    export YT_PROXY=http://hp.<идентификатор_кластера_{{ ytsaurus-name }}>.ytsaurus.mdb.yandexcloud.net:32100 ; \
    export YT_TOKEN=<IAM-токен> ; \
    export YT_USER=<идентификатор_сервисного_аккаунта>
    ```

1. Получите версию SPYT:

    ```bash
    yt list //home/spark/conf/releases
    ```

    Результат:

    ```bash
    2.7.0
    ```

1. Установите пакет `ytsaurus-spyt` той же версии, что и SPYT:

    ```bash
    pip install ytsaurus-spyt==2.7.0
    ```

1. Получите версию Spark из названия tgz-файла:

    ```bash
    yt find //home/spark/distrib --name *tgz
    ```

    Результат:

    ```bash
    //home/spark/distrib/3/5/6/spark-3.5.6-bin-hadoop3.tgz
    ```

1. Установите `pyspark` той же версии, что и дистрибутив `spark`:

    ```bash
    pip install pyspark==3.5.6
    ```

1. Активируйте конфигурацию SPYT:

    ```bash
    source spyt-env
    ```

    Результат:

    ```bash
    SPYT environment has been successfully activated
    ```

1. Проверьте значение переменной `$SPARK_CONF_DIR`:

    ```bash
    echo $SPARK_CONF_DIR
    ```

    Результат:

    ```bash
    /home/<домашняя_директория>/.venv/yt312/lib/python3.12/site-packages/spyt/conf
    ```

## Подготовьте тестовые данные {#prepare-data}

На виртуальной машине выполните команды:

1. Создайте таблицу `table1` в {{ ytsaurus-name }}:

    ```bash
    yt create table //tmp/table1 \
      --attributes '{schema = [{name = id; type = int64}; {name = text; type = string}]}'
    ```

1. Запишите данные в таблицу:

    ```bash
    echo '{ "id": 0, "text": "Hello" } { "id": 1, "text": "World!" }' | yt write-table //tmp/table1 --format json
    ```

## Создайте и запустите PySpark-задание {#create-job}

На виртуальной машине выполните действия:

1. Создайте файл `spark-job.py` с PySpark-заданием.

    ```python
    import spyt
    from pyspark import SparkConf

    conf = SparkConf()
    conf.set("spark.app.name","Show table")
    with spyt.direct_spark_session("http-proxies-lb.yt.svc.cluster.local", conf) as spark:
         spark.read.yt('//tmp/table1').show()
    ```

1. Запустите задание:

    ```bash
    spark-submit --master "ytsaurus://${YT_PROXY}" \
      --deploy-mode cluster \
      --num-executors 1 \
      --conf spark.hadoop.yt.proxyNetworkName=external \
      --queue research \
      ./spark-job.py
    ```

    Результат:

    ```bash
    ...
    25/12/09 23:29:49 INFO YTsaurusClusterApplication: Operation: fdff4aa2-d11767f6-e03e8-6affdd7c, State: running
    25/12/09 23:30:23 INFO YTsaurusClusterApplication: Operation: fdff4aa2-d11767f6-e03e8-6affdd7c, State: completed
    ```

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

{% list tabs group=instructions %}

- Вручную {#manual}

    * [Виртуальную машину](../../../compute/operations/vm-control/vm-delete.md).
    * [Кластер {{ ytsaurus-name }}](../../../managed-ytsaurus/operations/cluster-delete.md).

- С помощью {{ TF }} {#tf}

    {% include [terraform-clear-out](../../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}
