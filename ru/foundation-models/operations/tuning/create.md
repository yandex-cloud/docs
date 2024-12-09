# Создать дообучение в {{ foundation-models-name }}

_Дообучение моделей по методу {{ lora }} находится на стадии [Preview](../../../overview/concepts/launch-stages.md) и предоставляется по запросу. Вы можете заполнить заявку в [консоли управления]({{ link-console-main }}link/foundation-models/)._

Этот пример показывает, как дообучить модель {{ gpt-lite }} по методу {{ lora }} в {{ foundation-models-name }}. 

## Перед началом работы {#before-begin}

Чтобы воспользоваться примерами:

{% list tabs group=programming_language %}

- SDK {#sdk}

  1. [Создайте](../../../iam/operations/sa/create.md) сервисный аккаунт и [назначьте](../../../iam/operations/sa/assign-role-for-sa.md) ему [роль](../../../foundation-models/security/index.md#languageModels-user) `ai.editor`.
  1. [Получите](../../../iam/operations/api-key/create.md) и сохраните API-ключ сервисного аккаунта.  
  1. С помощью менеджера пакетов [pip](https://pip.pypa.io/en/stable/) установите бета-версию библиотеки {{ ml-sdk-name }}:

    ```bash
    pip install yandex-cloud-ml-sdk --upgrade --pre
    ```

- cURL {#curl}

  1. {% include notitle [ai-before-beginning](../../../_includes/foundation-models/yandexgpt/ai-before-beginning.md) %}
  1. Установите [gRPCurl](https://github.com/fullstorydev/grpcurl).
  1. {% include [curl](../../../_includes/curl.md) %}

{% endlist %}

## Загрузите датасет {#create-dataset}

Подготовьте [данные для дообучения](../../concepts/tuning/index.md#generation-data) модели в формате [JSON Lines](https://jsonlines.org/) в кодировке [UTF-8](https://{{ lang }}.wikipedia.org/wiki/UTF-8). Вы можете разбить свои данные на два датасета для обучения и валидации, но это не обязательно. 

Создайте датасет для дообучения:

{% list tabs group=programming_language %}

- SDK {#sdk}

  1. Создайте файл `dataset-create.py` и добавьте в него код:

     {% include [sdk-dataset](../../../_includes/foundation-models/examples/dataset-sdk.md) %}

  1. Выполните созданный файл:

     ```bash
     python3 dataset-create.py
     ```

- cURL {#curl}

  1. Создайте объект датасет:
  
     ```bash
     grpcurl \
       -H "Authorization: Bearer $<IAM-токен>" \
       -d @ \
       llm.api.cloud.yandex.net:443 yandex.cloud.ai.dataset.v1.DatasetService/Create <<EOM
       {
         "folder_id": "<идентификатор_каталога>", 
         "name": "My awesome dataset", 
         "task_type": "TextToTextGeneration", 
         "upload_format": "jsonlines"
       }
       EOM
     ```

  1. Получите ссылку, по которой вы сможете загрузить данные в датасет. В поле `size_bytes` укажите размер файла с данными для дообучения в байтах. Размер датасета в примере 10 КБ: 
  
     ```bash
     grpcurl \
     -H "Authorization: Bearer $<IAM-токен>" \
     -d '{"dataset_id": "<идентификатор_датасета>", "size_bytes": 10240}' \
     llm.api.cloud.yandex.net:443 yandex.cloud.ai.dataset.v1.DatasetService/GetUploadDraftUrl
     ```

     В ответ вернется ссылка на созданный шаблон датасета.

  1. [Декодируйте](https://www.url-encode-decode.com/) encode-символы в ссылке, полученной на предыдущем шаге, и загрузите данные:
  
      ```bash 
      curl --request PUT --upload-file <путь_к_файлу> "<ссылка>"
      ```

  1. После окончания загрузки данных запустите валидацию датасета:
  
      ```bash
      grpcurl \
        -H "Authorization: Bearer $<IAM-токен>" \
        -d '{"dataset_id": "<идентификатор_датасета>", "size_bytes": 1024}' \
        llm.api.cloud.yandex.net:443 yandex.cloud.ai.dataset.v1.DatasetService/Validate
      ```

      В ответ вернется объект, содержащий информацию о статусе операции валидации и, при наличии, отчет о возникших ошибках.

{% endlist %}

## Запустите дообучение {#start-tuning}

{% list tabs group=programming_language %}

- cURL {#curl}
  
  1. Запустите дообучение:
  
     ```bash
     grpcurl \
       -H "Authorization: Bearer $<IAM-токен>" \
       -d @ \
       "llm.api.cloud.yandex.net:443 yandex.cloud.ai.tuning.v1.TuningService/Tune" <<EOM
       {
         "base_model_uri": "gpt://<идентификатор_каталога>/yandexgpt-lite/latest",
         "train_datasets": [{"dataset_id": "<идентификатор_датасета>", "weight": 1.0}],
         "name": "my first model",
         "text_to_text_completion": {}
       } 
     EOM
     ```

     В ответе сервис вернет объект [Operation](../../../api-design-guide/concepts/operation.md):

     ```json
     {"id":"f**********","description":"","createdAt":null,"createdBy":"","modifiedAt":null,"done":false,"metadata":null}
     ```

     Сохраните идентификатор (`id`) операции, полученный в ответе.

  1. Дообучение модели может занять до 1 суток в зависимости от объема датасета и загрузки системы. Чтобы проверить готовность дообучения, запросите статус операции:
  
     ```bash
     grpcurl \
       -H "Authorization: Bearer $(yc --profile=sandbox iam create-token)" \
       -d '{"operation_id": "ftnq****************"}' \
       llm.api.cloud.yandex.net:443 yandex.cloud.operation.OperationService/Get
     ```

     Если дообучение завершилось, объект Operation будет содержать идентификатор дообученной модели в поле `targetModelUri:

     ```json
     {
       "id": "ftnq****************",
       "createdAt": "2024-12-04T10:56:08Z",
       "modifiedAt": "2024-12-04T11:14:25Z",
       "done": true,
       "metadata": {
         "@type": "type.googleapis.com/yandex.cloud.ai.tuning.v1.TuningMetadata",
         "status": "COMPLETED",
         "tuningTaskId": "ftn7****************"
       },
       "response": {
         "@type": "type.googleapis.com/yandex.cloud.ai.tuning.v1.TuningResponse",
         "status": "COMPLETED",
         "targetModelUri": "<modelUri_дообученной_модели>",
         "tuningTaskId": "ftn7****************"
       }
     }
     ```

     Используйте идентификатор дообученной модели в качестве `modelURI`, чтобы отправлять запросы в дообученную модель.

{% endlist %}

