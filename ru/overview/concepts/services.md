# Сервисы {{ yandex-cloud }}

_Сервис_ в составе {{ yandex-cloud }} позволяет управлять определенными облачными ресурсами и доступом к ним.

## Список сервисов {{ yandex-cloud }} {#list}

В разных [регионах](region.md) доступны разные наборы сервисов. Тегом {{ preview-stage }} отмечены сервисы на стадии [Preview](./launch-stages.md).

| Сервис                                                                          | Описание | Россия | Казахстан
|---------------------------------------------------------------------------------|---|---|---|
| [{{ api-gw-full-name }}](../../api-gateway/index.yaml)                          | Сервис для управления API-шлюзами. | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) |
| [{{ alb-full-name }}](../../application-load-balancer/index.yaml)               | Сервис для распределения входящего трафика между компонентами веб-приложений. | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| [{{ at-full-name }}](../../audit-trails/index.yaml)                             | Сервис сбора и выгрузки аудитных логов. | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| [{{ baremetal-full-name }}](../../baremetal/index.yaml)                         | Сервис аренды выделенного физического сервера. | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) |
| [{{ certificate-manager-full-name }}](../../certificate-manager/index.yaml)     | Сервис для управления TLS-сертификатами. | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| [{{ cloud-apps-full-name }}](../../cloud-apps/index.yaml)                       | {{ preview-stage }} Сервис для разворачивания приложений на базе {{ yandex-cloud }}. | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) |
| [{{ backup-full-name }}](../../backup/index.yaml)                               | Сервис для резервного копирования ресурсов {{ yandex-cloud }}. | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| [{{ billing-name }}](../../billing/index.yaml)                                  | Сервис для оплаты и детализации расходов. | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| [{{ cdn-full-name }}](../../cdn/index.yaml)                                     | Сервис для организации сети распространения контента. | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) |
| [{{ console-full-name }}](../../console/index.yaml)                             | Консоль управления ресурсами {{ yandex-cloud }}. | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| [{{ cloud-desktop-full-name }}](../../cloud-desktop/index.yaml)                 | {{ preview-stage }} Сервис для создания удаленных рабочих мест в облаке. | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) |
| [{{ dns-full-name }}](../../dns/)                                     | Сервис администрирования ресурсных записей [DNS](../../glossary/dns.md) и обслуживания DNS-запросов. | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| [{{ sf-full-name }}](../../functions/index.yaml)                                | Сервис бессерверных вычислений. | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) |
| [{{ interconnect-full-name }}](../../interconnect/index.yaml)                   | Сервис управления выделенными сетевыми соединениями. | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| [{{ cloud-logging-full-name }}](../../logging/index.yaml)                       | Сервис для агрегации и чтения логов пользовательских приложений и ресурсов {{ yandex-cloud }}. | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| [{{ cns-full-name }}](../../notifications/index.yaml)                           | Сервис для мультиканальной отправки уведомлений пользователям. | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) |
| [{{ org-full-name }}](../../organization/index.yaml)                            | Сервис для управления составом организации, настройки интеграции с каталогом сотрудников и разграничения доступа пользователей к облачным ресурсам организации. | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| [{{ postbox-full-name }}](../../postbox/index.yaml)                             | Сервис отправки транзакционных почтовых сообщений. | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) |
| [{{ quota-manager-full-name }}](../../quota-manager/index.yaml)                 | {{ preview-stage }} Сервис отправки транзакционных почтовых сообщений. | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) |
| [{{ cloud-registry-full-name }}](../../cloud-registry/index.yaml)               | {{ preview-stage }} Сервис для хранения артефактов разработки и управления ими. | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) |
| [{{ video-full-name }}](../../video/index.yaml)                                 | {{ preview-stage }} Сервис для видеохостинга и проведения онлайн-трансляций. | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) |
| [{{ ca-full-name }}]({{ link-src-docs }}/code-assistant/)                           | {{ preview-stage }} AI-ассистент разработчика с функцией автодополнения кода. | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) |
| [{{ compute-full-name }}](../../compute/index.yaml)                             | Сервис для создания и управления [виртуальными машинами](../../glossary/vm.md). | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| [{{ container-registry-full-name }}](../../container-registry/index.yaml)       | Сервис для управления образами и контейнерами. | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| [{{ dataproc-full-name }}](../../data-proc/index.yaml)                          | Сервис для управления кластерами Apache Hadoop® и {{ SPRK }}. | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) |
| [{{ yds-full-name }}](../../data-streams/index.yaml)                            | Сервис для управления потоками данных в режиме реального времени. | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) |
| [{{ data-transfer-full-name }}](../../data-transfer/index.yaml)                 | Сервис для миграции баз данных, объектных хранилищ или брокеров сообщений. | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| [{{ datalens-full-name }}](../../datalens/index.yaml)                           | Сервис визуализации и анализа данных. | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) |
| [{{ ml-platform-full-name }}](../../datasphere/index.yaml)                      | Сервис для ML-разработки полного цикла. | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) |
| [{{ ddos-protection-full-name }}](../../vpc/ddos-protection/index.md)           | Сервис защиты от DDoS-атак. | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) |
| [{{ foundation-models-full-name }}](../../foundation-models/index.yaml)         | Cервис больших генеративных моделей для бизнеса. | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) |
| [{{ iam-full-name }}](../../iam/index.yaml)                                     | Сервис для управления доступом к облачным ресурсам. | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| [{{ iot-full-name }}](../../iot-core/index.yaml)                                | Сервис интернета вещей для двустороннего обмена сообщениями между реестрами и устройствами по [протоколу MQTT](../../glossary/mqtt-server.md#mqtt-protocol). | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) |
| [{{ kms-full-name }}](../../kms/index.yaml)                                     | Сервис для управления ключами шифрования. | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| [{{ load-testing-full-name }}](../../load-testing/index.yaml)                   | Сервис для проведения нагрузочного тестирования и анализа производительности. | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) |
| [{{ lockbox-name }}](../../lockbox/index.yaml)                                  | Сервис для создания и хранения секретов в инфраструктуре {{ yandex-cloud }}. | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| [{{ maf-full-name }}](../../managed-airflow/index.yaml)                        | Сервис для создания и управления кластерами {{ AF }}. | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) |
| [{{ mkf-full-name }}](../../managed-kafka/index.yaml)                           | Сервис для создания и управления кластерами {{ KF }}. | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| [{{ msp-full-name }}](../../managed-spark/index.yaml)                           | {{ preview-stage }} Сервис для создания и управления кластерами {{ SPRK }}. | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) |
| [{{ mch-full-name }}](../../managed-clickhouse/index.yaml)                      | Сервис для создания и управления кластерами {{ CH }}. | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| [{{ mgl-full-name }}](../../managed-gitlab/index.yaml)                          | Сервис для управления DevOps-платформой {{ GL }}. | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) |
| [{{ mgp-full-name }}](../../managed-greenplum/index.yaml)                       | Сервис для создания и управления кластерами {{ GP }}. | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| [{{ managed-k8s-full-name }}®](../../managed-kubernetes/index.yaml)             | Сервис для создания и управления кластерами Kubernetes. | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| [{{ mmg-full-name }}](../../managed-mongodb/index.yaml)                         | Сервис для создания и управления кластерами {{ MG }}. | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) |
| [{{ mmy-full-name }}®](../../managed-mysql/index.yaml)                          | Сервис для создания и управления кластерами {{ MY }}. | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| [{{ mos-full-name }}](../../managed-opensearch/index.yaml)                      | Сервис для создания и управления кластерами {{ OS }}. | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| [{{ mpg-full-name }}](../../managed-postgresql/index.yaml)                      | Сервис для создания и управления кластерами {{ PG }}. | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| [{{ mrd-full-name }}™](../../managed-redis/index.yaml)                          | Сервис для создания и управления кластерами {{ VLK }}. | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| [{{ mtr-full-name }}](../../managed-trino/index.yaml)                           | {{ preview-stage }} Сервис управления распределенным аналитическим SQL-движком. | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) |
| [{{ ydb-full-name }}](../../ydb/index.yaml)                                     | Сервис управления для базы данных {{ ydb-full-name }}. | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) |
| [{{ marketplace-full-name }}](../../marketplace/index.yaml)                     | Магазин готовых инструментов для разработки, анализа данных, обеспечения безопасности, создания бизнес‑приложений и других задач. | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| [{{ message-queue-full-name }}](../../message-queue/index.yaml)                 | Сервис обмена сообщениями между приложениями. | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) |
| [{{ metadata-hub-full-name }}](../../metadata-hub/index.yaml)                   | {{ preview-stage }} Сервис для управления подключениями к базам данных, хранения схем обмена данными и описания наборов данных. | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) |
| [{{ monitoring-full-name }}](../../monitoring/index.yaml)                       | Сервис для сбора и визуализации метрик. | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| [{{ network-load-balancer-full-name }}](../../network-load-balancer/index.yaml) | Сервис для распределения сетевой нагрузки по облачным ресурсам. | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| [{{ neurosupport-full-name }}](../../neurosupport/index.yaml) |{{ preview-stage }} Сервис на базе {{ yagpt-name }}, который помогает операторам контакт-центров отвечать на сообщения пользователей. | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) |
| [{{ objstorage-full-name }}](../../storage/index.yaml)                          | Универсальное масштабируемое облачное объектное хранилище. | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| [{{ yq-full-name }}](../../query/index.yaml)                                    | Сервис выполнения запросов с помощью единого диалекта SQL. | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) |
| [{{ resmgr-full-name }}](../../resource-manager/index.yaml)                     | Сервис для управления облачными ресурсами. | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| [{{ search-api-full-name }}](../../search-api/index.yaml)                       | Сервис поисковых запросов. | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) |
| [{{ sd-full-name }}](../../security-deck/index.yaml)                            | Сервис для управления безопасностью в облаке. | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| [{{ serverless-containers-full-name }}](../../serverless-containers/index.yaml) | Сервис бессерверного запуска контейнеризированных приложений. | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) |
| [{{ si-full-name }}](../../serverless-integrations/index.yaml)                  | {{ preview-stage }} Сервис для настройки интеграций и управления ими на базе Serverless. | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) |
| [{{ captcha-full-name }}](../../smartcaptcha/index.yaml)                        | Сервис для распознавания пользователей системы. | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) |
| [{{ sws-full-name }}](../../smartwebsecurity/index.yaml)                        | Сервис для защиты от DDoS-атак и ботов на уровне приложений (L7). | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) |
| [{{ speechkit-full-name }}](../../{{ speechkit-slug }}/index.yaml)              | Сервис технологий распознавания и синтеза речи. | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| [{{ speechsense-full-name }}](../../speechsense/index.yaml)                     | Сервис речевой аналитики для анализа голосовых и текстовых каналов коммуникации. | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) |
| [{{ translate-full-name }}](../../translate/index.yaml)                         | Сервис машинного перевода. | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) |
| [{{ vpc-full-name }}](../../vpc/index.yaml)                                     | Сервис для управления облачными сетями. | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| [{{ vision-full-name }}](../../vision/index.yaml)                               | Сервис компьютерного зрения для распознавания текста на изображениях и в файлах PDF. | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) |
| [{{ websql-full-name }}](../../websql/index.yaml)                               | Сервис для подключения к кластерам управляемых баз данных. | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) |

## Как подключиться к сервисам {#enable}

Для подключения к сервисам и управления ресурсами вы можете использовать [консоль управления]({{ link-console-main }}) {{ yandex-cloud }}. С ее помощью вы можете запускать виртуальные машины в {{ yandex-cloud }} и подключаться к ним, обращаться к объектному хранилищу, создавать базы данных и т. п.

Сервисы, находящиеся на стадии Preview, доступны не всем пользователям. Если вы хотите воспользоваться одним из таких сервисов, отправьте нам заявку на доступ. Сделать это можно на странице соответствующего сервиса.

{% include [Apache trademark](../../_includes/data-processing/trademark.md) %}

{% include [Greenplum trademark](../../_includes/mdb/mgp/trademark.md) %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
