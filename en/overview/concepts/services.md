# {{ yandex-cloud }} services

_Services_ in {{ yandex-cloud }} let you manage specific cloud resources and access to them.

## List of {{ yandex-cloud }} services {#list}

Services at the [Preview](./launch-stages.md) stage are tagged with {{ preview-stage }}.

The following services are currently available as part of the {{ yandex-cloud }} platform:

| Service | Description |
|---|---|
{% if product == "yandex-cloud" %}| [{{ api-gw-full-name }}](../../api-gateway/) | A service for creating API gateways. |{% endif %}
| [{{ alb-full-name }}](../../application-load-balancer/) | A service for distributing incoming traffic between web application components. |
| [{{ at-full-name }}](../../audit-trails/) | {% if product == "yandex-cloud" %}{{ preview-stage }}{% endif %} A service for collecting and exporting audit logs. |
| [{{ certificate-manager-full-name }}](../../certificate-manager/) | A service for managing TLS certificates. |
{% if product == "yandex-cloud" %}| [{{ cloud-apps-full-name }}](../../cloud-apps/) | {{ preview-stage }} A service for deploying serverless stack-based applications |{% endif %}
{% if product == "yandex-cloud" %}| [{{ backup-full-name }}](../../backup/) | {{ preview-stage }} A service for backing up {{ yandex-cloud }} resources. |{% endif %}
{% if product == "yandex-cloud" %}| [{{ cdn-full-name }}](../../cdn/) | A service for setting up a content delivery network (CDN). |{% endif %}
{% if product == "yandex-cloud" %}| [{{ cloud-desktop-full-name }}](../../cloud-desktop/) | {{ preview-stage }} A service for creating remote desktops in the cloud. |{% endif %}
| [{{ dns-full-name }}](../../dns/) | Administering {% if lang == "ru" and audience != "internal" %}[DNS](../../glossary/dns.md){% else %}DNS{% endif %} resource records and handling DNS requests. |
{% if product == "yandex-cloud" %}| [{{ sf-full-name }}](../../functions/) | Serverless computing. |{% endif %}
{% if product == "yandex-cloud" %}| [{{ interconnect-full-name }}](../../interconnect/) | Dedicated network connection management. |{% endif %}
{% if product == "yandex-cloud" %}| [{{ cloud-logging-full-name }}](../../logging/) | A service for aggregating and reading the logs of user applications and {{ yandex-cloud }} resources. |{% endif %}
| [{{ org-full-name }}](../../organization) | A service for managing the organizational structure, setting up integration with the employee catalog, and differentiating user access to the organization's cloud resources. |
| [{{ compute-full-name }}](../../compute/) | Creation and management of {% if lang == "ru" and audience != "internal" %}[VMs](../../glossary/vm.md){% else %}VMs{% endif %}. |
| [{{ container-registry-full-name }}](../../container-registry/) | A service for managing Docker images and containers. |
{% if product == "yandex-cloud" %}| [{{ dataproc-full-name }}](../../data-proc/) | Managed Apache Hadoop® clusters. |{% endif %}
{% if product == "yandex-cloud" %}| [{{ yds-full-name }}](../../data-streams/) | Managed data streams in real time. |{% endif %}
| [{{ data-transfer-full-name }}](../../data-transfer/) | A service for database migration. |
| [{{ datalens-full-name }}](../../datalens/) | Data visualization and analytics. |
{% if product == "yandex-cloud" %}| [{{ ml-platform-full-name }}](../../datasphere/) | ML development. |{% endif %}
{% if product == "yandex-cloud" %}| [{{ ddos-protection-full-name }}](../../vpc/ddos-protection/) | Protection from DDoS attacks. |{% endif %}
{% if product == "yandex-cloud" %}| [{{ forms-full-name }}](../../forms/) | Form creation and integration. |{% endif %}
| [{{ iam-full-name }}](../../iam/) | Cloud resource access management. |
| [{{ ig-full-name }}](../../compute/concepts/instance-groups/) | Instance group creation and management. |
{% if product == "yandex-cloud" %}| [{{ iot-full-name }}](../../iot-core/) | An Internet of Things service that provides two-way messaging between registries and devices over the {% if lang == "ru" and audience != "internal" %}[MQTT protocol](../../glossary/mqtt-server.md#mqtt-protocol){% else %}MQTT protocol{% endif %}. |{% endif %}
| [{{ kms-full-name }}](../../kms/) | Encryption key management. |
{% if product == "yandex-cloud" %}| [{{ load-testing-full-name }}](../../load-testing/) | {{ preview-stage }} A service for load testing and performance analysis. |{% endif %}
| [{{ lockbox-name }}](../../lockbox) | {% if product == "yandex-cloud" %}{{ preview-stage }}{% endif %} A service for creating and storing secrets in the {{ yandex-cloud }} infrastructure.  |
| [{{ mkf-full-name }}](../../managed-kafka/) | {{ KF }} cluster creation and management. |
| [{{ mch-full-name }}](../../managed-clickhouse/) | {{ CH }} cluster creation and management. |
{% if product == "yandex-cloud" %}| [{{ mes-full-name }}](../../managed-elasticsearch/) | {{ ES }} cluster creation and management. |{% endif %}
{% if product == "yandex-cloud" %}| [{{ mgl-full-name }}](../../managed-gitlab/) | A service for managing the {{ GL }} DevOps platform. |{% endif %}
{% if product == "yandex-cloud" %}| [{{ mgp-full-name }}](../../managed-greenplum/) | {{ GP }} cluster creation and management. |{% endif %}
| [{{ managed-k8s-full-name }}®](../../managed-kubernetes/) | Kubernetes cluster creation and management. |
{% if product == "yandex-cloud" %}| [{{ mmg-full-name }}](../../managed-mongodb/) | {{ MG }} cluster creation and management. |{% endif %}
| [{{ mmy-full-name }}](../../managed-mysql/) | {{ MY }} cluster creation and management. |
{% if product == "yandex-cloud" %}| [{{ mos-full-name }}](../../managed-opensearch/) | {{ OS }} cluster creation and management. |{% endif %}
| [{{ mpg-full-name }}](../../managed-postgresql/) | {{ PG }} cluster creation and management. |
{% if product == "yandex-cloud" %}| [{{ mrd-full-name }}](../../managed-redis/) | {{ RD }} cluster creation and management. |{% endif %}
{% if product == "yandex-cloud" %}| [{{ mms-full-name }}](../../managed-sqlserver/) | {{ MS }} cluster creation and management. |{% endif %}
{% if product == "yandex-cloud" %}| [{{ ydb-full-name }}](../../ydb/) | {{ ydb-full-name }} database management service. |{% endif %}
{% if product == "yandex-cloud" %}| [{{ message-queue-full-name }}](../../message-queue/) | A queue service for messaging between components of distributed applications and microservices. |{% endif %}
| [{{ monitoring-full-name }}](../../monitoring/) | A service for collecting and visualizing metrics. |
| [{{ network-load-balancer-full-name }}](../../network-load-balancer/) | A service for distributing network load across cloud resources. |
| [{{ objstorage-full-name }}](../../storage/) | Universal scalable cloud object storage. |
{% if product == "yandex-cloud" %}| [{{ yq-full-name }}](../../query/) | {{ preview-stage }} A service for running queries using a common SQL dialect. |{% endif %}
| [{{ resmgr-full-name }}](../../resource-manager/) | Cloud resource management. |
{% if product == "yandex-cloud" %}| [{{ serverless-containers-full-name }}](../../serverless-containers/) | Serverless launch of containerized applications. |{% endif %}
{% if product == "yandex-cloud" %}| [{{ captcha-full-name }}](../../smartcaptcha/) | System user identification. |{% endif %}
{% if product == "yandex-cloud" %}| [{{ speechkit-full-name }}](../../speechkit/) | Speech recognition and speech synthesis technologies. |{% endif %}
{% if product == "yandex-cloud" %}| [{{ tracker-full-name }}](../../tracker/) | A service for business collaboration and workflows. |{% endif %}
{% if product == "yandex-cloud" %}| [{{ translate-full-name }}](../../translate/) | Machine translation. |{% endif %}
| [{{ vpc-full-name }}](../../vpc/) | Cloud network management. |
{% if product == "yandex-cloud" %}| [{{ vision-full-name }}](../../vision/) | A computer vision service for image analysis. |{% endif %}
{% if product == "yandex-cloud" %}| [{{ wiki-full-name }}](../../wiki/) | A service for creating corporate databases. |{% endif %}

### How to enable services {#enable}

You can use the {{ yandex-cloud }} [management console]({{ link-console-main }}) to enable services and manage resources. It allows you to launch VM instances in {{ yandex-cloud }}, connect to them, access object storage, create databases, and so on.

{% if product == "yandex-cloud" %}

Services at the Preview stage are available only to some users. If you want to use one of these services, send us a request for access. You can do this on the page of the service you want to use.

{% endif %}

## Service resource labels{#labels}

[Most services](#services) support labels for marking resources.

A _label_ is a key-value pair in `<label name>=<label value>` format. You can use labels to logically separate resources.

Labels are subject to the following restrictions:
* The maximum number of labels per resource is 64.
* For the key:
   * The length can be from 1 to 63 characters.
   * May contain lowercase Latin letters, numbers, hyphens, and underscores.
   * The first character must be a letter.
* Restrictions for the value:
   * The length can be up to 63 characters.
   * May contain lowercase Latin letters, numbers, hyphens, and underscores.

### Managing labels {#managed-labels}

You can add, delete, or update resource labels.

#### Adding a label {#add-label}

{% list tabs %}

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   Add a label to a service resource:

   ```
   yc <service name> <resource type> add-labels <resource name or ID> \
     --labels <label name>=<label value>
   ```

{% endlist %}

#### Updating a label {#update-label}

{% list tabs %}

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% note warning %}

   The existing set of `labels` is completely replaced by the set transmitted.

   {% endnote %}

   Update a service resource label:

   ```
   yc <service name> <resource type> update <resource name or ID> \
     --labels <label name>=<label value>
   ```

{% endlist %}

#### Deleting a label {#remove-label}

{% list tabs %}

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   Delete a service resource label:

   ```
   yc <service name> <resource type> remove-labels <resource name or ID> \
     --labels <label name>
   ```

{% endlist %}


#### Examples of label management {#examples}

{% cut "Add a label to a VM" %}

{% list tabs %}

- CLI

   To add a label, run the command:

   ```
   yc compute instance add-labels cl123g4dridnn5cna6df-yduv --labels project=test
   ```

   Result:

   ```
   done (5s)
   id: fhm1pr2bu3p45s6ildh7
   folder_id: b1g23ga45mev6cljderg
   created_at: "2020-08-07T11:29:18Z"
   name: cl123g4dridnn5cna6df-yduv
   labels:
     project: test
   zone_id: {{ region-id }}-a
   ...
   ```

{% endlist %}

{% endcut %}

{% cut " Change the {{ k8s }} cluster label" %}

{% list tabs %}

- CLI

   To update a label, run the command:

   ```
   yc managed-kubernetes cluster update k8s-gpu --labels new_lable=test_label
   ```

   Result:

   ```
   done (1m36s)
   id: cat1hknor2345e6d7rr8
   folder_id: b1g23ga45mev6cljderg
   created_at: "2020-08-07T11:15:59Z"
   name: cluster
   labels:
     new_lable: test_label
   status: RUNNING
   ...
   ```

{% endlist %}

{% endcut %}

{% cut " Remove a label from a {{ mmy-short-name }} cluster" %}

{% list tabs %}

- CLI

   To delete a label, run the command:

   ```
   yc managed-mysql cluster remove-labels mysql123 --labels my_lable
   ```

   Result:

   ```
   id: c1qmjaatlurm2bcoi34i
   folder_id: b1g23ga45mev6cljderg
   created_at: "2020-08-20T11:53:20.015543Z"
   name: mysql123
   environment: PRODUCTION
   ...
   ```

{% endlist %}

{% endcut %}



### Services that support labels {#services}

List of services whose resources support labels:
* [{{ certificate-manager-full-name }}](../../certificate-manager/)
* [{{ compute-full-name }}](../../compute/)
* [{{ vpc-full-name }}](../../vpc/)
* [{{ resmgr-full-name }}](../../resource-manager/)
* [{{ kms-full-name }}](../../kms/)
* [{{ network-load-balancer-full-name }}](../../network-load-balancer/)
* [{{ container-registry-full-name }}](../../container-registry/)
* [{{ mch-full-name }}](../../managed-clickhouse/)
* [{{ managed-k8s-full-name }}](../../managed-kubernetes/)
{% if product == "yandex-cloud" %}* [{{ mmg-full-name }}](../../managed-mongodb/){% endif %}
* [{{ mmy-full-name }}](../../managed-mysql/)
* [{{ mpg-full-name }}](../../managed-postgresql/)
{% if product == "yandex-cloud" %}* [{{ mrd-full-name }}](../../managed-redis/){% endif %}
{% if product == "yandex-cloud" %}* [{{ dataproc-full-name }}](../../data-proc/){% endif %}
{% if product == "yandex-cloud" %}* [{{ sf-full-name }}](../../functions/){% endif %}
{% if product == "yandex-cloud" %}* [{{ iot-full-name }}](../../iot-core/){% endif %}
{% if product == "yandex-cloud" %}* [{{ ydb-full-name }}](../../ydb/){% endif %}

{% if product == "yandex-cloud" %}

{% include [Greenplum trademark](../../_includes/mdb/mgp/trademark.md) %}

{% endif %}
