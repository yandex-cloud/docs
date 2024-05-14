# Management event reference


The value of the `event_type` field in a management event audit log is determined by the event source service.

The general value format is as follows:

```text
{{ at-event-prefix }}.audit.<service_name>.<event_name>
```

On this page, you will find events for the following services:

* [{{ api-gw-name }}](#api-gateway)
* [{{ alb-name }}](#alb)
* [{{ at-name }}](#audit-trails)
* [{{ certificate-manager-name }}](#certificate-manager)
* [{{ backup-name }}](#backup)
* [{{ cdn-name }}](#cdn)
* [{{ dns-name }}](#dns)
* [{{ sf-name }}](#functions)
* [{{ cloud-logging-name }}](#cloud-logging)
* [{{ marketplace-name }}](#marketplace)
* [{{ org-name }}](#organization)
* [{{ cloud-apps-name }}](#cloud-apps)
* [{{ compute-name }}](#compute)
* [{{ container-registry-name }}](#container-registry)
* [{{ dataproc-name }}](#dataproc)
* [{{ ml-platform-name }}](#datasphere)
* [{{ data-transfer-name }}](#datatransfer)
* [{{ iam-name }}](#iam)
* [{{ iot-name }}](#iot)
* [{{ kms-name }}](#kms)
* [{{ load-testing-name }}](#loadtesting)
* [{{ lockbox-name }}](#lockbox)
* [{{ mch-short-name }}](#managed-service-for-clickhouse)
* [{{ mgl-full-name }}](#managed-service-for-gitlab)
* [{{ mgp-short-name }}](#managed-service-for-greenplum)
* [{{ mkf-short-name }}](#managed-service-for-kafka)
* [{{ managed-k8s-name }}](#managed-service-for-kubernetes)
* [{{ mmg-short-name }}](#managed-service-for-mongodb)
* [{{ mmy-short-name }}](#managed-service-for-mysql)
* [{{ mos-short-name }}](#managed-service-for-opensearch)
* [{{ mpg-short-name }}](#managed-service-for-postgresql)
* [{{ mrd-short-name }}](#managed-service-for-redis)
* [{{ network-load-balancer-name }}](#network-load-balancer)
* [{{ objstorage-name }}](#objstorage)
* [{{ resmgr-name }}](#resmgr)
* [{{ search-api-name }}](#searchapi)
* [{{ serverless-containers-name }}](#serverless-containers)
* [{{ captcha-name }}](#smartcaptcha)
* [{{ sws-name }}](#smartwebsecurity)
* [{{ speechsense-name }}](#speechsense)
* [{{ vpc-name }}](#vpc)
* [{{ ydb-short-name }}](#ydb)
* [{{ yq-short-name }}](#yq)

## {{ api-gw-name }} {#api-gateway}

Service name: `serverless.apigateway`.

{% include [api-gw-events](../../_includes/audit-trails/events/api-gw-events.md) %}

## {{ alb-name }} {#alb}

Service name: `apploadbalancer`.

{% include [alb-events](../../_includes/audit-trails/events/alb-events.md) %}

## {{ at-name }} {#audit-trails}

Service name: `audittrails`.

| Event name | Description |
--- | ---
| `CreateTrail` | Creating a trail |
| `DeleteTrail` | Deleting a trail |
| `SetTrailAccessBindings` | Setting access bindings for a trail |
| `UpdateTrail` | Editing a trail |
| `UpdateTrailAccessBindings` | Updating access bindings for a trail |


## {{ certificate-manager-name }} {#certificate-manager}

Service name: `certificatemanager`.

{% include [cm-events](../../_includes/audit-trails/events/cm-events.md) %}

## {{ backup-name }} {#backup}

Service name: `backup`.

{% include [backup-events](../../_includes/audit-trails/events/backup-events.md) %}


## {{ cdn-name }} {#cdn}

Service name: `cdn`.

{% include [cdn-events](../../_includes/audit-trails/events/cdn-events.md) %}

## {{ dns-name }} {#dns}

Service name: `dns`.

{% include [dns-events](../../_includes/audit-trails/events/dns-events.md) %}

## {{ sf-name }} {#functions}

Service name: `serverless`.

{% include [functions-events](../../_includes/audit-trails/events/functions-events.md) %}


## {{ cloud-logging-name }} {#cloud-logging}

Service name: `logging`.

{% include [logging-events](../../_includes/audit-trails/events/logging-events.md) %}


## {{ marketplace-name }} {#marketplace}

Service name: `marketplace.licensemanager`.

{% include [marketplace-events](../../_includes/audit-trails/events/marketplace-events.md) %}

## {{ org-name }} {#organization}

The name of the service is `organizationmanager`.

{% include [org-events](../../_includes/audit-trails/events/org-events.md) %}

## {{ cloud-apps-name }} {#cloud-apps}

Service name: `cloudapps`.

| Event name | Description |
--- | ---
| `CreateCloudApplication` | Creating an application |
| `DeleteCloudApplication` | Deleting an application |
| `SetApplicationAccessBindings` | Setting application access bindings |
| `UpdateApplicationAccessBindings` | Updating application access bindings |
| `UpdateCloudApplication` | Updating an application |

## {{ compute-name }} {#compute}

Service name: `compute`.

{% include [compute-events](../../_includes/audit-trails/events/compute-events.md) %}

## {{ container-registry-name }} {#container-registry}

Service name: `containerregistry`.

{% include [container-registry-events](../../_includes/audit-trails/events/container-registry-events.md) %}

## {{ dataproc-name }} {#dataproc}

Service name: `dataproc`.

{% include [dataproc-events](../../_includes/audit-trails/events/dataproc-events.md) %}

## {{ data-transfer-name }} {#datatransfer}

Service name: `datatransfer`.

{% include [datatransfer-events](../../_includes/audit-trails/events/datatransfer-events.md) %}

## {{ ml-platform-name }} {#datasphere}

Service name: `datasphere`.

{% include [ds-events](../../_includes/audit-trails/events/ds-events.md) %}

## {{ iam-name }} {#iam}

Service name: `iam`.

{% include [iam-events](../../_includes/audit-trails/events/iam-events.md) %}

## {{ iot-name }} {#iot}

Service name: `iot`.

{% include [iot-events](../../_includes/audit-trails/events/iot-events.md) %}

## {{ kms-name }} {#kms}

Service name: `kms`.

{% include [kms-events](../../_includes/audit-trails/events/kms-events.md) %}

## {{ load-testing-name }} {#loadtesting}

Service name: `loadtesting`.

{% include [load-testing-events](../../_includes/audit-trails/events/load-testing-events.md) %}

## {{ lockbox-name }} {#lockbox}

Service name: `lockbox`.

{% include [lockbox-events](../../_includes/audit-trails/events/lockbox-events.md) %}

## {{ mch-short-name }} {#managed-service-for-clickhouse}

Service name: `mdb.clickhouse`.

{% include [mch-events](../../_includes/audit-trails/events/mch-events.md) %}



## {{ mgl-name }} {#managed-service-for-gitlab}

Service name: `gitlab`.

{% include [mgl-events](../../_includes/audit-trails/events/mgl-events.md) %}


## {{ mgp-short-name }} {#managed-service-for-greenplum}

Service name: `mdb.greenplum`.

{% include [mgp-events](../../_includes/audit-trails/events/managed-greenplum-events.md) %}

## {{ mkf-short-name }} {#managed-service-for-kafka}

Service name: `mdb.kafka`.

{% include [managed-kafka-events](../../_includes/audit-trails/events/managed-kafka-events.md) %}

## {{ managed-k8s-name }} {#managed-service-for-kubernetes}

Service name: `k8s`.

{% include [managed-k8s-events](../../_includes/audit-trails/events/managed-k8s-events.md) %}


## {{ mmg-short-name }} {#managed-service-for-mongodb}

Service name: `mdb.mongodb`.

{% include [mongodb-events](../../_includes/audit-trails/events/mongodb-events.md) %}


## {{ mmy-short-name }} {#managed-service-for-mysql}

Service name: `mdb.mysql`.

{% include [mysql-events](../../_includes/audit-trails/events/mysql-events.md) %}

## {{ mos-short-name }} {#managed-service-for-opensearch}

Service name: `mdb.opensearch`.

{% include [mos-events](../../_includes/audit-trails/events/mos-events.md) %}

## {{ mpg-short-name }} {#managed-service-for-postgresql}

Service name: `mdb.postgresql`.

{% include [mpg-events](../../_includes/audit-trails/events/managed-postgresql-events.md) %}

## {{ mrd-short-name }} {#managed-service-for-redis}

Service name: `mdb.redis`.

{% include [mrd-events](../../_includes/audit-trails/events/mrd-events.md) %}

## {{ network-load-balancer-name }} {#network-load-balancer}

Service name: `loadbalancer`.

{% include [network-load-balancer-events](../../_includes/audit-trails/events/network-load-balancer-events.md) %}

## {{ objstorage-name }} {#objstorage}

Service name: `storage`.

{% include [storage-events](../../_includes/audit-trails/events/storage-events.md) %}

## {{ resmgr-name }} {#resmgr}

Service name: `resourcemanager`.

{% include [resmgr-events](../../_includes/audit-trails/events/resmgr-events.md) %}

## {{ search-api-name }} {#searchapi}

Service name: `searchapi`.

{% include [searchapi-events](../../_includes/audit-trails/events/searchapi-events.md) %}

## {{ serverless-containers-name }} {#serverless-containers}

Service name: `serverless.containers`.

{% include [serverless-containers-events](../../_includes/audit-trails/events/serverless-containers-events.md) %}

## {{ captcha-name }} {#smartcaptcha}

Service name: `smartcaptcha`.

{% include [captcha-events](../../_includes/audit-trails/events/captcha-events.md) %}

## {{ sws-name }} {#smartwebsecurity}

Service name: `smartwebsecurity`.

{% include [sws-events](../../_includes/audit-trails/events/sws-events.md) %}

## {{ speechsense-name }} {#speechsense}

Service name: `speechsense`.

{% include [org-events](../../_includes/audit-trails/events/speechsense-events.md) %}

## {{ vpc-name }} {#vpc}

Service name: `network`.

{% include [vpc-events](../../_includes/audit-trails/events/vpc-events.md) %}


## {{ ydb-short-name }} {#ydb}

Service name: `ydb`.

{% include [ydb-events](../../_includes/audit-trails/events/ydb-events.md) %}

## {{ yq-short-name }} {#yq}

Service name: `yq`.

{% include [yq-events](../../_includes/audit-trails/events/yq-events.md) %}


{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}