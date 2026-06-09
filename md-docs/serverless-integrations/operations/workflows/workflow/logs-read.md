# Посмотреть логи рабочего процесса

Время в журнале указано по [UTC](https://ru.wikipedia.org/wiki/Всемирное_координированное_время).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится [рабочий процесс](../../../concepts/workflows/workflow.md).
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. На панели слева нажмите ![image](../../../../_assets/console-icons/graph-node.svg) **{{ ui-key.yacloud.serverless-workflows.label_service }}**.
  1. Выберите рабочий процесс, логи которого вы хотите посмотреть.
  1. На панели слева нажмите ![image](../../../../_assets/console-icons/receipt.svg) **{{ ui-key.yacloud.common.logs }}**.
  1. Укажите период, за который хотите посмотреть логи. По умолчанию задан период 1 час.

{% endlist %}

Подробнее о работе с логами в [документации {{ cloud-logging-full-name }}](../../../../logging/index.md).