# Использование результатов работы выполненных заданий

Иногда выходные данные [задания](../../concepts/jobs/index.md) нужно обработать или использовать для запуска другого задания. Для этого загрузите их с помощью функции {{ ds-jobs }} SDK `download_job_files` или подставьте в другое задание с помощью оператора [DAG Airflow](../../concepts/jobs/airflow.md).

## Загрузка с помощью {{ ds-cli }} {#cli}

Чтобы загрузить результаты задания в рабочую директорию с помощью [{{ ds-cli }}](../../concepts/jobs/cli.md), выполните команду, подставив идентификатор задания:

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

{% include [dag-load-job-results](../../../_includes/datasphere/dag-load-job-results.md) %}
