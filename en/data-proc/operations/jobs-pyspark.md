# Managing PySpark jobs

## Create a job {#create}

{% list tabs %}

- Management console

    1. Go to the folder page and select **{{ dataproc-name }}**.

    1. Click on the name of the cluster and open the **Jobs** tab.

    1. Click **Submit job**.

    1. (Optional) Enter a name for the job.

    1. In the **Job type** field, select `PySpark`.

    1. In the **Main python file** field, specify the path to the main PY application file in the following format:

       {% include [jar-file-path-requirements](../../_includes/data-proc/jar-file-path-requirements.md) %}

    1. (Optional) Specify the paths to the PY files, if any.

    1. Specify job arguments.

       {% include [job-properties-requirements](../../_includes/data-proc/job-properties-requirements.md) %}

    1. (Optional) Specify the paths to the JAR files, if any.

    1. (Optional) Configure advanced settings:
        * Specify paths to the necessary files and archives.
        * Specify job properties.

    1. Click **Submit job**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To create a job:

    1. View a description of the CLI create command for `PySpark` jobs:

        ```bash
        yc dataproc job create-pyspark --help
        ```

    1. Create a job (the example doesn't show all the available parameters):

        ```bash
        yc dataproc job create-pyspark \
           --cluster-name <cluster name> \
           --name <job name> \
           --main-python-file-uri <path to main py application file> \
           --python-file-uris <paths to additional py files> \
           --jar-file-uris <paths to jar files> \
           --archive-uris <paths to archives> \
           --properties <job properties> \
           --args <arguments passed to job>
        ```

        Pass in the paths to the files required for the job in the following format:

        {% include [jar-file-path-requirements](../../_includes/data-proc/jar-file-path-requirements.md) %}

    You can query the cluster ID and name with a [list of clusters in the folder](./cluster-list.md#list).

- API

    Use the [create](../api-ref/Job/create) API method and pass the following in the call:
    * The cluster ID in the `clusterId` parameter.
    * The job name in the `name` parameter.
    * The job properties in the `pysparkJob` parameter.

    You can get the cluster ID with a [list of clusters in the folder](./cluster-list.md#list).

{% endlist %}

## Get a list of jobs {#list}

{% list tabs %}

- Management console
    1. Go to the folder page and select **{{ dataproc-name }}**.
    1. Click on the name of the cluster and open the **Jobs** tab.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To get a list of jobs, run the command:

    ```bash
    yc dataproc job list --cluster-name <cluster name>
    ```

    You can query the cluster ID and name with a [list of clusters in the folder](./cluster-list.md#list).

- API

    Use the [list](../api-ref/Job/list) API method and pass the cluster ID in the `clusterId` parameter.

    You can get the cluster ID with a [list of clusters in the folder](./cluster-list.md#list).

{% endlist %}

## Get general information about the job {#get-info}

{% list tabs %}

- Management console
    1. Go to the folder page and select **{{ dataproc-name }}**.
    1. Click on the name of the cluster and open the **Jobs** tab.
    1. Click on the name of the job.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To get general information about the job, run the command:

    ```bash
    yc dataproc job get \
       --cluster-name <cluster name> \
       --name <job name>
    ```

    You can query the cluster ID and name with a [list of clusters in the folder](./cluster-list.md#list).

- API

    Use the [get](../api-ref/Job/get) API method and pass the following in the request:
    * The cluster ID in the `clusterId` parameter. You can get it with a [list of clusters in the folder](./cluster-list.md#list).
    * The job ID in the `jobId` parameter. You can get it with a [list of jobs in the cluster](#list).

{% endlist %}

## Get job execution logs {#get-logs}

{% list tabs %}

- Management console
    1. Go to the folder page and select **{{ dataproc-name }}**.
    1. Click on the name of the cluster and open the **Jobs** tab.
    1. Click on the name of the job.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To get job execution logs, run the command:

    ```bash
    yc dataproc job log \
       --cluster-name <cluster name> \
       --name <job name>
    ```

    You can query the cluster ID and name with a [list of clusters in the folder](./cluster-list.md#list).

- API

    Use the [listLog](../api-ref/Job/listLog) API method and pass the following in the request:
    * The cluster ID in the `clusterId` parameter. You can get it with a [list of clusters in the folder](./cluster-list.md#list).
    * The job ID in the `jobId` parameter. You can get it with a [list of jobs in the cluster](#list).

{% endlist %}

