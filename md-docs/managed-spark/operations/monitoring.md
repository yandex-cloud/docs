# Мониторинг состояния кластера Apache Spark™

Данные о состоянии кластера и его хостов доступны в [консоли управления](https://console.yandex.cloud). Их можно посмотреть на вкладке **Мониторинг** страницы управления кластером  или в сервисе [Yandex Monitoring](../../monitoring/concepts/index.md).

Диагностическая информация о состоянии кластера представлена в виде графиков.

Графики обновляются раз в 15 секунд.

{% note info %}

На графиках автоматически применяются наиболее подходящие кратные единицы измерения (мегабайты, гигабайты и т. д.).

{% endnote %}

Вы можете [настроить алерты](#monitoring-integration) в сервисе Yandex Monitoring для получения уведомлений о сбоях в работе кластера. В Yandex Monitoring используются два порога срабатывания алерта: `Warning` и `Alarm`. При превышении заданного порога вы получите оповещения через настроенные [каналы уведомлений](../../monitoring/concepts/alerting.md#notification-channel).

## Мониторинг состояния кластера {#monitoring-cluster}

Для просмотра детальной информации о состоянии кластера Apache Spark™:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в нужный каталог.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Managed Service for Apache Spark**.
  1. Нажмите на имя нужного кластера и выберите вкладку **Мониторинг**.

  1. Чтобы перейти к работе с метриками, дашбордами или алертами в сервисе Yandex Monitoring, нажмите кнопку **Открыть в Monium** на панели сверху.

  На странице отображаются графики:

  * В блоке **Cluster Resource Usage**:

    * **Total Allocated Nodes** — количество используемых хостов кластера.
    * **Total Running Containers & Total Running Jobs** — количество запущенных заданий и контейнеров.

      * **Spark Containers** — количество запущенных контейнеров.
      * **Spark Jobs** — количество запущенных заданий.

    * **Pending Containers** — количество контейнеров, ожидающих запуска.
    * **CPU Resources** — доступность процессорных ядер.
  
      * **Allocated CPU** — количество используемых CPU.
      * **Allocatable CPU** — количество доступных для контейнеров CPU.
      * **Capacity CPU** — общее количество CPU в кластере. Часть CPU может быть зарезервирована под системные нужды.

    * **Available CPU** — количество доступных CPU в кластере.
    * **CPU Usage/Limits** — расход CPU контейнерами.

      * **Additional containers CPU limited** — предел использования CPU для служебных контейнеров.
      * **Additional containers CPU usage** — количество CPU, используемое служебными контейнерами.
      * **Spark containers CPU usage** — предел использования CPU для контейнеров Spark-приложений.
      * **Spark containers CPU limited** — количество CPU, используемое контейнерами Spark-приложений.

    * **Memory Resources** — доступность памяти.

      * **Capacity Memory** — общий объем памяти хостов. Часть памяти может быть зарезервирована под системные нужды.
      * **Allocatable Memory** — объем доступной для контейнеров памяти хостов.
      * **Allocated Memory** – используемый объем памяти хостов.

    * **Available Memory** — объем доступной памяти в кластере.
    * **Memory Usage/Limits** – расход памяти контейнерами.

      * **Additional containers Memory limited** — предел памяти для служебных контейнеров.
      * **Additional containers Memory usage** — память, используемая служебными контейнерами.
      * **Spark containers Memory limited** — предел памяти для контейнеров Spark-приложений.
      * **Spark containers Memory usage** — память, используемая контейнерами Spark-приложений.

  * В блоке **Driver Pool**:

    * **Driver Pool: Allocated Nodes** — количество хостов драйверов Apache Spark™.
    * **Driver Pool: Running Containers** — количество работающих контейнеров в пуле драйверов.
    * **Spark Drivers: Running Containers By Nodes** — количество работающих контейнеров по хостам драйверов Apache Spark™.
    * **Spark Drivers: CPU Limits By Nodes** — лимит CPU по хостам драйверов Apache Spark™.
    * **Spark Drivers: Used CPU By Nodes** — используемые CPU по хостам драйверов Apache Spark™.
    * **Driver Pool: Available CPU By Nodes** — доступные CPU по хостам драйверов Apache Spark™.
    * **Spark Drivers: Memory Limits By Nodes** — лимит памяти по хостам драйверов Apache Spark™.
    * **Spark Drivers: Used Memory By Nodes** — используемая память по хостам драйверов Apache Spark™.
    * **Driver Pool: Available Memory By Nodes** — доступная память по хостам драйверов Apache Spark™.

  * В блоке **Executor Pool**:

    * **Executor Pool: Allocated Nodes** — количество хостов исполнителей Apache Spark™.
    * **Executor Pool: Running Containers** — количество работающих контейнеров в пуле исполнителей Apache Spark™.
    * **Spark Executors: Running Containers By Node** — количество работающих контейнеров по хостам исполнителей Apache Spark™.
    * **Spark Executors: CPU Limits By Nodes** — лимит CPU по хостам исполнителей Apache Spark™.
    * **Spark Executors: Used CPU By Nodes** — используемые CPU по хостам исполнителей Apache Spark™.
    * **Executor Pool: Available CPU By Nodes** — доступные CPU по хостам исполнителей Apache Spark™.
    * **Spark Executors: Memory Limits By Nodes** — лимит памяти по хостам исполнителей Apache Spark™.
    * **Spark Executors: Used Memory By Nodes** — используемая память по хостам исполнителей Apache Spark™.
    * **Executor Pool: Available Memory By Nodes** — доступная память по хостам исполнителей Apache Spark™.

  * В блоке **Spark Jobs**:

    * **Running Executors By Jobs** — количество хостов исполнителей Apache Spark™ по выполняемым заданиям.
    * **Spark Application: Running Stages** — количество выполняемых этапов по заданиям.
    * **Spark Application: Active Tasks** — количество выполняемых задач по заданиям.
    * **Spark CPU Limits By Jobs** — лимит CPU по заданиям.
    * **Spark Used CPU By Jobs** — используемые CPU по заданиям.
    * **Spark Application: Completed Stages** — количество завершенных этапов по заданиям.
    * **Spark Memory Limits By Jobs** — лимит памяти по заданиям.
    * **Spark Used Memory By Jobs** — используемая память по заданиям.
    * **Spark Application: Completed Tasks** — количество завершенных задач по заданиям.
    * **Spark Application: Failed Stages** — количество этапов выполнения заданий, завершившихся с ошибками, по заданиям.
    * **Spark Application: Waiting Stages** — количество этапов выполнения заданий в ожидании, по заданиям.
    * **Spark Application: Failed Tasks** — количество задач, завершенных с ошибками, по заданиям.

{% endlist %}

## Настройка алертов в Yandex Monitoring {#monitoring-integration}

Чтобы настроить алерты показателей состояния [кластера](#monitoring-cluster):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог с кластером, для которого нужно настроить алерты.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис ![image](../../_assets/console-icons/display-pulse.svg) **Monitoring**.
  1. В блоке **Сервисные дашборды** выберите **Managed Service for Apache Spark™ — Cluster Overview**.
  1. На нужном графике нажмите на значок ![options](../../_assets/console-icons/ellipsis.svg) и выберите пункт **Создать алерт**.
  1. Если на графике несколько показателей, выберите запрос данных для формирования метрики и нажмите **Продолжить**. Подробнее о языке запросов см. [документацию Yandex Monitoring](../../monitoring/concepts/querying.md).
  1. Задайте пороговые значения `Alarm` и `Warning` для срабатывания алерта.
  1. Нажмите кнопку **Создать алерт**.

{% endlist %}

Чтобы настроить автоматический мониторинг других показателей состояния кластера:

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. [Создайте алерт](../../monitoring/operations/alert/create-alert.md).
    1. Добавьте метрику состояния.
    1. В параметрах алерта задайте значения порогов для оповещения.

{% endlist %}

Полный список поддерживаемых метрик см. в [документации Monitoring](../../monitoring/metrics-ref/managed-spark-ref.md).

## Состояние и статус кластера {#cluster-health-and-status}

**Состояние** кластера указывает на исправность его хостов, а **Статус** показывает, запущен кластер, остановлен или находится в промежуточном состоянии.

Для просмотра состояния и статуса кластера:

1. Перейдите на страницу каталога и выберите **Managed Service for Apache Spark**.
1. Наведите курсор на индикатор в столбце **Доступность** в строке нужного кластера.

### Состояния кластера {#cluster-health}

Состояние | Описание | Предлагаемые действия
:--- | :--- | :---
**ALIVE** | Кластер работает в штатном режиме. | Действий не требуется.
**DEGRADED** | Кластер работает не на полную мощность: минимум один из хостов имеет состояние, отличное от `ALIVE`. | Выполните диагностику:<ul><li>Перейдите на вкладку **Хосты** и посмотрите, какие из них в нерабочем состоянии.</li><li>Перейдите на вкладку **Операции** и убедитесь, что все операции завершились.</li><li>Убедитесь, что кластер не находится в процессе технического обслуживания.</li></ul>Если причины не удалось выяснить самостоятельно, [обратитесь в службу поддержки](https://center.yandex.cloud/support).
**DEAD** | Кластер неработоспособен:  ни один его хост не работает. | [Составьте обращение в службу поддержки](https://center.yandex.cloud/support), указав:<ul><li>Идентификатор кластера.</li><li>Идентификаторы последних операций, которые на нем выполнялись.</li><li>Время по [графикам доступности](#monitoring-cluster), когда кластер перешел в состояние `DEAD`.</li></ul>
**UNKNOWN** | Состояние кластера неизвестно. | [Составьте обращение в службу поддержки](https://center.yandex.cloud/support), указав:<ul><li>Идентификатор кластера.</li><li>Идентификаторы последних операций, которые на нем выполнялись.</li><li>Время по [графикам доступности](#monitoring-cluster), когда кластер перешел в состояние `UNKNOWN`.</li></ul>

### Статусы кластера {#cluster-status}

Статус | Описание | Предлагаемые действия
:--- | :--- | :---
**CREATING** | Идет подготовка к первому запуску | Подождите немного и приступайте к работе. Время создания кластера зависит от класса хостов.
**RUNNING** | Кластер работает в штатном режиме | Действий не требуется.
**STOPPING** | Кластер останавливается | Через некоторое время кластеру будет присвоен статус `STOPPED`, и он будет выведен из работы. Действий не требуется.
**STOPPED** | Кластер остановлен | Запустите кластер, чтобы вернуть его в работу.
**STARTING** | Остановленный ранее кластер запускается | Через некоторое время кластеру будет присвоен статус `RUNNING`. Подождите немного и приступайте к работе.
**UPDATING** | Обновляется конфигурация кластера | По завершении обновления кластеру будет присвоен статус, который был до обновления: `RUNNING` или `STOPPED`.
**ERROR** | Произошла ошибка при выполнении операции с кластером или во время окна технического обслуживания | Если кластер долго находится в этом статусе, [обратитесь в службу поддержки](https://center.yandex.cloud/support). Доступность кластера можно определить по его состоянию.
**STATUS_UNKNOWN** | Кластер не может определить свой статус | Если кластер долго находится в этом статусе, [обратитесь в службу поддержки](https://center.yandex.cloud/support).