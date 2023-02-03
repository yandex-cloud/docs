# Удаление метрик через API

Чтобы удалить метрики в Solomon через API, воспользуйтесь ресурсом [metrics deletion](https://solomon.yandex-team.ru/swagger-ui/index.html#/metrics%20deletion).

Подробное описание механизма работы удаления можно прочитать в разделе [Удаление метрик по селектору](../../concepts/deletion/operation.md).

{% note info %}

В настоящий момент доступ к API для удаления метрик Голована ограничен. 

Если вам нужно удалить метрики из Голована, создайте заявку через [форму](https://st.yandex-team.ru/createTicket?queue=MONITORINGREQ&_form=87264).

{% endnote %}

## Перед началом {#before-you-begin}

Чтобы воспользоваться примерами в этом разделе, сохраните [OAuth-токен](../../api-ref/authentication.md#oauth) к Solomon API в переменную окружения `SOLOMON_TOKEN`.

## Примеры запросов {#sample-requests}

### Запуск удаления {#sample-run}

1. Создайте файл с телом запроса, например `body.json`. Множество метрик, подлежащих удалению, задается с помощью [селектора](../../concepts/glossary#selector) в обязательном поле `selector`. При желании, в необязательном поле `description` можно добавить текстовое описание запускаемой операции в произвольном формате (причина удаления, ссылка на задачу в трекере и т.д.).

    **body.json:**
    ```json
    {
        "description": "SOLOMON-990",
        "selectors": "{cluster='some_cluster', service='some_service', sensor='some_metric'}"
    }
    ```

1. Отправьте запрос, используя идентификатор нужного [проекта](../../concepts/glossary#project) в URL, и сохраните ответ в файл, например `output.json`:

    ```bash
        curl -s "https://solomon.yandex-team.ru/api/v2/projects/junk/sensors/deletion" \
        -X POST \
        -H "Content-Type: application/json" \
        -H "Authorization: OAuth "$SOLOMON_TOKEN \
        -d @body.json > output.json
    ```

    Пример ответа на запрос:

    **output.json:**
    ```bash
    {"operationId":"mon5865s98ruinjuthv5"}
    ```

1. Запомните идентификатор `operationId`, полученный на предыдущем шаге, для дальнейшего просмотра статуса операции.


{% note warning %}

Метрики, подпадающие под условия селектора, должны целиком содержаться ровно в одном [шарде](../glossary#shard). Мульти-шардовые удаления в данный момент не поддерживаются. В случае необходимости удалить метрики из нескольких шардов, необходимо запустить отдельную операцию удаления для каждого из шардов.

{% endnote %}

### Просмотр прогресса {#sample-progress}

Отслеживать прогресс запущенной операции удаления можно при помощи метода [get](https://solomon.yandex-team.ru/swagger-ui/index.html#/metrics%20deletion/getUsingGET).

1. Используйте полученный при запуске удаления идентификатор операции:

    ```bash
        curl -s "https://solomon.yandex-team.ru/api/v2/projects/junk/sensors/deletion/mon5865s98ruinjuthv5" \
        -X GET \
        -H "Authorization: OAuth "$SOLOMON_TOKEN \
        > output.json
    ```

    Пример ответа на запрос:

    **output.json:**
    ```bash
    {
        "id": "mon5865s98ruinjuthv5",
        "projectId": "junk",
        "description": "SOLOMON-990",
        "createdAt": "2022-02-07T15:14:18.727Z",
        "createdBy": "hpple",
        "updatedAt": "2022-02-07T15:17:04.856Z",
        "status": "DELETING",
        "selectors": "{cluster='some_cluster', service='some_service', sensor='some_metric', project='junk'}",
        "permanentDeletionAt": "2022-03-10T06:09:55.082Z",
        "estimatedMetricsCount": 100500,
        "progressPercentage": 42.1,
        "permanentlyDeletedMetricsCount": 0
    }
    ```
    Статус `DELETING` означает, что операция еще исполняется. Прогресс выполнения содержится в поле `progressPercentage` и принимает значения в диапазоне `[0, 100]`.

    Поле `estimatedMetricsCount` содержит приблизительную оценку количества удаляемых метрик и может уточняться в процессе выполнения операции.

    Более подробное описание полей и статусов можно увидеть в спецификации метода [get](https://solomon.yandex-team.ru/swagger-ui/index.html#/metrics%20deletion/getUsingGET).


1. Периодически перезапрашивайте состояние операции, дожидаясь перехода в статус `WAITING_FOR_PERMANENT_DELETION`. Начиная с этого момента метрики считаются удаленными с точки зрения системы Solomon.

{% note warning %}

Досрочное завершение операции со статусом `METRICS_HAVE_RECENT_WRITES` означает, что в метрики, выбранные для удаления, продолжается запись. Остановите запись и повторите попытку через час или исключите активные метрики из селектора и попробуйте снова.

{% endnote %}

### Отмена удаления {#sample-cancel}

Операцию удаления можно отменить до наступления момента времени, указанного в поле `permanentDeletionAt` при помощи метода [cancel](https://solomon.yandex-team.ru/swagger-ui/index.html#/metrics%20deletion/cancelUsingPUT).

1. Используйте полученный при запуске удаления идентификатор операции:

    ```bash
        curl -s "https://solomon.yandex-team.ru/api/v2/projects/junk/sensors/deletion/mon5865s98ruinjuthv5/cancel" \
        -X PUT \
        -H "Authorization: OAuth "$SOLOMON_TOKEN \
        > output.json
    ```

    Пример ответа на запрос:

    **output.json:**
    ```bash
    {
        "id": "mon5865s98ruinjuthv5",
        "projectId": "junk",
        "description": "SOLOMON-990",
        "createdAt": "2022-02-07T15:14:18.727Z",
        "createdBy": "hpple",
        "updatedAt": "2022-02-07T15:17:04.856Z",
        "cancelledAt": "2022-02-07T15:16:55.277Z",
        "cancelledBy": "hpple",
        "status": "CANCELLING",
        "selectors": "{cluster='some_cluster', service='some_service', sensor='some_metric', project='junk'}",
        "permanentDeletionAt": "2022-03-17T06:09:55.082Z",
        "estimatedMetricsCount": 100500,
        "progressPercentage": 12.34,
        "permanentlyDeletedMetricsCount": 0
    }
    ```

1. Периодически перезапрашивайте состояние операции, дожидаясь перехода в статус `CANCELLED`. Начиная с этого момента метрики считаются восстановленными с точки зрения системы Solomon.

{% note warning %}

В случае конфликта [меток](../../concepts/glossary#label)/исчерпания [квоты](../../concepts/limits.md) в шарде, часть метрик может быть пропущена при восстановлении. Сообщение об этой проблеме будет содержаться в поле `statusMessage`. 

Операция будет производить повторные попытки восстановления оставшихся метрик. Попробуйте удалить метрики с конфликтующими метками/запросить увеличение квоты. 

В случае если восстановление оставшихся метрик так и не завершится успехом, они будут удалены окончательно в момент времени `permanentDeletionAt`.

{% endnote %}

### Просмотр операций в проекте {#sample-list}

Для просмотра истории операций удаления в проекте воспользуйтесь методом [list](https://solomon.yandex-team.ru/swagger-ui/index.html#/metrics%20deletion/listUsingGET):

```bash
    curl -s "https://solomon.yandex-team.ru/api/v2/projects/junk/sensors/deletion" \
    -X GET \
    -H "Authorization: OAuth "$SOLOMON_TOKEN \
    > output.json
```
Пример ответа на запрос:

**output.json:**
```bash
{
  "result": [
    {
      "id": "monn4gmg27tlsgpha57a",
      "projectId": "junk",
      "description": "test",
      "createdAt": "2022-02-08T12:00:07.800Z",
      "createdBy": "hpple",
      "updatedAt": "2022-02-08T12:12:27.211Z",
      "cancelledAt": "2022-02-08T12:06:08.564Z",
      "cancelledBy": "hpple",
      "status": "CANCELLED",
      "statusMessage": "",
      "selectors": "{cluster='test', service='test', host!='fetcher-sas-000', project='junk'}",
      "permanentDeletionAt": "2022-03-18T02:04:29.355Z",
      "estimatedMetricsCount": 2157179,
      "progressPercentage": 100,
      "permanentlyDeletedMetricsCount": 0
    },
    {
      "id": "mongin874pegd7dolm7c",
      "projectId": "junk",
      "description": "test",
      "createdAt": "2022-01-24T14:21:48.970Z",
      "createdBy": "hpple",
      "updatedAt": "2022-01-24T14:33:20.572Z",
      "status": "COMPLETED",
      "selectors": "{cluster='test', service='test', host!='fetcher-sas-000', project='junk'}",
      "permanentDeletionAt": "2022-02-24T12:15:00.346Z",
      "estimatedMetricsCount": 2157179,
      "progressPercentage": 100,
      "permanentlyDeletedMetricsCount": 2157179
    }
  ],
  "nextPageToken": ""
}
```
