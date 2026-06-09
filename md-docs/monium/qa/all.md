# Вопросы и ответы про {{ monitoring-name }}

## Общие вопросы {#general}

# Общие вопросы про {{ monitoring-name }}

#### Я могу получить логи моей работы в сервисах? {#logs}

Да, вы можете запросить информацию о работе с вашими ресурсами из логов сервисов {{ yandex-cloud }}. Для этого обратитесь в [техническую поддержку]({{ link-console-support }}).

#### Как посмотреть сервисные дашборды? {#dont-see-dashboards}

Сервисные дашборды создаются автоматически после создания ресурсов в {{ yandex-cloud }}. Добавьте необходимый ресурс и обновите [главную страницу]({{ link-monitoring }}) сервиса {{ monitoring-name }}.

#### Почему пропали старые данные графиков в {{ monitoring-name }}? {#lost-data-graphs}

Метрики, для которых новые значения не поступали в течение 30 дней, автоматически удаляются из {{ monitoring-name }}. Для сервиса {{ managed-prometheus-name }} этот срок составляет 60 дней, для сервиса {{ compute-full-name }} — 7 дней.

Существует также ненастраиваемый механизм прореживания данных, сокращающий их объем в хранилищах.

#### Почему не передаются метрики и нельзя создать воркспейс {{ prometheus-name }}? {#prometheus-trouble}

Такое возможно, если в облаке нет [ресурсов](../../overview/roles-and-resources.md#resources), которые передают данные мониторинга. Начните использовать какой-либо ресурс и дождитесь, когда метрики начнут отображаться в {{ monitoring-name }}.

## Навигация {#navigation}

# Навигация

#### Где посмотреть график RAM на виртуальной машине? {#ram-graphs-overview}

Сервис {{ compute-full-name }} не может измерить потребление vRAM внутри гостевой операционной системы: для сервиса потребление памяти ВМ всегда одинаковое — то, которое выделено в момент ее запуска.

Вы можете самостоятельно настроить сбор пользовательских метрик [через API](../../monitoring/operations/metric/add.md), а для Linux-совместимых ОС — с помощью [агента для поставки системных метрик](../../monitoring/operations/unified-agent/linux_metrics.md).

#### Где посмотреть график места на диске ВМ? {#space-graphs-overview}

{{ monitoring-name }} не имеет доступа к гостевым ОС, поэтому такой метрики нет.

Вы можете самостоятельно настроить сбор пользовательских метрик [через API](../../monitoring/operations/metric/add.md), а для Linux-совместимых ОС — с помощью [агента для поставки системных метрик](../../monitoring/operations/unified-agent/linux_metrics.md).

## Сбор и экспорт метрик {#metrics-export}

# Сбор и экспорт метрик

#### Как добавить метрику RAM на виртуальной машине? {#add-metrics-ram}

Сервис {{ compute-full-name }} не может измерить потребление vRAM внутри гостевой операционной системы: для сервиса потребление памяти ВМ всегда одинаковое — то, которое выделено в момент ее запуска.

Вы можете самостоятельно настроить сбор пользовательских метрик [через API](../../monitoring/operations/metric/add.md), а для Linux-совместимых ОС — с помощью [агента для поставки системных метрик](../../monitoring/operations/unified-agent/linux_metrics.md). Агент позволяет собирать статистику использования большинства системных ресурсов: процессор, память, сеть, диск.

#### Как добавить метрику места на диске виртуальной машины? {#add-metrics-space}

{{ monitoring-name }} не имеет доступа к гостевым ОС, поэтому такой метрики нет.

Вы можете самостоятельно настроить сбор пользовательских метрик [](../../monitoring/operations/metric/add.md), а для Linux-совместимых ОС — с помощью [агента для поставки системных метрик](../../monitoring/operations/unified-agent/linux_metrics.md). Агент позволяет собирать статистику использования большинства системных ресурсов: процессор, память, сеть, диск.

#### Как собирать свои метрики из приложения? {#collect-1st-party}

[{{ unified-agent-full-name }}](../../monitoring/operations/unified-agent/pull_prometheus.md) поддерживает сбор метрик в формате {{ prometheus-name }} и конвертацию метрик в формат {{ monitoring-name }}. Таким образом, при помощи {{ unified-agent-short-name }} можно собирать метрики любых приложений, предоставляющих метрики в формате {{ prometheus-name }}.

Воспользуйтесь [клиентской библиотекой](https://prometheus.io/docs/instrumenting/clientlibs/) для языка программирования, на котором написано ваше приложение, и передавайте метрики в {{ monitoring-name }} в формате {{ prometheus-name }}.

{% list tabs group=programming_language %}

- Go {#go}

  [Клиентская библиотека Prometheus для Go](https://github.com/prometheus/client_golang).

- Python {#python}

  [Клиентская библиотека Prometheus для Python](https://github.com/prometheus/client_python).

- PHP {#php}

  [Клиентская библиотека Prometheus для PHP](https://github.com/promphp/prometheus_client_php).

- Java {#java}

  [Клиентская библиотека Prometheus для Java](https://github.com/prometheus/client_java).

- Node.js {#node}

  [Клиентская библиотека Prometheus для Node.js](https://github.com/siimon/prom-client).

- C++ {#cpp}

  [Клиентская библиотека Prometheus для C++](https://github.com/jupp0r/prometheus-cpp).

{% endlist %}

Примеры приведены в следующих разделах документации:
* [{#T}](../../monitoring/operations/unified-agent/pull_prometheus.md).
* [{#T}](../../monitoring/operations/unified-agent/haproxy.md).

#### Можно ли поставлять в {{ monitoring-name }} метрики кластера {{ managed-k8s-full-name }}? {#collect-k8s}

Да, для этого используйте приложение [Metrics Provider](https://yandex.cloud/ru/marketplace/products/yc/metric-provider). Чтобы установить его, [воспользуйтесь инструкцией](../../managed-kubernetes/operations/applications/metrics-provider.md).

#### Как поставлять в {{ monitoring-name }} метрики сторонних приложений? {#collect-3rd-party}

Для поставки в {{ monitoring-name }} метрик сторонних приложений используется {{ unified-agent-short-name }}, в котором сконфигурирован вход `metrics_pull`. {{ unified-agent-short-name }} периодически опрашивает напрямую стороннее приложение, если оно поддерживает метрики в формате {{ prometheus-name }}, или специальное приложение-экспортер, реализующее интеграцию с {{ prometheus-name }}.

В разделе [{#T}](../../monitoring/operations/unified-agent/haproxy.md) приведен пример настройки поставки метрик HAProxy.

#### Как поставлять метрики с хостов вне {{ yandex-cloud }}? {#collect-external}

Настройте [авторизованные ключи сервисных аккаунтов](../../monitoring/operations/unified-agent/non-yc.md) для передачи метрик в {{ monitoring-name }} через {{ unified-agent-short-name }}.

Используйте эту методику и для отправки метрик с ВМ {{ yandex-cloud }} без привязанного сервисного аккаунта.

#### Как посмотреть список метрик? {#metrics-list}

Для этого откройте раздел **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.explorer.title }}** и выберите нужный сервис.

Чтобы получить полный список метрик, принадлежащих определенному облаку и каталогу, воспользуйтесь [инструкцией по запросу к API](../../monitoring/operations/metric/list.md).

#### Можно ли экспортировать метрики в формате {{ prometheus-name }}? {#export-prometheus}

Для экспорта метрик в формате {{ prometheus-name }} воспользуйтесь методом [prometheusMetrics](../../monitoring/api-ref/MetricsData/prometheusMetrics.md).

Пример настройки экспорта описан в [документации](../../monitoring/operations/metric/prometheusExport.md).

## Метрики и единицы измерения {#metrics-measure}

# Метрики и единицы измерения

#### Что означает запятая? {#comma}

Запятая отделяет целую часть числа от дробной. Например, значение `123,456` следует трактовать как 123 целых 456 тысячных.

#### Почему cpu_usage более 100%? {#cpu-usage}

Вы используете виртуальную машину с [гарантированной долей](../../compute/concepts/performance-levels.md) ниже 100% vCPU. Например, гарантировано 20% производительности vCPU. Для системы мониторинга эта доля принимается за 100% ожидаемой нагрузки. Если на физическом ядре не окажется «соседей», вашей ВМ может быть выдано до 100% мощности vCPU, что в 5 раз больше гарантированной доли. На графике может отобразиться до 500%.

Если вы видите превышение верхней границы 100% на графиках длительное время, рекомендуем увеличить гарантированную долю vCPU. В любой момент на физическом ядре могут появиться «соседи», и реальное потребление vCPU может упасть до гарантированных 20% (около 400 МГц для платформы Intel Cascade Lake).

#### Где посмотреть описание метрик баз данных? {#metrics-description}

Описания метрик приведены в документации к сервисам, например:
* [{{ mpg-full-name }}](../../managed-postgresql/operations/monitoring.md).
* [{{ mmy-full-name }}](../../managed-mysql/operations/monitoring.md).
* [{{ mrd-full-name }}](../../managed-valkey/operations/monitoring.md).

Важные метрики выведены на сервисные дашборды каждого сервиса. Полный список метрик для каждого сервиса доступен в разделе **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.explorer.title }}**. Выгрузить полный список метрик можно по [инструкции](../../monitoring/operations/metric/list.md).

#### Как настроить единицы измерения на графике? {#graph-units}

Единицы измерения настраиваются во вкладке **{{ ui-key.yacloud_monitoring.wizard.tab.axes }}** при редактировании графика. Можно выбрать тип единицы измерения, задать формат чисел, масштаб (линейный или логарифмический), максимальное и минимальное значения.

#### Как отображаются максимумы/пики на графиках? {#graph-peaks}

{{ monitoring-name }} получает метрики за определенный период времени группами и при создании точки усредняет значения. При уменьшении масштаба временного отрезка количество значений в выборке увеличивается, и пиковые значения на графике могут расти.

Это работает и в обратную сторону — при выборе большего интервала времени точечные пиковые значения сглаживаются и могут не быть видны на графике.

#### Почему график пропал или выглядит обрезанным? {#graph-lost}

Данные могли попасть за пределы установленных границ графика. Проверьте настройки масштаба, а также максимального и минимального значений на вкладке **{{ ui-key.yacloud_monitoring.wizard.tab.axes }}**.

#### Есть ли описание функций в языке запросов? {#function-description}

Описание функций приведено в [Справочнике](../../monitoring/concepts/querying.md#functions).

Вы можете протестировать функции в разделе **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.explorer.title }}**.

## Алерты/уведомления {#alerts}

# Алерты/уведомления

#### Как уменьшить число ложных срабатываний алерта? {#reduce-false-alerts}

Вы можете увеличить [окно вычисления](../../monitoring/concepts/alerting/alert.md#evaluation-window) или поменять [функцию агрегации](../../monitoring/concepts/alerting/alert.md#aggregation) в параметрах [алерта](../../monitoring/concepts/alerting/alert.md#alert-parameters).

#### Какое значение указывать в пороге? {#threshold-values}

Значение порога задают в единицах измерения выбранной метрики.

Например, для порога свободного места на диске кластера баз данных значение указывается в байтах. Значение порога удобно задавать, передвигая ползунок на графике с реальными данными. Значение порога для **{{ ui-key.yacloud_monitoring.alert-template.threshold-status.warn }}** не должно превышать значение порога для **{{ ui-key.yacloud_monitoring.alert-template.threshold-status.alarm }}**.

#### Как задать получателя алерта? {#alert-recipient}

В [канале уведомлений](../../monitoring/concepts/alerting/notification-channel.md) поддерживаются следующие методы:

* `{{ ui-key.yacloud_monitoring.channel.title_method-email }}`.
* `{{ ui-key.yacloud_monitoring.channel.title_method-sms }}`.
* `{{ ui-key.yacloud_monitoring.channel.title_method-push }}` (в [мобильном приложении](../../overview/mobile-app/index.md) {{ yandex-cloud }}).
* `Telegram`.
* `{{ sf-name }}`.

В качестве получателя почтовых уведомлений нужно указать аккаунт в {{ yandex-cloud }}. Это может быть аккаунт владельца или специально добавленный для этих целей [дополнительный аккаунт](../../iam/concepts/index.md#accounts), например федеративный аккаунт или Яндекс ID.

#### Почему пользователю не приходят алерты? {#alert-receive-failed}

Проверьте настройки почтового ящика и номера телефона в аккаунте пользователя в [канале уведомлений](../../monitoring/concepts/alerting/notification-channel.md).

Чтобы получать уведомления, пользователь должен:

* иметь роль `monitoring.viewer` на каталог, в котором настроен алерт.
* в [настройках]({{ link-console-main }}/settings) консоли управления:
    * включить опцию **{{ ui-key.yacloud_components.settings.label_monitoring-name }}**;
    * указать адрес электронной почты, номер телефона и Telegram-аккаунт или группу.

#### Что делать, если нет данных? {#alert-no-data}

При отсутствии данных отображается временная шкала за последний час. Чтобы увидеть данные, измените время в [окне вычисления](../../monitoring/concepts/alerting/alert.md#evaluation-window) — в него должна войти последняя точка.

Если ошибок функций нет, то данные отображаться не будут. Подробнее см. в разделе [Обработка отсутствия данных](../../monitoring/concepts/alerting/alert.md#no-data-policy)