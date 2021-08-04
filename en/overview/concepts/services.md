# Services {{ yandex-cloud }}

_Services_ in {{ yandex-cloud }} let you manage specific cloud resources and access them.

## Service list {{ yandex-cloud }} {#list}

The following services are currently available as part of the {{ yandex-cloud }} platform:

* [{{ alb-full-name }}](../../application-load-balancer/)
* [{{ api-gw-full-name }}](../../api-gateway/)
* [{{ certificate-manager-full-name }}](../../certificate-manager/)
* [{{ sf-full-name }}](../../functions/)
* [{{ interconnect-full-name }}](../../interconnect/)
* [{{ compute-full-name }}](../../compute/)
* [{{ container-registry-full-name }}](../../container-registry/)
* [{{ dataproc-full-name }}](../../data-proc/)
* [{{ data-transfer-full-name }}](../../data-transfer/)
* [{{ ydb-full-name }}](../../ydb/)
* [{{ datalens-full-name }}](../../datalens/)
* [{{ ml-platform-full-name }}](../../datasphere/)
* [Yandex DDoS Protection](../../vpc/ddos-protection/)
* [{{ iam-full-name }}](../../iam/)
* [Yandex Instance Groups](../../compute/concepts/instance-groups/)
* [{{ iot-full-name }}](../../iot-core/)
* [{{ kms-full-name }}](../../kms/)
* [{{ mkf-full-name }}](../../managed-kafka/)
* [{{ mch-full-name }}](../../managed-clickhouse/)
* [{{ mes-full-name }}](../../managed-elasticsearch/)
* [{{managed-k8s-full-name}}<sup>®</sup>](../../managed-kubernetes/)
* [{{ mmg-full-name }}](../../managed-mongodb/)
* [{{ mmy-full-name }}<sup>®</sup>](../../managed-mysql/)
* [{{ mpg-full-name }}](../../managed-postgresql/)
* [{{ mrd-full-name }}™](../../managed-redis/)
* [{{ mms-full-name }}](../../managed-sqlserver/)
* [{{ message-queue-full-name }}](../../message-queue/)
* [{{ monitoring-full-name }}](../../monitoring/)
* [{{ network-load-balancer-full-name }}](../../network-load-balancer/)
* [{{ objstorage-full-name }}](../../storage/)
* [{{ resmgr-full-name }}](../../resource-manager/)
* [{{ speechkit-full-name }}](../../speechkit/)
* [{{ translate-full-name }}](../../translate/)
* [{{ vpc-full-name }}](../../vpc/)
* [{{ vision-full-name }}](../../vision/)

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
