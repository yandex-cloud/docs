[Документация Yandex Cloud](../../../../index.md) > [Yandex Serverless Integrations](../../../index.md) > [Пошаговые инструкции](../../index.md) > Workflows > Управление запуском рабочего процесса > Запустить рабочий процесс > По ссылке

# Запустить рабочий процесс по ссылке

{% note info %}

На данный момент Workflows поддерживается в двух интерфейсах — [Yandex Cloud](https://console.yandex.cloud/link/serverless-integrations/workflows/workflows) и [Yandex AI Studio](https://aistudio.yandex.ru/platform/link//workflows). При этом:

* рабочие процессы, [созданные в интерфейсе Yandex Cloud](../workflow/create-constructor.md), автоматически _доступны_ в интерфейсе AI Studio;
* рабочие процессы, созданные в интерфейсе AI Studio, _недоступны_ в интерфейсе Yandex Cloud.

С 3 сентября 2026 года Workflows перестанет поддерживаться в интерфейсе Yandex Cloud. Для создания рабочих процессов и управления ими используйте интерфейс AI Studio.

{% endnote %}

## Получить ссылку для запуска {#get-link}

{% list tabs group=instructions %}

- Консоль управления {#console}

    {% note info %}

    Получить ссылку для запуска рабочего процесса с помощью консоли управления можно только, если рабочий процесс [публичный](../workflow/make-public.md).

    {% endnote %}

    1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором находится рабочий процесс.
    1. Перейдите в сервис **Serverless Integrations**.
    1. На панели слева нажмите ![image](../../../../_assets/console-icons/graph-node.svg) **Workflows**.
    1. Выберите рабочий процесс. Ссылка для запуска будет в поле **Ссылка для запуска**.

- CLI {#cli}

    Чтобы получить ссылку для запуска, выполните команду:

    ```bash
    yc serverless workflow get <имя_контейнера>
    ```

    Ссылка для запуска будет в поле `execution_url`.

- API {#api}

  Чтобы получить ссылку для запуска рабочего процесса, воспользуйтесь методом REST API [get](../../../workflows/api-ref/Workflow/get.md) для ресурса [Workflow](../../../workflows/api-ref/Workflow/index.md) или вызовом gRPC API [WorkflowsService/Get](../../../workflows/api-ref/grpc/Workflow/get.md). Ссылка для запуска будет в поле `execution_url`.

{% endlist %}

## Запустить рабочий процесс через HTTPS {#https}

Если рабочий процесс:
* [публичный](../workflow/make-public.md), его может запустить любой пользователь.
* приватный, чтобы запустить его, пользователю необходимо аутентифицироваться, передав [IAM-токен](../../../../iam/concepts/authorization/iam-token.md) или [API-ключ](../../../../iam/concepts/authorization/api-key.md) в заголовке `Authorization`.

Чтобы запустить рабочий процесс, сделайте POST-запрос:

* Пример запуска публичного рабочего процесса без передачи входных данных:

    ```bash
    curl -X POST "https://serverless-workflows.api.cloud.yandex.net/workflows/v1/execution/fd2g4pu20roc********/start"
    ```

*  Пример запуска приватного рабочего процесса без передачи входных данных и с аутентификацией по IAM-токену:

    ```bash
    IAM_TOKEN="<IAM-токен>"
    curl -X POST \
    --header "Authorization: Bearer $IAM_TOKEN" \
    "https://serverless-workflows.api.cloud.yandex.net/workflows/v1/execution/dfq3l36kr2gh********/start"
    ```

*  Пример запуска приватного рабочего процесса без передачи входных данных и с аутентификацией по API-ключу:

    ```bash
    API_KEY="<API-ключ>"
    curl -X POST \
    --header "Authorization: Api-Key $API_KEY" \
    "https://serverless-workflows.api.cloud.yandex.net/workflows/v1/execution/dfq3l36kr2gh********/start"
    ```

* Пример запуска публичного рабочего процесса с передачей входных данных (входные данные передаются на вход рабочего процесса без изменений):

    ```bash
    curl "https://serverless-workflows.api.cloud.yandex.net/workflows/v1/execution/fd2g4pu20roc********/start" -d '{"hello": "world"}'
    ```

#### Полезные ссылки {#see-also}

* [Запуск рабочего процесса](../../../concepts/workflows/execution.md)
* [Получить список запусков рабочего процесса](get-list.md)