---
title: Обзор интерфейсов для работы с сервисами
description: Сервисы в {{ yandex-cloud }} могут быть доступны в различных интерфейсах — консоль управления, отдельный веб-интерфейс, мобильное приложение, а также CLI, {{ TF }} и API.
---

# Обзор интерфейсов для работы с сервисами

Вы можете работать c сервисами {{ yandex-cloud }} с помощью следующих интерфейсов:

* [Консоль управления](../../console/index.yaml) или отдельный веб-интерфейс
* [Интерфейс командной строки ({{ yandex-cloud }} CLI)](../../cli/index.yaml)
* [{{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md)
* [API](../../api-design-guide/index.yaml)

Информация о доступности интерфейсов для конкретных сервисов представлена в таблице:

| Сервис | Консоль&nbsp;управления</br> или отдельный&nbsp;веб-интерфейс | CLI | {{ TF }} | API |
|---|---|---|---|---|
| [{{ alb-full-name }}](../../application-load-balancer/index.yaml) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ at-full-name }}](../../audit-trails/index.yaml) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ backup-full-name }}](../../backup/index.yaml) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ baremetal-full-name }}](../../baremetal/index.yaml) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) |
| [{{ billing-name }}](../../billing/index.yaml) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ cdn-full-name }}](../../cdn/index.yaml) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ certificate-manager-full-name }}](../../certificate-manager/index.yaml) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ cloud-apps-full-name }}](../../cloud-apps/index.yaml) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) |
| [{{ cloud-desktop-full-name }}](../../cloud-desktop/index.yaml) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ cloud-registry-full-name }}](../../cloud-registry/index.yaml) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ ca-full-name }}](../../code-assistant/index.md) ^1^ | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) |
| [{{ compute-full-name }}](../../compute/index.yaml) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ container-registry-full-name }}](../../container-registry/index.yaml) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ dataproc-full-name }}](../../data-proc/index.yaml) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ yds-full-name }}](../../data-streams/index.yaml) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ data-transfer-full-name }}](../../data-transfer/index.yaml) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ datalens-full-name }}](../../datalens/index.yaml) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) |
| [{{ ml-platform-full-name }}](../../datasphere/index.yaml) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ dns-full-name }}](../../dns/index.yaml) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ foundation-models-full-name }}](../../foundation-models/index.yaml) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ sf-full-name }}](../../functions/index.yaml) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ iam-full-name }}](../../iam/index.yaml) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ iot-full-name }}](../../iot-core/index.yaml) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ kms-full-name }}](../../kms/index.yaml) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ load-testing-full-name }}](../../load-testing/index.yaml) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ lockbox-name }}](../../lockbox/index.yaml) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ cloud-logging-full-name }}](../../logging/index.yaml) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ maf-full-name }}](../../managed-airflow/index.yaml) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ mkf-full-name }}](../../managed-kafka/index.yaml) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ msp-full-name }}](../../managed-spark/index.yaml) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ mch-full-name }}](../../managed-clickhouse/index.yaml) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ mgl-full-name }}](../../managed-gitlab/index.yaml) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ mgp-full-name }}](../../managed-greenplum/index.yaml) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ managed-k8s-full-name }}®](../../managed-kubernetes/index.yaml) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ mmg-full-name }}](../../managed-mongodb/index.yaml) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ mmy-full-name }}](../../managed-mysql/index.yaml) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ mos-full-name }}](../../managed-opensearch/index.yaml) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ mpg-full-name }}](../../managed-postgresql/index.yaml) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ mrd-full-name }}](../../managed-redis/index.yaml) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ mtr-full-name }}](../../managed-trino/index.yaml) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) |
| [{{ marketplace-full-name }}](../../marketplace/index.yaml) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ message-queue-full-name }}](../../message-queue/index.yaml) ^2^ | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ metadata-hub-full-name }}](../../metadata-hub/index.yaml) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ monitoring-full-name }}](../../monitoring/index.yaml) ^3^ | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ network-load-balancer-full-name }}](../../network-load-balancer/index.yaml) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ cns-full-name}}](../../notifications/index.yaml) ^2^  | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ org-full-name }}](../../organization/index.yaml) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ postbox-full-name }}](../../postbox/index.yaml) ^2^ | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ yq-full-name }}](../../query/index.yaml) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ resmgr-full-name }}](../../resource-manager/index.yaml) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ search-api-full-name }}](../../search-api/index.yaml) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ sd-full-name }}](../../security-deck/index.yaml) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) |
| [{{ serverless-containers-full-name }}](../../serverless-containers/index.yaml) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ si-full-name }}: {{ api-gw-short-name }}](../../api-gateway/index.yaml) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ si-full-name }}: {{ er-name }}](../../serverless-integrations/quickstart/eventrouter.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ si-full-name }}: {{ sw-name }}](../../serverless-integrations/quickstart/workflows.md) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ captcha-full-name }}](../../smartcaptcha/index.yaml) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ sws-full-name }}](../../smartwebsecurity/index.yaml) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ speechkit-full-name }}](../../{{ speechkit-slug }}/index.yaml) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ speechsense-full-name }}](../../speechsense/index.yaml) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ objstorage-full-name }}](../../storage/index.yaml) ^2^ | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ translate-full-name }}](../../translate/index.yaml) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ video-full-name }}](../../video/index.yaml) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ vision-full-name }}](../../vision/index.yaml) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ vpc-full-name }}](../../vpc/index.yaml) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [{{ websql-full-name }}](../../websql/index.yaml) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) |
| [{{ ydb-full-name }}](../../ydb/index.yaml) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |

^1^ Взаимодействие с сервисом осуществляется с помощью специального плагина для [Visual Studio Code](https://code.visualstudio.com/) и [IDE от JetBrains](https://www.jetbrains.com/ides/).
^2^ Дополнительно доступен интерфейс командной строки [AWS CLI](../../storage/tools/aws-cli.md).
^3^ Графический интерфейс {{ monitoring-name }} доступен как в [консоли управления]({{ link-console-main }}), так и в [собственном интерфейсе сервиса]({{ link-monitoring }}).

## См. также {#see-also}

* [Справочник {{ yandex-cloud }} CLI](../../cli/cli-ref/)
* [Справочник {{ TF }}]({{ tf-docs-link }})
* [Справочник API](../api.md)