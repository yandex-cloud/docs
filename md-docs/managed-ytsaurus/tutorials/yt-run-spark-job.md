# Запуск PySpark-задания

# Запуск PySpark-задания

В кластере YTsaurus вы можете запускать Spark- и PySpark-задания с помощью скрипта `spark-submit`. Он сохраняет результаты расчета в HDFS. Подробнее о `spark-submit` читайте в [документации Spark](https://spark.apache.org/docs/latest/submitting-applications.html#submitting-applications). Задания запускаются в кластере Apache Spark™, работающем на вычислительных ресурсах кластера YTsaurus, с помощью инструмента [SPYT](https://ytsaurus.tech/docs/ru/user-guide/data-processing/spyt/overview#what-is-spyt).

Ниже рассматривается пример запуска приложения на языке программирования [Python](https://www.python.org/downloads).

Чтобы запустить PySpark-задание:

1. [Подготовьте инфраструктуру](#before-you-begin).
1. [Подготовьте ВМ к работе](#prepare-vm).
1. [Подготовьте тестовые данные](#prepare-data).
1. [Создайте и запустите PySpark-задание](#create-job).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Необходимые платные ресурсы {#paid-resources}

* Кластер YTsaurus: использование вычислительных ресурсов компонентов кластера и объем хранилища ([тарифы YTsaurus](../pricing.md)).
* Виртуальная машина: использование вычислительных ресурсов, хранилища, публичного IP-адреса и операционной системы ([тарифы Compute Cloud](../../compute/pricing.md)).

## Перед началом работы {#before-you-begin}

Подготовьте инфраструктуру:

{% list tabs group=resources %}

- Вручную {#manual}

    1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) `ytsaurus-sa` с ролью `managed-ytsaurus.editor`.

    1. [Создайте сеть](../../vpc/operations/network-create.md) с именем `ytsaurus-network`. При создании выключите опцию **Создать подсети**.
    1. В сети `ytsaurus-network` [создайте подсеть](../../vpc/operations/subnet-create.md) со следующими параметрами:

        * Имя — `ytsaurus-subnet-a`.
        * Зона доступности — `ru-central1-a`.
        * CIDR — `10.1.0.0/16`.

    1. В сети `ytsaurus-network` [создайте группы безопасности](../../vpc/operations/security-group-create.md):

        * Для виртуальной машины — с именем `vm-security-group` и правилами, разрешающими входящий трафик по протоколу TCP на порт 22 со всех адресов и исходящий трафик на все порты и адреса.

        * Для кластера YTsaurus — с именем `ytsaurus-security-group` и правилом, разрешающим входящий трафик на все порты со всех адресов.

    1. [Создайте виртуальную машину](../../compute/quickstart/quick-create-linux.md) `vm-ubuntu-24-04` со следующими параметрами:

        * Операционная система — `Ubuntu 24.04`.
        * Зона доступности — `ru-central1-a`.
        * Подсеть — `ytsaurus-subnet-a`.
        * Группа безопасности — `vm-security-group`.
        * Сервисный аккаунт — `ytsaurus-sa`.

    1. [Создайте кластер YTsaurus](../operations/cluster-create.md) с настройками:

        * Тип кластера — `Demo-кластер`.
        * Имя кластера — `ytsaurus-cluster`.
        * Зона доступности — `ru-central1-a`.
        * Подсеть — `ytsaurus-subnet-a`.
        * Группа безопасности — `ytsaurus-security-group`.

- Terraform {#tf}

    1. Если у вас еще нет Terraform, [установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
    1. [Получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
    1. [Настройте и инициализируйте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
    1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

    1. Скачайте в ту же рабочую директорию файл конфигурации [ytsaurus-for-spark-jobs.tf](https://github.com/yandex-cloud-examples/yc-yt-run-spark-job/blob/main/ytsaurus-for-spark-jobs.tf).

        В этом файле описаны:

        * сеть;
        * подсеть;
        * группы безопасности;
        * сервисный аккаунт для работы с ресурсами кластера;
        * виртуальная машина;
        * кластер YTsaurus.

    1. Укажите в файле конфигурации `ytsaurus-for-spark-jobs.tf` необходимые параметры.
    1. Проверьте корректность файлов конфигурации Terraform с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, Terraform на них укажет.

    1. Создайте необходимую инфраструктуру:

        1. Выполните команду для просмотра планируемых изменений:
        
           ```bash
           terraform plan
           ```
        
           Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
        
        1. Если вас устраивают планируемые изменения, внесите их:
           1. Выполните команду:
        
              ```bash
              terraform apply
              ```
        
           1. Подтвердите изменение ресурсов.
           1. Дождитесь завершения операции.

        В указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления](https://console.yandex.cloud).

{% endlist %}

## Подготовьте ВМ к работе {#prepare-vm}

1. [Подключитесь к виртуальной машине по SSH](../../compute/operations/vm-connect/ssh.md#vm-connect).
1. Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

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
    export YT_PROXY=http://hp.<идентификатор_кластера_YTsaurus>.ytsaurus.mdb.yandexcloud.net:32100 ; \
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

1. Создайте таблицу `table1` в YTsaurus:

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

    * [Виртуальную машину](../../compute/operations/vm-control/vm-delete.md).
    * [Кластер YTsaurus](../operations/cluster-delete.md).

- С помощью Terraform {#tf}

    1. В терминале перейдите в директорию с планом инфраструктуры.
    
        {% note warning %}
    
        Убедитесь, что в директории нет Terraform-манифестов с ресурсами, которые вы хотите сохранить. Terraform удаляет все ресурсы, которые были созданы с помощью манифестов в текущей директории.
    
        {% endnote %}
    
    1. Удалите ресурсы:
    
        1. Выполните команду:
    
            ```bash
            terraform destroy
            ```
    
        1. Подтвердите удаление ресурсов и дождитесь завершения операции.
    
        Все ресурсы, которые были описаны в Terraform-манифестах, будут удалены.

{% endlist %}