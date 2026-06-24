# Правила записи

_Правила записи_ позволяют на основе полученных метрик вычислять новые значения и сохранять их во временных рядах. Это помогает настроить анализ данных под свою систему и оптимизировать работу Yandex Managed Service for Prometheus®.

## Особенности вычисления правил {#rule-specific}

* Для согласования правил записи с результатами запросов на чтение в сервисе установлена глобальная задержка вычислений в 2 минуты. Это означает, что правила применяются к данным не сразу, а через 2 минуты после их поступления. Это позволяет всем агентам сбора метрик передать данные, прежде чем они будут прочитаны сервисом и записаны как результат выполнения правил записи.

* Лимит количества серий в результате вычисления правила по умолчанию равен 1000. Максимальное возможное значение лимита — 10000.

## Требования к правилам записи {#rule-requirements}

В Prometheus вы можете загружать ваши существующие файлы с правилами записи ([recording rules](https://prometheus.io/docs/prometheus/latest/configuration/recording_rules/#recording-rules)). Поддерживаются все поля, описанные в [спецификации](https://prometheus.io/docs/prometheus/latest/configuration/recording_rules/) YAML-файла.

{% note info %}

Имя файла может содержать только буквы латинского алфавита, цифры, точки, тире и подчеркивания. Максимальная длина файла — 256 символов. Длина имени группы не может превышать 256 символов.

{% endnote %}

Вы можете управлять файлами с правилами записи через [консоль управления](https://console.yandex.cloud) или API.

## Предварительная настройка для работы с API {#api-set}

API представлен набором REST-ресурсов, которые находятся по адресу `https://monitoring.api.cloud.yandex.net/prometheus/workspaces/<идентификатор_воркспейса>/extensions/v1/rules`. 

Чтобы начать выполнять запросы:

1. Установите [cURL](https://curl.haxx.se/).
1. [Аутентифицируйтесь](../../api-ref/authentication.md) в API.
1. [Создайте воркспейс](index.md#access) и скопируйте его идентификатор, чтобы использовать в адресе запросов.

## Добавление и замена файла с правилами записи {#create}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. На главной странице [Monium](https://monium.yandex.cloud) слева выберите раздел **Prometheus**.
   1. Выберите или создайте воркспейс.
   1. Перейдите на вкладку **Правила**.
   1. Если у вас еще нет загруженных файлов, нажмите **Добавить файл** и выберите файл `.yml` с правилами.
   1. Чтобы добавить еще один файл, нажмите **Добавить файл**.
   1. Чтобы заменить существующий файл, справа от него нажмите **![options](../../../_assets/horizontal-ellipsis.svg)** > **Заменить файл**. 

- API {#api}

   1. Закодируйте содержимое файла в [Base64](https://en.wikipedia.org/wiki/Base64) согласно RFC 4648:

       ```bash
       cat recording-rule.yaml

       # groups:
       #   - name: example
       #     rules:
       #     - record: example
       #       expr: up

       base64 -i recording-rule.yaml

       # Z3JvdXBzOgogIC0gbmFtZTogZXhhbXBsZQogICAgcnVsZXM6CiAgICAtIHJlY29yZDogZXhhbXBsZQogICAgICBleHByOiB1cA==
       ```

   1. Сохраните результат в JSON-файл:

       **body.json**

       ```json
       {
           "name": "recording-rules",
           "content" : "Z3JvdXBzOgogIC0gbmFtZTogZXhhbXBsZQogICAgcnVsZXM6CiAgICAtIHJlY29yZDogZXhhbXBsZQogICAgICBleHByOiB1cA=="
       }
       ```

   1. Создайте или замените файл с правилами записи:

       ```bash
       export IAM_TOKEN=<IAM-токен>

       curl \
         --request PUT \
         --header "Content-Type: application/json" \
         --header "Authorization: Bearer ${IAM_TOKEN}" \
         --data "@body.json"  \
         "https://monitoring.api.cloud.yandex.net/prometheus/workspaces/<идентификатор_воркспейса>/extensions/v1/rules"
       ```

   В случае успешного запроса будет возвращен HTTP-код `204`, иначе — текст ошибки.

{% endlist %}

Если в результате замены файла были удалены правила или группы правил, они перестанут вычисляться. Все новые правила и группы правил начнут вычисляться.

## Просмотр списка файлов {#list}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. На главной странице [Monium](https://monium.yandex.cloud) слева выберите раздел **Prometheus**.
   1. Выберите воркспейс.
   1. Перейдите на вкладку **Recording rules**. 

- API {#api}

   Выполните запрос:

   ```bash
   export IAM_TOKEN=<IAM-токен>

   curl \
     --request GET \
     --header "Authorization: Bearer ${IAM_TOKEN}" \
     "https://monitoring.api.cloud.yandex.net/prometheus/workspaces/<идентификатор_воркспейса>/extensions/v1/rules"
   ```

   Пример ответа:

   ```json
   {
     "files": [
       "recording-rules"
     ]
   }
   ```

{% endlist %}

## Просмотр содержимого файла {#get-content}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. На главной странице [Monium](https://monium.yandex.cloud) слева выберите раздел **Prometheus**.
   1. Выберите воркспейс.
   1. Прейдите на вкладку **Recording rules**. 
   1. Справа от файла нажмите **![options](../../../_assets/horizontal-ellipsis.svg)** > **Код файла**.

- API {#api}

   Выполните запрос:

   ```bash
   export IAM_TOKEN=<IAM-токен>

   curl \
     --request GET \
     --header "Authorization: Bearer ${IAM_TOKEN}" \
     "https://monitoring.api.cloud.yandex.net/prometheus/workspaces/<идентификатор_воркспейса>/extensions/v1/rules/recording-rules"
   ```

   Пример ответа:

   ```json
   {
     "name": "recording-rules",
     "content": "Z3JvdXBzOgogIC0gbmFtZTogZXhhbXBsZQogICAgcnVsZXM6CiAgICAtIHJlY29yZDogZXhhbXBsZQogICAgICBleHByOiB1cA=="
   }
   ```

{% endlist %}

## Просмотр состояния вычисления файла {#get-calculation-state}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. На главной странице [Monium](https://monium.yandex.cloud) слева выберите раздел **Prometheus**.
   1. Выберите воркспейс.
   1. Прейдите на вкладку **Recording rules**. 
   1. Выберите файл с правилами. На открывшейся странице будет отражено состояние последних вычислений по данному правилу.

- API {#api}

   Вычисление каждого правила во всех группах файла можно получить, используя REST-ресурс `snapshots`. Каждый снимок содержит информацию о статусе, ошибке, имени правила и о том, как долго оно вычислялось.

   Выполните запрос:

   ```bash
   export IAM_TOKEN=<IAM-токен>

   curl \
     --request GET \
     --header "Authorization: Bearer ${IAM_TOKEN}" \
     "https://monitoring.api.cloud.yandex.net/prometheus/workspaces/<идентификатор_воркспейса>/extensions/v1/rules/recording-rules/snapshots"
   ```

   Пример ответа:

   ```json
   {
     "snapshotByGroup": {
       "example": [
         {
           "state": "OK",
           "error": "",
           "evaluationTimeMs": 21,
           "evaluatedAtTimeEpochMs": 1710490243322,
           "record": "example"
         }
       ]
     }
   }
   ```

   Возможные состояния правила:
   * `NOT_EVALUATED_YET` — файл загружен, но вычисление еще не началось.
   * `OK` — успешное вычисление.
   * `LIMIT_EXCEEDED` — правило вернуло больше временных рядов, чем разрешено в поле `limit` в YAML-файле. Для таких правил не сохраняется частичный результат вычислений.
   * `TIMEOUT` — правило вычислялось слишком долго.
   * `UNEXPECTED_RESULT_TYPE` — вычисление вернуло неожиданный результат, например строку.
   * `UNKNOWN_ERROR` — общая ошибка, которая не может быть описана предыдущими состояниями.

{% endlist %}

## Удаление файла {#delete}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. На главной странице [Monium](https://monium.yandex.cloud) слева выберите раздел **Prometheus**.
   1. Выберите воркспейс.
   1. Прейдите на вкладку **Recording rules**. 
   1. Справа от файла нажмите **![options](../../../_assets/horizontal-ellipsis.svg)** > **Удалить**.

- API {#api}

   Выполните запрос:

   ```bash
   export IAM_TOKEN=<IAM-токен>

   curl \
     --request DELETE \
     --header "Authorization: Bearer ${IAM_TOKEN}" \
     "https://monitoring.api.cloud.yandex.net/prometheus/workspaces/<идентификатор_воркспейса>/extensions/v1/rules/recording-rules"
   ```

{% endlist %}

## Скачивание файла {#download}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. На главной странице [Monium](https://monium.yandex.cloud) слева выберите раздел **Prometheus**.
   1. Выберите воркспейс.
   1. Прейдите на вкладку **Recording rules**. 
   1. Слева от файла нажмите **![options](../../../_assets/horizontal-ellipsis.svg)** > **Скачать файл**.

{% endlist %}

_© 2025 Linux Foundation. Все права защищены. Linux Foundation зарегистрировала товарные знаки и использует товарные знаки. Список товарных знаков Linux Foundation приведен на странице [Trademark Usage](https://www.linuxfoundation.org/legal/trademark-usage)._