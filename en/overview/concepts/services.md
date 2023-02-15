# {{ yandex-cloud }} services

_Services_ in {{ yandex-cloud }} let you manage specific cloud resources and access to them.

## List of {{ yandex-cloud }} services {#list}

The following services are currently available as part of the {{ yandex-cloud }} platform:

* [{{ api-gw-full-name }}](../../api-gateway/) (A service for creating API gateways).
* [{{ alb-full-name }}](../../application-load-balancer/) (A service for distributing incoming traffic between web application components).
* [{{ at-full-name }}](../../audit-trails/) (A service for collecting and exporting audit logs). _The service is at the [Preview stage](./launch-stages.md)._
* [{{ certificate-manager-full-name }}](../../certificate-manager/) (A service for managing TLS certificates).
* [{{ backup-full-name }}](../../backup/) (A service for backing up {{ yandex-cloud }} resources). _The service is at the [Preview](./launch-stages.md) stage._
* [{{ cdn-full-name }}](../../cdn/) (A service for setting up a Content Delivery Network (CDN).
* [{{ cloud-desktop-full-name }}](../../cloud-desktop/) (A service for creating remote desktops in the cloud). _The service is at the [Preview stage](./launch-stages.md)._
* [{{ dns-full-name }}](../../dns/) (A service for administering DNS resource records and handling DNS requests).
* [{{ sf-full-name }}](../../functions/) (Serverless computing).
* [{{ interconnect-full-name }}](../../interconnect/) (Dedicated network connection management).
* [{{ cloud-logging-full-name }}](../../logging/) (A service for aggregating and reading the logs of user applications and resources{{ yandex-cloud }}). _The service is at the [Preview stage](./launch-stages.md)._
* [{{ org-full-name }}](../../organization) (A service for managing the organizational structure, setting up integration with the employee catalog, and differentiating user access to the organization's cloud resources).
* [{{ compute-full-name }}](../../compute/) (Instance group creation and management).
* [{{ container-registry-full-name }}](../../container-registry/) (A service for managing Docker images and containers).
* [{{ dataproc-full-name }}](../../data-proc/) (Managed Apache Hadoop® clusters).
* [{{ yds-full-name }}](../../data-streams/) (Managed data streams in real time).
* [{{ data-transfer-full-name }}](../../data-transfer/) (A service for database migration).
* [{{ ydb-full-name }}](../../ydb/) (Database management service {{ ydb-full-name }}).
* [{{ datalens-full-name }}](../../datalens/) (Data visualization and analytics).
* [{{ ml-platform-full-name }}](../../datasphere/) (ML development).
* [{{ ddos-protection-full-name }}](../../vpc/ddos-protection/) (Protection from DDoS attacks).
* [{{ forms-full-name }}](../../forms/) (Form creation and integration).
* [{{ iam-full-name }}](../../iam/) (Cloud resource access management).
* [{{ ig-full-name }}](../../compute/concepts/instance-groups/) (Instance group creation and management).
* [{{ iot-full-name }}](../../iot-core/) (An Internet of Things service that provides two-way messaging between registries and devices over the MQTT protocol).
* [{{ kms-full-name }}](../../kms/) (Encryption key management).
* [{{ load-testing-full-name }}](../../load-testing/) (A service for load testing and performance analysis). _The service is at the [Preview stage](./launch-stages.md)._
* [{{ lockbox-name }}](../../lockbox) (A service for creating and storing secrets in the {{ yandex-cloud }} infrastructure). _The service is at the [Preview stage](./launch-stages.md)._
* [{{ mkf-full-name }}](../../managed-kafka/) ({{ KF }} cluster creation and management).
* [{{ mch-full-name }}](../../managed-clickhouse/) ({{ CH }} cluster creation and management).
* [{{ mes-full-name }}](../../managed-elasticsearch/) (Cluster creation and management {{ ES }}).
* [{{ mgl-full-name }}](../../managed-gitlab/) (A service for managing the {{ GL }} DevOps platform).
* [{{ mgp-full-name }}](../../managed-greenplum/) (Cluster creation and management {{ GP }}).
* [{{ managed-k8s-full-name }}®](../../managed-kubernetes/) (Kubernetes cluster creation and management).
* [{{ mmg-full-name }}](../../managed-mongodb/) (Cluster creation and management {{ MG }}).
* [{{ mmy-full-name }}](../../managed-mysql/) ({{ MY }} cluster creation and management).
* [{{ mos-full-name }}](../../managed-opensearch/) (Cluster creation and management {{ OS }}).
* [{{ mpg-full-name }}](../../managed-postgresql/) ({{ PG }} cluster creation and management).
* [{{ mrd-full-name }}](../../managed-redis/) (Cluster creation and management {{ RD }}).
* [{{ mms-full-name }}](../../managed-sqlserver/) (Cluster creation and management {{ MS }}).
* [{{ message-queue-full-name }}](../../message-queue/) (A queue service for messaging between components of distributed applications and microservices).
* [{{ monitoring-full-name }}](../../monitoring/) (A service for collecting and visualizing metrics).
* [{{ network-load-balancer-full-name }}](../../network-load-balancer/) (A service for distributing network load across cloud resources).
* [{{ objstorage-full-name }}](../../storage/) (Universal scalable cloud object storage).
* [{{ resmgr-full-name }}](../../resource-manager/) (Cloud resource management).
* [{{ serverless-containers-full-name }}](../../serverless-containers/) (Serverless launch of containerized applications).
* [{{ speechkit-full-name }}](../../speechkit/) (Speech recognition and speech synthesis technologies).
* [{{ tracker-full-name }}](../../tracker/) (A service for business collaboration and workflows).
* [{{ translate-full-name }}](../../translate/) (Machine translation).
* [{{ vpc-full-name }}](../../vpc/) (Cloud network management).
* [{{ vision-full-name }}](../../vision/) (A computer vision service for image analysis).
* [{{ wiki-full-name }}](../../wiki/) (A service for creating corporate databases).

### How to enable services {#enable}

You can use the {{ yandex-cloud }} [management console]({{ link-console-main }}) to enable services and manage resources. It allows you to launch VM instances in {{ yandex-cloud }}, connect to them, access object storage, create databases, and so on.


Services at the Preview stage are available only to some users. If you want to use one of these services, send us a request for access. You can do this on the page of the service you want to use.


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
* [{{ mmg-full-name }}](../../managed-mongodb/)
* [{{ mmy-full-name }}](../../managed-mysql/)
* [{{ mpg-full-name }}](../../managed-postgresql/)
* [{{ mrd-full-name }}](../../managed-redis/)
* [{{ dataproc-full-name }}](../../data-proc/)
* [{{ sf-full-name }}](../../functions/)
* [{{ iot-full-name }}](../../iot-core/)
* [{{ ydb-full-name }}](../../ydb/)


{% include [Greenplum trademark](../../_includes/mdb/mgp/trademark.md) %}

