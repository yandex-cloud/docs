# 5. Сбор, мониторинг и анализ аудитных логов

#### Введение {#intro}

Аудитные логи (журналы аудита) — это записи обо всех событиях в системе, включая доступ к ней и выполненные операции. Сбор и проверка аудитных логов позволяют контролировать соблюдение установленных процедур и стандартов безопасности и выявить изъяны в механизмах безопасности.

События в аудитных логах относятся к различным уровням:
* [уровень {{ yandex-cloud }}](#cloud-level) — события, происходящие с ресурсами {{ yandex-cloud }};
* [уровень ОС](#os-level);
* [уровень приложений](#app-level);
* [уровень сети](#network-level) (Flow Logs).

{% note info %}

О событиях {{ k8s }} читайте в разделе [Сбор, мониторинг и анализ аудитных логов в {{ managed-k8s-full-name }}](../../../security/domains/kubernetes.md#collection-monitoring-analysis-audit-logs).

{% endnote %}

#### 5.1 Включен сервис {{ at-full-name }} на уровне организации {#audit-trails}

Основным инструментом сбора логов уровня {{ yandex-cloud }} является сервис [{{ at-full-name }}](../../../audit-trails/concepts/index.md). Сервис позволяет собирать аудитные логи о происходящих с ресурсами {{ yandex-cloud }} событиях и загружать эти логи в бакет {{ objstorage-full-name }} или лог-группу {{ cloud-logging-name }} для дальнейшего анализа или экспорта. См. [инструкцию](../../../audit-trails/quickstart.md), как запустить сбор логов, а также [формат](../../../audit-trails/concepts/format.md) и [справочник](../../../audit-trails/concepts/events.md) событий.

 Для сбора метрик, анализа некоторых событий уровня {{ yandex-cloud }} и настройки оповещений рекомендуется использовать сервис [{{ monitoring-full-name }}](../../../monitoring/).  С его помощью возможно отслеживать, например, резкое возрастание нагрузки на {{ compute-name }}, RPS сервиса {{ alb-name }}, значительные изменения в статистике событий сервиса {{ iam-name }}.

Кроме того, {{ monitoring-name }} можно применять для мониторинга работоспособности самого сервиса {{ at-name }} и мониторинга событий безопасности. Выгрузка метрик в SIEM-систему возможна через [API](../../../glossary/rest-api.md), см. [инструкцию](../../../monitoring/operations/metric/get.md).

[Решение: Мониторинг {{ at-name }} и событий безопасности с помощью {{ monitoring-name }}](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/trail_monitoring)

Аудитные логи возможно экспортировать в лог-группу [{{ cloud-logging-name }}](../../../logging/) или {{ yds-name }} и в SIEM-систему клиента для анализа информации о событиях и инцидентах.

Список важных событий уровня {{ yandex-cloud }} для поиска в аудитных логах:

[Решение: поиск важных событий безопасности в аудитных логах](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/_use_cases_and_searches)

{{ at-full-name }} возможно включить на уровне каталога, облака и организации. Рекомендуется включать {{ at-full-name }} на уровне всей организации — это позволит централизованно собирать аудитные логи, например, в отдельное облако безопасности.

{% list tabs %}

- Проверка в консоли управления

  1. В консоли управления выберите облако или каталог, в которых необходимо проверить функции.
  1. В списке сервисов выберите {{ at-full-name }}.
  1. Убедитесь, что в параметре Фильтр находится значение Организация.
  1. Дополнительно убедитесь, что назначение логов: bucket {{ objstorage-full-name }}, лог-группа [{{ cloud-logging-name }}](../../logging/), {{ yds-name }} в рабочем состоянии и логи доступны для дальнейшего анализа.

{% endlist %}

#### 5.2 События {{ at-full-name }} экспортируются в SIEM-системы {#events}

Решения для экспорта аудитных логов {{ yandex-cloud }} подготовлены для следующих SIEM-систем:

* {{ mes-full-name }} (ELK/Opensearch) — [Сбор, мониторинг и анализ аудитных логов в {{ mes-full-name }}](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/export-auditlogs-to-ELK_main)

* ArcSight — [Сбор, мониторинг и анализ аудитных логов во SIEM ArcSight](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/export-auditlogs-to-ArcSight)

* Splunk — [Сбор, мониторинг и анализ аудитных логов в SIEM Splunk](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/export-auditlogs-to-Splunk)

* MaxPatrol SIEM — [Сбор, мониторинг и анализ аудитных логов в MaxPatrol SIEM](https://cloud.yandex.ru/docs/audit-trails/tutorials/maxpatrol)

* Wazuh — [Сбор, мониторинг и анализ аудитных логов в Wazuh](https://github.com/yandex-cloud/yc-solution-library-for-security/blob/master/auditlogs/export-auditlogs-to-wazuh/README.md)

Вы можете подробнее ознакомиться с MaxPatrol в [разделе](../../../audit-trails/tutorials/maxpatrol.md).

Для настройки экспорта в любые SIEM подходят утилиты [GeeseFS](../../../storage/tools/geesefs.md) или [s3fs](../../../storage/tools/s3fs.md). Они позволяют смонтировать бакет {{ objstorage-full-name }} как локальный диск виртуальной машины. Далее на ВМ необходимо установить коннектор для SIEM и настроить вычитывание JSON-файлов из бакета. Либо утилиты совместимые с AWS Kinesis datastreams в случае, если вы направляете аудит логи в {{ yds-full-name }}.

Вы также можете анализировать аудит логи вручную, если у вас отсутствует SIEM система, одним из следующих образов (в порядке удобства):

* [поиск](../../../audit-trails/tutorials/query.md) событий {{ yandex-cloud }} в {{ yq-full-name }};
* [загрузка](../../../audit-trails/tutorials/logs-analysis.md) аудитных логов в {{ mch-full-name }} и визуализация данных в {{ datalens-full-name }};
* [поиск](../../../audit-trails/tutorials/search-cloud-logging.md) событий {{ yandex-cloud }} в {{ cloud-logging-name }};
* [поиск](../../../audit-trails/tutorials/search-bucket.md) событий {{ yandex-cloud }} в {{ objstorage-name }}.

{% list tabs %}

- Ручная проверка

  Убедитесь, что аудитные логи из {{ at-full-name }} экспортируются для анализа в SIEM-систему либо анализируются в облаке одним из способов.

{% endlist %}

#### 5.3 Настроено реагирование на события {{ at-full-name }} {#reaction}

Вы можете реагировать на события {{ at-full-name }} средствами вашей SIEM системы либо вручную. Либо вы можете использовать автоматическое реагирование.

C помощью {{ sf-full-name }} можно настроить оповещения о событиях {{ at-name }}, а так же автоматическое реагирование на вредоносные действия, например  удаление опасных правил или прав доступа.

[Решение: уведомления и реагирование на события ИБ {{ at-name }} с помощью {{ iam-short-name }} / {{ sf-name }} + Telegram](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/trails-function-detector)

#### 5.4 Выполнен hardering бакета Object Storage, где хранятся аудит логи {{ at-full-name }} {#hardering}

Убедитесь, что в случае записи аудит логов {{ at-full-name }} в bucket {{ objstorage-full-name }} сам бакет настроен в соответствии с лучшими практиками безопасности:

* 4.1 В {{ objstorage-full-name }} включено шифрование данных at rest с помощью ключа KMS.
* 3.8 В {{ objstorage-full-name }} включен механизм логирования действий с бакетом.
* 3.8 В {{ objstorage-full-name }} включена функция **Блокировка версии объекта** (object lock).
* 3.7 В {{ objstorage-full-name }} используются политики доступа (Bucket Policy).
* 3.6 Отсутствует публичный доступ к бакету {{ objstorage-full-name }}.

Вы можете воспользоваться решением для настройки безопасного бакета {{ objstorage-full-name }} с помощью {{ TF }}.

{% list tabs %}

- Ручная проверка

  Выполните проверку вручную.

{% endlist %}

#### 5.5 Выполняется сбор аудит логов с уровня ОС {#os-collection}

При использовании облачных сервисов по модели [IaaS](https://cloud.yandex.ru/blog/posts/2022/01/iaas) и использовании групп узлов {{ k8s }} клиент отвечает за безопасность ОС и выполняет сбор событий уровня ОС самостоятельно. Для сбора стандартных событий, которые генерирует ОС, и их экспорта в SIEM-систему клиента существуют бесплатные инструменты, такие как:
  * [Osquery](https://osquery.io/);
  * [Filebeat (ELK)](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-system.html);
  * [Wazuh](https://documentation.wazuh.com/current/getting-started/use_cases/log_analysis.html).

Дополнительные опции генерации событий возможно реализовать с помощью утилиты Auditd для Linux, Sysmon для Windows.

Системные метрики Linux (процессор, память, диск) можно собирать с помощью компонента [{{ unified-agent-short-name }}](../../../monitoring/concepts/data-collection/unified-agent/index.md) сервиса {{ monitoring-name }}.

Также события ОС возможно экспортировать в {{ cloud-logging-name }} с  помощью [плагина Fluent bit](https://github.com/yandex-cloud/fluent-bit-plugin-yandex) либо в {{ yds-name }}.

Для описания событий, которые нужно искать в логах, рекомендуем использовать формат [Sigma](https://github.com/SigmaHQ/sigma), поддерживаемый популярными SIEM-системами. Репозиторий Sigma содержит [библиотеку событий](https://github.com/SigmaHQ/sigma/tree/master/rules), описанных в этом формате.

Чтобы получать точную хронологию событий уровня ОС и приложений, настройте синхронизацию часов по [инструкции](../../../compute/tutorials/ntp.md).

{% list tabs %}

- Ручная проверка

  Выполните проверку вручную.

{% endlist %}

#### 5.6 Выполняется сбор аудит логов с уровня приложений {#app-level}

Сбор событий уровня приложений, развернутых на ресурсах {{ compute-short-name }}, клиент может выполнять самостоятельно. Например, записывать логи приложения в файл и передавать их в SIEM-систему с помощью инструментов, перечисленных в подразделе выше.

{% list tabs %}

- Ручная проверка

  Выполните проверку вручную.

{% endlist %}

#### 5.7 Выполняется сбор логов с уровня сети {#network-level}

Запись событий о сетевом трафике {{ vpc-short-name }} (Flow Logs) на текущий момент может выполняться только средствами клиента. Для сбора и передачи событий могут использоваться решения из {{ marketplace-full-name }} (например, [NGFW](/marketplace?tab=software&search=NGFW), [IDS/IPS](/marketplace?tab=software&search=IDS%2FIPS), [сетевые продукты](/marketplace?categories=network)) либо бесплатное ПО. Также сбор логов уровня сети возможно выполнять с помощью различных агентов — HIDS и др.

{% list tabs %}

- Ручная проверка

  Выполните проверку вручную.

{% endlist %}
