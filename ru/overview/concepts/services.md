# Сервисы {{ yandex-cloud }}

_Сервис_ в составе {{ yandex-cloud }} позволяет управлять определенными облачными ресурсами и доступом к ним.

## Список сервисов {{ yandex-cloud }} {#list}

Тегом {{ preview-stage }} отмечены сервисы на стадии [Preview](./launch-stages.md).

На данный момент в рамках платформы {{ yandex-cloud }} доступны следующие сервисы:


| Сервис | Описание |
|---|---|
| [{{ api-gw-full-name }}](../../api-gateway/index.yaml) | Сервис для создания API-шлюзов. |
| [{{ alb-full-name }}](../../application-load-balancer/index.yaml) | Сервис для распределения входящего трафика между компонентами веб-приложений. |
| [{{ at-full-name }}](../../audit-trails/index.yaml) | {{ preview-stage }} Сервис сбора и выгрузки аудитных логов. |
| [{{ certificate-manager-full-name }}](../../certificate-manager/index.yaml) | Сервис для управления TLS-сертификатами. |
| [{{ cloud-apps-full-name }}](../../cloud-apps/index.yaml) | {{ preview-stage }} Сервис для разворачивания приложений на базе стека serverless. |
| [{{ backup-full-name }}](../../backup/index.yaml) | Сервис для резервного копирования ресурсов {{ yandex-cloud }}. |
| [{{ billing-name }}](../../billing/index.yaml) | Сервис для оплаты и детализации расходов. |
| [{{ cdn-full-name }}](../../cdn/index.yaml) | Сервис для организации сети распространения контента. |
| [{{ console-full-name }}](../../console/index.yaml) | Консоль управления ресурсами {{ yandex-cloud }}. |
| [{{ cloud-desktop-full-name }}](../../cloud-desktop/index.yaml) | {{ preview-stage }} Сервис для создания удаленных рабочих мест в облаке. |
| [{{ dns-full-name }}](../../dns/index.yaml) | Сервис администрирования ресурсных записей [DNS](../../glossary/dns.md) и обслуживания DNS-запросов. |
| [{{ sf-full-name }}](../../functions/index.yaml) | Сервис бессерверных вычислений. |
| [{{ interconnect-full-name }}](../../interconnect/index.yaml) | Сервис управления выделенными сетевыми соединениями. |
| [{{ cloud-logging-full-name }}](../../logging/index.yaml) | Сервис для агрегации и чтения логов пользовательских приложений и ресурсов {{ yandex-cloud }}. |
| [{{ org-full-name }}](../../organization/index.yaml) | Сервис для управления составом организации, настройки интеграции с каталогом сотрудников и разграничения доступа пользователей к облачным ресурсам организации. |
| [{{ postbox-full-name }}](../../postbox/index.yaml) | {{ preview-stage }} Сервис отправки транзакционных почтовых сообщений. |
| [{{ compute-full-name }}](../../compute/index.yaml) | Сервис для создания и управления [виртуальными машинами](../../glossary/vm.md). |
| [{{ container-registry-full-name }}](../../container-registry/index.yaml) | Сервис для управления образами и контейнерами. |
| [{{ dataproc-full-name }}](../../data-proc/index.yaml) | Сервис для управления кластерами Apache Hadoop®. |
| [{{ yds-full-name }}](../../data-streams/index.yaml) | Сервис для управления потоками данных в режиме реального времени. |
| [{{ data-transfer-full-name }}](../../data-transfer/index.yaml) | Сервис для миграции баз данных. |
| [{{ datalens-full-name }}](../../datalens/index.yaml) | Сервис визуализации и анализа данных. |
| [{{ ml-platform-full-name }}](../../datasphere/index.yaml) | Сервис для ML-разработки. |
| [{{ ddos-protection-full-name }}](../../vpc/ddos-protection/index.md) | Сервис защиты от DDoS-атак. |
| [{{ forms-full-name }}](../../forms/index.yaml) | Сервис для создания и интеграции форм. |
| [{{ iam-full-name }}](../../iam/index.yaml) | Сервис для управления доступом к облачным ресурсам. |
| [{{ iot-full-name }}](../../iot-core/index.yaml) | Сервис интернета вещей для двустороннего обмена сообщениями между реестрами и устройствами по [протоколу MQTT](../../glossary/mqtt-server.md#mqtt-protocol). |
| [{{ kms-full-name }}](../../kms/index.yaml) | Сервис для управления ключами шифрования. |
| [{{ load-testing-full-name }}](../../load-testing/index.yaml) | {{ preview-stage }} Сервис для проведения нагрузочного тестирования и анализа производительности. |
| [{{ lockbox-name }}](../../lockbox/index.yaml) |  Сервис для создания и хранения секретов в инфраструктуре {{ yandex-cloud }}. |
| [{{ maf-full-name }}](../../managed-airflow/index.yaml) | {{ preview-stage }} Сервис для создания и управления кластерами {{ AF }}. |
| [{{ mkf-full-name }}](../../managed-kafka/index.yaml) | Сервис для создания и управления кластерами {{ KF }}. |
| [{{ mch-full-name }}](../../managed-clickhouse/index.yaml) | Сервис для создания и управления кластерами {{ CH }}. |
| [{{ mes-full-name }}](../../managed-elasticsearch/index.yaml) | Сервис для создания и управления кластерами {{ ES }}. |
| [{{ mgl-full-name }}](../../managed-gitlab/index.yaml) | Сервис для управления DevOps-платформой {{ GL }}. |
| [{{ mgp-full-name }}](../../managed-greenplum/index.yaml) | Сервис для создания и управления кластерами {{ GP }}. |
| [{{ managed-k8s-full-name }}®](../../managed-kubernetes/index.yaml) | Сервис для создания и управления кластерами Kubernetes. |
| [{{ mmg-full-name }}](../../managed-mongodb/index.yaml) | Сервис для создания и управления кластерами {{ MG }}. |
| [{{ mmy-full-name }}®](../../managed-mysql/index.yaml) | Сервис для создания и управления кластерами {{ MY }}. |
| [{{ mos-full-name }}](../../managed-opensearch/index.yaml) | Сервис для создания и управления кластерами {{ OS }}. |
| [{{ mpg-full-name }}](../../managed-postgresql/index.yaml) | Сервис для создания и управления кластерами {{ PG }}. |
| [{{ managed-prometheus-full-name }}](../../monitoring/operations/prometheus/index.md) | {{ preview-stage }} Система мониторинга, совместимая с [{{ prometheus-name }}](https://prometheus.io/docs/introduction/overview/). |
| [{{ mrd-full-name }}™](../../managed-redis/index.yaml) | Сервис для создания и управления кластерами {{ RD }}. |
| [{{ ydb-full-name }}](../../ydb/index.yaml) | Сервис управления для базы данных {{ ydb-full-name }}. |
| [{{ message-queue-full-name }}](../../message-queue/index.yaml) | Сервис очередей для обмена сообщениями между компонентами распределенных приложений и микросервисов. |
| [{{ monitoring-full-name }}](../../monitoring/index.yaml) | Сервис для сбора и визуализации метрик. |
| [{{ network-load-balancer-full-name }}](../../network-load-balancer/index.yaml) | Сервис для распределения сетевой нагрузки по облачным ресурсам. |
| [{{ objstorage-full-name }}](../../storage/index.yaml) | Универсальное масштабируемое облачное объектное хранилище. |
| [{{ yq-full-name }}](../../query/index.yaml) | {{ preview-stage }} Сервис выполнения запросов с помощью единого диалекта SQL. |
| [{{ resmgr-full-name }}](../../resource-manager/index.yaml) | Сервис для управления облачными ресурсами. |
| [{{ search-api-full-name }}](../../search-api/index.yaml) | Сервис поисковых запросов. |
| [{{ serverless-containers-full-name }}](../../serverless-containers/index.yaml) | Сервис бессерверного запуска контейнеризированных приложений. |
| [{{ captcha-full-name }}](../../smartcaptcha/index.yaml) | Сервис для распознавания пользователей системы. |
| [{{ sws-full-name }}](../../smartwebsecurity/index.yaml) | {{ preview-stage }} Сервис для защиты от DDoS-атак на прикладном уровне L7 модели OSI. |
| [{{ speechkit-full-name }}](../../{{ speechkit-slug }}/index.yaml) | Сервис технологий распознавания и синтеза речи. |
|[{{ speechsense-full-name }}](../../speechsense/index.yaml) | {{ preview-stage }} Сервис речевой аналитики для анализа голосовых и текстовых каналов коммуникации. |
| [{{ tracker-full-name }}](../../tracker/index.yaml) | Сервис для совместной работы и организации процессов в компании. |
| [{{ translate-full-name }}](../../translate/index.yaml) | Сервис машинного перевода. |
| [{{ vpc-full-name }}](../../vpc/index.yaml) | Сервис для управления облачными сетями. |
| [{{ vision-full-name }}](../../vision/index.yaml) | Сервис компьютерного зрения для анализа изображений. |
| [{{ websql-full-name }}](../../websql/index.yaml) | {{ preview-stage }} Сервис для подключения к кластерам управляемых баз данных. |
| [{{ wiki-full-name }}](../../wiki/index.yaml) | Сервис для создания корпоративной базы данных. |
| [{{ yagpt-full-name }}](../../yandexgpt/index.yaml) | {{ preview-stage }} Генеративная языковая модель для задач бизнеса. |



## Как подключиться к сервисам {#enable}

Для подключения к сервисам и управления ресурсами вы можете использовать [консоль управления]({{ link-console-main }}) {{ yandex-cloud }}. С ее помощью вы можете запускать виртуальные машины в {{ yandex-cloud }} и подключаться к ним, обращаться к объектному хранилищу, создавать базы данных и т. п.


Сервисы, находящиеся на стадии Preview, доступны не всем пользователям. Если вы хотите воспользоваться одним из таких сервисов, отправьте нам заявку на доступ. Сделать это можно на странице соответствующего сервиса.



{% include [Greenplum trademark](../../_includes/mdb/mgp/trademark.md) %}

