# Managing Hive jobs

In a {{ dataproc-name }} cluster, you can manage [jobs](../concepts/jobs.md) and receive execution logs for them. For sample jobs, see [{#T}](../tutorials/job-overview.md).

## Creating a job {#create}

{% list tabs group=instructions %}

- Management console {#console}

    1. Open the [folder dashboard]({{ link-console-main }}).
    1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
    1. Click the name of your cluster and select the **{{ ui-key.yacloud.mdb.cluster.switch_jobs }}** tab.
    1. Click **{{ ui-key.yacloud.dataproc.jobs.button_create }}**.
    1. Optionally, enter a name for the job.
    1. In the **{{ ui-key.yacloud.dataproc.jobs.field_job-type }}** field, select `{{ ui-key.yacloud.dataproc.jobs.field_hive-job-type }}`.
    1. Optionally, in the **{{ ui-key.yacloud.dataproc.jobs.field_properties }}** field, specify [component properties](../concepts/settings-list.md) as `key-value` pairs.

       {% include [job-properties-requirements](../../_includes/data-processing/job-properties-requirements.md) %}

    1. Optionally, enable the **{{ ui-key.yacloud.dataproc.jobs.field_continue-on-failure }}** setting.
    1. Specify **{{ ui-key.yacloud.dataproc.jobs.field_script-variables }}** as a `key-value` pair.
    1. Optionally, specify the paths to JAR files, if any.

        {% include [jar-file-path-requirements](../../_includes/data-processing/jar-file-path-requirements.md) %}

    1. Select one of the driver types and specify which to use to run the job:
        * List of queries to execute.
        * Path to the file with the queries to execute.
    1. Click **{{ ui-key.yacloud.dataproc.jobs.button_create }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To create a job:

    1. View the description of the CLI create command for `Hive` jobs:

        ```bash
        {{ yc-dp }} job create-hive --help
        ```

    1. Create a job (the example does not illustrate all available parameters):

        ```bash
        {{ yc-dp }} job create-hive \
           --cluster-name=<cluster_name> \
           --name=<job_name> \
           --query-file-uri=<query_file_URI> \
           --script-variables=<list_of_values>
        ```

        Where `--script-variables` is a comma-separated list of variable values.

        Provide the paths to the files required for the job in the following format:

        {% include [jar-file-path-requirements](../../_includes/data-processing/jar-file-path-requirements.md) %}

    You can get the cluster ID and name with the [list of clusters in the folder](./cluster-list.md#list).

- API {#api}

    Call the [create](../api-ref/Job/create) API method and provide the following in the request:

    * Cluster ID in the `clusterId` parameter. You can get it with the [list of clusters in the folder](./cluster-list.md#list).
    * Job name in the `name` parameter.
    * Job properties in the `hiveJob` parameter.

{% endlist %}

## Cancel a job {#cancel}

{% include [jobs-cancel](../../_includes/data-processing/jobs-cancel.md) %}

## Get a list of jobs {#list}

{% include [jobs-list](../../_includes/data-processing/jobs-list.md) %}

## Get general info about a job {#get-info}

{% include [jobs-get-info](../../_includes/data-processing/jobs-get-info.md) %}

## Get job execution logs {#get-logs}

{% include [jobs-get-logs](../../_includes/data-processing/jobs-get-logs.md) %}