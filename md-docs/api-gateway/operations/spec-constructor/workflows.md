# Добавить расширение x-yc-apigateway-integration:http для интеграции с Yandex Workflows

{% list tabs %}

- Консоль управления

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создали или хотите создать [API-шлюз](../../concepts/index.md).
  1. Перейдите в сервис **API Gateway**.
  1. Выберите API-шлюз или нажмите кнопку **Создать API-шлюз**, чтобы [создать](../api-gw-create.md) новый.
  1. В поле **Спецификация** нажмите значок ![image](../../../_assets/api-gateway/spec-constructor/workflows.svg).
  1. Укажите в поле:

      * **Путь** — относительный путь к интеграции, который будет добавлен к URL-адресу API Gateway. Переменные указывайте в фигурных скобках, например `/static/{function_id}`. Подробнее в спецификации [OpenAPI 3.0](https://github.com/OAI/OpenAPI-Specification).
      * **HTTP-метод** — метод, который будет использоваться для взаимодействия с интеграцией.

      * **Сервисный аккаунт** — сервисный аккаунт с ролью `serverless.workflows.executor` для [запуска рабочего процесса](../../../serverless-integrations/concepts/workflows/execution.md). Если у вас нет сервисного аккаунта, [создайте](../../../iam/operations/sa/create.md) его.
      * **Рабочий процесс** — имя [рабочего процесса](../../../serverless-integrations/concepts/workflows/workflow.md).

  1. Нажмите кнопку **Добавить**.

{% endlist %}

В поле **Спецификация** отобразится OpenAPI-спецификация с указанными значениями параметров.

## Требования к структуре входящего запроса {#requirements}

Чтобы API-шлюз корректно обрабатывал входящие запросы, для них должно быть задано значение заголовка `Content-Type: application/json`.