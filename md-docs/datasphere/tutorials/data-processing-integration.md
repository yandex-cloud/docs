# Интеграция с сервисом Yandex Data Processing

# Интеграция с сервисом Yandex Data Processing

Вы можете использовать кластеры Apache Spark™, развернутые в сервисе Yandex Data Processing, в проектах Yandex DataSphere. Чтобы в DataSphere настроить интеграцию с сервисом Yandex Data Processing:

1. [Подготовьте инфраструктуру](#infra).
1. [Создайте бакет](#create-bucket).
1. [Создайте кластер Yandex Data Processing](#create-cluster).
1. [Настройте проект DataSphere](#project).
1. [Запустите вычисления](#run-code).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки описываемого решения входят:

* Плата за кластер Yandex Data Processing (см. [тарифы Yandex Data Processing](../../data-proc/pricing.md)).
* Плата за NAT-шлюз (см. [тарифы Virtual Private Cloud](../../vpc/pricing.md)).
* Плата за бакет Object Storage: хранение данных и выполнение операций с ними (см. [тарифы Object Storage](../../storage/pricing.md)).


## Перед началом работы {#before-you-begin}

Перед началом работы нужно зарегистрироваться в Yandex Cloud, настроить [сообщество](../concepts/community.md) и привязать к нему [платежный аккаунт](../../billing/concepts/billing-account.md):
1. [На главной странице DataSphere](https://datasphere.yandex.cloud) нажмите **Попробовать бесплатно** и выберите аккаунт для входа — Яндекс ID или рабочий аккаунт в федерации (SSO).
1. Выберите [организацию Yandex Identity Hub](../../organization/index.md), в которой вы будете работать в Yandex Cloud.
1. [Создайте сообщество](../operations/community/create.md).
1. [Привяжите платежный аккаунт](../operations/community/link-ba.md) к сообществу DataSphere, в котором вы будете работать. Убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, создайте его в интерфейсе DataSphere.

## Подготовьте инфраструктуру {#infra}

Войдите в [консоль управления](https://console.yandex.cloud) Yandex Cloud и выберите организацию, в которой вы работаете с DataSphere. На странице [**Yandex Cloud Billing**](https://center.yandex.cloud/billing/accounts) убедитесь, что у вас подключен платежный аккаунт.

Если у вас есть активный платежный аккаунт, на [странице облака](https://console.yandex.cloud/cloud) вы можете создать или выбрать каталог, в котором будет работать ваша инфраструктура.

{% note info %}

Если вы работаете с Yandex Cloud через [федерацию удостоверений](../../organization/concepts/add-federation.md), вам может быть недоступна платежная информация. В этом случае обратитесь к администратору вашей организации в Yandex Cloud.

{% endnote %}

### Создайте каталог и сеть {#create-folder}

Создайте каталог, в котором будет работать ваш кластер Yandex Data Processing.

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления](https://console.yandex.cloud) выберите облако и нажмите ![create](../../_assets/console-icons/plus.svg)**Создать каталог**.
   1. Введите имя каталога, например `data-folder`.
   1. Выберите опцию **Создать сеть по умолчанию**. Будет создана [сеть](../../vpc/concepts/network.md#network) с подсетями в каждой [зоне доступности](../../overview/concepts/geo-scope.md).
   1. Нажмите **Создать**.

{% endlist %}

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

#### Создайте NAT-шлюз для доступа в интернет {#create-nat}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В каталоге `data-folder` [перейдите]( ../../console/operations/select-service.md#select-service) в сервис **Virtual Private Cloud**.
   1. На панели слева выберите ![image](../../_assets/console-icons/arrows-opposite-to-dots.svg) **Шлюзы**.
   1. Нажмите **Создать** и задайте настройки шлюза:
      * Введите имя шлюза, например `nat-for-cluster`.
      * **Тип** шлюза — **NAT-шлюз**.
      * Нажмите **Сохранить**.
   1. На панели слева выберите ![image](../../_assets/console-icons/route.svg) **Таблицы маршрутизации**.
   1. Нажмите **Создать** и введите параметры таблицы маршрутизации:
      1. Введите имя, например `route-table`.
      1. Выберите сеть `data-network`.
      1. Нажмите **Добавить маршрут**.
         * В открывшемся окне в поле **Next hop** выберите **Шлюз**.
         * В поле **Шлюз** выберите созданный NAT-шлюз. Префикс назначения заполнится автоматически.
         * Нажмите **Добавить**.
   1. Нажмите **Создать таблицу маршрутизации**.

  Затем привяжите таблицу маршрутизации к одной из подсетей, чтобы направить трафик из нее через NAT-шлюз:

   1. На панели слева выберите ![image](../../_assets/console-icons/nodes-right.svg) **Подсети**.
   1. В строке нужной подсети нажмите ![image](../../_assets/console-icons/ellipsis.svg).
   1. В открывшемся меню выберите пункт **Привязать таблицу маршрутизации**.
   1. В открывшемся окне выберите созданную таблицу в списке.
   1. Нажмите **Привязать**.

{% endlist %}

### Создайте сервисный аккаунт кластера {#create-sa}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. Перейдите в каталог `data-folder`.
   1. [Перейдите]( ../../console/operations/select-service.md#select-service) в сервис **Identity and Access Management**.
   1. Нажмите кнопку **Создать сервисный аккаунт**.
   1. Введите имя [сервисного аккаунта](../../iam/concepts/users/service-accounts.md), например `sa-for-data-proc`.
   1. Нажмите **Добавить роль** и назначьте сервисному аккаунту [роли](../../iam/concepts/access-control/roles.md):
      * `dataproc.agent` — для создания и использования кластеров Yandex Data Processing.
      * `dataproc.provisioner` — для [автомасштабирования подкластеров](../../data-proc/concepts/autoscaling.md).
      * `vpc.user` — для работы с сетью кластера Yandex Data Processing.
      * `iam.serviceAccounts.user` — для создания ресурсов в каталоге от имени сервисного аккаунта.

   1. Нажмите **Создать**.

{% endlist %}

### Сгенерируйте пару ключей SSH {#ssh}

Для безопасного подключения к хостам кластера Yandex Data Processing потребуются [SSH-ключи](../../glossary/ssh-keygen.md). Если у вас уже есть сгенерированные SSH-ключи, вы можете пропустить этот шаг.

{% cut "Как сгенерировать пару ключей SSH" %}

{% list tabs group=operating_system %}

- Linux/macOS {#linux-macos}

  1. Откройте терминал.
  1. Создайте новый ключ с помощью команды `ssh-keygen`:
  
      ```bash
      ssh-keygen -t ed25519 -C "<опциональный_комментарий>"
      ```
  
      Вы можете передать в параметре `-C` пустую строку, чтобы не добавлять комментарий, или не указывать параметр `-C` вообще — в таком случае будет добавлен комментарий по умолчанию.
  
      После выполнения команды вам будет предложено указать имя и путь к файлам с ключами, а также ввести пароль для закрытого ключа. Если задать только имя, пара ключей будет создана в текущей директории. Открытый ключ будет сохранен в файле с расширением `.pub`, закрытый ключ — в файле без расширения.
  
      По умолчанию команда предлагает сохранить ключ под именем `id_ed25519` в директории `/home/<имя_пользователя>/.ssh`. Если в этой директории уже есть SSH-ключ с именем `id_ed25519`, вы можете случайно перезаписать его и потерять доступ к ресурсам, в которых он используется. Поэтому рекомендуется использовать уникальные имена для всех SSH-ключей.

- Windows 10/11 {#windows}

  Если у вас еще не установлен [OpenSSH](https://ru.wikipedia.org/wiki/OpenSSH), установите его по [инструкции](https://learn.microsoft.com/ru-ru/windows-server/administration/openssh/openssh_install_firstuse).
  
  1. Запустите `cmd.exe` или `powershell.exe` (предварительно обновите PowerShell).
  1. Создайте новый ключ с помощью команды `ssh-keygen`:
  
      ```shell
      ssh-keygen -t ed25519 -C "<опциональный_комментарий>"
      ```
  
      Вы можете передать в параметре `-C` пустую строку, чтобы не добавлять комментарий, или не указывать параметр `-C` вообще — в таком случае будет добавлен комментарий по умолчанию.
  
      После выполнения команды вам будет предложено указать имя и путь к файлам с ключами, а также ввести пароль для закрытого ключа. Если задать только имя, пара ключей будет создана в текущей директории. Открытый ключ будет сохранен в файле с расширением `.pub`, закрытый ключ — в файле без расширения.
  
      По умолчанию команда предлагает сохранить ключ под именем `id_ed25519` в папку `C:\Users\<имя_пользователя>/.ssh`. Если в этой директории уже есть SSH-ключ с именем `id_ed25519`, вы можете случайно перезаписать его и потерять доступ к ресурсам, в которых он используется. Поэтому рекомендуется использовать уникальные имена для всех SSH-ключей.

- Windows 7/8 {#windows7-8}

  Создайте ключи с помощью приложения PuTTY:
  
  1. [Скачайте](https://www.putty.org) и установите PuTTY.
  1. Добавьте папку с PuTTY в переменную `PATH`:
  
      1. Нажмите кнопку **Пуск** и в строке поиска Windows введите **Изменение системных переменных среды**.
      1. Справа снизу нажмите кнопку **Переменные среды...**.
      1. В открывшемся окне найдите параметр `PATH` и нажмите **Изменить**.
      1. Добавьте путь к папке в список.
      1. Нажмите кнопку **ОК**.
  
  1. Запустите приложение PuTTYgen.
  1. В качестве типа генерируемой пары выберите **EdDSA**. Нажмите **Generate** и поводите курсором в поле выше до тех пор, пока не закончится создание ключа.
  
      ![ssh_generate_key](../../_assets/compute/ssh-putty/ssh_generate_key.png)
  
  1. В поле **Key passphrase** введите надежный пароль. Повторно введите его в поле ниже.
  1. Нажмите кнопку **Save private key** и сохраните закрытый ключ. Никому не сообщайте ключевую фразу от него.
  1. Нажмите кнопку **Save public key** и сохраните открытый ключ в файле `<имя_ключа>.pub`.

{% endlist %}

{% note warning %}

Надежно сохраните закрытый ключ: без него подключиться к ВМ будет невозможно.

{% endnote %}

{% endcut %}

## Настройте DataSphere {#project}

Чтобы работать с кластерами Yandex Data Processing в DataSphere, создайте и настройте проект.

### Создайте проект {#create-project}

1. Откройте [главную страницу](https://datasphere.yandex.cloud) DataSphere.
1. На панели слева выберите ![image](../../_assets/console-icons/circles-concentric.svg) **Сообщества**.
1. Выберите сообщество, в котором вы хотите создать проект.
1. На странице сообщества нажмите кнопку ![image](../../_assets/console-icons/folder-plus.svg) **Создать проект**.
1. В открывшемся окне укажите имя и (опционально) описание проекта.
1. Нажмите кнопку **Создать**.

### Измените настройки проекта {#change-settings}

1. Перейдите на вкладку **Настройки**.
1. В блоке **Расширенные настройки** нажмите кнопку **![pencil](../../_assets/console-icons/pencil-to-line.svg) Редактировать**.
1. Укажите параметры:
   * **Каталог по умолчанию** — `data-folder`.
   * **Сервисный аккаунт** — `sa-for-data-proc`.
   * **Подсеть** — подсеть зоны доступности `ru-central1-a` в каталоге `data-folder`.

     {% note info %}
     
     Если вы указали подсеть в настройках проекта, подготовка ВМ при первом запуске вычислений может занять больше времени.
     
     {% endnote %}

   * [Группу безопасности](../../vpc/concepts/security-groups.md), если они используются в вашей организации.

1. Нажмите **Сохранить**.

## Создайте бакет {#create-bucket}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором хотите создать бакет.
  1. [Перейдите]( ../../console/operations/select-service.md#select-service) в сервис **Object Storage**.
  1. Нажмите кнопку **Создать бакет**.
  1. В поле **Имя** укажите имя бакета.
  1. В полях **Чтение объектов**, **Чтение списка объектов** и **Чтение настроек** выберите **С авторизацией**.
  1. Нажмите кнопку **Создать бакет**.

{% endlist %}

## Создайте кластер Yandex Data Processing {#create-cluster}

Перед созданием кластера убедитесь, что в вашем облаке имеется достаточный суммарный объем SSD-дисков (по умолчанию для нового облака выделяется 200 ГБ).

Посмотреть имеющиеся у вас ресурсы можно в консоли управления в разделе [Квоты](https://console.yandex.cloud/cloud?section=quotas).

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором нужно создать кластер.
   1. Нажмите **Создать ресурс** и выберите **Кластер Yandex Data Processing** в выпадающем списке.
   1. Введите имя кластера в поле **Имя кластера**. Имя кластера должно быть уникальным в рамках каталога.
   1. В поле **Окружение** выберите `PRODUCTION`.
   1. В поле **Версия** выберите `2.0`.
   1. В поле **Сервисы** выберите: `LIVY`, `SPARK`, `YARN` и `HDFS`.
   1. Вставьте в поле **SSH-ключ** публичную часть вашего SSH-ключа.
   1. В поле **Сервисный аккаунт** выберите `sa-for-data-proc`.
   1. В поле **Зона доступности** выберите `ru-central1-a`.
   1. При необходимости в поле **Свойства** задайте свойства Hadoop и его компонентов, например:

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

   1. В поле **Имя бакета** выберите созданный бакет.
   1. Выберите сеть для кластера.
   1. Включите опцию **UI Proxy**, чтобы получить доступ к [веб-интерфейсам компонентов](../../data-proc/concepts/interfaces.md) Yandex Data Processing.
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
   1. После настройки всех подкластеров нажмите **Создать кластер**.

{% endlist %}

Yandex Data Processing запустит операцию создания кластера. После того как кластер перейдет в статус **Running**, вы можете [подключиться](../../data-proc/operations/connect-ssh.md) к любому активному подкластеру с помощью указанного SSH-ключа.

Созданный кластер Yandex Data Processing появится в проекте DataSphere в разделе **Ресурсы проекта** ⟶ **Yandex Data&nbsp;Processing** ⟶ **Доступные кластеры**.

## Запустите вычисления на кластере {#run-code}

1. Откройте проект DataSphere:
   
   1. Выберите нужный проект в своем сообществе или на [главной странице](https://datasphere.yandex.cloud) DataSphere во вкладке **Недавние проекты**.
   1. Нажмите кнопку **Открыть проект в JupyterLab** и дождитесь окончания загрузки.
   1. Откройте вкладку с ноутбуком.
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

После этого файл появится в бакете. Чтобы просматривать содержимое бакета в интерфейсе JupyterLab, создайте и активируйте в проекте [коннектор S3](../operations/data/s3-connectors.md).

{% note info %}

Чтобы получить из кластера Yandex Data Processing данные больше 100 МБ, используйте [коннектор S3](../operations/data/s3-connectors.md).

{% endnote %}

Подробнее о запуске вычислений на кластерах Yandex Data Processing в DataSphere см. в [концепции](../concepts/data-processing.md#existing-clusters).

## Удалите созданные ресурсы {#clear-out}

{% note warning %}

Используя кластер, развернутый в сервисе Yandex Data Processing, вы управляете его жизненным циклом самостоятельно. Кластер будет работать и [тарифицироваться](../../data-proc/pricing.md), пока вы его не выключите.

{% endnote %}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

* [объекты](../../storage/operations/objects/delete-all.md) из бакета;
* [бакет](../../storage/operations/buckets/delete.md);
* [кластер](../../data-proc/operations/cluster-delete.md);
* [проект](../operations/projects/delete.md);
* [подсеть](../../vpc/operations/subnet-delete.md);
* [таблицу маршрутизации](../../vpc/operations/delete-route-table.md);
* [NAT-шлюз](../../vpc/operations/delete-nat-gateway.md);
* [сеть](../../vpc/operations/network-delete.md);
* [сервисный аккаунт](../../iam/operations/sa/delete.md).

#### См. также {#see-also}

[Временные кластеры Yandex Data Processing, развернутые в DataSphere](../concepts/data-processing-template.md)