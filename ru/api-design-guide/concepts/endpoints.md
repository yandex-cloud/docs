# Эндпоинты API сервисов {{ yandex-cloud }}

У каждого из сервисов {{ yandex-cloud }} есть эндпоинт, к которому следует отправлять HTTP-запросы. Полный список эндпоинтов можно запросить с помощью вызова [endpoints](https://{{ api-host }}/endpoints) к URL `https://{{ api-host }}`.

## Пример {#example}

{% if product == "yandex-cloud" %}

```bash
curl https://{{ api-host }}/endpoints
{
 "endpoints": [
  {
   "id": "ai-speechkit",
   "address": "transcribe.{{ api-host }}:443"
  },
  {
   "id": "ai-stt",
   "address": "transcribe.{{ api-host }}:443"
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
   "id": "alb",
   "address": "alb.{{ api-host }}:443"
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
   "id": "billing",
   "address": "billing.{{ api-host }}:443"
  },
  {
   "id": "cdn",
   "address": "cdn.{{ api-host }}:443"
  },
  {
   "id": "certificate-manager",
   "address": "certificate-manager.{{ api-host }}:443"
  },
  {
   "id": "certificate-manager-data",
   "address": "data.certificate-manager.{{ api-host }}:443"
  },
  {
   "id": "clouddesktops",
   "address": "clouddesktops.api.cloud.yandex.net:443"
  },
  {
   "id": "compute",
   "address": "compute.{{ api-host }}:443"
  },
  {
   "id": "container-registry",
   "address": "container-registry.{{ api-host }}:443"
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
   "id": "iam",
   "address": "iam.{{ api-host }}:443"
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
   "address": "kms.{{ api-host }}:443"
  },
  {
   "id": "kms-crypto",
   "address": "kms.yandex:443"
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
   "address": "lockbox.{{ api-host }}:443"
  },
  {
   "id": "lockbox-payload",
   "address": "payload.lockbox.{{ api-host }}:443"
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
   "address": "logging.{{ api-host }}:443"
  },
  {
   "id": "logs",
   "address": "logs.{{ api-host }}:443"
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
   "id": "managed-mongodb",
   "address": "mdb.{{ api-host }}:443"
  },
  {
   "id": "managed-mysql",
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
   "id": "managed-sqlserver",
   "address": "mdb.{{ api-host }}:443"
  },
  {
   "id": "marketplace",
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
   "id": "mdb-postgresql",
   "address": "mdb.{{ api-host }}:443"
  },
  {
   "id": "mdb-redis",
   "address": "mdb.{{ api-host }}:443"
  },
  {
   "id": "mdbproxy",
   "address": "mdbproxy.{{ api-host }}:443"
  },
  {
   "id": "monitoring",
   "address": "monitoring.api.cloud.yandex.net:443"
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
   "id": "resource-manager",
   "address": "resource-manager.{{ api-host }}:443"
  },
  {
   "id": "resourcemanager",
   "address": "resource-manager.{{ api-host }}:443"
  },
  {
   "id": "serialssh",
   "address": "serialssh.cloud.yandex.net:9600"
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
   "id": "serverless-functions",
   "address": "serverless-functions.{{ api-host }}:443"
  },
  {
   "id": "serverless-triggers",
   "address": "serverless-triggers.{{ api-host }}:443"
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
   "id": "vpc",
   "address": "vpc.{{ api-host }}:443"
  },
  {
   "id": "ydb",
   "address": "ydb.{{ api-host }}:443"
  }
 ]
}
```

{% endif %}

{% if product == "cloud-il" %}

```bash
curl https://{{ api-host }}/endpoints
{
 "endpoints": [
  {
   "id": "alb",
   "address": "alb.{{ api-host }}:443"
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
   "id": "certificate-manager",
   "address": "cpl.ycm.{{ api-host }}:443"
  },
  {
   "id": "certificate-manager-data",
   "address": "dpl.ycm.{{ api-host }}:443"
  },
  {
   "id": "compute",
   "address": "compute.{{ api-host }}:443"
  },
  {
   "id": "container-registry",
   "address": "container-registry.{{ api-host }}:443"
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
   "id": "iam",
   "address": "iam.{{ api-host }}:443"
  },
  {
   "id": "k8s",
   "address": "mks.{{ api-host }}:443"
  },
  {
   "id": "kms",
   "address": "cpl.kms.{{ api-host }}:443"
  },
  {
   "id": "kms-crypto",
   "address": "dpl.kms.{{ api-host }}:443"
  },
  {
   "id": "load-balancer",
   "address": "load-balancer.{{ api-host }}:443"
  },
  {
   "id": "lockbox",
   "address": "cpl.lockbox.{{ api-host }}:443"
  },
  {
   "id": "lockbox-payload",
   "address": "dpl.lockbox.{{ api-host }}:443"
  },
  {
   "id": "managed-kubernetes",
   "address": "mks.{{ api-host }}:443"
  },
  {
   "id": "operation",
   "address": "operation.{{ api-host }}:443"
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
   "id": "vpc",
   "address": "vpc.{{ api-host }}:443"
  }
 ]
}
```

{% endif %}