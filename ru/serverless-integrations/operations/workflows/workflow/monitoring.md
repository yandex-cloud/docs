---
title: Просмотр графиков мониторинга рабочего процесса в {{ sw-full-name }}
description: Вы можете посмотреть график мониторинга в {{ sw-full-name }} с помощью консоли управления, для этого выберите сервис {{ sw-name }}, нажмите на рабочий процесс, графики мониторинга которого вы хотите посмотреть.
---

# Посмотреть графики мониторинга рабочего процесса

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится [рабочий процесс](../../../concepts/workflows/workflow.md).
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. На панели слева нажмите ![image](../../../../_assets/console-icons/graph-node.svg) **{{ ui-key.yacloud.serverless-workflows.label_service }}**.
  1. Выберите рабочий процесс, графики мониторинга которого вы хотите посмотреть.
  1. На панели слева нажмите ![image](../../../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.common.monitoring }}**.
  1. На странице появятся следующие графики:

      * **Workflow Executions** — общее количество [запусков рабочего процесса](../../../concepts/workflows/execution.md).
      * **Workflow Executions Inflight** — количество запусков рабочего процесса в процессе выполнения.
      * **Workflow Executions Timings** — гистограмма выполнения рабочего процесса.
      * **Workflow Steps** — общее количество запущенных шагов.
      * **Workflow Steps Inflight** — количество шагов в процессе выполнения.
      * **Workflow Steps Timings** — гистограмма выполнения отдельного шага.

      Вы можете выбрать период, за который необходимо отобразить информацию на графике: час, день, неделя, месяц или произвольный период.

{% endlist %}