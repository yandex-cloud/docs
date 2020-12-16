# Настройка вычислений на кластерах Apache Spark™ 

Чтобы начать вычисления на кластерах Apache Spark™, подготовьте проект {{ ml-platform-name }}. Для вычислений создайте новый кластер {{ dataproc-name }} или используйте уже существующий.

## Подготовьте проект для работы с кластером {{ dataproc-name }} {#settings}

Чтобы настроить проект: 
1. {% include [include](../../_includes/datasphere/first-step.md) %}
1. Нажмите значок ![image](../../_assets/options.svg) в строке проекта, который требуется настроить.
1. В открывшемся меню нажмите кнопку **Изменить**.
1. В открывшемся окне нажмите **Дополнительные настройки**.
1. В поле **Сервисный аккаунт** выберите сервисный аккаунт с необходимыми [ролями](../concepts/data-proc.md#roles).
1. В поле **Подсеть** укажите подсеть, в которой будут создаваться новые или использоваться существующие кластеры {{ dataproc-name }}.

{% include [subnet-create](../../_includes/subnet-create.md) %}

## Создайте кластер {{ dataproc-name }} {#create}

Перед созданием кластера убедитесь, что в вашем облаке достаточно ресурсов. Это можно сделать в консоли управления в разделе [Квоты]({{ link-console-quotas }}). 

### Создайте кластер через интерфейс ноутбука в сервисе {{ ml-platform-name }} {#notebook}

{{ ml-platform-name }} следит за временем жизни созданного кластера и удалит его автоматически после двух часов бездействия.

Чтобы создать кластер через интерфейс ноутбука:
1. {% include [include](../../_includes/datasphere/first-step.md) %}
1. Выберите проект, для которого необходимо создать кластер {{ dataproc-name }}.
1. В верхней панели нажмите **File** и выберите **Data Proc Clusters**.
1. В открывшемся окне в блоке **Create new cluster**:
    1. В поле **Name** укажите имя кластера {{ dataproc-name }}.
    1. Из списка **Size** выберите конфигурацию кластера {{ dataproc-name }}.
1. Нажмите кнопку **Create**.

Информация о состоянии созданного кластера будет отображаться в этом же окне.

#### Статусы кластера {{ dataproc-name }} {#status}

После создания, кластер может быть в следующих статусах: 
* `STARTING` — кластер создается.
* `UP` — кластер создан и готов для выполнения вычислений.
* `DOWN` — возникли проблемы при создании кластера.

### Создайте кластер в сервисе {{ dataproc-name }} {#console}

Вы самостоятельно управляете жизненным циклом кластера, созданного вручную. Для корректной работы интеграции необходимо создать кластер со следующими параметрами: 
* **Версия**: 1.3 и выше.
* **Включенные сервисы**: `LIVY`, `SPARK`, `YARN` и `HDFS`.
* **Зона доступности кластера**: `ru-central1-a`.

{% cut "Как создать кластер {{ dataproc-name }}" %}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать кластер.
    1. Нажмите кнопку **Создать ресурс** и выберите **Кластер {{ dataproc-name }}** в выпадающем списке.
    1. Введите имя кластера в поле **Имя кластера**. Имя кластера должно быть уникальным в рамках каталога.
    1. В поле **Версия** выберите `1.3` 
    1. В поле **Сервисы** выберите: `LIVY`, `SPARK`, `YARN` и `HDFS`.
    1. Вставьте в поле **Публичный ключ** публичную часть вашего SSH-ключа. Как сгенерировать и использовать SSH-ключи, читайте в [документации {{ compute-full-name }}](../../compute/operations/vm-connect/ssh.md).
    1. Выберите или создайте [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), которому нужно разрешить доступ к кластеру.
    1. В поле **Зона доступности** выберите `ru-central1-a`.
    1. При необходимости задайте свойства Hadoop и его компонентов, например:
    
        ```
        hdfs:dfs.replication : 2
        hdfs:dfs.blocksize : 1073741824
        spark:spark.driver.cores : 1
        ```
        
        Доступные свойства перечислены в официальной документации компонентов:
        
        * [Hadoop](https://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-common/core-default.xml)
        * [HDFS](https://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-hdfs/hdfs-default.xml)
        * [YARN](https://hadoop.apache.org/docs/current/hadoop-yarn/hadoop-yarn-common/yarn-default.xml)
        * [MapReduce](https://hadoop.apache.org/docs/current/hadoop-mapreduce-client/hadoop-mapreduce-client-core/mapred-default.xml)
        * [Spark](https://spark.apache.org/docs/2.2.3/configuration.html#available-properties)
        * [Flume 1.8.0](https://flume.apache.org/releases/content/1.8.0/FlumeUserGuide.html#flume-properties)
        * [HBASE](https://hbase.apache.org/book.html#hbase_default_configurations)
        * [HIVE](https://cwiki.apache.org/confluence/display/Hive/Configuration+Properties)
        * [SQOOP](https://sqoop.apache.org/docs/1.4.6/SqoopUserGuide.html#_additional_import_configuration_properties)
        * [Tez 0.9.1](https://tez.apache.org/releases/0.9.1/tez-api-javadocs/configs/TezConfiguration.html)
        * [Zeppelin 0.7.3](https://zeppelin.apache.org/docs/0.7.3/install/configuration.html)
        * [ZooKeeper 3.4.6](http://zookeeper.apache.org/doc/r3.4.6/zookeeperAdmin#sc_configuration)
    1. Выберите или создайте сеть для кластера.
    1. Включите опцию **UI Proxy**, чтобы получить доступ к [веб-интерфейсам компонентов](../../data-proc/concepts/ui-proxy.md) {{ dataproc-name }}.
    1. Настройте подкластеры: не больше одного главного подкластера с управляющим хостом (обозначается как **Мастер**) и подкластеры для хранения данных или вычислений.
    
        {% note info %}
        
        Для проведения вычислений на кластерах у вас должен быть хотя бы один подкластер типа `Compute` или `Data`.
        
        {% endnote %}
    
        Роли подкластеров (`Compute` и `Data`) различаются тем, что на `Data`-подкластерах можно разворачивать компоненты для хранения данных, а на `Compute` — компоненты обработки данных. Хранилище на подкластере `Compute` предназначено только для временного хранения обрабатываемых файлов.
    1. Для каждого подкластера можно настроить:
    
        * Количество хостов.
        * [Класс хостов](../../data-proc/concepts/instance-types.md) — платформа и вычислительные ресурсы, доступные хосту.
        * Размер и тип хранилища.
        * Подсеть сети, в которой расположен кластер.
    
    1. Для `Compute` подкластеров можно задать параметры [автоматического масштабирования](../../data-proc/concepts/autoscaling.md).
    1. После того как все нужные подкластеры настроены, нажмите кнопку **Создать кластер**.

{% endlist %}
    
{{ dataproc-name }} запустит операцию создания кластера. После того как кластер перейдет в статус **Running**, вы можете [подключиться](../../data-proc/operations/connect.md) к любому активному подкластеру с помощью указанного SSH-ключа.
    
{% endcut %}

После создания кластера необходимо добавить его в настройки проекта:
1. {% include [include](../../_includes/datasphere/first-step.md) %}
1. Нажмите значок ![image](../../_assets/options.svg) в строке проекта, который требуется настроить.
1. В открывшемся меню нажмите кнопку **Изменить**.
1. В открывшемся окне нажмите **Дополнительные настройки**.
1. В поле **Кластер {{ dataproc-name }}** укажите только что созданный кластер.

## Запустите вычислительную операцию на кластере {{ dataproc-name }} {#run-code}

Чтобы запустить вычисления на кластере, созданном из интерфейса ноутбука: 
1. Откройте проект, для которого вы создали кластер Data Proc.
1. В ячейку вставьте код для вычисления, например:

    ```
    #!spark --cluster <имя кластера>
    import random
    
    def inside(p):
        x, y = random.random(), random.random()
        return x*x + y*y < 1
    
    NUM_SAMPLES = 1_000_000
    
    count = sc.parallelize(range(0, NUM_SAMPLES)) \
                 .filter(inside).count()
    print("Pi is roughly %f" % (4.0 * count / NUM_SAMPLES))
    ```
   
   Где:
   * `#!spark --cluster <имя кластера>` — обязательная системная команда для запуска вычислений на кластере. Посмотреть имя кластера можно в окне **Data Proc Clusters** в меню **File**.
1. Нажмите значок ![image](../../_assets/datasphere/jupyterlab/run.svg) для запуска вычисления.

Дождитесь запуска вычисления. Под ячейкой в процессе вычисления будут отображаться логи.

## Удалите кластер {{ dataproc-name }} {#delete}

Если вы создали кластер через интерфейс ноутбука в сервисе {{ ml-platform-name }}, он будет автоматически удален после двух часов бездействия. Или вы можете удалить его вручную также через интерфейс ноутбука.

Кластер, созданный самостоятельно, необходимо удалить в сервисе {{ dataproc-name }}. 

### Удалите кластер через интерфейс ноутбука в сервисе {{ ml-platform-name }} {#delete-notebook}

Чтобы удалить кластер через интерфейс ноутбука:
1. {% include [include](../../_includes/datasphere/first-step.md) %}
1. Выберите проект, в котором необходимо удалить кластер {{ dataproc-name }}.
1. В верхней панели нажмите **File** и выберите **Data Proc Clusters**.
1. В открывшемся окне в строке кластера нажмите кнопку **Destroy**.

### Удалите кластер в сервисе {{ dataproc-name }} {#delete-console}

{% list tabs %}

- Консоль управления

    Чтобы удалить кластер:
    1. В [консоли управления]({{ link-console-main }}) откройте каталог с кластером, который необходимо удалить.
    1. Выберите сервис **{{ dataproc-name }}**.
    1. Нажмите значок ![image](../../_assets/options.svg) для нужного кластера и выберите пункт **Удалить**.
    1. Подтвердите удаление кластера.

    {{ dataproc-name }} запустит операцию удаления кластера.

{% endlist%}