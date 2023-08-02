# Managing Hive jobs

In a {{ dataproc-name }} cluster, you can manage [jobs](../concepts/jobs.md) and receive execution logs for them. For job examples, see [{#T}](../tutorials/job-overview.md).

## Create a job {#create}

{% list tabs %}

- Management console

    1. Go to the [folder page]({{ link-console-main }}) and select **{{ dataproc-name }}**.
    1. Click on the name of the cluster and open the **Jobs** tab.
    1. Click **Submit job**.
    1. (optional) Enter a name for the job.
    1. In the **Job type** field, select `Hive`.
    1. (Optional) In the **{{ ui-key.yacloud.dataproc.jobs.field_properties }}** field, specify [component properties](../concepts/settings-list.md) as `key:value` pairs.

       {% include [job-properties-requirements](../../_includes/data-proc/job-properties-requirements.md) %}

    1. (optional) Enable the **Continue on failure** setting.
    1. Specify **Script variables** as `key-value` pairs
    1. (optional) Specify the paths to JAR files, if any.

       {% include [jar-file-path-requirements](../../_includes/data-proc/jar-file-path-requirements.md) %}

    1. Select one of the driver types and specify which to use to start the job:
        * List of queries to be executed.
        * Path to the file with the queries to be executed.
    1. Click **Submit job**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To create a job:

   1. View a description of the CLI create command for `Hive` jobs:

      ```bash
      {{ yc-dp }} job create-hive --help
      ```

   1. Create a job (the example doesn't show all the available parameters):

      ```bash
      {{ yc-dp }} job create-hive \
         --cluster-name=<cluster name> \
         --name=<job name> \
         --query-file-uri=<query file URI> \
         --script-variables=<comma-separated list of variables>
      ```

      Pass in the paths to the files required for the job in the following format:

      {% include [jar-file-path-requirements](../../_includes/data-proc/jar-file-path-requirements.md) %}

   You can find out the cluster ID and name in a [list of clusters in the folder](./cluster-list.md#list).

- API

    Use the [create](../api-ref/Job/create) API method and include the following information in the request:

    * Cluster ID in the `clusterId` parameter. You can retrieve it with a [list of clusters in the folder](./cluster-list.md#list).
    * Job name in the `name` parameter.
    * Job properties in the `hiveJob` parameter.

{% endlist %}

## Cancel a job {#cancel}

{% include [jobs-cancel](../../_includes/data-proc/jobs-cancel.md) %}

## Get a list of jobs {#list}

{% include [jobs-list](../../_includes/data-proc/jobs-list.md) %}

## Get general information about the job {#get-info}

{% include [jobs-get-info](../../_includes/data-proc/jobs-get-info.md) %}


## Get job execution logs {#get-logs}

{% include [jobs-get-logs](../../_includes/data-proc/jobs-get-logs.md) %}

