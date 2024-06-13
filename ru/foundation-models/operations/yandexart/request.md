# Сгенерировать изображение с помощью {{ yandexart-name }}

{% include notitle [preview-stage](../../../_includes/foundation-models/yandexgpt/preview.md) %}

С помощью нейросети {{ yandexart-name }} вы можете генерировать изображения в [асинхронном режиме](../../concepts/index.md#working-mode). В ответ на асинхронный запрос модель вернет [объект Operation](../../../api-design-guide/concepts/operation.md), содержащий идентификатор операции, по которому можно [отследить ее выполнение](../../../api-design-guide/concepts/operation.md#monitoring) и получить результат после того, как генерация завершится. Генерация результата в асинхронном режиме может занимать от пары минут до нескольких часов.

## Перед началом работы {#before-begin}

{% list tabs group=instructions %}

- API {#api}

  Чтобы воспользоваться примерами запросов через API, установите:
  
  * [cURL](https://curl.haxx.se) для отправки API-запросов;
  * утилиту [jq](https://github.com/jqlang/jq) для работы с файлами JSON.

  Получите данные для аутентификации в API, как описано на странице [{#T}](../../api-ref/authentication.md).

{% endlist %}

## Сгенерируйте изображение {#generate-text}

{% note info %}

Чтобы повышать качество генерируемых ответов, {{ yandexart-name }} логирует промты пользователей. Не передавайте в запросах чувствительную информацию и персональные данные.

{% endnote %}

{% list tabs group=instructions %}

- API {#api}

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
     curl --request POST \
       -H "Authorization: Bearer <значение_IAM-токена>" \
       -d "@prompt.json" \
       "https://llm.{{ api-host }}/foundationModels/v1/imageGenerationAsync"  
     ```

     Где:
 
     * `<значение_IAM-токена>` — IAM-токен вашего аккаунта.
     * `prompt.json` — файл в формате JSON, содержащий параметры запроса.
     
     В ответе сервис вернет объект Operation:

     ```json
     {
     "id":"fbveu1sntj**********","description":"","createdAt":null,"createdBy":"","modifiedAt":null,"done":false,"metadata":null}
     ```

     Сохраните идентификатор (`id`) операции, полученный в ответе.

  1. Генерация изображения может занять от нескольких секунд до нескольких часов. Подождите некоторое время и отправьте запрос по адресу: `https://llm.api.cloud.yandex.net:443/operations/<идентификатор_операции>`, чтобы получить результат генерации. Если изображение готово, результат вернется в [кодировке Base64](https://ru.wikipedia.org/wiki/Base64) и будет записан в файл `image.jpeg`. 
  
     ```bash
     curl -X GET -H "Authorization: Bearer <значение_IAM-токена>" https://llm.api.cloud.yandex.net:443/operations/<идентификатор_операции> | jq -r '.response | .image' | base64 -d > image.jpeg
     ```

     Где:

     * `<значение_IAM-токена>` — IAM-токен, полученный [перед началом работы](#before-begin).
     * `<идентификатор_операции>` — значение поля `id`, полученное в ответе на запрос генерации.

{% endlist %}
