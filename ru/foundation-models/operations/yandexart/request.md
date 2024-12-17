# Сгенерировать изображение с помощью {{ yandexart-name }}

С помощью нейросети {{ yandexart-name }} вы можете генерировать изображения в [асинхронном режиме](../../concepts/index.md#working-mode). В ответ на асинхронный запрос модель вернет [объект Operation](../../../api-design-guide/concepts/operation.md), содержащий идентификатор операции, по которому можно [отследить ее выполнение](../../../api-design-guide/concepts/operation.md#monitoring) и получить результат после того, как генерация завершится. Генерация результата в асинхронном режиме может занимать от пары минут до нескольких часов.

## Перед началом работы {#before-begin}

Чтобы воспользоваться примерами:

{% list tabs group=programming_language %}

- SDK {#sdk}

  {% include [yandexart-sdk-before-start](../../../_includes/foundation-models/yandexart/yandexart-sdk-before-start.md) %}

- cURL {#curl}

  1. Получите данные для аутентификации в API, как описано на странице [{#T}](../../api-ref/authentication.md).

      Чтобы использовать API {{ yandexart-name }}, назначьте [роль](../../security/index.md#imageGeneration-user) `ai.imageGeneration.user` пользователю или сервисному аккаунту, от имени которого вы будете аутентифицироваться.
  1. Установите утилиты:

      * [cURL](https://curl.haxx.se) для отправки API-запросов;
      * [jq](https://github.com/jqlang/jq) для работы с файлами JSON.

{% endlist %}

## Сгенерируйте изображение {#generate-text}

{% note info %}

Чтобы повышать качество генерируемых ответов, {{ yandexart-name }} логирует промты пользователей. Не передавайте в запросах чувствительную информацию и персональные данные.

{% endnote %}

{% list tabs group=programming_language %}

- SDK {#sdk}

  В данный код входят четыре независимые друг от друга примера, иллюстрирующие различные варианты использования интерфейса SDK:
  * Пример 1: простой запрос, состоящий из одного текстового описания.
  * Пример 2: запрос, состоящий из двух текстовых описаний, с сохранением результата в файл `./image.jpeg`.
  * Пример 3: запрос, состоящий из двух текстовых описаний с указанием веса.
  * Пример 4: сочетание запроса к [модели {{ yagpt-full-name }}](../../../foundation-models/concepts/yandexgpt/models.md) (для генерации расширенного промта) и запроса к модели {{ yandexart-name }} (для генерации изображения по этому промту).

  Код в примере не возвращает [объект Operation](../../../api-design-guide/concepts/operation.md), а дожидается выполнения моделями запросов и сохраняет результат в переменную `result`.

  1. Создайте файл `generate-image.py` и добавьте в него следующий код:

      {% include [yandexart-sdk-big](../../../_includes/foundation-models/examples/yandexart-sdk-big.md) %}

      Где:

      {% note info %}

      {% include [sdk-input-format](../../../_includes/foundation-models/sdk-input-format.md) %}

      {% endnote %}

      * `message1` — основная часть запроса на генерацию изображения.
      * `message2` — уточняющая часть запроса на генерацию изображения.

      {% include [sdk-code-legend](../../../_includes/foundation-models/examples/sdk-code-legend.md) %}
      
  1. Выполните созданный файл:

      ```bash
      python3 generate-image.py
      ```

      Результат выполнения:

      ```text
      ImageGenerationModelResult(model_version='', image_bytes=<889288 bytes>)
      ImageGenerationModelResult(model_version='', image_bytes=<1062632 bytes>)
      GPTModelResult(alternatives=(Alternative(role='assistant', text='Вот пример того, как может выглядеть запрос для модели YandexART:\n\n«Создай изображение красной кошки в стиле аниме Хаяо Миядзаки. Фон должен быть выполнен в мягких пастельных тонах с добавлением деталей, которые подчёркивают атмосферу волшебства и уюта».\n\n*Обратите внимание, что это лишь пример запроса, и вы можете адаптировать его под свои нужды.*', status=<AlternativeStatus.FINAL: 3>),), usage=Usage(input_text_tokens=31, completion_tokens=76, total_tokens=107), model_version='07.03.2024')
      ImageGenerationModelResult(model_version='', image_bytes=<1180073 bytes>)
      ```

- cURL {#curl}

  {% include [bash-windows-note-single](../../../_includes/translate/bash-windows-note-single.md) %}

  1. Создайте файл с телом запроса (например, `prompt.json`):

     ```json
     {
     "modelUri": "art://<идентификатор_каталога>/yandex-art/latest",
     "generationOptions": {
       "seed": "1863",
       "aspectRatio": {
          "widthRatio": "2",
          "heightRatio": "1"
        }
     },
     "messages": [
       {
         "weight": "1",
         "text": "узор из цветных пастельных суккулентов разных сортов, hd full wallpaper, четкий фокус, множество сложных деталей, глубина кадра, вид сверху"
       }
     ]
     }
     ```

     {% include [api-parameters](../../../_includes/foundation-models/yandexart/api-parameters.md) %}

  1. Отправьте запрос нейросети с помощью метода [ImageGenerationAsync.generate](../../image-generation/api-ref/ImageGenerationAsync/generate.md), выполнив команду:

     ```bash
     curl \
       --request POST \
       --header "Authorization: Bearer <значение_IAM-токена>" \
       --data "@prompt.json" \
       "https://llm.{{ api-host }}/foundationModels/v1/imageGenerationAsync"
     ```

     Где:

     * `<значение_IAM-токена>` — IAM-токен вашего аккаунта.
     * `prompt.json` — файл в формате JSON, содержащий параметры запроса.

     В ответе сервис вернет объект Operation:

     ```json
     {"id":"fbveu1sntj**********","description":"","createdAt":null,"createdBy":"","modifiedAt":null,"done":false,"metadata":null}
     ```

     Сохраните идентификатор (`id`) операции, полученный в ответе.

  1. Генерация изображения может занять от нескольких секунд до нескольких часов. Подождите некоторое время и отправьте запрос по адресу: `https://llm.api.cloud.yandex.net:443/operations/<идентификатор_операции>`, чтобы получить результат генерации. Если изображение готово, результат вернется в [кодировке Base64](https://ru.wikipedia.org/wiki/Base64) и будет записан в файл `image.jpeg`. 

     ```bash
     curl --request GET --header "Authorization: Bearer <значение_IAM-токена>" https://llm.api.cloud.yandex.net:443/operations/<идентификатор_операции> | jq -r '.response | .image' | base64 -d > image.jpeg
     ```

     Где:

     * `<значение_IAM-токена>` — IAM-токен, полученный [перед началом работы](#before-begin).
     * `<идентификатор_операции>` — значение поля `id`, полученное в ответе на запрос генерации.

{% endlist %}

#### См. также {#see-also}

* [{#T}](../../concepts/yandexart/index.md)
* Примеры работы с ML SDK на [GitHub](https://github.com/yandex-cloud/yandex-cloud-ml-sdk/tree/master/examples/sync/image_generation)