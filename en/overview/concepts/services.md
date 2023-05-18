# {{ yandex-cloud }} services

_Services_ in {{ yandex-cloud }} allow you to manage specific cloud resources and access to them.

## List of {{ yandex-cloud }} services {#list}

Services at the [Preview](./launch-stages.md) stage are tagged with {{ preview-stage }}.

The following services are currently available as part of the {{ yandex-cloud }} platform:


| Service | Description |
|---|---|
| [{{ api-gw-full-name }}](../../api-gateway/index.yaml) | A service for creating API gateways. |
| [{{ alb-full-name }}](../../application-load-balancer/index.yaml) | A service for distributing incoming traffic between web application components. |
| [{{ at-full-name }}](../../audit-trails/index.yaml) | {{ preview-stage }} A service for collecting and exporting audit logs. |
| [{{ certificate-manager-full-name }}](../../certificate-manager/index.yaml) | A service for managing TLS certificates. |
| [{{ cloud-apps-full-name }}](../../cloud-apps/index.yaml) | {{ preview-stage }} A service for deploying serverless stack-based applications. |
| [{{ backup-full-name }}](../../backup/index.yaml) | {{ preview-stage }} A service for backing up {{ yandex-cloud }} resources. |
| [{{ cdn-full-name }}](../../cdn/index.yaml) | A service for setting up a content delivery network (CDN). |
| [{{ cloud-desktop-full-name }}](../../cloud-desktop/index.yaml) | {{ preview-stage }} A service for creating remote desktops in the cloud. |
| [{{ dns-full-name }}](../../dns/index.yaml) | Administering DNS resource records and handling DNS requests. |
| [{{ sf-full-name }}](../../functions/index.yaml) | Serverless computing. |
| [{{ interconnect-full-name }}](../../interconnect/index.yaml) | Dedicated network connection management. |
| [{{ cloud-logging-full-name }}](../../logging/index.yaml) | A service for aggregating and reading the logs of user applications and {{ yandex-cloud }} resources. |
| [{{ org-full-name }}](../../organization/index.yaml) | A service for managing the organizational structure, setting up integration with the employee catalog, and differentiating user access to the organization's cloud resources. |
| [{{ compute-full-name }}](../../compute/index.yaml) | Creation and management of VMs. |
| [{{ container-registry-full-name }}](../../container-registry/index.yaml) | A service for managing Docker images and containers. |
| [{{ dataproc-full-name }}](../../data-proc/index.yaml) | Managed Apache Hadoop® clusters. |
| [{{ yds-full-name }}](../../data-streams/index.yaml) | Managed data streams in real time. |
| [{{ data-transfer-full-name }}](../../data-transfer/index.yaml) | A service for database migration. |
| [{{ datalens-full-name }}](../../datalens/index.yaml) | Data visualization and analytics. |
| [{{ ml-platform-full-name }}](../../datasphere/index.yaml) | ML development. |
| [{{ ddos-protection-full-name }}](../../vpc/ddos-protection/index.md) | Protection from DDoS attacks. |
| [{{ forms-full-name }}](../../forms/index.yaml) | Form creation and integration. |
| [{{ iam-full-name }}](../../iam/index.yaml) | Cloud resource access management. |
| [{{ ig-full-name }}](../../compute/concepts/instance-groups/index.md) | Instance group creation and management. |
| [{{ iot-full-name }}](../../iot-core/index.yaml) | An Internet of Things service that provides two-way messaging between registries and devices over the MQTT protocol. |
| [{{ kms-full-name }}](../../kms/index.yaml) | Encryption key management. |
| [{{ load-testing-full-name }}](../../load-testing/index.yaml) | {{ preview-stage }} A service for load testing and performance analysis. |
| [{{ lockbox-name }}](../../lockbox/index.yaml) | {{ preview-stage }} A service for creating and storing secrets in the {{ yandex-cloud }} infrastructure. |
| [{{ mkf-full-name }}](../../managed-kafka/index.yaml) | {{ KF }} cluster creation and management. |
| [{{ mch-full-name }}](../../managed-clickhouse/index.yaml) | {{ CH }} cluster creation and management. |
| [{{ mes-full-name }}](../../managed-elasticsearch/index.yaml) | {{ ES }} cluster creation and management. |
| [{{ mgl-full-name }}](../../managed-gitlab/index.yaml) | A service for managing the {{ GL }} DevOps platform. |
| [{{ mgp-full-name }}](../../managed-greenplum/index.yaml) | {{ GP }} cluster creation and management. |
| [{{ managed-k8s-full-name }}®](../../managed-kubernetes/index.yaml) | Kubernetes cluster creation and management. |
| [{{ mmg-full-name }}](../../managed-mongodb/index.yaml) | {{ MG }} cluster creation and management. |
| [{{ mmy-full-name }}](../../managed-mysql/index.yaml) | {{ MY }} cluster creation and management. |
| [{{ mos-full-name }}](../../managed-opensearch/index.yaml) | {{ OS }} cluster creation and management. |
| [{{ mpg-full-name }}](../../managed-postgresql/index.yaml) | {{ PG }} cluster creation and management. |
| [{{ mrd-full-name }}](../../managed-redis/index.yaml) | {{ RD }} cluster creation and management. |
| [{{ ydb-full-name }}](../../ydb/index.yaml) | {{ ydb-full-name }} database management service. |
| [{{ message-queue-full-name }}](../../message-queue/index.yaml) | A queue service for messaging between components of distributed applications and microservices. |
| [{{ monitoring-full-name }}](../../monitoring/index.yaml) | A service for collecting and visualizing metrics. |
| [{{ network-load-balancer-full-name }}](../../network-load-balancer/index.yaml) | A service for distributing network load across cloud resources. |
| [{{ objstorage-full-name }}](../../storage/index.yaml) | Universal scalable cloud object storage. |
| [{{ yq-full-name }}](../../query/index.yaml) | {{ preview-stage }} A service for running queries using a common SQL dialect. |
| [{{ resmgr-full-name }}](../../resource-manager/index.yaml) | Cloud resource management. |
| [{{ serverless-containers-full-name }}](../../serverless-containers/index.yaml) | Serverless launch of containerized applications. |
| [{{ captcha-full-name }}](../../smartcaptcha/index.yaml) | System user identification. |
| [{{ speechkit-full-name }}](../../speechkit/index.yaml) | Speech recognition and speech synthesis technologies. |
| [{{ tracker-full-name }}](../../tracker/index.yaml) | A service for business collaboration and workflows. |
| [{{ translate-full-name }}](../../translate/index.yaml) | Machine translation. |
| [{{ vpc-full-name }}](../../vpc/index.yaml) | Cloud network management. |
| [{{ vision-full-name }}](../../vision/index.yaml) | A computer vision service for image analysis. |
| [{{ wiki-full-name }}](../../wiki/index.yaml) | A service for creating corporate databases. |



## How to enable services {#enable}

You can use the {{ yandex-cloud }} [management console]({{ link-console-main }}) to enable services and manage resources. It allows you to launch VM instances in {{ yandex-cloud }}, connect to them, access object storage, create databases, and more.


Services at the Preview stage are available only to some users. If you want to use one of these services, send us a request for access. You can do this on the page of the service you want to use.



{% include [Greenplum trademark](../../_includes/mdb/mgp/trademark.md) %}

