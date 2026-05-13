# Посмотреть графики мониторинга рабочего процесса

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором находится [рабочий процесс](../../../concepts/workflows/workflow.md).
  1. [Перейдите](../../../../console/operations/select-service.md#select-service) в сервис **Serverless Integrations**.
  1. На панели слева нажмите ![image](../../../../_assets/console-icons/graph-node.svg) **Workflows**.
  1. Выберите рабочий процесс, графики мониторинга которого вы хотите посмотреть.
  1. На панели слева нажмите ![image](../../../../_assets/console-icons/display-pulse.svg) **Мониторинг**.
  1. На странице появятся следующие графики:

      * **Workflow Executions** — общее количество [запусков рабочего процесса](../../../concepts/workflows/execution.md).
      * **Workflow Executions Inflight** — количество запусков рабочего процесса в процессе выполнения.
      * **Workflow Executions Timings** — гистограмма выполнения рабочего процесса.
      * **Workflow Steps** — общее количество запущенных шагов.
      * **Workflow Steps Inflight** — количество шагов в процессе выполнения.
      * **Workflow Steps Timings** — гистограмма выполнения отдельного шага.

      Вы можете выбрать период, за который необходимо отобразить информацию на графике: час, день, неделя, месяц или произвольный период.

{% endlist %}