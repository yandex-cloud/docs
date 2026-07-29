[Документация Yandex Cloud](../../../../index.md) > [Yandex Serverless Integrations](../../../index.md) > [Пошаговые инструкции](../../index.md) > Workflows > Управление рабочим процессом > Управлять логами > Посмотреть логи

# Посмотреть логи рабочего процесса

{% note info %}

На данный момент Workflows поддерживается в двух интерфейсах — [Yandex Cloud](https://console.yandex.cloud/link/serverless-integrations/workflows/workflows) и [Yandex AI Studio](https://aistudio.yandex.ru/platform/link//workflows). При этом:

* рабочие процессы, [созданные в интерфейсе Yandex Cloud](create-constructor.md), автоматически _доступны_ в интерфейсе AI Studio;
* рабочие процессы, созданные в интерфейсе AI Studio, _недоступны_ в интерфейсе Yandex Cloud.

С 3 сентября 2026 года Workflows перестанет поддерживаться в интерфейсе Yandex Cloud. Для создания рабочих процессов и управления ими используйте интерфейс AI Studio.

{% endnote %}

Время в журнале указано по [UTC](https://ru.wikipedia.org/wiki/Всемирное_координированное_время).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором находится [рабочий процесс](../../../concepts/workflows/workflow.md).
  1. Перейдите в сервис **Serverless Integrations**.
  1. На панели слева нажмите ![image](../../../../_assets/console-icons/graph-node.svg) **Workflows**.
  1. Выберите рабочий процесс, логи которого вы хотите посмотреть.
  1. На панели слева нажмите ![image](../../../../_assets/console-icons/receipt.svg) **Логи**.
  1. Укажите период, за который хотите посмотреть логи. По умолчанию задан период 1 час.

{% endlist %}

Подробнее о работе с логами в [документации Yandex Cloud Logging](../../../../logging/index.md).