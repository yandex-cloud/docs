# Обзор интерфейсов для работы с сервисами

Вы можете работать c сервисами {{ yandex-cloud }} с помощью следующих интерфейсов:

* [Консоль управления](../../console/index.md) или отдельный веб-интерфейс
* [Интерфейс командной строки ({{ yandex-cloud }} CLI)](../../cli/index.md)
* [{{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md)
* [API](../../api-design-guide/index.md)

Информация о доступности интерфейсов для конкретных сервисов представлена в таблице:

| Сервис | Консоль&nbsp;управления</br> или отдельный&nbsp;веб-интерфейс | CLI | {{ TF }} | API |
|---|---|---|---|---|
| [{{ gost-gateway-name }}](../../gost-gateway/index.md) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) |
| [{{ ai-studio-full-name }}]({{ link-docs-ai }}ai-studio/concepts/index) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ alb-full-name }}](../../application-load-balancer/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ at-full-name }}](../../audit-trails/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ backup-full-name }}](../../backup/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ baremetal-full-name }}](../../baremetal/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ billing-name }}](../../billing/index.md) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ cdn-full-name }}](../../cdn/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ certificate-manager-full-name }}](../../certificate-manager/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ cloud-apps-full-name }}](../../cloud-apps/index.md) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) |
| [{{ cloud-desktop-full-name }}](../../cloud-desktop/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ cloud-registry-full-name }}](../../cloud-registry/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ stackland-full-name }}](../../stackland/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) |
| [{{ ca-full-name }}]({{ link-src-docs }}/code-assistant/) ^1^ | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) |
| [{{ compute-full-name }}](../../compute/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ container-registry-full-name }}](../../container-registry/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ dataproc-full-name }}](../../data-proc/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ yds-full-name }}](../../data-streams/index.md) ^2^ | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ data-transfer-full-name }}](../../data-transfer/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ datalens-full-name }}](../../datalens/index.md) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) |
| [{{ ml-platform-full-name }}](../../datasphere/index.md) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ dns-full-name }}](../../dns/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ sf-full-name }}](../../functions/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ iam-full-name }}](../../iam/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ iot-full-name }}](../../iot-core/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ kms-full-name }}](../../kms/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ load-testing-full-name }}](../../load-testing/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ lockbox-name }}](../../lockbox/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ cloud-logging-full-name }}](../../logging/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ maf-full-name }}](../../managed-airflow/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ mkf-full-name }}](../../managed-kafka/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ msp-full-name }}](../../managed-spark/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ mch-full-name }}](../../managed-clickhouse/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ mgl-full-name }}](../../managed-gitlab/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ mgp-full-name }}](../../managed-greenplum/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ managed-k8s-full-name }}®](../../managed-kubernetes/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ mmg-full-name }}](../../storedoc/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ mmy-full-name }}](../../managed-mysql/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ mos-full-name }}](../../managed-opensearch/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ mpg-full-name }}](../../managed-postgresql/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ mspqr-full-name }}](../../managed-spqr/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ mrd-full-name }}](../../managed-valkey/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ mtr-full-name }}](../../managed-trino/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ marketplace-full-name }}](../../marketplace/index.md) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ message-queue-full-name }}](../../message-queue/index.md) ^2^ | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ metadata-hub-full-name }}](../../metadata-hub/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ monitoring-full-name }}](../../monitoring/index.md) ^3^ | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ monium-full-name }}](../../monium/index.md) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ network-load-balancer-full-name }}](../../network-load-balancer/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ neurosupport-full-name }}](../../neurosupport/index.md) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) |
| [{{ cns-full-name }}](../../notifications/index.md) ^2^  | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ org-full-name }}](../../organization/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ postbox-full-name }}](../../postbox/index.md) ^2^ | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ quota-manager-full-name }}](../../quota-manager/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ yq-full-name }}](../../query/index.md) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ resmgr-full-name }}](../../resource-manager/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ search-api-full-name }}]({{ link-docs-ai }}search-api/concepts/index) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ sd-full-name }}](../../security-deck/index.md) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) |
| [{{ serverless-containers-full-name }}](../../serverless-containers/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ si-full-name }}: {{ api-gw-short-name }}](../../api-gateway/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ si-full-name }}: {{ er-name }}](../../serverless-integrations/quickstart/eventrouter.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ si-full-name }}: {{ sw-name }}](../../serverless-integrations/quickstart/workflows.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ captcha-full-name }}](../../smartcaptcha/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ sws-full-name }}](../../smartwebsecurity/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ speechkit-full-name }}]({{ link-docs-ai }}speechkit/overview) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ speechsense-full-name }}]({{ link-docs-ai }}speechsense/) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ objstorage-full-name }}](../../storage/index.md) ^2^ | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ translate-full-name }}]({{ link-docs-ai }}translate/concepts/index) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ video-full-name }}](../../video/index.md) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ vision-full-name }}]({{ link-docs-ai }}vision/concepts/ocr/index) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ vpc-full-name }}](../../vpc/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ websql-full-name }}](../../websql/index.md) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) |
| [{{ ydb-full-name }}](../../ydb/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ myt-full-name }}](../../managed-ytsaurus/index.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |

^1^ Взаимодействие с сервисом осуществляется с помощью специального плагина для [Visual Studio Code](https://code.visualstudio.com/) и [IDE от JetBrains](https://www.jetbrains.com/ides/).
^2^ Дополнительно доступен интерфейс командной строки [AWS CLI](../../storage/tools/aws-cli.md).
^3^ Графический интерфейс {{ monitoring-name }} доступен как в [консоли управления]({{ link-console-main }}), так и в [собственном интерфейсе сервиса]({{ link-monitoring }}).

## См. также {#see-also}

* [Справочник {{ yandex-cloud }} CLI](../../cli/cli-ref/index.md)
* [Справочник {{ TF }}]({{ tf-docs-link }})
* [Справочник API](../api.md)