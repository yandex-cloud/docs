[Документация Yandex Cloud](../../index.md) > [Обзор платформы](../index.md) > Сервисы Yandex Cloud > Observability-инструменты мониторинга и логирования

# Observability-инструменты мониторинга и логирования

В Yandex Cloud доступны следующие сервисы для мониторинга и логирования:

* [Monium Metrics](../../monium/metrics/overview.md)
* [Yandex Audit Trails](../../audit-trails/index.md)
* [Yandex Cloud Logging](../../logging/index.md)

Метрики, логи и аудитные события решают разные задачи и дополняют друг друга. Метрики помогают следить за состоянием и производительностью систем. Логи помогают разбирать поведение приложений и сервисов, искать ошибки и анализировать отдельные запросы или операции. Аудитные события фиксируют действия с ресурсами и события безопасности.

Эти данные обычно анализируют разные специалисты. Метрики и логи используют [SRE](https://ru.wikipedia.org/wiki/Site_Reliability_Engineering)-, [DevOps](https://ru.wikipedia.org/wiki/DevOps) и инженерные команды. Аудитные события используют администраторы безопасности, [SOC](https://yandex.cloud/ru/blog/soc-security-operations-center)- и [compliance](https://yandex.cloud/ru/security/compliance-portal)-команды.

Сбор аудитных событий не относится к [Observability](../../glossary/observability.md), но эти данные полезно анализировать вместе с метриками и логами.

Информация о доступности инструментов мониторинга и логирования для конкретных сервисов представлена в таблице.

#|
|| **Сервис** | **Monium Metrics** | **Audit Trails Control&nbsp;Plane** | **Audit Trails Data&nbsp;Plane** | **Cloud Logging** ||
|| **Инфраструктура и сеть** | > | > | > ||
|| [Yandex Application Load Balancer](../../application-load-balancer/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) ||
|| [Yandex BareMetal](../../baremetal/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) ||
|| [Yandex Cloud Backup](../../backup/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) ||
|| [Yandex Cloud CDN](../../cdn/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) ||
|| [Yandex Cloud DNS](../../dns/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) ||
|| [Yandex Cloud Interconnect](../../interconnect/index.md) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) ||
|| [Yandex Cloud Router](../../cloud-router/index.md) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) ||
|| [Yandex Cloud Stackland](../../stackland/index.md) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) ||
|| [Yandex Cloud Video](../../video/index.md) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) ||
|| [Yandex Compute Cloud](../../compute/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) ^1^ ||
|| [Yandex Network Load Balancer](../../network-load-balancer/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) ||
|| [Yandex Object Storage](../../storage/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) ^2^ ||
|| [Yandex Virtual Private Cloud](../../vpc/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) ||
|| **Платформа данных** | > | > | > ||
|| [Yandex Data Processing](../../data-proc/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) ||
|| [Yandex Data Transfer](../../data-transfer/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) ||
|| [Yandex DataLens](../../datalens/index.md) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) ||
|| [Yandex Managed Service for Apache Airflow™](../../managed-airflow/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) ||
|| [Yandex Managed Service for Apache Kafka®](../../managed-kafka/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) ||
|| [Yandex Managed Service for Apache Spark™](../../managed-spark/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) ||
|| [Yandex Managed Service for ClickHouse®](../../managed-clickhouse/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) ||
|| [Yandex Managed Service for MySQL®](../../managed-mysql/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) ||
|| [Yandex Managed Service for OpenSearch](../../managed-opensearch/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) ||
|| [Yandex Managed Service for PostgreSQL](../../managed-postgresql/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) ||
|| [Yandex Managed Service for Sharded PostgreSQL](../../managed-spqr/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) ||
|| [Yandex Managed Service for Trino](../../managed-trino/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) ||
|| [Yandex Managed Service for Valkey™™](../../managed-valkey/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) ||
|| [Yandex Managed Service for YDB](../../ydb/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) ||
|| [Yandex Managed Service for YTsaurus](../../managed-ytsaurus/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) ||
|| [Yandex MetaData Hub: Yandex Connection Manager](../../metadata-hub/quickstart/connection-manager.md) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) ||
|| [Yandex MetaData Hub: Apache Hive™ Metastore](../../metadata-hub/quickstart/metastore.md) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) ||
|| [Yandex MetaData Hub: Yandex Schema Registry](../../metadata-hub/quickstart/schema-registry.md) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) ||
|| [Yandex MetaData Hub: Yandex Data Catalog](../../metadata-hub/quickstart/data-steward-quickstart.md) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) ||
|| [Yandex MPP Analytics for PostgreSQL](../../managed-greenplum/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) ||
|| [Yandex StoreDoc](../../storedoc/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) ||
|| [Yandex WebSQL](../../websql/index.md) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) ||
|| **Искусственный интеллект** | > | > | > ||
|| [Yandex AI Studio](https://aistudio.yandex.ru/docs/ru/ai-studio/concepts/index) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) ||
|| [Yandex DataSphere](../../datasphere/index.md) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) ||
|| [Yandex Search API](https://aistudio.yandex.ru/docs/ru/search-api/concepts/index) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) ||
|| [Yandex SpeechKit](https://aistudio.yandex.ru/docs/ru/speechkit/overview) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) ||
|| [Yandex SpeechSense](https://aistudio.yandex.ru/docs/ru/speechsense/) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) ||
|| [Yandex Translate](https://aistudio.yandex.ru/docs/ru/translate/concepts/index) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) ||
|| [Yandex Vision OCR](https://aistudio.yandex.ru/docs/ru/vision/concepts/ocr/index) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) ||
|| **Безопасность** | > | > | > ||
|| [GOST Gateway](../../gost-gateway/index.md) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) ||
|| [Yandex Audit Trails](../../audit-trails/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) ||
|| [Yandex Certificate Manager](../../certificate-manager/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) ||
|| [Yandex Cloud Desktop](../../cloud-desktop/index.md) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) ||
|| [Yandex Cloud Detection and Response](../../ycdr/index.md) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) ||
|| [Yandex Cloud Registry](../../cloud-registry/index.md) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) ||
|| [Yandex Identity Hub](../../organization/index.md) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) ||
|| [Yandex Key Management Service](../../kms/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) ||
|| [Yandex Lockbox](../../lockbox/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) ||
|| [Yandex Security Deck](../../security-deck/index.md) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) ||
|| [Yandex SIEM](../../siem/index.md) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) ||
|| [Yandex SmartCaptcha](../../smartcaptcha/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) ||
|| [Yandex Smart Web Security](../../smartwebsecurity/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) ||
|| **Инструменты DevOps** | > | > | > ||
|| [SourceCraft](https://sourcecraft.dev/portal/docs/ru) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) ||
|| [SourceCraft Code Assistant](https://sourcecraft.dev/portal/docs/ru/code-assistant/) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) ||
|| [Vibecraft](https://sourcecraft.dev/portal/docs/ru/vibecraft/) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) ||
|| [Yandex Cloud Logging](../../logging/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) ||
|| [Yandex Cloud Marketplace](../../marketplace/index.md) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) ||
|| [Yandex Container Registry](../../container-registry/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) ||
|| [Yandex Managed Service for GitLab](../../managed-gitlab/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) ||
|| [Yandex Managed Service for Kubernetes®](../../managed-kubernetes/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) ||
|| [Yandex Monitoring](../../monitoring/index.md) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) ||
|| [Yandex Monium](../../monium/index.md) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) ||
|| **Бессерверные вычисления** | > | > | > ||
|| [Yandex API Gateway](../../api-gateway/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) ||
|| [Yandex Cloud Functions](../../functions/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) ||
|| [Yandex Cloud Notification Service](../../notifications/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) ||
|| [Yandex Cloud Postbox](../../postbox/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) ||
|| [Yandex Data Streams](../../data-streams/index.md) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) ||
|| [Yandex IoT Core](../../iot-core/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) ||
|| [Yandex Message Queue](../../message-queue/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) ||
|| [Yandex Query](../../query/index.md) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) ||
|| [Yandex Serverless Containers](../../serverless-containers/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) ||
|| [Yandex Serverless Integrations: EventRouter](../../serverless-integrations/quickstart/eventrouter.md) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) ||
|| **Управление ресурсами** | > | > | > ||
|| [Yandex Cloud Apps](../../cloud-apps/index.md) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) ||
|| [Yandex Cloud Billing](../../billing/index.md) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) ||
|| [Yandex Cloud Console](../../console/index.md) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) ||
|| [Yandex Cloud Quota Manager](../../quota-manager/index.md) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) ||
|| [Yandex Identity and Access Management](../../iam/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) ||
|| [Yandex Resource Manager](../../resource-manager/index.md) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) ||
|#

^1^ Логи виртуальных машин можно передавать с помощью [Fluent Bit](../../logging/tutorials/vm-fluent-bit-logging.md) или [Unified Agent](../../logging/tutorials/ua-http-logging.md).
^2^ Логирование действий с бакетами осуществляется [средствами](../../storage/concepts/server-logs.md) сервиса Object Storage.

## Полезные ссылки {#see-also}

* [Справочник метрик Monitoring](../../monitoring/metrics-ref/index.md)
* [Справочник событий уровня конфигурации Audit Trails](../../audit-trails/concepts/events.md)
* [Справочник событий уровня сервисов Audit Trails](../../audit-trails/concepts/events-data-plane.md)