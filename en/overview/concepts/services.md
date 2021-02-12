# Services {{ yandex-cloud }}

_Services_ in {{ yandex-cloud }} let you manage specific categories of cloud resources and access them.

## Service categories {#service-type}

{% include  [service-type](../../_includes/overview/service-type.md) %}

## Service list {{ yandex-cloud }} {#list}

The following services are currently available as part of the {{ yandex-cloud }} platform:

* Infrastructure:
    * [{{ compute-full-name }}](../../compute/) (Compute Cloud).
    * [{{ objstorage-full-name }}](../../storage/) (Object Storage).
    * [{{ vpc-full-name }}](../../vpc/) (Virtual Private Cloud).
    * [{{ interconnect-full-name }}](../../vpc/interconnect/) (Dedicated network connection management).
    * [{{ iam-full-name }}](../../iam/) (Cloud resource access management).
    * [{{ resmgr-full-name }}](../../resource-manager/) (Cloud resource management).
    * [{{ kms-full-name }}](../../kms/) (Encryption key management).
    * [{{ network-load-balancer-full-name }}](../../network-load-balancer/) (Network load balancer management).
    * [Yandex Instance Groups](../../compute/concepts/instance-groups/) (Instance group creation and management).
    * [{{ container-registry-full-name }}](../../container-registry/) (Container image management).
    * [{{managed-k8s-full-name}}<sup>®</sup>](../../managed-kubernetes/) (Kubernetes management).
    * [{{ monitoring-full-name }}](../../monitoring/) (Monitoring).
    * [Yandex DDoS Protection](../../vpc/ddos-protection/) (DDoS protection).
* Data storage & Analytics:
    * [{{ mpg-full-name }}](../../managed-postgresql/) (PostgreSQL management).
    * [{{ mch-full-name }}](../../managed-clickhouse/) (ClickHouse management).
    * [{{ mmg-full-name }}](../../managed-mongodb/) (MongoDB management).
    * [{{ mmy-full-name }}<sup>®</sup>](../../managed-mysql/) (MySQL management).
    * [{{ mrd-full-name }}™](../../managed-redis/) (Redis management).
    * [{{ dataproc-full-name }}](../../data-proc/) (Data Proc management).
    * [{{ datalens-full-name }}](../../datalens/) (Data visualization and analysis).
* Cloud-native:
    * [{{ ydb-full-name }}](../../ydb/) ({{ ydb-full-name }} management).
    * [{{ message-queue-full-name }}](../../message-queue/) (Message queue).
    * [{{ sf-full-name }}](../../functions/) (Serverless computing).
    * [{{ iot-full-name }}](../../iot-core/) (Internet of things).
* Machine Learning & Artificial Intelligence (ML & AI):
    * [{{ speechkit-full-name }}](../../speechkit/) (Speech technologies).
    * [{{ translate-full-name }}](../../translate/) (Machine translation).
    * [{{ vision-full-name }}](../../vision/) (Computer vision).

### How to enable services {#enable}

You can use the [management console]({{ link-console-main }}) {{ yandex-cloud }} to connect to services and manage resources. It allows you to launch VM instances in {{ yandex-cloud }}, connect to them, access object storage, create databases, and so on.

## Service resource labels {#labels}

[Most services](#services) support labels for marking resource.

_A label_ is a key-value pair in `<label name>=<label value>` format. You can use labels to logically separate resources.

Labels are subject to the following restrictions:

* The maximum number of labels per resource is 64.
* Restrictions for the key:
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

{% cut "Adding a VM label" %}

{% list tabs %}

- CLI

    To add a label, run the command:

    ```
    yc compute instance add-labels cl123g4dridnn5cna6df-yduv --labels project=test
    ```

    Command execution result:

    ```
    done (5s)
    id: fhm1pr2bu3p45s6ildh7
    folder_id: b1g23ga45mev6cljderg
    created_at: "2020-08-07T11:29:18Z"
    name: cl123g4dridnn5cna6df-yduv
    labels:
      project: test
    zone_id: ru-central1-a
    ...
    ```

{% endlist %}

{% endcut %}

{% cut " Updating a label for {{ k8s }} cluster" %}

{% list tabs %}

- CLI

    To update a label, run the command:

    ```
    yc managed-kubernetes cluster update k8s-gpu --labels new_lable=test_label
    ```

    Command execution result:

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

{% cut "Deleting a label for {{ mmy-short-name }} cluster" %}

{% list tabs %}

- CLI

    To delete a label, run the command:

    ```
    yc managed-mysql cluster remove-labels mysql123 --labels my_lable
    ```

    Command execution result:

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
* [{{ managed-k8s-full-name }}](../../managed-kubernetes/)
* [{{ mpg-full-name }}](../../managed-postgresql/)
* [{{ mch-full-name }}](../../managed-clickhouse/)
* [{{ mmg-full-name }}](../../managed-mongodb/)
* [{{ mmy-full-name }}](../../managed-mysql/)
* [{{ mrd-full-name }}](../../managed-redis/)
* [{{ dataproc-full-name }}](../../data-proc/)
* [{{ sf-full-name }}](../../functions/)
* [{{ iot-full-name }}](../../iot-core/)
* [{{ ydb-full-name }}](../../ydb/)

