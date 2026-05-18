---
title: Эндпоинты API сервисов {{ yandex-cloud }}
description: Из статьи вы узнаете про эндпоинты API сервисов {{ yandex-cloud }}, а также ознакомитесь с примерами эндпоинтов.
---

# Эндпоинты API сервисов {{ yandex-cloud }}

У каждого из сервисов {{ yandex-cloud }} есть эндпоинт, к которому следует отправлять HTTP-запросы. Полный список эндпоинтов можно запросить с помощью вызова [endpoints](https://{{ api-host }}/endpoints) к URL `https://{{ api-host }}`.

## Пример {#example}


```bash
curl https://{{ api-host }}/endpoints
{
 "endpoints": [
  {
   "id": "ai-assistants",
   "address": "assistant.{{ api-host }}:443"
  },
  {
   "id": "ai-files",
   "address": "assistant.{{ api-host }}:443"
  },
  {
   "id": "ai-foundation-models",
   "address": "ai.{{ api-host }}:443"
  },
  {
   "id": "ai-llm",
   "address": "ai.{{ api-host }}:443"
  },
  {
   "id": "ai-speechkit",
   "address": "transcribe.{{ api-host }}:443"
  },
  {
   "id": "ai-stt",
   "address": "transcribe.{{ api-host }}:443"
  },
  {
   "id": "ai-stt-v3",
   "address": "stt.{{ api-host }}:443"
  },
  {
   "id": "ai-translate",
   "address": "translate.{{ api-host }}:443"
  },
  {
   "id": "ai-vision",
   "address": "vision.{{ api-host }}:443"
  },
  {
   "id": "ai-vision-ocr",
   "address": "ocr.{{ api-host }}:443"
  },
  {
   "id": "alb",
   "address": "alb.{{ api-host }}:443"
  },
  {
   "id": "alert-sink",
   "address": "alert-sink.{{ api-host }}:443"
  },
  {
   "id": "apigateway-connections",
   "address": "apigateway-connections.{{ api-host }}:443"
  },
  {
   "id": "application-load-balancer",
   "address": "alb.{{ api-host }}:443"
  },
  {
   "id": "apploadbalancer",
   "address": "alb.{{ api-host }}:443"
  },
  {
   "id": "audittrails",
   "address": "audittrails.{{ api-host }}:443"
  },
  {
   "id": "baas",
   "address": "backup.{{ api-host }}:443"
  },
  {
   "id": "backup",
   "address": "backup.{{ api-host }}:443"
  },
  {
   "id": "baremetal",
   "address": "baremetal.{{ api-host }}:443"
  },
  {
   "id": "billing",
   "address": "billing.{{ api-host }}:443"
  },
  {
   "id": "broker-data",
   "address": "iot-data.{{ api-host }}:443"
  },
  {
   "id": "cdn",
   "address": "cdn.{{ api-host }}:443"
  },
  {
   "id": "certificate-manager",
   "address": "{{ api-host-certmanager }}:443"
  },
  {
   "id": "certificate-manager-data",
   "address": "{{ api-host-certmanager-certcontent }}:443"
  },
  {
   "id": "certificate-manager-private-ca",
   "address": "private-ca.certificate-manager.{{ api-host }}:443"
  },
  {
   "id": "certificate-manager-private-ca-data",
   "address": "data.private-ca.certificate-manager.{{ api-host }}:443"
  },
  {
   "id": "cic",
   "address": "cic.{{ api-host }}:443"
  },
  {
   "id": "cloud-registry",
   "address": "registry.{{ api-host }}:443"
  },
  {
   "id": "cloudapps",
   "address": "cloudapps.{{ api-host }}:443"
  },
  {
   "id": "cloudbackup",
   "address": "backup.{{ api-host }}:443"
  },
  {
   "id": "clouddesktops",
   "address": "clouddesktops.{{ api-host }}:443"
  },
  {
   "id": "cloudrouter",
   "address": "cloudrouter.{{ api-host }}:443"
  },
  {
   "id": "cloudvideo",
   "address": "video.{{ api-host }}:443"
  },
  {
   "id": "compute",
   "address": "compute.{{ api-host }}:443"
  },
  {
   "id": "connection-manager",
   "address": "connectionmanager.{{ api-host }}:443"
  },
  {
   "id": "container-registry",
   "address": "container-registry.{{ api-host }}:443"
  },
  {
   "id": "datacatalog",
   "address": "datacatalog.{{ api-host }}:443"
  },
  {
   "id": "dataproc",
   "address": "dataproc.{{ api-host }}:443"
  },
  {
   "id": "dataproc-manager",
   "address": "dataproc-manager.{{ api-host }}:443"
  },
  {
   "id": "datasphere",
   "address": "datasphere.{{ api-host }}:443"
  },
  {
   "id": "datatransfer",
   "address": "datatransfer.{{ api-host }}:443"
  },
  {
   "id": "dns",
   "address": "dns.{{ api-host }}:443"
  },
  {
   "id": "endpoint",
   "address": "{{ api-host }}:443"
  },
  {
   "id": "fomo-dataset",
   "address": "fomo-dataset.{{ api-host }}:443"
  },
  {
   "id": "fomo-tuning",
   "address": "fomo-tuning.{{ api-host }}:443"
  },
  {
   "id": "gitlab",
   "address": "gitlab.{{ api-host }}:443"
  },
  {
   "id": "iam",
   "address": "iam.{{ api-host }}:443"
  },
  {
   "id": "iot-broker",
   "address": "iot-broker.{{ api-host }}:443"
  },
  {
   "id": "iot-data",
   "address": "iot-data.{{ api-host }}:443"
  },
  {
   "id": "iot-devices",
   "address": "iot-devices.{{ api-host }}:443"
  },
  {
   "id": "k8s",
   "address": "mks.{{ api-host }}:443"
  },
  {
   "id": "kms",
   "address": "{{ api-host-kms }}:443"
  },
  {
   "id": "kms-crypto",
   "address": "{{ api-host-kms-symcrypto }}:443"
  },
  {
   "id": "kspm",
   "address": "kspm.{{ api-host }}:443"
  },
  {
   "id": "load-balancer",
   "address": "load-balancer.{{ api-host }}:443"
  },
  {
   "id": "loadtesting",
   "address": "loadtesting.{{ api-host }}:443"
  },
  {
   "id": "locator",
   "address": "locator.{{ api-host }}:443"
  },
  {
   "id": "lockbox",
   "address": "{{ api-host-lockbox }}:443"
  },
  {
   "id": "lockbox-payload",
   "address": "{{ api-host-lockbox-payload }}:443"
  },
  {
   "id": "log-ingestion",
   "address": "{{ logging-endpoint-ingester }}:443"
  },
  {
   "id": "log-reading",
   "address": "{{ logging-endpoint-reader }}:443"
  },
  {
   "id": "logging",
   "address": "logging.{{ api-host }}:443"
  },
  {
   "id": "managed-airflow",
   "address": "airflow.{{ api-host }}:443"
  },
  {
   "id": "managed-clickhouse",
   "address": "mdb.{{ api-host }}:443"
  },
  {
   "id": "managed-elasticsearch",
   "address": "mdb.{{ api-host }}:443"
  },
  {
   "id": "managed-greenplum",
   "address": "mdb.{{ api-host }}:443"
  },
  {
   "id": "managed-kafka",
   "address": "mdb.{{ api-host }}:443"
  },
  {
   "id": "managed-kubernetes",
   "address": "mks.{{ api-host }}:443"
  },
  {
   "id": "managed-metastore",
   "address": "metastore.{{ api-host }}:443"
  },
  {
   "id": "managed-mongodb",
   "address": "mdb.{{ api-host }}:443"
  },
  {
   "id": "managed-mysql",
   "address": "mdb.{{ api-host }}:443"
  },
  {
   "id": "managed-opensearch",
   "address": "mdb.{{ api-host }}:443"
  },
  {
   "id": "managed-postgresql",
   "address": "mdb.{{ api-host }}:443"
  },
  {
   "id": "managed-redis",
   "address": "mdb.{{ api-host }}:443"
  },
  {
   "id": "managed-spark",
   "address": "{{ api-host-spark }}:443"
  },
  {
   "id": "managed-spqr",
   "address": "mdb.{{ api-host }}:443"
  },
  {
   "id": "managed-trino",
   "address": "trino.{{ api-host }}:443"
  },
  {
   "id": "managed-ytsaurus",
   "address": "ytsaurus.{{ api-host }}:443"
  },
  {
   "id": "marketplace",
   "address": "marketplace.{{ api-host }}:443"
  },
  {
   "id": "marketplace-pim",
   "address": "marketplace.{{ api-host }}:443"
  },
  {
   "id": "marketplace-stacklandlicenseapi",
   "address": "marketplace.{{ api-host }}:443"
  },
  {
   "id": "mdb-clickhouse",
   "address": "mdb.{{ api-host }}:443"
  },
  {
   "id": "mdb-mongodb",
   "address": "mdb.{{ api-host }}:443"
  },
  {
   "id": "mdb-mysql",
   "address": "mdb.{{ api-host }}:443"
  },
  {
   "id": "mdb-opensearch",
   "address": "mdb.{{ api-host }}:443"
  },
  {
   "id": "mdb-postgresql",
   "address": "mdb.{{ api-host }}:443"
  },
  {
   "id": "mdb-redis",
   "address": "mdb.{{ api-host }}:443"
  },
  {
   "id": "mdb-spqr",
   "address": "mdb.{{ api-host }}:443"
  },
  {
   "id": "mdbproxy",
   "address": "mdbproxy.{{ api-host }}:443"
  },
  {
   "id": "monitoring",
   "address": "monitoring.{{ api-host }}:443"
  },
  {
   "id": "operation",
   "address": "operation.{{ api-host }}:443"
  },
  {
   "id": "organization-manager",
   "address": "organization-manager.{{ api-host }}:443"
  },
  {
   "id": "organizationmanager",
   "address": "organization-manager.{{ api-host }}:443"
  },
  {
   "id": "quota-manager",
   "address": "quota-manager.{{ api-host }}:443"
  },
  {
   "id": "quotamanager",
   "address": "quota-manager.{{ api-host }}:443"
  },
  {
   "id": "resource-manager",
   "address": "resource-manager.{{ api-host }}:443"
  },
  {
   "id": "resourcemanager",
   "address": "resource-manager.{{ api-host }}:443"
  },
  {
   "id": "searchapi",
   "address": "searchapi.{{ api-host }}:443"
  },
  {
   "id": "serialssh",
   "address": "{{ serial-ssh-host }}:9600"
  },
  {
   "id": "serverless-apigateway",
   "address": "serverless-apigateway.{{ api-host }}:443"
  },
  {
   "id": "serverless-containers",
   "address": "serverless-containers.{{ api-host }}:443"
  },
  {
   "id": "serverless-eventrouter",
   "address": "serverless-eventrouter.{{ api-host }}:443"
  },
  {
   "id": "serverless-functions",
   "address": "serverless-functions.{{ api-host }}:443"
  },
  {
   "id": "serverless-gateway-connections",
   "address": "apigateway-connections.{{ api-host }}:443"
  },
  {
   "id": "serverless-mcp-gateway",
   "address": "serverless-mcp-gateway.{{ api-host }}:443"
  },
  {
   "id": "serverless-triggers",
   "address": "serverless-triggers.{{ api-host }}:443"
  },
  {
   "id": "serverless-workflows",
   "address": "serverless-workflows.{{ api-host }}:443"
  },
  {
   "id": "serverlesseventrouter-events",
   "address": "events.eventrouter.serverless.yandexcloud.net:443"
  },
  {
   "id": "smart-captcha",
   "address": "smartcaptcha.{{ api-host }}:443"
  },
  {
   "id": "smart-web-security",
   "address": "smartwebsecurity.{{ api-host }}:443"
  },
  {
   "id": "storage",
   "address": "{{ s3-storage-host }}:443"
  },
  {
   "id": "storage-api",
   "address": "storage.{{ api-host }}:443"
  },
  {
   "id": "video",
   "address": "video.{{ api-host }}:443"
  },
  {
   "id": "vpc",
   "address": "vpc.{{ api-host }}:443"
  },
  {
   "id": "ycvc",
   "address": "yc-tools-version-control.{{ api-host }}:443"
  },
  {
   "id": "ydb",
   "address": "ydb.{{ api-host }}:443"
  }
 ]
}
```



