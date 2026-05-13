# Интеграция с Yandex Managed Service for Apache Airflow™

[Сервис Yandex Managed Service for Apache Airflow™](../../../managed-airflow/concepts/index.md#about-the-service) позволяет описывать и управлять автоматизированными процессами обработки данных — воркфлоу. Воркфлоу представляет собой направленный ациклический граф (Directed Acyclic Graph, _DAG_), который реализуется с помощью скрипта на Python. Файл с таким скриптом называется _DAG-файлом_. В нем содержатся задачи, расписание их запуска и зависимости между ними.

Вы можете использовать Managed Service for Apache Airflow™, чтобы организовать [повторный запуск](fork.md) заданий DataSphere Jobs по расписанию.

## Регулярный запуск заданий {#airflow-dag}

Чтобы реализовать регулярный запуск заданий, при [создании](../../../managed-airflow/operations/cluster-create.md) кластера Apache Airflow™ в разделе **Зависимости** укажите **Pip-пакеты** — **DataSphere Jobs: datasphere**. Чтобы кластер Apache Airflow™ мог работать с заданиями DataSphere, добавьте [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) кластера в проект DataSphere с [ролью](../../security/index.md) не ниже `Developer`.

Чтобы управлять DAG-файлом через веб-интерфейс Apache Airflow™, [сохраните его](../../../managed-airflow/operations/upload-dags.md#dag-bucket-import) в бакет Yandex Object Storage.

{% note warning %}

При написании кода задания указывайте зависимость от пакета `yandexcloud` последней опубликованной версии, чтобы избежать конфликтов зависимостей.

{% endnote %}

#### Пример {#example-airflow-dag}

Содержимое DAG-файла, настроенного на ежедневный запуск с помощью параметра `schedule`:

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

Логи выполнения задания отображаются в [DataSphere CLI](cli.md) и в интерфейсе веб-сервера. В случае возникновения проблем, DAG-операция завершится ошибкой, а в логах появится соответствующая трассировка стека.

{% note info %}

В данный момент при работе с DataSphere Jobs через Airflow DAG нет возможности переопределения файлов с входными и выходными данными. Файлы с входными данными будут взяты у родительского задания. Выходные данные сохраняйте во внешние хранилища, например, в S3.

{% endnote %}

## Неблокирующие вызовы клонов задания через DAG {#fork-from-dag}

Неблокирующий вызов позволяет сразу после запуска задания, не дожидаясь его завершения, проводить новые вычисления на кластере Apache Airflow™. Для проверки статуса задания используется [Airflow Sensor](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/sensors.html), который экономит вычислительные ресурсы кластера для запуска других графов заданий.

#### Пример {#example-fork-from-dag}

Рассмотрим DAG-файл с Airflow Sensor, который каждую минуту запрашивает статус задания с помощью функции `get_job`. Когда задание завершено, запускается последний оператор — `handle_job_result`:

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

    job_id = fork_job('<идентификатор_родительского_задания>', {'RANGE': '1'})
    print_job_info(job_id)
    wait_for_job(job_id) >> handle_job_result()

run()
```

Добавьте дополнительные операторы до или после запуска задания, интегрировав его с другими системами или внешними хранилищами.

## Использование результатов работы выполненных заданий {#use-results}

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

* [DataSphere Jobs](index.md)
* [Повторный запуск заданий DataSphere Jobs](fork.md)
* [Взаимосвязь ресурсов в Managed Service for Apache Airflow™](../../../managed-airflow/concepts/index.md)