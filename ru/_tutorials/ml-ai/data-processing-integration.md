# Интеграция с сервисом {{ dataproc-full-name }}

Вы можете использовать кластеры Apache Spark™, развернутые в сервисе {{ dataproc-full-name }}, в проектах {{ ml-platform-full-name }}. Чтобы в {{ ml-platform-name }} настроить интеграцию с сервисом {{ dataproc-name }}:

1. [Подготовьте инфраструктуру](#infra).
1. [Создайте бакет](#create-bucket).
1. [Создайте кластер {{ dataproc-name }}](#create-cluster).
1. [Настройте проект {{ ml-platform-name }}](#project).
1. [Запустите вычисления](#run-code).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin-datasphere.md) %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки кластера {{ dataproc-name }} входит плата за вычислительные ресурсы кластера и объем хранилища (см. [тарифы {{ dataproc-name }}](../../data-proc/pricing.md)).

## Подготовьте инфраструктуру {#infra}

{% include [intro](../../_includes/datasphere/infra-intro.md) %}

{% include [intro](../../_includes/datasphere/federation-disclaimer.md) %}

### Создайте каталог и сеть {#create-folder}

Создайте каталог, в котором будет работать ваш кластер {{ dataproc-name }}.

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) выберите облако и нажмите ![create](../../_assets/console-icons/plus.svg)**{{ ui-key.yacloud.component.console-dashboard.button_action-create-folder }}**.
   1. Введите имя каталога, например `data-folder`.
   1. Выберите опцию **{{ ui-key.yacloud.iam.cloud.folders-create.field_default-net }}**. Будет создана [сеть](../../vpc/concepts/network.md#network) с подсетями в каждой [зоне доступности](../../overview/concepts/geo-scope.md).
   1. Нажмите **{{ ui-key.yacloud.iam.cloud.folders-create.button_create }}**.

{% endlist %}

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

#### Создайте NAT-шлюз для доступа в интернет {#create-nat}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В каталоге `data-folder` выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
   1. На панели слева выберите ![image](../../_assets/console-icons/arrows-opposite-to-dots.svg) **{{ ui-key.yacloud.vpc.switch_gateways }}**.
   1. Нажмите **{{ ui-key.yacloud.common.create }}** и задайте настройки шлюза:
      * Введите имя шлюза, например `nat-for-cluster`.
      * **{{ ui-key.yacloud.vpc.gateways.field_type }}** шлюза — **{{ ui-key.yacloud.vpc.gateways.value_gateway-type-egress-nat }}**.
      * Нажмите **{{ ui-key.yacloud.common.save }}**.
   1. На панели слева выберите ![image](../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.vpc.network.switch_route-table }}**.
   1. Нажмите **{{ ui-key.yacloud.common.create }}** и введите параметры таблицы маршрутизации:
      1. Введите имя, например `route-table`.
      1. Выберите сеть `data-network`.
      1. Нажмите **{{ ui-key.yacloud.vpc.route-table-form.label_add-static-route }}**.
         * В открывшемся окне в поле **{{ ui-key.yacloud.vpc.add-static-route.field_next-hop-address }}** выберите **{{ ui-key.yacloud.vpc.add-static-route.value_gateway }}**.
         * В поле **{{ ui-key.yacloud.vpc.add-static-route.value_gateway }}** выберите созданный NAT-шлюз. Префикс назначения заполнится автоматически.
         * Нажмите **{{ ui-key.yacloud.vpc.add-static-route.button_add }}**.
   1. Нажмите **{{ ui-key.yacloud.vpc.route-table.create.button_create }}**.

  Затем привяжите таблицу маршрутизации к одной из подсетей, чтобы направить трафик из нее через NAT-шлюз:

   1. На панели слева выберите ![image](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.vpc.switch_networks }}**.
   1. В строке нужной подсети нажмите ![image](../../_assets/console-icons/ellipsis.svg).
   1. В открывшемся меню выберите пункт **{{ ui-key.yacloud.vpc.subnetworks.button_action-add-route-table }}**.
   1. В открывшемся окне выберите созданную таблицу в списке.
   1. Нажмите **{{ ui-key.yacloud.vpc.subnet.add-route-table.button_add }}**.

{% endlist %}

### Создайте сервисный аккаунт кластера {#create-sa}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. Перейдите в каталог `data-folder`.
   1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
   1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
   1. Введите имя [сервисного аккаунта](../../iam/concepts/users/service-accounts.md), например `sa-for-data-proc`.
   1. Нажмите **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** и назначьте сервисному аккаунту [роли](../../iam/concepts/access-control/roles.md):
      * `dataproc.agent` — для создания и использования кластеров {{ dataproc-name }}.
      * `dataproc.provisioner` — для [автомасштабирования подкластеров](../../data-proc/concepts/autoscaling.md).
      * `vpc.user` — для работы с сетью кластера {{ dataproc-name }}.
      * `iam.serviceAccounts.user` — для создания ресурсов в каталоге от имени сервисного аккаунта.

   1. Нажмите **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

{% endlist %}

### Сгенерируйте пару ключей SSH {#ssh}

Для безопасного подключения к хостам кластера {{ dataproc-name }} потребуются [SSH-ключи](../../glossary/ssh-keygen.md). Если у вас уже есть сгенерированные SSH-ключи, вы можете пропустить этот шаг.

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

1. Перейдите на вкладку **{{ ui-key.yc-ui-datasphere.project-page.tab.settings }}**.
1. В блоке **{{ ui-key.yc-ui-datasphere.edit-project-page.advanced-settings }}** нажмите кнопку **![pencil](../../_assets/console-icons/pencil-to-line.svg) {{ ui-key.yc-ui-datasphere.common.edit }}**.
1. Укажите параметры:
   * **{{ ui-key.yc-ui-datasphere.project-page.settings.default-folder }}** — `data-folder`.
   * **{{ ui-key.yc-ui-datasphere.project-page.settings.service-account }}** — `sa-for-data-proc`.
   * **{{ ui-key.yc-ui-datasphere.project-page.settings.subnet }}** — подсеть зоны доступности `{{ region-id }}-a` в каталоге `data-folder`.

     {% include [subnet-create](../../_includes/subnet-create.md) %}

   * [Группу безопасности](../../vpc/concepts/security-groups.md), если они используются в вашей организации.

1. Нажмите **{{ ui-key.yc-ui-datasphere.common.save }}**.

## Создайте бакет {#create-bucket}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать бакет.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.storage.buckets.button_create }}**.
  1. В поле **{{ ui-key.yacloud.storage.bucket.settings.field_name }}** укажите имя бакета.
  1. В полях **{{ ui-key.yacloud.storage.bucket.settings.field_access-read }}**, **{{ ui-key.yacloud.storage.bucket.settings.field_access-list }}** и **{{ ui-key.yacloud.storage.bucket.settings.field_access-config-read }}** выберите **{{ ui-key.yacloud.storage.bucket.settings.access_value_private }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.storage.buckets.create.button_create }}**.

{% endlist %}

## Создайте кластер {{ dataproc-name }} {#create-cluster}

Перед созданием кластера убедитесь, что в вашем облаке имеется достаточный суммарный объем SSD-дисков (по умолчанию для нового облака выделяется 200 ГБ).

Посмотреть имеющиеся у вас ресурсы можно в консоли управления в разделе [Квоты]({{ link-console-quotas }}).

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать кластер.
   1. Нажмите **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** и выберите **{{ ui-key.yacloud.iam.folder.dashboard.value_data-proc }}** в выпадающем списке.
   1. Введите имя кластера в поле **{{ ui-key.yacloud.mdb.forms.base_field_name }}**. Имя кластера должно быть уникальным в рамках каталога.
   1. В поле **{{ ui-key.yacloud.mdb.forms.config_field_version }}** выберите `2.0`.
   1. В поле **{{ ui-key.yacloud.mdb.forms.config_field_services }}** выберите: `LIVY`, `SPARK`, `YARN` и `HDFS`.
   1. Вставьте в поле **{{ ui-key.yacloud.mdb.forms.config_field_public-keys }}** публичную часть вашего SSH-ключа.
   1. В поле **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}** выберите `sa-for-data-proc`.
   1. В поле **{{ ui-key.yacloud.mdb.forms.config_field_zone }}** выберите `{{ region-id }}-a`.
   1. При необходимости в поле **{{ ui-key.yacloud.mdb.forms.config_field_properties }}** задайте свойства Hadoop и его компонентов, например:

      ```text
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

   1. В поле **{{ ui-key.yacloud.mdb.forms.config_field_bucket }}** выберите созданный бакет.
   1. Выберите сеть для кластера.
   1. Включите опцию **{{ ui-key.yacloud.mdb.forms.config_field_ui_proxy }}**, чтобы получить доступ к [веб-интерфейсам компонентов](../../data-proc/concepts/interfaces.md) {{ dataproc-name }}.
   1. Настройте подкластеры: не больше одного главного подкластера с управляющим хостом (обозначается как **{{ ui-key.yacloud.mdb.forms.label_master-subcluster }}**) и подкластеры для хранения данных или вычислений.

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
   1. После настройки всех подкластеров нажмите **{{ ui-key.yacloud.mdb.forms.button_create }}**.

{% endlist %}

{{ dataproc-name }} запустит операцию создания кластера. После того как кластер перейдет в статус **{{ ui-key.yc-ui-datasphere.data-proc.running }}**, вы можете [подключиться](../../data-proc/operations/connect.md) к любому активному подкластеру с помощью указанного SSH-ключа.

Созданный кластер {{ dataproc-name }} появится в проекте {{ ml-platform-name }} в разделе **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** ⟶ **{{ ui-key.yc-ui-datasphere.resources.dataProc }}** ⟶ **{{ ui-key.yc-ui-datasphere.data-proc.available-clusters }}**.

## Запустите вычисления на кластере {#run-code}

1. {% include [include](../../_includes/datasphere/ui-before-begin.md) %}
1. В ячейку вставьте код для вычисления, например:

   ```python
   #!spark --cluster <имя_кластера>
   import random

   def inside(p):
       x, y = random.random(), random.random()
       return x*x + y*y < 1
   
   NUM_SAMPLES = 1_000_000
   
   count = sc.parallelize(range(0, NUM_SAMPLES)) \
       .filter(inside).count()
   print("Pi is roughly %f" % (4.0 * count / NUM_SAMPLES))
   ```

   Где `#!spark --cluster <имя_кластера>` — обязательная системная команда для запуска вычислений на кластере.

   Дождитесь запуска вычисления. Под ячейкой в процессе вычисления будут отображаться логи.

1. Запишите данные в S3, указав имя бакета:

   ```python
   #!spark 
   data = [[1, "tiger"], [2, "lion"], [3, "snow leopard"]]
   df = spark.createDataFrame(df, schema="id LONG, name STRING")
   df.repartition(1).write.option("header", True).csv("s3://<имя_бакета>/")
   ```

1. Запустите ячейки, выбрав в меню **Run** ⟶ **Run Selected Cells** (также можно использовать сочетание клавиш **Shift** + **Enter**).

После этого файл появится в бакете. Чтобы просматривать содержимое бакета в интерфейсе {{ jlab }}Lab, создайте и активируйте в проекте [коннектор S3](../../datasphere/operations/data/s3-connectors.md).

{% include [dataproc-s3-connector](../../_includes/datasphere/data-processing-s3-connector.md) %}

Подробнее о запуске вычислений на кластерах {{ dataproc-name }} в {{ ml-platform-name }} см. в [концепции](../../datasphere/concepts/data-processing.md#existing-clusters).

## Удалите созданные ресурсы {#clear-out}

{% note warning %}

Используя кластер, развернутый в сервисе {{ dataproc-name }}, вы управляете его жизненным циклом самостоятельно. Кластер будет работать и [тарифицироваться](../../data-proc/pricing.md), пока вы его не выключите.

{% endnote %}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

* [объекты](../../storage/operations/objects/delete-all.md) из бакета;
* [бакет](../../storage/operations/buckets/delete.md);
* [кластер](../../data-proc/operations/cluster-delete.md);
* [проект](../../datasphere/operations/projects/delete.md);
* [подсеть](../../vpc/operations/subnet-delete.md);
* [таблицу маршрутизации](../../vpc/operations/delete-route-table.md);
* [NAT-шлюз](../../vpc/operations/delete-nat-gateway.md);
* [сеть](../../vpc/operations/network-delete.md);
* [сервисный аккаунт](../../iam/operations/sa/delete.md).
