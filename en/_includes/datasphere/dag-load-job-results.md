You can use a DAG operator to load the output file of one job (`result.txt`) and provide it as an input file (`INPUT_DATA`) for another:

{% list tabs group=programming_language %}

- Python {#bash}

  ```python
  from typing import Dict
  
  from airflow.decorators import dag, task
  import pendulum
  
  from datasphere import SDK
  
  now = pendulum.now()
  
  @dag(dag_id='output_files_for_other_job', start_date=now, schedule="@daily", catchup=False)
  def run():
      @task(task_id='fork_job')
      def fork_job(files_job_id: str, fork_source_job_id: str):
          sdk = SDK()
          sdk.download_job_files(files_job_id)
          job = sdk.fork_job(fork_source_job_id, vars={'INPUT_DATA': 'result.txt'})
          job.wait()
  
      fork_job('<ID_of_job_to_download>', '<ID_of_job_to_run>')
  ```

{% endlist %}