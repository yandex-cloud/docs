# Сбор, мониторинг и анализ аудитных логов

Аудитные логи (журналы аудита) — это записи обо всех событиях в системе, включая доступ к ней и выполненные операции. Сбор и проверка аудитных логов позволяют контролировать соблюдение установленных процедур и стандартов безопасности и выявить изъяны в механизмах безопасности.

События в аудитных логах относятся к различным уровням:
- [уровень {{ yandex-cloud }}](#cloud-level) — события, происходящие с ресурсами {{ yandex-cloud }};
- [уровень ОС](#os-level);
- [уровень приложений](#app-level);
- [уровень сети](#network-level) (Flow Logs).

{% note info %}

О событиях {{ k8s }} читайте в разделе [Сбор, мониторинг и анализ аудитных логов в {{ managed-k8s-full-name }}](./kubernetes.md#collection-monitoring-analysis-audit-logs).

{% endnote %}

## Уровень {{ yandex-cloud }} {#cloud-level}

### Сбор событий {#collect}

Основным инструментом сбора логов уровня {{ yandex-cloud }} является сервис [{{ at-full-name }}](../../audit-trails/concepts/index.md). Сервис позволяет собирать аудитные логи о происходящих с ресурсами {{ yandex-cloud }} событиях и загружать эти логи в бакет {{ objstorage-full-name }} {% if product == "yandex-cloud" %}или лог-группу {{ cloud-logging-name }} {% endif %}для дальнейшего анализа или экспорта. См. [инструкцию](../../audit-trails/quickstart.md), как запустить сбор логов, а также [формат](../../audit-trails/concepts/format.md) и [справочник](../../audit-trails/concepts/events.md) событий.

{% note info %}

Рекомендации по безопасности {{ objstorage-full-name }} представлены в разделе [{#T}](secure-config.md#object-storage).

{% endnote %}

{% if audience != "internal" %} Для сбора метрик, анализа некоторых событий уровня {{ yandex-cloud }} и настройки оповещений рекомендуется использовать сервис [{{ monitoring-full-name }}](../../monitoring/). {% endif %} С его помощью возможно отслеживать, например, резкое возрастание нагрузки на {{ compute-name }}, RPS сервиса {{ alb-name }}, значительные изменения в статистике событий сервиса {{ iam-name }}.

Кроме того, {{ monitoring-name }} можно применять для мониторинга работоспособности самого сервиса {{ at-name }} и мониторинга событий безопасности.

{% if product == "yandex-cloud" %}
![](../../_assets/overview/solution-library-icon.svg)[Решение: Мониторинг {{ at-name }} и событий безопасности с помощью {{ monitoring-name }}](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/trail_monitoring)

{% endif %}
Аудитные логи возможно экспортировать {% if product == "yandex-cloud" %}в лог-группу [{{ cloud-logging-name }}](../../logging/) и {% endif %}в [SIEM-систему клиента](#export) для анализа информации о событиях и инцидентах.

{% if product == "yandex-cloud" %}
Список важных событий уровня {{ yandex-cloud }} для поиска в аудитных логах:
![](../../_assets/overview/solution-library-icon.svg)[Решение: поиск важных событий безопасности в аудитных логах](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/_use_cases_and_searches)

{% endif %}
### Экспорт событий в SIEM {#export}

#### {{ at-name }} {#export-at}

{% if product == "yandex-cloud" %}
Решения для экспорта аудитных логов {{ yandex-cloud }} подготовлены для следующих SIEM-систем:

- {{ mes-full-name }} (ELK)

  ![](../../_assets/overview/solution-library-icon.svg)[Решение: Сбор, мониторинг и анализ аудитных логов в {{ mes-full-name }}](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/export-auditlogs-to-ELK_main)

- ArcSight

  ![](../../_assets/overview/solution-library-icon.svg)[Решение: Сбор, мониторинг и анализ аудитных логов во SIEM ArcSight](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/export-auditlogs-to-ArcSight)

- Splunk

  ![](../../_assets/overview/solution-library-icon.svg)[Решение: Сбор, мониторинг и анализ аудитных логов в SIEM Splunk](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/export-auditlogs-to-Splunk)

{% endif %}
Для настройки экспорта в любые SIEM подходят утилиты [GeeseFS](../../storage/tools/geesefs.md) или [s3fs](../../storage/tools/s3fs.md). Она позволяет смонтировать бакет {{ objstorage-full-name }} как локальный диск виртуальной машины. Далее на ВМ необходимо установить коннектор для SIEM и настроить вычитывание JSON-файлов из бакета.

#### Метрики {{ monitoring-full-name }}

{% if audience != "internal" %} Выгрузка метрик в SIEM-систему возможна через API, см. [инструкцию](../../monitoring/operations/metric/get.md). {% endif %}

{% if product == "yandex-cloud" %}
### Реагирование на события {#respond}

C помощью {{ sf-full-name }} можно настроить оповещения о событиях {{ at-name }}, а так же автоматическое реагирование на вредоносные действия, например  удаление опасных правил или прав доступа.

![](../../_assets/overview/solution-library-icon.svg)[Решение: уведомления и реагирование на события ИБ {{ at-name }} с помощью {{ iam-short-name }} / {{ sf-name }} + Telegram](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/trails-function-detector)
{% endif %}

## Уровень ОС {#os-level}

При использовании облачных сервисов по модели IaaS и использовании групп узлов {{ k8s }} клиент отвечает за безопасность ОС и выполняет сбор событий уровня ОС самостоятельно. Для сбора стандартных событий, которые генерирует ОС, и их экспорта в SIEM-систему клиента существуют бесплатные инструменты, такие как:
  - [Osquery](https://osquery.io/)
  {% if product == "yandex-cloud" %}- [Filebeat (ELK)](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-system.html){% endif %}
  - [Wazuh](https://documentation.wazuh.com/current/getting-started/use_cases/log_analysis.html)

Дополнительные опции генерации событий возможно реализовать с помощью утилиты Auditd для Linux, Sysmon для Windows.

{% if audience != "internal" %} Системные метрики Linux (процессор, память, диск) можно собирать с помощью компонента [{{ unified-agent-short-name }}](../../monitoring/concepts/data-collection/unified-agent/index.md) сервиса {{ monitoring-name }}. {% endif %}

{% if product == "yandex-cloud" %}
Также события ОС возможно экспортировать в {{ cloud-logging-name }} с  помощью [плагина Fluent bit](https://github.com/yandex-cloud/fluent-bit-plugin-yandex).
{% endif %}

Для описания событий, которые нужно искать в логах, рекомендуем использовать формат [Sigma](https://github.com/SigmaHQ/sigma), поддерживаемый популярными SIEM-системами. Репозиторий Sigma содержит [библиотеку событий](https://github.com/SigmaHQ/sigma/tree/master/rules), описанных в этом формате.

## Уровень приложений {#app-level}

Сбор событий уровня приложений, развернутых на ресурсах {{ compute-name }}, клиент может выполнять самостоятельно. Например, записывать логи приложения в файл и передавать их в SIEM-систему с помощью инструментов, перечисленных в подразделе [{#T}](#os-level) выше.

## Уровень сети {#network-level}

Запись событий о сетевом трафике {{ vpc-short-name }} (Flow Logs) на текущий момент может выполняться только средствами клиента. Для сбора и передачи событий могут использоваться решения из {{ marketplace-full-name }} (например, {% if product == "yandex-cloud" %}[NGFW](/marketplace?tab=software&search=NGFW), [IDS/IPS](/marketplace?tab=software&search=IDS%2FIPS),{% endif %} [сетевые продукты](/marketplace?categories=network)) либо бесплатное ПО.

## Синхронизация времени {#time-synch}

Чтобы получать точную хронологию событий уровня ОС и приложений, настройте синхронизацию часов по [инструкции](../../compute/tutorials/ntp.md).
