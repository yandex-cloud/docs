# Running a PySpark job

In a {{ ytsaurus-name }} cluster, you can run Spark and PySpark jobs using the `spark-submit` script. It saves the calculation results to HDFS. For more information about `spark-submit`, see the [Spark documentation](https://spark.apache.org/docs/latest/submitting-applications.html#submitting-applications). These jobs are executed in a {{ SPRK }} cluster that runs on the computing resources of the {{ ytsaurus-name }} cluster, using the [SPYT](https://ytsaurus.tech/docs/ru/user-guide/data-processing/spyt/overview#what-is-spyt) tool.

The example below shows how to run an application in [Python](https://www.python.org/downloads).

To run a PySpark job:

1. [Prepare the infrastructure](#before-you-begin).
1. [Prepare your VM](#prepare-vm).
1. [Prepare your test data](#prepare-data).
1. [Create and run a PySpark job](#create-job).

If you no longer need the resources you created, [delete them](#clear-out).

## Required paid resources {#paid-resources}

* The {{ ytsaurus-name }} cluster, which includes the use of computing resources of cluster components and storage size (see [{{ ytsaurus-name }} pricing](../../../managed-ytsaurus/pricing.md)).
* VM instance: use of computing resources, storage, public IP address, and OS (see [{{ compute-name }} pricing](../../../compute/pricing.md)).

## Getting started {#before-you-begin}

Set up your infrastructure:

{% list tabs group=resources %}

- Manually {#manual}

    1. [Create a service account](../../../iam/operations/sa/create.md) named `ytsaurus-sa` with the `managed-ytsaurus.editor` role.

    1. [Create a network](../../../vpc/operations/network-create.md) named `ytsaurus-network`. Disable **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}** when creating it.
    1. In `ytsaurus-network`, [create a subnet](../../../vpc/operations/subnet-create.md) with the following settings:

        * Name: `ytsaurus-subnet-a`
        * Availability zone: `{{ region-id }}-a`
        * CIDR: `10.1.0.0/16`

    1. [Create security groups](../../../vpc/operations/security-group-create.md) in `ytsaurus-network`:

        * For the virtual machine: a security group named `vm-security-group` with rules allowing incoming TCP traffic to port 22 from all addresses and outgoing traffic to all ports and addresses.

        * For the {{ ytsaurus-name }} cluster: a security group named `ytsaurus-security-group` with a rule allowing incoming traffic on all ports from all addresses.

    1. [Create a `vm-ubuntu-24-04` virtual machine](../../../compute/quickstart/quick-create-linux.md) with the following parameters:

        * Operating system: `Ubuntu 24.04`
        * Availability zone: `{{ region-id }}-a`
        * Subnet: `ytsaurus-subnet-a`
        * Security group: `vm-security-group`
        * Service account: `ytsaurus-sa`

    1. [Create a {{ ytsaurus-name }} cluster](../../../managed-ytsaurus/operations/cluster-create.md) with the following settings:

        * Cluster type: `{{ ui-key.yacloud.managed-ytsaurus.clusters.YTSaurusClusterCreatePage.cluster-kind-card_demo_title_4B7zu }}`
        * Cluster name: `ytsaurus-cluster`
        * Availability zone: `{{ region-id }}-a`
        * Subnet: `ytsaurus-subnet-a`
        * Security group: `ytsaurus-security-group`

- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../../_includes/mdb/terraform/configure-provider.md) %}

    1. Download the [ytsaurus-for-spark-jobs.tf](https://github.com/yandex-cloud-examples/yc-yt-run-spark-job/blob/main/ytsaurus-for-spark-jobs.tf) configuration file to the same working directory.

        This file describes:

        * Network.
        * Subnet.
        * Security groups.
        * Service account to work with cluster resources.
        * Virtual machine.
        * {{ ytsaurus-name }} cluster.

    1. In the `ytsaurus-for-spark-jobs.tf` configuration file, specify the required parameters.
    1. Validate your {{ TF }} configuration files using this command:

        ```bash
        terraform validate
        ```

        {{ TF }} will display any configuration errors detected in your files.

    1. Create the required infrastructure:

        {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Prepare your VM {#prepare-vm}

1. [Connect to a virtual machine over SSH](../../../compute/operations/vm-connect/ssh.md#vm-connect).
1. {% include [cli-install](../../../_includes/cli-install.md) %}

1. Install the dependencies:

    ```bash
    sudo apt update && sudo apt install -y python3 python3-pip python3-venv
    ```

1. Create and activate a virtual environment to run a Python script:

    ```bash
    python3 -m venv .venv/yt312 && \
    source .venv/yt312/bin/activate
    ```

1. Install Java:

    ```bash
    sudo apt install -y openjdk-11-jdk
    ```

1. Install the YTsaurus CLI:

    ```bash
    pip install ytsaurus-client
    ```

1. Create an IAM token:

    ```bash
    yc iam create-token
    ```

1. Get the service account ID:

    ```bash
    yc iam whoami
    ```

1. Set the environment variables:

    ```bash
    export YT_PROXY=http://hp.<{{ ytsaurus-name }}_cluster_ID>.ytsaurus.mdb.yandexcloud.net:32100 ; \
    export YT_TOKEN=<IAM_token> ; \
    export YT_USER=<service_account_ID>
    ```

1. Get the SPYR version:

    ```bash
    yt list //home/spark/conf/releases
    ```

    Result:

    ```bash
    2.7.0
    ```

1. Install the `ytsaurus-spyt` package of the same version as SPYT:

    ```bash
    pip install ytsaurus-spyt==2.7.0
    ```

1. Get the Spark version from the name of the tgz file:

    ```bash
    yt find //home/spark/distrib --name *tgz
    ```

    Result:

    ```bash
    //home/spark/distrib/3/5/6/spark-3.5.6-bin-hadoop3.tgz
    ```

1. Install `pyspark` of the same version as the `spark` distribution:

    ```bash
    pip install pyspark==3.5.6
    ```

1. Activate the SPYT configuration:

    ```bash
    source spyt-env
    ```

    Result:

    ```bash
    SPYT environment has been successfully activated
    ```

1. Check the value of the `$SPARK_CONF_DIR` variable:

    ```bash
    echo $SPARK_CONF_DIR
    ```

    Result:

    ```bash
    /home/<home_directory>/.venv/yt312/lib/python3.12/site-packages/spyt/conf
    ```

## Prepare your test data {#prepare-data}

Run these commands on the VM:

1. Create a table named `table1` in {{ ytsaurus-name }}:

    ```bash
    yt create table //tmp/table1 \
      --attributes '{schema = [{name = id; type = int64}; {name = text; type = string}]}'
    ```

1. Write the data to the table:

    ```bash
    echo '{ "id": 0, "text": "Hello" } { "id": 1, "text": "World!" }' | yt write-table //tmp/table1 --format json
    ```

## Create and run a PySpark job {#create-job}

Perform these actions on the VM:

1. Create the `spark-job.py` file with the PySpark job.

    ```python
    import spyt
    from pyspark import SparkConf

    conf = SparkConf()
    conf.set("spark.app.name","Show table")
    with spyt.direct_spark_session("http-proxies-lb.yt.svc.cluster.local", conf) as spark:
         spark.read.yt('//tmp/table1').show()
    ```

1. Run the job:

    ```bash
    spark-submit --master "ytsaurus://${YT_PROXY}" \
      --deploy-mode cluster \
      --num-executors 1 \
      --conf spark.hadoop.yt.proxyNetworkName=external \
      --queue research \
      ./spark-job.py
    ```

    Result:

    ```bash
    ...
    25/12/09 23:29:49 INFO YTsaurusClusterApplication: Operation: fdff4aa2-d11767f6-e03e8-6affdd7c, State: running
    25/12/09 23:30:23 INFO YTsaurusClusterApplication: Operation: fdff4aa2-d11767f6-e03e8-6affdd7c, State: completed
    ```

## Delete the resources you created {#clear-out}

Some resources are not free of charge. Delete the resources you no longer need to avoid paying for them:

{% list tabs group=instructions %}

- Manually {#manual}

    * [Virtual machine](../../../compute/operations/vm-control/vm-delete.md)
    * [{{ ytsaurus-name }} cluster](../../../managed-ytsaurus/operations/cluster-delete.md)

- Using {{ TF }} {#tf}

    {% include [terraform-clear-out](../../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}
