---
title: Service resource labels
description: In this article you will learn about labels, their use cases, and the services labels are supported in.
---

# Service resource labels


Most {{ yandex-cloud }} services support resource labeling.

A _label_ is a key-value pair in `<label_name>=<label_value>` format. You can use labels to break resources into logical groups.

{% include [tags-restrictions](../../_includes/tags-restrictions.md) %}

## Label usage examples {#examples}

* [Viewing service usage details by labels](../../billing/operations/check-charges.md#labels_1).

    For example, you can [view the {{ ml-platform-name }} spending details](../../datasphere/operations/community/billing-details.md).

* Searching for resources belonging to the same project, owner, environment, etc.

    For example, you can use the `project:app` label to find the {{ yandex-cloud }} resources used in the `app` project.

* Grouping resources by various criteria, such as project, team, environment, application, etc.

    For example, you can use the `environment:production` and `environment:test` labels to mark {{ yandex-cloud }} resources as belonging to the production and test environments.

* Automating actions with a resource group, such as launching, stopping, or deleting the labeled resources.

    For example, you can [manage a resource group using {{ sf-full-name }}](../../tutorials/infrastructure-management/serverless-trigger-budget-vm.md).

## Services that support labels {#services}

{% note info %}

Some service resources do not support labels, and some interfaces may not display them. For example, resource labels may not be visible in the management console interface or {{ cloud-center }} interface.

{% endnote %}

### Infrastructure and network {#infra}

* [{{ api-gw-full-name }}](../../api-gateway/index.yaml)
* [{{ alb-full-name }}](../../application-load-balancer/index.yaml)
* [{{ cdn-full-name }}](../../cdn/index.yaml)
* [{{ dns-full-name }}](../../dns/index.yaml)
* [{{ cloud-logging-full-name }}](../../logging/index.yaml)
* [{{ compute-full-name }}](../../compute/index.yaml)
* [{{ load-testing-full-name }}](../../load-testing/index.yaml)
* [{{ network-load-balancer-full-name }}](../../network-load-balancer/index.yaml)
* [{{ objstorage-full-name }}](../../storage/index.yaml)
* [{{ vpc-full-name }}](../../vpc/index.yaml)

### Data platform {#data-platform}

* [{{ dataproc-full-name }}](../../data-proc/index.yaml)
* [{{ data-transfer-full-name }}](../../data-transfer/index.yaml)
* [{{ ml-platform-full-name }}](../../datasphere/index.yaml)
* [{{ message-queue-full-name }}](../../message-queue/index.yaml)
* [{{ maf-full-name }}](../../managed-airflow/index.yaml)
* [{{ mkf-full-name }}](../../managed-kafka/index.yaml)
* [{{ mch-full-name }}](../../managed-clickhouse/index.yaml)
* [{{ mes-full-name }}](../../managed-elasticsearch/index.yaml)
* [{{ mgp-full-name }}](../../managed-greenplum/index.yaml)
* [{{ mmg-full-name }}](../../managed-mongodb/index.yaml)
* [{{ mmy-full-name }}](../../managed-mysql/index.yaml)
* [{{ mos-full-name }}](../../managed-opensearch/index.yaml)
* [{{ mpg-full-name }}](../../managed-postgresql/index.yaml)
* [{{ mrd-full-name }}](../../managed-redis/index.yaml)
* [{{ ydb-full-name }}](../../ydb/index.yaml)
* [{{ metadata-hub-full-name }}](../../metadata-hub/index.yaml) ({{ connection-manager-full-name }} and {{ metastore-full-name }} clusters)

### Containers {#containers}

* [{{ container-registry-full-name }}](../../container-registry/index.yaml)
* [{{ managed-k8s-full-name }}](../../managed-kubernetes/index.yaml)
* [{{ serverless-containers-full-name }}](../../serverless-containers/index.yaml)

### Serverless computing {#serverless}

* [{{ sf-full-name }}](../../functions/index.yaml)
* [{{ iot-full-name }}](../../iot-core/index.yaml)
* [{{ serverless-containers-full-name }}](../../serverless-containers/index.yaml)
* [{{ si-full-name }}](../../serverless-integrations/index.yaml) ({{ er-name }})

### Security {#security}

* [{{ at-full-name }}](../../audit-trails/index.yaml)
* [{{ certificate-manager-full-name }}](../../certificate-manager/index.yaml)
* [{{ iam-full-name }}](../../iam/index.yaml)
* [{{ kms-full-name }}](../../kms/index.yaml)
* [{{ lockbox-full-name }}](../../lockbox/index.yaml)

### Developer tools {#developer-tools}

* [{{ mgl-full-name }}](../../managed-gitlab/index.yaml)

### Monitoring and resource management {#resources-operations}

* [{{ org-full-name }}](../../organization/index.yaml)
* [{{ resmgr-full-name }}](../../resource-manager/index.yaml)

#### See also {#see-also}

* [Managing labels](../operations/manage-labels.md)
* [Managing labels in {{ ml-platform-full-name }} communities](../../datasphere/operations/community/manage-community-labels.md)
* [Managing labels in {{ ml-platform-full-name }} projects](../../datasphere/operations/projects/manage-project-labels.md)

{% include [Greenplum trademark](../../_includes/mdb/mgp/trademark.md) %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
