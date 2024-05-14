# Service resource labels


Most {{ yandex-cloud }} services support resource labeling.

A _label_ is a key-value pair in `<label_name>=<label_value>` format. You can use labels to logically separate resources.

Labels are subject to the following restrictions:

* Maximum number of labels per resource: 64.
* The key:
   * Must be from 1 to 63 characters long.
   * May contain lowercase Latin letters, numbers, hyphens, and underscores.
   * Must start with a letter.
* The value:
   * May be up to 63 characters long.
   * May contain lowercase Latin letters, numbers, hyphens, and underscores.

## Services that support labels {#services}

List of services whose resources support labels:
* [{{ api-gw-full-name }}](../../api-gateway/index.yaml)
* [{{ alb-full-name }}](../../application-load-balancer/index.yaml)
* [{{ certificate-manager-full-name }}](../../certificate-manager/index.yaml)
* [{{ dns-full-name }}](../../dns/index.yaml)
* [{{ sf-full-name }}](../../functions/index.yaml)
* [{{ cloud-logging-full-name }}](../../logging/index.yaml)
* [{{ compute-full-name }}](../../compute/index.yaml)
* [{{ container-registry-full-name }}](../../container-registry/index.yaml)
* [{{ dataproc-full-name }}](../../data-proc/index.yaml)
* [{{ ml-platform-full-name }}](../../datasphere/index.yaml)
* [{{ iot-full-name }}](../../iot-core/index.yaml)
* [{{ kms-full-name }}](../../kms/index.yaml)
* [{{ lockbox-full-name }}](../../lockbox/index.yaml)
* [{{ mkf-full-name }}](../../managed-kafka/index.yaml)
* [{{ mch-full-name }}](../../managed-clickhouse/index.yaml)
* [{{ mgp-full-name }}](../../managed-greenplum/index.yaml)
* [{{ managed-k8s-full-name }}](../../managed-kubernetes/index.yaml)
* [{{ mmg-full-name }}](../../managed-mongodb/index.yaml)
* [{{ mmy-full-name }}](../../managed-mysql/index.yaml)
* [{{ mpg-full-name }}](../../managed-postgresql/index.yaml)
* [{{ mrd-full-name }}](../../managed-redis/index.yaml)
* [{{ ydb-full-name }}](../../ydb/index.yaml)
* [{{ network-load-balancer-full-name }}](../../network-load-balancer/index.yaml)
* [{{ objstorage-full-name }}](../../storage/index.yaml)
* [{{ resmgr-full-name }}](../../resource-manager/index.yaml)
* [{{ serverless-containers-full-name }}](../../serverless-containers/index.yaml)
* [{{ vpc-full-name }}](../../vpc/index.yaml)

#### See also {#see-also}

* [Managing labels](../operations/manage-labels.md)
* [Managing labels in {{ ml-platform-full-name }} communities](../../datasphere/operations/community/manage-community-labels.md)
* [Managing labels in {{ ml-platform-full-name }} projects](../../datasphere/operations/projects/manage-project-labels.md)


{% include [Greenplum trademark](../../_includes/mdb/mgp/trademark.md) %}


{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
