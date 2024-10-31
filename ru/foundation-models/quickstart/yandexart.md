# Как начать работать с {{ yandexart-name }}

В этом разделе вы научитесь использовать нейросеть {{ yandexart-name }} для генерации изображений.

В [консоли управления]({{ link-console-main }}/link/foundation-models/yandexart) новым пользователям без [платежного аккаунта](../../billing/concepts/billing-account.md) доступно {{ art-freetier }} бесплатных запросов в сутки. Чтобы использовать API и иметь возможность увеличить [квоты](../concepts/limits.md) на потребление, [привяжите](../../billing/operations/pin-cloud.md) платежный аккаунт к облаку.

## Перед началом работы {#before-begin}

Чтобы начать работать в {{ yandex-cloud }}:

1. Войдите в [консоль управления]({{ link-console-main }}). Если вы еще не зарегистрированы, перейдите в консоль управления и следуйте инструкциям.
1. В [сервисе {{ billing-name }}]({{ link-console-billing }}) убедитесь, что у вас подключен [платежный аккаунт](../../billing/concepts/billing-account.md), и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md#create_billing_account).
1. Если у вас еще нет [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder), [создайте его](../../resource-manager/operations/folder/create.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

  Для работы из консоли управления подготовительные действия не требуются.

- API {#api}

  Чтобы воспользоваться примерами запросов через API, установите:
  
  * [cURL](https://curl.haxx.se) для отправки API-запросов;
  * утилиту [jq](https://github.com/jqlang/jq) для работы с файлами JSON.

  Для работы с API {{ yandexart-name }} необходимо аутентифицироваться со своего аккаунта:

  1. Получите IAM-токен для [аккаунта на Яндексе](../../iam/operations/iam-token/create.md) или [федеративного аккаунта](../../iam/operations/iam-token/create-for-federation.md).
  1. Получите [идентификатор каталога](../../resource-manager/operations/folder/get-id.md), на который у вашего аккаунта есть роль `{{ roles-yaart-user }}` или выше. Идентификатор каталога понадобится, чтобы получить [URI модели](../concepts/yandexart/models.md).
  1. При обращении к {{ yandexart-name }} через API в заголовке `Authorization` каждого запроса указывайте IAM-токен;

     ```json
     x-folder-id: <идентификатор_каталога>
     ```

  Другие способы аутентификации в API описаны на странице [{#T}](../api-ref/authentication.md).

{% endlist %}

## Сгенерируйте изображение {#generate-text}

{% note info %}

Чтобы повышать качество генерируемых ответов, {{ yandexart-name }} логирует промты пользователей. Не передавайте в запросах чувствительную информацию и персональные данные.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, на который у вашего аккаунта есть роль `{{ roles-yaart-user }}` или выше.
  1. В списке сервисов выберите **{{ foundation-models-name }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/palette.svg) **{{ yandexart-name }}**.
  1. В поле ввода опишите изображение, которое вы хотите сгенерировать. Старайтесь использовать яркие образы, описывайте детали, указывайте стили, если хотите получить изображение определенного вида.
  1. [Параметр **Зерно**](../concepts/yandexart/index.md) оставьте случайным или укажите любое значение.
  1. Нажмите кнопку **Сгенерировать**. Генерация изображения займет некоторое время. Ответ отобразится в левой части экрана.

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

     {% include [api-parameters](../../_includes/foundation-models/yandexart/api-parameters.md) %}

  1. Отправьте запрос нейросети с помощью метода [ImageGenerationAsync.generate](../image-generation/api-ref/ImageGenerationAsync/generate.md), выполнив команду:

     ```bash
     curl \
       --request POST \
       --header "Authorization: Bearer <значение_IAM-токена>" \
       --data "@prompt.json" \
       "https://llm.{{ api-host }}/foundationModels/v1/imageGenerationAsync"
     ```

     Где:
 
     * `<значение_IAM-токена>` — IAM-токен, полученный для вашего аккаунта.
     * `prompt.json` — файл в формате JSON, содержащий параметры запроса.
     
     В ответе сервис вернет идентификатор вашего запроса:

     ```json
     {
     "id":"fbveu1sntj**********","description":"","createdAt":null,"createdBy":"","modifiedAt":null,"done":false,"metadata":null}
     ```

  1. Генерация изображения занимает некоторое время. Подождите 10 секунд и отправьте запрос, чтобы получить результат генерации. Если изображение готово, результат вернется в [кодировке Base64](https://en.wikipedia.org/wiki/Base64) и будет записан в файл `image.jpeg`.
  
     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer <значение_IAM-токена>" \
       https://llm.api.cloud.yandex.net:443/operations/<идентификатор_запроса> | \
       jq -r '.response | .image' | base64 -d > image.jpeg
     ```

     Где:

     * `<значение_IAM-токена>` — IAM-токен, полученный [перед началом работы](#before-begin).
     * `<идентификатор_запроса>` — значение поля `id`, полученное в ответе на запрос генерации.
     

     **Результат**: 

     ![succulent](../../_assets/yandexgpt/succulent.jpeg)

{% endlist %}

#### Что дальше {#what-is-next}

* [Узнайте подробнее о сервисе](../concepts/index.md)
* [Прочитайте про способы аутентификации в API](../api-ref/authentication.md)