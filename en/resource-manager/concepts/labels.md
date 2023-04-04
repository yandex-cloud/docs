# Service resource labels

Most {{ yandex-cloud }} services support resource labeling.

A _label_ is a key-value pair in `<label name>=<label value>` format. You can use labels to logically separate resources.

Labels are subject to the following restrictions:

* Maximum number of labels per resource is 64.
* The key:
   * Must be from 1 to 63 characters long.
   * May contain lowercase Latin letters, numbers, hyphens, and underscores.
   * Must start with a letter.
* The value:
   * May be up to 63 characters long.
   * May contain lowercase Latin letters, numbers, hyphens, and underscores.

## Services that support labels {#services}

List of services whose resources support labels:
* [{{ api-gw-full-name }}](../../api-gateway/)
* [{{ alb-full-name }}](../../application-load-balancer/)
* [{{ certificate-manager-full-name }}](../../certificate-manager/)
* [{{ dns-full-name }}](../../dns/)
* [{{ sf-full-name }}](../../functions/)
* [{{ cloud-logging-full-name }}](../../logging/)
* [{{ compute-full-name }}](../../compute/)
* [{{ container-registry-full-name }}](../../container-registry/)
* [{{ dataproc-full-name }}](../../data-proc/)
* [{{ iot-full-name }}](../../iot-core/)
* [{{ kms-full-name }}](../../kms/)
* [{{ lockbox-full-name }}](../../lockbox/)
* [{{ mkf-full-name }}](../../managed-kafka/)
* [{{ mch-full-name }}](../../managed-clickhouse/)
* [{{ mes-full-name }}](../../managed-elasticsearch/)
* [{{ mgp-full-name }}](../../managed-greenplum/)
* [{{ managed-k8s-full-name }}](../../managed-kubernetes/)
* [{{ mmg-full-name }}](../../managed-mongodb/)
* [{{ mmy-full-name }}](../../managed-mysql/)
* [{{ mpg-full-name }}](../../managed-postgresql/)
* [{{ mrd-full-name }}](../../managed-redis/)
* [{{ ydb-full-name }}](../../ydb/)
* [{{ network-load-balancer-full-name }}](../../network-load-balancer/)
* [{{ resmgr-full-name }}](../../resource-manager/)
* [{{ serverless-containers-full-name }}](../../serverless-containers/)
* [{{ vpc-full-name }}](../../vpc/)

#### See also {#see-also}

* [Managing labels](../operations/manage-labels.md)


{% include [Greenplum trademark](../../_includes/mdb/mgp/trademark.md) %}
