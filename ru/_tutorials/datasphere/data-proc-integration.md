# Интеграция с сервисом {{ dataproc-full-name }}

Вы можете использовать кластеры Apache Spark™, развернутые в сервисе {{ dataproc-full-name }}, в проектах {{ ml-platform-full-name }}. Чтобы в {{ ml-platform-name }} настроить интеграцию с сервисом {{ dataproc-name }}:

1. [Подготовьте инфраструктуру](#infra).
2. [Создайте кластер {{ dataproc-name }}](#cluster).
3. [Настройте проект {{ ml-platform-name }}](#project).
4. [Запустите вычисления](#run-code).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin-datasphere.md) %}

{% if product == "yandex-cloud" %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки кластера {{ dataproc-name }} входит плата за вычислительные ресурсы кластера и объем хранилища (см. [тарифы {{ dataproc-name }}](../../data-proc/pricing.md)).

{% endif %}

## Подготовьте инфраструктуру {#infra}

{% include [intro](../../_includes/datasphere/infra-intro.md) %}

### Создайте каталог и сеть {#create-folder}

Создайте каталог, в котором будет работать ваш кластер {{ dataproc-name }}.

{% list tabs %}

- Консоль управления

   1. В [консоли управления]({{ link-console-main }}) выберите облако и нажмите кнопку ![create](../../_assets/plus-sign.svg)**Создать каталог**.
   1. Введите имя каталога, например `data-folder`.
   1. Выберите опцию **Создать сеть по умолчанию**. Будет создана [сеть](../../vpc/concepts/network.md#network) с подсетями в каждой [зоне доступности](../../overview/concepts/geo-scope.md).
   1. Нажмите кнопку **Создать**.

{% endlist %}

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

#### Создайте NAT-шлюз для доступа в интернет {#create-nat}

{% list tabs %}

- Консоль управления

   1. В каталоге `data-folder` выберите сервис **{{ vpc-name }}**.
   1. В списке сервисов выберите **{{ vpc-name }}**.
   1. На панели слева выберите **Шлюзы**.
   1. Нажмите кнопку **Создать** и задайте настройки шлюза:
      * Введите имя шлюза, например `nat-for-cluster`.
      * **Тип** шлюза — **NAT в интернет**.
      * Нажмите кнопку **Сохранить**.
   1. На панели слева выберите **Таблицы маршрутизации**.
   1. Нажмите кнопку **Создать** и введите параметры таблицы маршрутизации:
      1. Введите имя, например `route-table`.
      1. Выберите сеть `data-network`.
      1. Нажмите кнопку **Добавить маршрут**.
         * В открывшемся окне в поле **Next hop** выберите **Шлюз**.
         * В поле **Шлюз** выберите созданный NAT-шлюз. Префикс назначения заполнится автоматически.
         * Нажмите кнопку **Добавить**.
      1. Нажмите кнопку **Сохранить**.
   1. Нажмите кнопку **Создать таблицу маршрутизации**.

  Затем привяжите таблицу маршрутизации к одной из подсетей, чтобы направить трафик из нее через NAT-шлюз:

   1. На панели слева выберите ![image](../../_assets/vpc/subnets.svg) **Подсети**.
   1. В строке нужной подсети нажмите кнопку ![image](../../_assets/options.svg).
   1. В открывшемся меню выберите пункт **Привязать таблицу маршрутизации**.
   1. В открывшемся окне выберите созданную таблицу в списке.
   1. Нажмите кнопку **Привязать**.

{% endlist %}

### Создайте сервисный аккаунт кластера {#create-sa}

{% list tabs %}

- Консоль управления

   1. Перейдите в каталог `data-folder`.
   1. На вкладке **Сервисные аккаунты** нажмите кнопку **Создать сервисный аккаунт**.
   1. Введите имя [сервисного аккаунта](../../iam/concepts/users/service-accounts.md), например `sa-for-data-proc`.
   1. Нажмите **Добавить роль** и назначьте сервисному аккаунту [роли](../../iam/concepts/access-control/roles.md):
      * `dataproc.agent` — для создания и использования кластеров {{ dataproc-name }}.
      * `vpc.user` — для работы с сетью кластера {{ dataproc-name }}.

   1. Нажмите кнопку **Создать**.

{% endlist %}

### Сгенерируйте пару ключей SSH {#ssh}

Для безопасного подключения к хостам кластера {{ dataproc-name }} потребуются {% if lang == "ru" and audience != "internal" %}[SSH-ключи](../../glossary/ssh-keygen.md){% else %}SSH-ключи{% endif %}. Если у вас уже есть сгенерированные SSH-ключи, вы можете пропустить этот шаг.

{% cut "Как сгенерировать пару ключей SSH" %}

{% include [vm-ssh-prepare-key](../../_includes/vm-ssh-prepare-key.md) %}

{% note warning %}

Надежно сохраните закрытый ключ: без него подключиться к ВМ будет невозможно.

{% endnote %}

{% endcut %}

## Настройте {{ ml-platform-name }} {#project}

Чтобы работать с кластерами {{ dataproc-name }} в {{ ml-platform-name }}, создайте и настройте проект.

### Создайте проект {#create-project}

{% include [include](../../_includes/datasphere/ui-create-project.md) %}

### Измените настройки проекта {#change-settings}

1. Перейдите на вкладку **Настройки** и нажмите кнопку **![pencil](../../_assets/pencil.svg) Редактировать**.
1. В разделе **Расширенные настройки** задайте:
   * **Каталог** — `data-folder`.
   * **Сервисный аккаунт** — `sa-for-data-proc`.
   * **Подсеть** — подсеть зоны доступности `{{region-id}}-a` в каталоге `data-folder`.

     {% include [subnet-create](../../_includes/subnet-create.md) %}

   * [Группу безопасности](../../vpc/concepts/security-groups.md), если они используются в вашей организации.

1. Нажмите кнопку **Сохранить**.

## Создайте кластер {{ dataproc-name }} {#cluster}

Перед созданием кластера убедитесь, что в вашем облаке имеется достаточный суммарный объем SSD-дисков (по умолчанию для нового облака выделяется 200 ГБ).

Посмотреть имеющиеся у вас ресурсы можно в консоли управления в разделе [Квоты]({{ link-console-quotas }}).

{% list tabs %}

- Консоль управления

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать кластер.
   1. Нажмите кнопку **Создать ресурс** и выберите **Кластер {{ dataproc-name }}** в выпадающем списке.
   1. Введите имя кластера в поле **Имя кластера**. Имя кластера должно быть уникальным в рамках каталога.
   1. В поле **Версия** выберите `2.0`.
   1. В поле **Сервисы** выберите: `LIVY`, `SPARK`, `YARN` и `HDFS`.
   1. Вставьте в поле **Публичный ключ** публичную часть вашего SSH-ключа.
   1. В поле **Сервисный аккаунт** выберите `sa-for-data-proc`.
   1. В поле **Зона доступности** выберите `{{ region-id }}-a`.
   1. При необходимости задайте свойства Hadoop и его компонентов, например:

      ```
      hdfs:dfs.replication : 2
      hdfs:dfs.blocksize : 1073741824
      spark:spark.driver.cores : 1
      ```

      {% cut "Доступные свойства в официальной документации компонентов" %}

      * [Flume 1.8.0](https://flume.apache.org/releases/content/1.8.0/FlumeUserGuide.html#flume-properties)
      * [Hadoop](https://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-common/core-default.xml)
      * [HBASE](https://hbase.apache.org/book.html#hbase_default_configurations)
      * [HDFS](https://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-hdfs/hdfs-default.xml)
      * [HIVE](https://cwiki.apache.org/confluence/display/Hive/Configuration+Properties)
      * [MapReduce](https://hadoop.apache.org/docs/current/hadoop-mapreduce-client/hadoop-mapreduce-client-core/mapred-default.xml)
      * [Spark](https://spark.apache.org/docs/2.2.3/configuration.html#available-properties)
      * [SQOOP](https://sqoop.apache.org/docs/1.4.6/SqoopUserGuide.html#_additional_import_configuration_properties)
      * [Tez 0.9.1](https://tez.apache.org/releases/0.9.1/tez-api-javadocs/configs/TezConfiguration.html)
      * [YARN](https://hadoop.apache.org/docs/current/hadoop-yarn/hadoop-yarn-common/yarn-default.xml)
      * [Zeppelin 0.7.3](https://zeppelin.apache.org/docs/0.7.3/install/configuration.html)
      * [ZooKeeper 3.4.6](http://zookeeper.apache.org/doc/r3.4.6/zookeeperAdmin#sc_configuration)

      {% endcut %}

   1. Выберите сеть для кластера.
   1. Включите опцию **UI Proxy**, чтобы получить доступ к [веб-интерфейсам компонентов](../../data-proc/concepts/interfaces.md) {{ dataproc-name }}.
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
   1. Для `Compute`-подкластеров можно задать параметры [автоматического масштабирования](../../data-proc/concepts/autoscaling.md).
   1. После настройки всех подкластеров нажмите кнопку **Создать кластер**.

{% endlist %}

{{ dataproc-name }} запустит операцию создания кластера. После того как кластер перейдет в статус **Running**, вы можете [подключиться](../../data-proc/operations/connect.md) к любому активному подкластеру с помощью указанного SSH-ключа.

Созданный кластер {{ dataproc-name }} появится в проекте {{ ml-platform-name }} в разделе **Ресурсы** ⟶ **{{ dataproc-name }}** ⟶ **Доступные кластеры**.

## Запустите вычисления на кластере {#run-code}

1. В интерфейсе {{ ml-platform-name }} откройте проект, для которого вы создали кластер {{ dataproc-name }}.
1. Откройте новый ноутбук **DataSphere Kernel**.
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

   Где `#!spark --cluster <имя кластера>` — обязательная системная команда для запуска вычислений на кластере.
1. Нажмите ![Run](../../_assets/datasphere/jupyterlab/run.svg), чтобы запустить выполнение ячейки.

Дождитесь запуска вычисления. Под ячейкой в процессе вычисления будут отображаться логи.

Подробнее о запуске вычислений на кластерах {{ dataproc-name }} в {{ ml-platform-name }} см. [{#T}](../../datasphere/concepts/data-proc.md#session).

## Удалите созданные ресурсы {#clear-out}

{% note warning %}

Используя кластер, развернутый в сервисе {{ dataproc-name }}, вы управляете его жизненным циклом кластера самостоятельно. Кластер будет работать и [тарифицироваться](../../data-proc/pricing.md), пока вы его не выключите.

{% endnote %}

Удалите ресурсы, которые вы больше не будете использовать, во избежание списания средств за них:

{% list tabs %}

- Консоль управления

  Чтобы удалить кластер:
   1. В [консоли управления]({{ link-console-main }}) откройте каталог с кластером, который необходимо удалить.
   1. [Отключите защиту от удаления](../../data-proc/operations/cluster-update.md) для кластера, если она включена.
   1. Выберите сервис **{{ dataproc-name }}**.
   1. Нажмите значок ![image](../../_assets/options.svg) для нужного кластера и выберите пункт **Удалить**.
   1. В открывшемся окне нажмите кнопку **Удалить**.

  {{ dataproc-name }} запустит операцию удаления кластера.

{% endlist %}
