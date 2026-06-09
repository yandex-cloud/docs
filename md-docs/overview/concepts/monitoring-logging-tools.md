# Observability-инструменты мониторинга и логирования

В {{ yandex-cloud }} доступны следующие сервисы для мониторинга и логирования:

* [{{ metrics-name }}](../../monium/metrics/overview.md)
* [{{ at-full-name }}](../../audit-trails/index.md)
* [{{ cloud-logging-full-name }}](../../logging/index.md)

Метрики, логи и аудитные события решают разные задачи и дополняют друг друга. Метрики помогают следить за состоянием и производительностью систем. Логи помогают разбирать поведение приложений и сервисов, искать ошибки и анализировать отдельные запросы или операции. Аудитные события фиксируют действия с ресурсами и события безопасности.

Эти данные обычно анализируют разные специалисты. Метрики и логи используют [SRE](https://ru.wikipedia.org/wiki/Site_Reliability_Engineering)-, [DevOps](https://ru.wikipedia.org/wiki/DevOps) и инженерные команды. Аудитные события используют администраторы безопасности, [SOC](https://yandex.cloud/ru/blog/soc-security-operations-center)- и [compliance](https://yandex.cloud/ru/security/compliance-portal)-команды.

Сбор аудитных событий не относится к [Observability](../../glossary/observability.md), но эти данные полезно анализировать вместе с метриками и логами.

Информация о доступности инструментов мониторинга и логирования для конкретных сервисов представлена в таблице.

| Сервис | {{ metrics-name }} | {{ at-name }} Control&nbsp;Plane | {{ at-name }} Data&nbsp;Plane | {{ cloud-logging-name }} |
|--------|-----------------------|-----------------------------|--------------------------|--------------------------|
| [{{ gost-gateway-name }}](../../gost-gateway/index.md) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) |
| [{{ ai-studio-full-name }}]({{ link-docs-ai }}ai-studio/concepts/index) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| [{{ alb-full-name }}](../../application-load-balancer/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ at-full-name }}](../../audit-trails/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ backup-full-name }}](../../backup/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) |
| [{{ baremetal-full-name }}](../../baremetal/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| [{{ billing-name }}](../../billing/index.md) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) |
| [{{ cdn-full-name }}](../../cdn/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) |
| [{{ certificate-manager-full-name }}](../../certificate-manager/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| [{{ cloud-apps-full-name }}](../../cloud-apps/index.md) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) |
| [{{ cloud-desktop-full-name }}](../../cloud-desktop/index.md) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| [{{ cloud-registry-full-name }}](../../cloud-registry/index.md) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) |
| [{{ stackland-full-name }}](../../stackland/index.md) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) |
| [{{ ca-full-name }}]({{ link-src-docs }}/code-assistant/) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) |
| [{{ compute-full-name }}](../../compute/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) ^1^ |
| [{{ container-registry-full-name }}](../../container-registry/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ dataproc-full-name }}](../../data-proc/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ yds-full-name }}](../../data-streams/index.md) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ data-transfer-full-name }}](../../data-transfer/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) |
| [{{ datalens-full-name }}](../../datalens/index.md) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) |
| [{{ ml-platform-full-name }}](../../datasphere/index.md) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ dns-full-name }}](../../dns/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| [{{ sf-full-name }}](../../functions/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ iam-full-name }}](../../iam/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| [{{ iot-full-name }}](../../iot-core/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ kms-full-name }}](../../kms/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| [{{ load-testing-full-name }}](../../load-testing/index.md) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) |
| [{{ lockbox-name }}](../../lockbox/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| [{{ cloud-logging-full-name }}](../../logging/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ maf-full-name }}](../../managed-airflow/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ mch-full-name }}](../../managed-clickhouse/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| [{{ mgl-full-name }}](../../managed-gitlab/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) |
| [{{ mgp-full-name }}](../../managed-greenplum/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ mkf-full-name }}](../../managed-kafka/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| [{{ msp-full-name }}](../../managed-spark/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) |
| [{{ managed-k8s-full-name }}®](../../managed-kubernetes/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ mmg-full-name }}](../../storedoc/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| [{{ mmy-full-name }}](../../managed-mysql/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| [{{ mos-full-name }}](../../managed-opensearch/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| [{{ mpg-full-name }}](../../managed-postgresql/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ mspqr-full-name }}](../../managed-spqr/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| [{{ mrd-full-name }}™](../../managed-valkey/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| [{{ mtr-full-name }}](../../managed-trino/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) |
| [{{ marketplace-full-name }}](../../marketplace/index.md) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) |
| [{{ message-queue-full-name }}](../../message-queue/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) |
| [{{ metadata-hub-full-name }}](../../metadata-hub/index.md) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) |
| [{{ monitoring-full-name }}](../../monitoring/index.md) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) |
| [{{ monium-full-name }}](../../monium/index.md) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) |
| [{{ network-load-balancer-full-name }}](../../network-load-balancer/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) |
| [{{ neurosupport-full-name }}](../../neurosupport/index.md) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) |
| [{{ cns-full-name }}](../../notifications/index.md) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ org-full-name }}](../../organization/index.md) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| [{{ postbox-full-name }}](../../postbox/index.md) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ quota-manager-full-name }}](../../quota-manager/index.md) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) |
| [{{ yq-full-name }}](../../query/index.md) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) |
| [{{ resmgr-full-name }}](../../resource-manager/index.md) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) |
| [{{ search-api-full-name }}]({{ link-docs-ai }}search-api/concepts/index) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) |
| [{{ sd-full-name }}](../../security-deck/index.md) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| [{{ serverless-containers-full-name }}](../../serverless-containers/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ si-full-name }}: {{ api-gw-short-name }}](../../api-gateway/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ si-full-name }}: {{ er-name }}](../../serverless-integrations/quickstart/eventrouter.md) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ si-full-name }}: {{ sw-name }}](../../serverless-integrations/quickstart/workflows.md) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ captcha-full-name }}](../../smartcaptcha/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) |
| [{{ sws-full-name }}](../../smartwebsecurity/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| [{{ speechkit-full-name }}]({{ link-docs-ai }}{{ speechkit-slug }}/overview) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| [{{ speechsense-full-name }}]({{ link-docs-ai }}speechsense/) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| [{{ objstorage-full-name }}](../../storage/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) ^2^ |
| [{{ translate-full-name }}]({{ link-docs-ai }}translate/concepts/index) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| [{{ video-full-name }}](../../video/index.md) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) |
| [{{ vision-full-name }}]({{ link-docs-ai }}vision/concepts/ocr/index) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| [{{ vpc-full-name }}](../../vpc/index.md) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| [{{ websql-full-name }}](../../websql/index.md) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| [{{ ydb-full-name }}](../../ydb/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) |
| [{{ myt-full-name }}](../../managed-ytsaurus/index.md) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) |

^1^ Логи виртуальных машин можно передавать с помощью [Fluent Bit](../../logging/tutorials/vm-fluent-bit-logging.md) или [Unified Agent](../../logging/tutorials/ua-http-logging.md).
^2^ Логирование действий с бакетами осуществляется [средствами](../../storage/concepts/server-logs.md) сервиса {{ objstorage-name }}.

## См. также {#see-also}

* [Справочник метрик Monitoring](../../monitoring/metrics-ref/index.md)
* [Справочник событий уровня конфигурации Audit Trails](../../audit-trails/concepts/events.md)
* [Справочник событий уровня сервисов Audit Trails](../../audit-trails/concepts/events-data-plane.md)