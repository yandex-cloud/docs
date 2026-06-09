# Использование результатов работы выполненных заданий

Иногда выходные данные [задания](../../concepts/jobs/index.md) нужно обработать или использовать для запуска другого задания. Для этого загрузите их с помощью функции DataSphere Jobs SDK `download_job_files` или подставьте в другое задание с помощью оператора [DAG Airflow](../../concepts/jobs/airflow.md).

## Загрузка с помощью DataSphere CLI {#cli}

Если общий размер результатов задания превышает лимит на [суммарный размер](../../concepts/limits.md) файлов, доступных для скачивания через DataSphere CLI, то будут скачаны только файлы с общим размером не больше этого лимита.

Чтобы загрузить результаты задания в рабочую директорию с помощью [DataSphere CLI](../../concepts/jobs/cli.md), выполните команду, подставив идентификатор задания:

{% list tabs group=programming_language %}

- Bash {#bash}
  
  ```bash
  datasphere project job download-files --id <идентификатор_задания>
  ```

{% endlist %}

У функции есть необязательные параметры:

* `with_logs` — загрузка [логов](../../concepts/jobs/cli.md#logs), `false` по умолчанию.
* `with_diagnostics` — загрузка файлов диагностики, `false` по умолчанию.
* `output_dir` — директория для загрузки файлов, рабочая директория по умолчанию.

Чтобы использовать загруженные данные в другом задании, укажите их в параметре `input` в [файле](../../concepts/jobs/index.md#config) `config.yaml`.

## Загрузка с помощью DAG Airflow {#dag}

С помощью оператора DAG вы можете загрузить выходной файл одного задания (`result.txt`) и сделать его входным файлом (`INPUT_DATA`) другого:

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
  
      fork_job('<идентификатор_задания_для_загрузки>', '<идентификатор_запускаемого_задания>')
  ```

{% endlist %}

#### См. также {#see-also}

* [DataSphere CLI](../../concepts/jobs/cli.md)