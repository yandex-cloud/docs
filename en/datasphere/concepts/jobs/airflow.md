# Integration with {{ maf-full-name }}

[{{ maf-full-name }}](../../../managed-airflow/concepts/index.md#about-the-service) allows you to describe and manage automated data processing workflows. A workflow is a Directed Acyclic Graph (_DAG_) implemented using a Python script. A file with this script is called a _DAG file_. It contains jobs, their run schedule, and dependencies between them.

You can use {{ maf-name }} for {{ ds-jobs }} to be [rerun](./fork.md) on a schedule.

## Running jobs regularly {#airflow-dag}

To run jobs regularly, specify **{{ ui-key.yacloud.airflow.title_pip-packages }}** — **DataSphere Jobs: datasphere** in the **{{ ui-key.yacloud.airflow.cluster.overview.section_dependencies }}** section when [creating](../../../managed-airflow/operations/cluster-create.md) a {{ AF }} cluster. For your {{ AF }} cluster to work with {{ ml-platform-name }} jobs, add the cluster's [service account](../../../iam/concepts/users/service-accounts.md) to the {{ ml-platform-name }} project with the `Developer` [role](../../security/index.md) or higher.

To manage a DAG file through the {{ AF }} web service interface, [save](../../../managed-airflow/operations/upload-dags.md) it to the {{ objstorage-full-name }} bucket.

{% note warning %}

When writing job code, specify the `yandexcloud` package dependency of the latest published version to avoid dependency conflicts.

{% endnote %}

#### Example {#example-airflow-dag}

Contents of a DAG file configured to run daily using the `schedule` parameter:

```python
from typing import Dict

from airflow.decorators import dag, task
import pendulum

from datasphere import SDK

now = pendulum.now()

@dag(dag_id='fork_job_sync', start_date=now, schedule="@daily", catchup=False)
def run():
    @task(task_id='fork_job')
    def fork_job(source_job_id: str, args: Dict[str, str]):
        sdk = SDK()
        job = sdk.fork_job(source_job_id, args=args)
        job.wait()

    fork_job('<source_job_id>', {'RANGE': '1'})

run()
```

Job execution logs are displayed in [{{ ds-cli }}](cli.md) and the web server interface. If there are any issues, the DAG operation will fail and the corresponding stack trace will appear in the logs.

{% note info %}

Currently, when working with {{ ds-jobs }} via Airflow DAG, you cannot redefine the input and output data files. Input data files will be taken from the parent job. Save output data externally, e.g., to an S3 storage.

{% endnote %}

## Non-blocking job fork calls via DAG {#fork-from-dag}

A non-blocking call allows you to perform new calculations on your {{ AF }} cluster immediately after running a job without waiting for it to be completed. Job status checks are performed using [Airflow Sensor](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/sensors.html), which saves cluster computing resources to run other job graphs.

#### Example {#example-fork-from-dag}

Let's take a look at a DAG file with Airflow Sensor which inquires for job status every minute using the `get_job` function. When the job is completed, the last operator, `handle_job_result`,  is run:

```python
from typing import Optional

from airflow.decorators import dag, task
from airflow.sensors.base import PokeReturnValue
import pendulum

from datasphere import SDK

now = pendulum.now()

@dag(dag_id='fork_job_async', start_date=now, schedule="@daily", catchup=False)
def run():
    @task(task_id='fork_job')
    def fork_job(source_job_id: str, args: Dict[str, str]) -> str:
        sdk = SDK()
        job = sdk.fork_job(source_job_id, args=args)
        return job.id

    @task(task_id='print_job_info')
    def print_job_info(job_id: str):
        print(f'Do something useful, may be with job {job_id}')

    @task.sensor(task_id='wait_for_job', poke_interval=60, timeout=3600, mode='reschedule')
    def wait_for_job(job_id: str) -> PokeReturnValue:
        sdk = SDK()
        job = sdk.get_job(job_id)
        return PokeReturnValue(is_done=job.done, xcom_value='xcom_value')

    @task(task_id='handle_job_result')
    def handle_job_result():
        print('Processing job results')

    job_id = fork_job('<parent_job_ID>', {'RANGE': '1'})
    print_job_info(job_id)
    wait_for_job(job_id) >> handle_job_result()

run()
```

Add additional operators before or after the job run by integrating it with other systems or external storages.

## Using the results of completed jobs {#use-results}

{% include [dag-load-job-results](../../../_includes/datasphere/dag-load-job-results.md) %}

#### See also {#see-also}

* [{#T}](./index.md)
* [{#T}](./fork.md)
* [{#T}](../../../managed-airflow/concepts/index.md)
