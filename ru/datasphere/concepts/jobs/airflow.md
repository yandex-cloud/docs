# Интеграция с {{ maf-full-name }}

[Сервис {{ maf-full-name }}](../../../managed-airflow/concepts/index.md#about-the-service) позволяет описывать и управлять автоматизированными процессами обработки данных — воркфлоу. Воркфлоу представляет собой направленный ациклический граф (Directed Acyclic Graph, _DAG_), который реализуется с помощью скрипта на Python. Файл с таким скриптом называется _DAG-файлом_. В нем содержатся задачи, расписание их запуска и зависимости между ними.

Вы можете использовать {{ maf-name }}, чтобы организовать [повторный запуск](./fork.md) заданий {{ ds-jobs }} по расписанию.

## Регулярный запуск заданий {#airflow-dag}

Чтобы реализовать регулярный запуск заданий, при [создании](../../../managed-airflow/operations/cluster-create.md) кластера {{ AF }} в разделе **{{ ui-key.yacloud.airflow.cluster.overview.section_dependencies }}** укажите **{{ ui-key.yacloud.airflow.title_pip-packages }}** — **DataSphere Jobs: datasphere**. Чтобы кластер {{ AF }} мог работать с заданиями {{ ml-platform-name }}, добавьте [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) кластера в проект {{ ml-platform-name }} с [ролью](../../security/index.md) не ниже `Developer`.

Чтобы управлять DAG-файлом через интерфейс веб-сервиса {{ AF }}, [сохраните](../../../managed-airflow/operations/upload-dags.md) его в бакет {{ objstorage-full-name }}.

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

Логи выполнения задания отображаются в CLI и в интерфейсе веб-сервера. В случае возникновения проблем, DAG-операция завершится ошибкой, а в логах появится соответствующая трассировка стека.

{% note info %}

В данный момент при работе с {{ ds-jobs }} через Airflow DAG нет возможности переопределения файлов с входными и выходными данными. Файлы с входными данными будут взяты у родительского задания. Выходные данные сохраняйте во внешние хранилища, например, в S3.

{% endnote %}

## Неблокирующие вызовы клонов задания через DAG {#fork-from-dag}

Неблокирующий вызов позволяет сразу после запуска задания, не дожидаясь его завершения, проводить новые вычисления на кластере {{ AF }}. Для проверки статуса задания используется [Airflow Sensor](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/sensors.html), который экономит вычислительные ресурсы кластера для запуска других графов заданий.

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

#### См. также {#see-also}

* [{#T}](./index.md)
* [{#T}](./fork.md)
* [{#T}](../../../managed-airflow/concepts/index.md)
