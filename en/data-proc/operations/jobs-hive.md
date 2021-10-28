# Managing Hive jobs

In a {{ dataproc-name }} cluster, you can manage [jobs](../concepts/jobs.md) and receive execution logs for them. For examples of jobs, see [{#T}](../solutions/job-overview.md).

## Create a job {#create}

{% list tabs %}

* Management console

    1. Go to the folder page and select **{{ dataproc-name }}**.

    1. Click on the name of the cluster and open the **Jobs** tab.

    1. Click **Submit job**.

    1. (Optional) Enter a name for the job.

    1. In the **Job type** field, select `Hive`.

    1. Specify job properties.

       {% include [job-properties-requirements](../../_includes/data-proc/job-properties-requirements.md) %}

    1. If necessary, enable **Continue on failure**.

    1. Specify script variables.

    1. Specify paths to JAR files (if any):

       {% include [jar-file-path-requirements](../../_includes/data-proc/jar-file-path-requirements.md) %}

    1. Select one of the driver types and specify which to use to start the job:
        * List of queries to be executed.
        * Path to the file with the queries to be executed.

    1. Click **Submit job**.

* CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To create a job:

    1. View a description of the CLI create command for `Hive` jobs:

        ```bash
        yc dataproc job create-hive --help
        ```

    1. Create a job (the example doesn't show all the available parameters):

        ```bash
        yc dataproc job create-hive \
           --cluster-name <cluster name> \
           --name <job name> \
           --query-file-uri <query file URI> \
           --script-variables <comma-separated list of variable values>
        ```

        Pass the paths to the files necessary for completing the job in the following format:

        {% include [jar-file-path-requirements](../../_includes/data-proc/jar-file-path-requirements.md) %}

    You can query the cluster ID and name with a [list of clusters in the folder](./cluster-list.md#list).

* API

    To create a job, use the [create](../api-ref/Job/create.md) API method and pass the following in the query:
    * The job name in the `name` parameter.
    * Job properties, in the `hiveJob` parameter.

{% endlist %}

## Get a list of jobs {#list}

{% list tabs %}

* Management console
    1. Go to the folder page and select **{{ dataproc-name }}**.
    1. Click on the name of the cluster and open the **Jobs** tab.

* CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To get a list of jobs, run the command:

    ```bash
    yc dataproc job list --cluster-name <cluster name>
    ```

    You can query the cluster ID and name with a [list of clusters in the folder](./cluster-list.md#list).

* API

    To get a list of jobs, use the [list](../api-ref/Job/list) API method.

{% endlist %}

## Get general information about the job {#get-info}

{% list tabs %}

* Management console
    1. Go to the folder page and select **{{ dataproc-name }}**.
    1. Click on the name of the cluster and open the **Jobs** tab.
    1. Click on the name of the job.

* CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To get general information about the job, run the command:

    ```bash
    yc dataproc job get \
       --cluster-name <cluster name> \
       --name <job name>
    ```

    You can query the cluster ID and name with a [list of clusters in the folder](./cluster-list.md#list).

* API

    To get general information about a job, use the [get](../api-ref/Job/list) API method.

{% endlist %}

## Get job execution logs {#get-logs}

{% list tabs %}

* Management console
    1. Go to the folder page and select **{{ dataproc-name }}**.
    1. Click on the name of the cluster and open the **Jobs** tab.
    1. Click on the name of the job.

* CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To get job execution logs, run the command:

    ```bash
    yc dataproc job log \
       --cluster-name <cluster name> \
       --name <job name>
    ```

    You can query the cluster ID and name with a [list of clusters in the folder](./cluster-list.md#list).

* API

    To get a job execution log, use the [listLog](../api-ref/Job/log) API method.

{% endlist %}

