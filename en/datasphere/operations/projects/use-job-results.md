# Using results of completed jobs

Sometimes you need to process the [job](../../concepts/jobs/index.md) outputs or use them to run another job. To do this, upload them using the {{ ds-jobs }} SDK `download_job_files` function or substitute them into another job using the [DAG Airflow](../../concepts/jobs/airflow.md) operator.

## Uploading via {{ ds-cli }} {#cli}

To upload job results into the working directory using [{{ ds-cli }}](../../concepts/jobs/cli.md), run this command by substituting the job ID:

{% list tabs group=programming_language %}

- Bash {#bash}
  
  ```bash
  datasphere project job download-files --id <job_ID>
  ```

{% endlist %}

The function has optional parameters:

* `with_logs`: Upload [logs](../../concepts/jobs/cli.md#logs), `false` by default.
* `with_diagnostics`: Upload diagnostic files, `false` by default.
* `with_diagnostics`: File upload directory, the working directory by default.

To use the uploaded data in another job, specify the data in the `input` parameter in the `config.yaml` [file](../../concepts/jobs/index.md#config).

## Uploading via DAG Airflow {#dag}

{% include [dag-load-job-results](../../../_includes/datasphere/dag-load-job-results.md) %}
