[Документация Yandex Cloud](../../index.md) > [Концепции API Yandex Cloud](../index.md) > Методы API > Эндпоинты API

# Эндпоинты API сервисов Yandex Cloud

У каждого из сервисов Yandex Cloud есть эндпоинт, к которому следует отправлять HTTP-запросы. Полный список эндпоинтов можно запросить с помощью вызова [endpoints](https://api.cloud.yandex.net/endpoints) к URL `https://api.cloud.yandex.net`.

## Пример {#example}


```bash
curl https://api.cloud.yandex.net/endpoints
{
 "endpoints": [
  {
   "id": "ai-assistants",
   "address": "assistant.api.cloud.yandex.net:443"
  },
  {
   "id": "ai-files",
   "address": "assistant.api.cloud.yandex.net:443"
  },
  {
   "id": "ai-foundation-models",
   "address": "ai.api.cloud.yandex.net:443"
  },
  {
   "id": "ai-llm",
   "address": "ai.api.cloud.yandex.net:443"
  },
  {
   "id": "ai-speechkit",
   "address": "transcribe.api.cloud.yandex.net:443"
  },
  {
   "id": "ai-stt",
   "address": "transcribe.api.cloud.yandex.net:443"
  },
  {
   "id": "ai-stt-v3",
   "address": "stt.api.cloud.yandex.net:443"
  },
  {
   "id": "ai-translate",
   "address": "translate.api.cloud.yandex.net:443"
  },
  {
   "id": "ai-vision",
   "address": "vision.api.cloud.yandex.net:443"
  },
  {
   "id": "ai-vision-ocr",
   "address": "ocr.api.cloud.yandex.net:443"
  },
  {
   "id": "alb",
   "address": "alb.api.cloud.yandex.net:443"
  },
  {
   "id": "alert-sink",
   "address": "alert-sink.api.cloud.yandex.net:443"
  },
  {
   "id": "apigateway-connections",
   "address": "apigateway-connections.api.cloud.yandex.net:443"
  },
  {
   "id": "application-load-balancer",
   "address": "alb.api.cloud.yandex.net:443"
  },
  {
   "id": "apploadbalancer",
   "address": "alb.api.cloud.yandex.net:443"
  },
  {
   "id": "audittrails",
   "address": "audittrails.api.cloud.yandex.net:443"
  },
  {
   "id": "baas",
   "address": "backup.api.cloud.yandex.net:443"
  },
  {
   "id": "backup",
   "address": "backup.api.cloud.yandex.net:443"
  },
  {
   "id": "baremetal",
   "address": "baremetal.api.cloud.yandex.net:443"
  },
  {
   "id": "billing",
   "address": "billing.api.cloud.yandex.net:443"
  },
  {
   "id": "broker-data",
   "address": "iot-data.api.cloud.yandex.net:443"
  },
  {
   "id": "cdn",
   "address": "cdn.api.cloud.yandex.net:443"
  },
  {
   "id": "certificate-manager",
   "address": "certificate-manager.api.cloud.yandex.net:443"
  },
  {
   "id": "certificate-manager-data",
   "address": "data.certificate-manager.api.cloud.yandex.net:443"
  },
  {
   "id": "certificate-manager-private-ca",
   "address": "private-ca.certificate-manager.api.cloud.yandex.net:443"
  },
  {
   "id": "certificate-manager-private-ca-data",
   "address": "data.private-ca.certificate-manager.api.cloud.yandex.net:443"
  },
  {
   "id": "cic",
   "address": "cic.api.cloud.yandex.net:443"
  },
  {
   "id": "cloud-registry",
   "address": "registry.api.cloud.yandex.net:443"
  },
  {
   "id": "cloudapps",
   "address": "cloudapps.api.cloud.yandex.net:443"
  },
  {
   "id": "cloudbackup",
   "address": "backup.api.cloud.yandex.net:443"
  },
  {
   "id": "clouddesktops",
   "address": "clouddesktops.api.cloud.yandex.net:443"
  },
  {
   "id": "cloudrouter",
   "address": "cloudrouter.api.cloud.yandex.net:443"
  },
  {
   "id": "cloudvideo",
   "address": "video.api.cloud.yandex.net:443"
  },
  {
   "id": "compute",
   "address": "compute.api.cloud.yandex.net:443"
  },
  {
   "id": "connection-manager",
   "address": "connectionmanager.api.cloud.yandex.net:443"
  },
  {
   "id": "container-registry",
   "address": "container-registry.api.cloud.yandex.net:443"
  },
  {
   "id": "datacatalog",
   "address": "datacatalog.api.cloud.yandex.net:443"
  },
  {
   "id": "dataproc",
   "address": "dataproc.api.cloud.yandex.net:443"
  },
  {
   "id": "dataproc-manager",
   "address": "dataproc-manager.api.cloud.yandex.net:443"
  },
  {
   "id": "datasphere",
   "address": "datasphere.api.cloud.yandex.net:443"
  },
  {
   "id": "datatransfer",
   "address": "datatransfer.api.cloud.yandex.net:443"
  },
  {
   "id": "dns",
   "address": "dns.api.cloud.yandex.net:443"
  },
  {
   "id": "endpoint",
   "address": "api.cloud.yandex.net:443"
  },
  {
   "id": "fomo-dataset",
   "address": "fomo-dataset.api.cloud.yandex.net:443"
  },
  {
   "id": "fomo-tuning",
   "address": "fomo-tuning.api.cloud.yandex.net:443"
  },
  {
   "id": "gitlab",
   "address": "gitlab.api.cloud.yandex.net:443"
  },
  {
   "id": "iam",
   "address": "iam.api.cloud.yandex.net:443"
  },
  {
   "id": "iot-broker",
   "address": "iot-broker.api.cloud.yandex.net:443"
  },
  {
   "id": "iot-data",
   "address": "iot-data.api.cloud.yandex.net:443"
  },
  {
   "id": "iot-devices",
   "address": "iot-devices.api.cloud.yandex.net:443"
  },
  {
   "id": "k8s",
   "address": "mks.api.cloud.yandex.net:443"
  },
  {
   "id": "kms",
   "address": "kms.api.cloud.yandex.net:443"
  },
  {
   "id": "kms-crypto",
   "address": "kms.yandex:443"
  },
  {
   "id": "kspm",
   "address": "kspm.api.cloud.yandex.net:443"
  },
  {
   "id": "load-balancer",
   "address": "load-balancer.api.cloud.yandex.net:443"
  },
  {
   "id": "loadtesting",
   "address": "loadtesting.api.cloud.yandex.net:443"
  },
  {
   "id": "locator",
   "address": "locator.api.cloud.yandex.net:443"
  },
  {
   "id": "lockbox",
   "address": "lockbox.api.cloud.yandex.net:443"
  },
  {
   "id": "lockbox-payload",
   "address": "payload.lockbox.api.cloud.yandex.net:443"
  },
  {
   "id": "log-ingestion",
   "address": "ingester.logging.yandexcloud.net:443"
  },
  {
   "id": "log-reading",
   "address": "reader.logging.yandexcloud.net:443"
  },
  {
   "id": "logging",
   "address": "logging.api.cloud.yandex.net:443"
  },
  {
   "id": "managed-airflow",
   "address": "airflow.api.cloud.yandex.net:443"
  },
  {
   "id": "managed-clickhouse",
   "address": "mdb.api.cloud.yandex.net:443"
  },
  {
   "id": "managed-elasticsearch",
   "address": "mdb.api.cloud.yandex.net:443"
  },
  {
   "id": "managed-greenplum",
   "address": "mdb.api.cloud.yandex.net:443"
  },
  {
   "id": "managed-kafka",
   "address": "mdb.api.cloud.yandex.net:443"
  },
  {
   "id": "managed-kubernetes",
   "address": "mks.api.cloud.yandex.net:443"
  },
  {
   "id": "managed-metastore",
   "address": "metastore.api.cloud.yandex.net:443"
  },
  {
   "id": "managed-mongodb",
   "address": "mdb.api.cloud.yandex.net:443"
  },
  {
   "id": "managed-mysql",
   "address": "mdb.api.cloud.yandex.net:443"
  },
  {
   "id": "managed-opensearch",
   "address": "mdb.api.cloud.yandex.net:443"
  },
  {
   "id": "managed-postgresql",
   "address": "mdb.api.cloud.yandex.net:443"
  },
  {
   "id": "managed-redis",
   "address": "mdb.api.cloud.yandex.net:443"
  },
  {
   "id": "managed-spark",
   "address": "spark.api.cloud.yandex.net:443"
  },
  {
   "id": "managed-spqr",
   "address": "mdb.api.cloud.yandex.net:443"
  },
  {
   "id": "managed-trino",
   "address": "trino.api.cloud.yandex.net:443"
  },
  {
   "id": "managed-ytsaurus",
   "address": "ytsaurus.api.cloud.yandex.net:443"
  },
  {
   "id": "marketplace",
   "address": "marketplace.api.cloud.yandex.net:443"
  },
  {
   "id": "marketplace-pim",
   "address": "marketplace.api.cloud.yandex.net:443"
  },
  {
   "id": "marketplace-stacklandlicenseapi",
   "address": "marketplace.api.cloud.yandex.net:443"
  },
  {
   "id": "mdb-clickhouse",
   "address": "mdb.api.cloud.yandex.net:443"
  },
  {
   "id": "mdb-mongodb",
   "address": "mdb.api.cloud.yandex.net:443"
  },
  {
   "id": "mdb-mysql",
   "address": "mdb.api.cloud.yandex.net:443"
  },
  {
   "id": "mdb-opensearch",
   "address": "mdb.api.cloud.yandex.net:443"
  },
  {
   "id": "mdb-postgresql",
   "address": "mdb.api.cloud.yandex.net:443"
  },
  {
   "id": "mdb-redis",
   "address": "mdb.api.cloud.yandex.net:443"
  },
  {
   "id": "mdb-spqr",
   "address": "mdb.api.cloud.yandex.net:443"
  },
  {
   "id": "mdbproxy",
   "address": "mdbproxy.api.cloud.yandex.net:443"
  },
  {
   "id": "monitoring",
   "address": "monitoring.api.cloud.yandex.net:443"
  },
  {
   "id": "operation",
   "address": "operation.api.cloud.yandex.net:443"
  },
  {
   "id": "organization-manager",
   "address": "organization-manager.api.cloud.yandex.net:443"
  },
  {
   "id": "organizationmanager",
   "address": "organization-manager.api.cloud.yandex.net:443"
  },
  {
   "id": "quota-manager",
   "address": "quota-manager.api.cloud.yandex.net:443"
  },
  {
   "id": "quotamanager",
   "address": "quota-manager.api.cloud.yandex.net:443"
  },
  {
   "id": "resource-manager",
   "address": "resource-manager.api.cloud.yandex.net:443"
  },
  {
   "id": "resourcemanager",
   "address": "resource-manager.api.cloud.yandex.net:443"
  },
  {
   "id": "searchapi",
   "address": "searchapi.api.cloud.yandex.net:443"
  },
  {
   "id": "serialssh",
   "address": "serialssh.cloud.yandex.net:9600"
  },
  {
   "id": "serverless-apigateway",
   "address": "serverless-apigateway.api.cloud.yandex.net:443"
  },
  {
   "id": "serverless-containers",
   "address": "serverless-containers.api.cloud.yandex.net:443"
  },
  {
   "id": "serverless-eventrouter",
   "address": "serverless-eventrouter.api.cloud.yandex.net:443"
  },
  {
   "id": "serverless-functions",
   "address": "serverless-functions.api.cloud.yandex.net:443"
  },
  {
   "id": "serverless-gateway-connections",
   "address": "apigateway-connections.api.cloud.yandex.net:443"
  },
  {
   "id": "serverless-mcp-gateway",
   "address": "serverless-mcp-gateway.api.cloud.yandex.net:443"
  },
  {
   "id": "serverless-triggers",
   "address": "serverless-triggers.api.cloud.yandex.net:443"
  },
  {
   "id": "serverless-workflows",
   "address": "serverless-workflows.api.cloud.yandex.net:443"
  },
  {
   "id": "serverlesseventrouter-events",
   "address": "events.eventrouter.serverless.yandexcloud.net:443"
  },
  {
   "id": "smart-captcha",
   "address": "smartcaptcha.api.cloud.yandex.net:443"
  },
  {
   "id": "smart-web-security",
   "address": "smartwebsecurity.api.cloud.yandex.net:443"
  },
  {
   "id": "storage",
   "address": "storage.yandexcloud.net:443"
  },
  {
   "id": "storage-api",
   "address": "storage.api.cloud.yandex.net:443"
  },
  {
   "id": "video",
   "address": "video.api.cloud.yandex.net:443"
  },
  {
   "id": "vpc",
   "address": "vpc.api.cloud.yandex.net:443"
  },
  {
   "id": "ycvc",
   "address": "yc-tools-version-control.api.cloud.yandex.net:443"
  },
  {
   "id": "ydb",
   "address": "ydb.api.cloud.yandex.net:443"
  }
 ]
}
```