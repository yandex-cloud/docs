# Сбор, мониторинг и анализ аудитных логов

Аудитные логи (журналы аудита) — это записи обо всех событиях в системе, включая доступ к ней и выполненные операции. Сбор и проверка аудитных логов позволяют контролировать соблюдение установленных процедур и стандартов безопасности и выявить изъяны в механизмах безопасности.

События в аудитных логах относятся к различным уровням:
- [уровень Yandex.Cloud](#cloud-level) — события, происходящие с ресурсами Yandex.Cloud;
- [уровень ОС](#os-level);
- [уровень приложений](#app-level);
- [уровень сети](#network-level) (Flow Logs).

{% note info %}

О событиях Kubernetes читайте в разделе «Сбор, мониторинг и анализ аудитных логов в Managed Service for Kubernetes».<!-- добавить ссылку, когда появится -->

{% endnote %}

## Уровень Yandex.Cloud {#cloud-level}

### Сбор событий {#collect}

Основным инструментом сбора логов уровня Yandex.Cloud является сервис [Yandex Audit Trails](../../../audit-trails/concepts/index.md). Сервис позволяет собирать аудитные логи о происходящих с ресурсами Yandex.Cloud событиях и загружать эти логи в бакет Object Storage или лог-группу {{ cloud-logging-name }} для дальнейшего анализа или экспорта. Cм. [инструкцию](../../../audit-trails/quickstart.md), как запустить сбор логов, а также [формат](../../../audit-trails/concepts/format.md) и [справочник](../../../audit-trails/concepts/events.md) событий.

{% note info %}

Рекомендации по безопасности Object Storage представлены в разделе [{#T}](secure-config.md#object-storage).

{% endnote %}

{% if audience != "internal" %} Для сбора метрик, анализа некоторых событий уровня {{ yandex-cloud }} и настройки оповещений рекомендуется использовать сервис [Yandex Monitoring](../../../monitoring/index.yaml). {% endif %} С его помощью возможно отслеживать, например, резкое возрастание нагрузки на Compute Cloud, RPS сервиса Application LoadBalancer, значительные изменения в статистике событий сервиса IAM.

Кроме того, Yandex Monitoring можно применять для мониторинга работоспособности самого сервиса Audit Trails и мониторинга событий безопасности.

![](../../../_assets/overview/solution-library-icon.svg)[Решение: Мониторинг Audit Trails и событий безопасности с помощью Yandex Monitoring](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/trail_monitoring)

Аудитные логи возможно экспортировать в лог-группу [{{ cloud-logging-name }}](../../../logging/index.yaml) и в  [SIEM-систему клиента](#export) для анализа информации о событиях и инцидентах.

Список важных событий уровня {{ yandex-cloud }} для поиска в аудитных логах:
![](../../../_assets/overview/solution-library-icon.svg)[Решение: поиск важных событий безопасности в аудитных логах](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/_use_cases_and_searches)

### Экспорт событий в SIEM {#export}

#### Audit Trails

Решения для экспорта аудитных логов Yandex.Cloud подготовлены для следующих SIEM-систем:

- Yandex Managed Service for Elasticsearch (ELK)

  ![](../../../_assets/overview/solution-library-icon.svg)[Решение: Сбор, мониторинг и анализ аудитных логов в Yandex Managed Service for Elasticsearch](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/export-auditlogs-to-ELK_main)

- ArcSight

  ![](../../../_assets/overview/solution-library-icon.svg)[Решение: Сбор, мониторинг и анализ аудитных логов во SIEM ArcSight](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/export-auditlogs-to-ArcSight)

- Splunk

  ![](../../../_assets/overview/solution-library-icon.svg)[Решение: Сбор, мониторинг и анализ аудитных логов в SIEM Splunk](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/export-auditlogs-to-Splunk)

Для настройки экспорта в любые SIEM подходят утилиты [GeeseFS](../../../storage/tools/geesefs.md) или [s3fs](../../../storage/tools/s3fs.md). Она позволяет смонтировать бакет Object Storage как локальный диск виртуальной машины. Далее на ВМ необходимо установить коннектор для SIEM и настроить вычитывание JSON-файлов из бакета. 

#### Метрики Yandex Monitoring

{% if audience != "internal" %} Выгрузка метрик в SIEM-систему возможна через API, см. [инструкцию](../../../monitoring/operations/metric/get.md). {% endif %}

### Реагирование на события {#respond}

C помощью Cloud Functions можно настроить оповещения о событиях Audit Trails, а так же автоматическое реагирование на вредоносные действия, например  удаление опасных правил или прав доступа.

![](../../../_assets/overview/solution-library-icon.svg)[Решение: уведомления и реагирование на события ИБ Audit Trails с помощью Cloud Logging/Cloud Functions + Telegram](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/trails-function-detector)

## Уровень ОС {#os-level}

При использовании облачных сервисов по модели IaaS и использовании групп узлов Kubernetes клиент отвечает за безопасность ОС и выполняет сбор событий уровня ОС самостоятельно. Для сбора стандартных событий, которые генерирует ОС, и их экспорта в SIEM-систему клиента существуют бесплатные инструменты, такие как:
  - [Osquery](https://osquery.io/)
  - [Filebeat (ELK)](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-system.html)
  - [Wazuh](https://documentation.wazuh.com/current/getting-started/use_cases/log_analysis.html)

Дополнительные опции генерации событий возможно реализовать с помощью утилиты Auditd для Linux, Sysmon для Windows.

{% if audience != "internal" %} Системные метрики Linux (процессор, память, диск) можно собирать с помощью компонента [Yandex Unified Agent](../../../monitoring/concepts/data-collection/unified-agent/index.md) сервиса Yandex Monitoring. {% endif %}

Также события ОС возможно экспортировать в {{ cloud-logging-name }} с  помощью [плагина Fluent bit](https://github.com/yandex-cloud/fluent-bit-plugin-yandex).

Для описания событий, которые нужно искать в логах, рекомендуем использовать формат [Sigma](https://github.com/SigmaHQ/sigma), поддерживаемый популярными SIEM-системами. Репозиторий Sigma содержит [библиотеку событий](https://github.com/SigmaHQ/sigma/tree/master/rules), описанных в этом формате.

## Уровень приложений {#app-level}

Сбор событий уровня приложений, развернутых на ресурсах {{ compute-name }}, клиент может выполнять самостоятельно. Например, записывать логи приложения в файл и передавать их в SIEM-систему с помощью инструментов, перечисленных в подразделе [{#T}](#os-level) выше. 

## Уровень сети {#network-level}

Запись событий о сетевом траффике VPC (Flow Logs) на текущий момент может выполняться только средствами клиента. Для сбора и передачи событий могут использоваться решения из [Yandex Cloud Marketplace](https://cloud.yandex.ru/marketplace?categories=network) (например,  NGFW, IDS/IPS, сетевые продукты) либо бесплатное ПО.

## Синхронизация времени {#time-synch}

Чтобы получать точную хронологию событий уровня ОС и приложений, настройте синхронизацию часов по [инструкции](../../../compute/solutions/ntp.md).
