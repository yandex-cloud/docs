[Документация Yandex Cloud](../../index.md) > [Безопасность в Yandex Cloud](../index.md) > [Стандарт по защите облачной инфраструктуры, версия 1.4.2](index.md) > Сбор, мониторинг и анализ аудитных логов

# Требования к сбору, мониторингу и анализу аудитных логов

## 5. Сбор, мониторинг и анализ аудитных логов {#audit--logs}


Аудитные логи (журналы аудита) — это записи обо всех событиях в системе, включая доступ к ней и выполненные операции. Сбор и проверка аудитных логов позволяют контролировать соблюдение установленных процедур и стандартов безопасности и выявить изъяны в механизмах безопасности.

События в аудитных логах относятся к различным уровням:
* [уровень Yandex Cloud](#audit-trails) — события, происходящие с ресурсами Yandex Cloud;
* [уровень ОС](#os-level);
* [уровень приложений](#app-level);
* [уровень сети](#network-level) (Flow Logs).

{% note info %}

О событиях Kubernetes читайте в разделе [Сбор, мониторинг и анализ аудитных логов в Yandex Managed Service for Kubernetes](../domains/kubernetes.md#collection-monitoring-analysis-audit-logs).

{% endnote %}

### Общее {#general}

#### 5.1 Включен сервис Yandex Audit Trails на уровне организации {#audit-trails}

Основным инструментом сбора логов уровня Yandex Cloud является сервис [Yandex Audit Trails](../../audit-trails/concepts/index.md). Сервис позволяет собирать аудитные логи о происходящих с ресурсами Yandex Cloud событиях и загружать эти логи в бакет Yandex Object Storage или лог-группу Cloud Logging для дальнейшего анализа или экспорта. Смотрите [инструкцию](../../audit-trails/quickstart.md), как запустить сбор логов.

Аудитные логи Audit Trails могут содержать два разных типа событий: [события уровня конфигурации](../../audit-trails/concepts/events.md) и [события уровня сервисов](../../audit-trails/concepts/events-data-plane.md).

К [событиям уровня конфигурации](../../audit-trails/concepts/format.md) относятся действия, связанные с конфигурированием ресурсов Yandex Cloud, такие как создание, изменение или удаление компонентов инфраструктуры, пользователей или политик. К [событиям уровня сервисов](../../audit-trails/concepts/format-data-plane.md) относятся изменения и действия, которые происходят с данными и ресурсами внутри сервисов Yandex Cloud. По умолчанию Audit Trails не регистрирует события уровня сервисов. [Включать](../../audit-trails/quickstart.md#the-trail-creation) сбор аудитных логов уровня сервисов нужно отдельно для каждого из поддерживаемых сервисов.

Подробнее читайте в разделе [Сравнение логов событий уровня конфигурации и уровня сервисов](../../audit-trails/concepts/control-plane-vs-data-plane.md).

 Для сбора метрик, анализа некоторых событий уровня Yandex Cloud и настройки оповещений рекомендуется использовать сервис [Yandex Monitoring](../../monitoring/index.md).  С его помощью возможно отслеживать, например, резкое возрастание нагрузки на Compute Cloud, RPS сервиса Application Load Balancer, значительные изменения в статистике событий сервиса Identity and Access Management.

Кроме того, Monitoring можно применять для мониторинга работоспособности самого сервиса Audit Trails и мониторинга событий безопасности. Выгрузка метрик в SIEM-систему возможна через [API](../../glossary/rest-api.md), смотрите [инструкцию](../../monitoring/operations/metric/get.md).

[Решение: Мониторинг Audit Trails и событий безопасности с помощью Monitoring](https://github.com/yandex-cloud-examples/yc-audit-trails-monitoring)

Аудитные логи возможно экспортировать в лог-группу [Cloud Logging](../../logging/index.md) или Data Streams и в SIEM-систему клиента для анализа информации о событиях и инцидентах.

Список важных событий уровня Yandex Cloud для поиска в аудитных логах:

[Решение: поиск важных событий безопасности в аудитных логах](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/_use_cases_and_searches)

Yandex Audit Trails возможно включить на уровне каталога, облака и организации. Рекомендуется включать Yandex Audit Trails на уровне всей организации — это позволит централизованно собирать аудитные логи, например, в отдельное облако безопасности.

| ID требования | Критичность |
| --- | --- |
| AUDIT1 | Высокая |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. В консоли управления выберите облако или каталог, в которых необходимо проверить функции.
  1. В списке сервисов выберите Yandex Audit Trails.
  1. Убедитесь, что в параметре Фильтр находится значение Организация.
  1. Дополнительно убедитесь, что назначение логов: bucket Yandex Object Storage, лог-группа [Cloud Logging](../../logging/index.md), Data Streams в рабочем состоянии и логи доступны для дальнейшего анализа.

{% endlist %}

#### 5.2 События Yandex Audit Trails экспортируются в SIEM-системы {#events}

Решения для экспорта аудитных логов Yandex Cloud подготовлены для следующих SIEM-систем:


* ArcSight — [Сбор, мониторинг и анализ аудитных логов во SIEM ArcSight](https://github.com/yandex-cloud-examples/yc-export-auditlogs-to-arcsight)

* Splunk — [Сбор, мониторинг и анализ аудитных логов в SIEM Splunk](https://github.com/yandex-cloud-examples/yc-export-auditlogs-to-splunk)

* MaxPatrol SIEM — [Сбор, мониторинг и анализ аудитных логов в MaxPatrol SIEM](../../audit-trails/tutorials/maxpatrol/index.md)

* Wazuh — [Сбор, мониторинг и анализ аудитных логов в Wazuh](https://github.com/yandex-cloud-examples/yc-export-auditlogs-to-wazuh/blob/main/README.md)

* KUMA — [Сбор, мониторинг и анализ аудитных логов в KUMA](../../tutorials/security/audit-trails-events-to-kuma/index.md)

Вы можете подробнее ознакомиться с MaxPatrol в [разделе](../../audit-trails/tutorials/maxpatrol/index.md).

Для настройки экспорта в любые SIEM подходят утилиты [GeeseFS](../../storage/tools/geesefs.md) или [s3fs](../../storage/tools/s3fs.md). Они позволяют смонтировать бакет Yandex Object Storage как локальный диск виртуальной машины. Далее на ВМ необходимо установить коннектор для SIEM и настроить вычитывание JSON-файлов из бакета. Либо утилиты совместимые с AWS Kinesis datastreams в случае, если вы направляете аудитные логи в Yandex Data Streams.


Вы также можете анализировать аудитные логи вручную, если у вас отсутствует SIEM-система, с помощью [поиска](../../audit-trails/tutorials/search-events-audit-logs/index.md) событий Yandex Cloud в Yandex Query, Cloud Logging или Object Storage.


| ID требования | Критичность |
| --- | --- |
| AUDIT2 | Информационная |

{% list tabs group=instructions %}

- Ручная проверка {#manual}

  Убедитесь, что аудитные логи из Yandex Audit Trails экспортируются для анализа в SIEM-систему либо анализируются в облаке одним из способов.

{% endlist %}

#### 5.3 Настроено реагирование на события Yandex Audit Trails {#reaction}

Вы можете реагировать на события Yandex Audit Trails средствами вашей SIEM-системы либо вручную. Либо вы можете использовать автоматическое реагирование.

C помощью Yandex Cloud Functions можно настроить оповещения о событиях Audit Trails, а так же автоматическое реагирование на вредоносные действия, например  удаление опасных правил или прав доступа.

[Решение: уведомления и реагирование на события ИБ Audit Trails с помощью IAM / Cloud Functions + Telegram](https://github.com/yandex-cloud-examples/yc-audit-trails-automatic-response)

| ID требования | Критичность |
| --- | --- |
| AUDIT3 | Средняя |

#### 5.4 Выполнен hardering бакета Object Storage, где хранятся аудитные логи Yandex Audit Trails {#hardering}

Убедитесь, что в случае записи аудитных логов Yandex Audit Trails в bucket Yandex Object Storage сам бакет настроен в соответствии с лучшими практиками безопасности:

* [Отсутствует публичный доступ к бакету Yandex Object Storage](virtualenv-safe-config.md#bucket-access).
* [В Yandex Object Storage используются политики доступа (Bucket Policy)](virtualenv-safe-config.md#bucket-policy).
* [В Yandex Object Storage включена функция **Блокировка версии объекта** (object lock)](virtualenv-safe-config.md#object-lock).
* [В Yandex Object Storage включен механизм логирования действий с бакетом](virtualenv-safe-config.md#bucket-logs).
* [В Yandex Object Storage включено шифрование данных at rest с помощью ключа KMS](encryption.md#storage-kms).

Вы можете воспользоваться решением для настройки безопасного бакета Yandex Object Storage с помощью Terraform.

| ID требования | Критичность |
| --- | --- |
| AUDIT4 | Средняя |

{% list tabs group=instructions %}

- Ручная проверка {#manual}

  Выполните проверку вручную.

{% endlist %}

#### 5.5 Выполняется сбор аудитных логов с уровня ОС {#os-level}

При использовании облачных сервисов по модели [IaaS](https://yandex.cloud/ru/blog/posts/2022/01/iaas) и использовании групп узлов Kubernetes клиент отвечает за безопасность ОС и выполняет сбор событий уровня ОС самостоятельно. Для сбора стандартных событий, которые генерирует ОС, и их экспорта в SIEM-систему клиента существуют бесплатные инструменты, такие как:
  * [Osquery](https://osquery.io/);
  * [Filebeat (ELK)](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-system.html);
  * [Wazuh](https://documentation.wazuh.com/current/getting-started/use_cases/log_analysis.html).

Дополнительные опции генерации событий возможно реализовать с помощью утилиты Auditd для Linux, Sysmon для Windows.

Системные метрики Linux (процессор, память, диск) можно собирать с помощью компонента [Unified Agent](../../monitoring/concepts/data-collection/unified-agent/index.md) сервиса Monitoring.

Также события ОС возможно экспортировать в Cloud Logging с  помощью [плагина Fluent bit](https://github.com/yandex-cloud/fluent-bit-plugin-yandex) либо в Data Streams.

Для описания событий, которые нужно искать в логах, рекомендуем использовать формат [Sigma](https://github.com/SigmaHQ/sigma), поддерживаемый популярными SIEM-системами. Репозиторий Sigma содержит [библиотеку событий](https://github.com/SigmaHQ/sigma/tree/master/rules), описанных в этом формате.

Чтобы получать точную хронологию событий уровня ОС и приложений, настройте синхронизацию часов по [инструкции](../../compute/tutorials/ntp.md).

Дополнительно рекомендуется повысить уровень логирования внутри виртуальных машин как минимум до [`VERBOSE`](https://en.wikipedia.org/wiki/Verbose_mode).

| ID требования | Критичность |
| --- | --- |
| AUDIT5 | Высокая |

{% list tabs group=instructions %}

- Ручная проверка {#manual}

  Выполните проверку вручную.

{% endlist %}

#### 5.6 Выполняется сбор аудитных логов с уровня приложений {#app-level}

Сбор событий уровня приложений, развернутых на ресурсах Compute Cloud, клиент может выполнять самостоятельно. Например, записывать логи приложения в файл и передавать их в SIEM-систему с помощью инструментов, перечисленных в подразделе выше.

Включите сбор аудитных логов в используемых неуправляемых СУБД:

* Включите протоколирование всех действий аутентификации (успешных и неудачных).
* Активируйте логирование операций изменения данных (`INSERT`, `UPDATE`, `DELETE`).
* Настройте регистрацию операций изменения схемы (`ALTER`, `CREATE`, `DROP`).
* Фиксируйте изменения разрешений и привилегий.
* Настройте события для отслеживания запросов.

| ID требования | Критичность |
| --- | --- |
| AUDIT6 | Средняя |

{% list tabs group=instructions %}

- Ручная проверка {#manual}

  Выполните проверку вручную.

{% endlist %}

#### 5.7 Выполняется сбор логов с уровня сети {#network-level}

Запись событий о сетевом трафике VPC (Flow Logs) на текущий момент может выполняться только средствами клиента. Для сбора и передачи событий могут использоваться решения из Yandex Cloud Marketplace (например, [NGFW](https://yandex.cloud/ru/marketplace?tab=software&search=NGFW), [IDS/IPS](https://yandex.cloud/ru/marketplace?tab=software&search=IDS%2FIPS), [сетевые продукты](https://yandex.cloud/ru/marketplace?categories=network)) либо бесплатное ПО. Также сбор логов уровня сети возможно выполнять с помощью различных агентов — HIDS и др.

| ID требования | Критичность |
| --- | --- |
| AUDIT7 | Средняя |

{% list tabs group=instructions %}

- Ручная проверка {#manual}

  Выполните проверку вручную.

{% endlist %}

#### 5.8 Отслеживаются события уровня сервисов {#data-plane-events}

[Аудитный лог событий уровня сервисов](../../audit-trails/concepts/format-data-plane.md) — это запись о событиях, которые произошли с ресурсами Yandex Cloud, в форме JSON-объекта. Благодаря отслеживанию событий уровня сервисов вам будет проще собирать дополнительные события с облачных сервисов, что позволит эффективнее реагировать на инциденты безопасности в облаках. Кроме того, отслеживание событий уровня сервисов поможет обеспечить соответствие вашей облачной инфраструктуры нормативным правовым актам и отраслевым стандартам. Например, вы можете отслеживать получение сотрудниками доступа к конфиденциальным данным, хранящимся в [бакетах](../../storage/concepts/bucket.md).

Включать сбор аудитных логов уровня сервисов нужно отдельно для каждого из [поддерживаемых сервисов](../../audit-trails/concepts/control-plane-vs-data-plane.md#data-plane-events).

Рекомендуется включать **все события** для сервисов [Yandex Identity and Access Management](../../audit-trails/concepts/events-data-plane.md#iam) и [Yandex Cloud DNS](../../audit-trails/concepts/events-data-plane.md#dns), а также **все события** для следующих сервисов, если эти сервисы используются:

* [Yandex Certificate Manager](../../audit-trails/concepts/events-data-plane.md#certificate-manager)
* [Yandex Compute Cloud](../../audit-trails/concepts/events-data-plane.md#compute)
* [Yandex Key Management Service](../../audit-trails/concepts/events-data-plane.md#kms)
* [Yandex Lockbox](../../audit-trails/concepts/events-data-plane.md#lockbox)
* [Yandex Managed Service for ClickHouse®](../../audit-trails/concepts/events-data-plane.md#mch)
* [Yandex Managed Service for Kubernetes](../../audit-trails/concepts/events-data-plane.md#managed-service-for-kubernetes)
* [Yandex StoreDoc](../../audit-trails/concepts/events-data-plane.md#mmg)
* [Yandex Managed Service for MySQL®](../../audit-trails/concepts/events-data-plane.md#mmy)
* [Yandex Managed Service for PostgreSQL](../../audit-trails/concepts/events-data-plane.md#mpg)
* [Yandex Managed Service for Valkey™](../../audit-trails/concepts/events-data-plane.md#mrd)
* [Yandex Object Storage](../../audit-trails/concepts/events-data-plane.md#objstorage)
* [Yandex Smart Web Security](../../audit-trails/concepts/events-data-plane.md#sws)
* [Yandex WebSQL](../../audit-trails/concepts/events-data-plane.md#websql)

| ID требования | Критичность |
| --- | --- |
| AUDIT8 | Средняя |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором расположен [трейл](../../audit-trails/concepts/trail.md).
  1. В списке сервисов выберите **Audit Trails**.
  1. Выберите нужный трейл.
  1. Убедитесь, что на странице с информацией о трейле в блоке **Сбор событий с уровня сервисов** указаны все сервисы, для которых вы хотите собирать логи уровня сервисов, и для каждого указанного сервиса задана нужная [область сбора](../../audit-trails/concepts/trail.md#collecting-area) аудитных логов.

      Cписок поддерживаемых сервисов приведен в [Справочнике событий уровня сервисов Yandex Audit Trails](../../audit-trails/concepts/events-data-plane.md).

{% endlist %}

#### 5.9 Включен модуль Security Deck Access Transparency для проверки действий, произведенных сотрудниками Yandex Cloud с инфраструктурой {#access-transparency-enabled}

Все действия сотрудников Yandex Cloud фиксируются и контролируются с помощью [бастионных хостов](../../tutorials/routing/bastion.md), на которых записываются операции с ресурсами, обрабатывающими пользовательские данные.

Модуль [Access Transparency](../../security-deck/concepts/access-transparency.md) позволяет проверить, для каких целей сотрудники провайдера получили доступ к инфраструктуре. Например, для выполнения дополнительной диагностики IT‑систем инженерами службы поддержки или обновления ПО. [ML‑модели](../../glossary/ml-models.md) анализируют эти действия. YandexGPT, встроенный в Access Transparency, создает сводки о событиях доступа для повышения прозрачности. Подозрительные сессии автоматически передаются на рассмотрение команде безопасности Yandex Cloud.

| ID требования | Критичность |
| --- | --- |
| AUDIT9 | Низкая |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. Перейдите в сервис [Yandex Security Deck](https://center.yandex.cloud/security/).
  1. На панели слева выберите ![CloudCheck](../../_assets/console-icons/cloud-check.svg) **Access Transparency**.
  1. Если вы видите предложение о подключении модуля Access Transparency, то этот модуль у вас еще не активирован: перейдите к п. <q>Инструкции и решения по выполнению</q>.

{% endlist %}

**Инструкции и решения по выполнению:**

Нажмите кнопку **Подключить**, чтобы активировать модуль `Access Transparency`.

_ClickHouse® является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._