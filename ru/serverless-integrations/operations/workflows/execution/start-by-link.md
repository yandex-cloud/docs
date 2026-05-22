---
title: Как запустить рабочий процесс по ссылке
description: Следуя данной инструкции, вы сможете запустить рабочий процесс по ссылке.
---

# Запустить рабочий процесс по ссылке

## Получить ссылку для запуска {#get-link}

{% list tabs group=instructions %}

- Консоль управления {#console}

    {% note info %}

    Получить ссылку для запуска рабочего процесса с помощью консоли управления можно только, если рабочий процесс [публичный](../workflow/make-public.md).

    {% endnote %}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится рабочий процесс.
    1. [Перейдите](../../../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
    1. На панели слева нажмите ![image](../../../../_assets/console-icons/graph-node.svg) **{{ ui-key.yacloud.serverless-workflows.label_service }}**.
    1. Выберите рабочий процесс. Ссылка для запуска будет в поле **{{ ui-key.yacloud.serverless-workflows.label_execution-url }}**.

- CLI {#cli}

    Чтобы получить ссылку для запуска, выполните команду:

    ```bash
    yc serverless workflow get <имя_контейнера>
    ```

    Ссылка для запуска будет в поле `execution_url`.

- API {#api}

  Чтобы получить ссылку для запуска рабочего процесса, воспользуйтесь методом REST API [get](../../../../serverless-integrations/workflows/api-ref/Workflow/get.md) для ресурса [Workflow](../../../../serverless-integrations/workflows/api-ref/Workflow/index.md) или вызовом gRPC API [WorkflowsService/Get](../../../../serverless-integrations/workflows/api-ref/grpc/Workflow/get.md). Ссылка для запуска будет в поле `execution_url`.

{% endlist %}

## Запустить рабочий процесс через HTTPS {#https}

Если рабочий процесс:
* [публичный](../workflow/make-public.md), его может запустить любой пользователь.
* приватный, чтобы запустить его, пользователю необходимо аутентифицироваться, передав [{{ iam-short-name }}-токен](../../../../iam/concepts/authorization/iam-token.md) в заголовке `Authorization` в следующем формате:

    ```bash
    Authorization: Bearer <{{ iam-short-name }}-токен>
    ```

Чтобы запустить рабочий процесс, сделайте POST-запрос:

* Пример запуска публичного рабочего процесса без передачи входных данных:

    ```bash
    curl -X POST "https://serverless-workflows.api.cloud.yandex.net/workflows/v1/execution/fd2g4pu20roc********/start"
    ```

*  Пример запуска приватного рабочего процесса без передачи входных данных:

    ```bash
    IAM_TOKEN="<{{ iam-short-name }}-токен>"
    curl -X POST \
    --header "Authorization: Bearer $IAM_TOKEN" \
    "https://serverless-workflows.api.cloud.yandex.net/workflows/v1/execution/dfq3l36kr2gh********/start"
    ```

* Пример запуска публичного рабочего процесса с передачей входных данных (входные данные передаются на вход рабочего процесса без изменений):

    ```bash
    curl "https://serverless-workflows.api.cloud.yandex.net/workflows/v1/execution/fd2g4pu20roc********/start" -d '{"hello": "world"}'
    ```

#### См. также {#see-also}

* [{#T}](../../../concepts/workflows/execution.md)
* [{#T}](get-list.md)
