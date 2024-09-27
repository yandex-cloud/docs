# Как начать работать с {{ yagpt-full-name }}

В этом разделе вы научитесь использовать нейросеть {{ yagpt-name }} для генерации текста в [синхронном режиме](../concepts/index.md#working-mode) без дополнения контекста. Другие примеры см. в разделе [Инструкции для работы с {{ yagpt-full-name }}](../operations/index.md#yandexgpt-api)

В [консоли управления]({{ link-console-main }}/link/foundation-models/yandexgpt) новым пользователям без [платежного аккаунта](../../billing/concepts/billing-account.md) доступно {{ gpt-freetier }} бесплатных запросов в час, чтобы вы могли максимально быстро и просто познакомиться с возможностями модели. Чтобы использовать API и иметь возможность увеличить [квоты](../concepts/limits.md) на потребление, [привяжите](../../billing/operations/pin-cloud.md) платежный аккаунт к своему облаку.

О стоимости использования {{ yagpt-full-name }} читайте в разделе [{#T}](../pricing.md).

## Перед началом работы {#before-begin}

Чтобы начать работать в {{ yandex-cloud }}:

1. Войдите в [консоль управления]({{ link-console-main }}). Если вы еще не зарегистрированы, перейдите в консоль управления и следуйте инструкциям.
1. В [сервисе {{ billing-name }}]({{ link-console-billing }}) убедитесь, что у вас подключен [платежный аккаунт](../../billing/concepts/billing-account.md), и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md#create_billing_account).
1. Если у вас еще нет [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder), [создайте его](../../resource-manager/operations/folder/create.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

  Для работы из консоли управления подготовительные действия не требуются.

- API {#api}

  Чтобы воспользоваться примерами запроса через API, установите [cURL](https://curl.haxx.se). 

  Для работы с API {{ yagpt-name }} необходимо аутентифицироваться со своего аккаунта:

  1. Получите IAM-токен: см. инструкцию для [аккаунта на Яндексе](../../iam/operations/iam-token/create.md) или [федеративного аккаунта](../../iam/operations/iam-token/create-for-federation.md).
  1. Получите [идентификатор каталога](../../resource-manager/operations/folder/get-id.md), на который у вашего аккаунта есть роль `{{ roles-yagpt-user }}` или выше.
  1. При обращении к {{ yagpt-full-name }} через API в каждом запросе передавайте полученные параметры:

     * в заголовке `Authorization` указывайте IAM-токен;
     * в заголовке `x-folder-id` указывайте идентификатор каталога.

     ```json
     Authorization: Bearer <IAM-токен> 
     x-folder-id: <идентификатор_каталога>
     ```

  Другие способы аутентификации в API описаны на странице [{#T}](../api-ref/authentication.md).

{% endlist %}

## Сгенерируйте текст {#generate-text}

{% include [logging](../../_includes/foundation-models/yandexgpt/logging-disclaimer.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, на который у вашего аккаунта есть роль `{{ roles-yagpt-user }}` или выше.
  1. В списке сервисов выберите **{{ foundation-models-name }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/dice-3.svg) **{{ ui-key.yacloud.yagpt.label_promt }}**.
  1. В блоке **{{ ui-key.yacloud.yagpt.label_instruction-text }}** опишите контекст запроса.
  1. В блоке **{{ ui-key.yacloud.yagpt.label_request-text }}** опишите свой запрос к модели.
  1. В поле **{{ ui-key.yacloud.yagpt.label_temperature-text }}** укажите значение от `0` до `1`, которое определяет вариативность ответа модели: чем выше значение, тем более непредсказуемым будет результат выполнения запроса.
  1. Нажмите кнопку **{{ ui-key.yacloud.yagpt.label_button-instruct-submit }}**. Ответ отобразится в правой части экрана.

- API {#api}

  1. Создайте файл с телом запроса (например, `prompt.json`):

     ```json
     {
       "modelUri": "gpt://<идентификатор_каталога>/yandexgpt-lite",
       "completionOptions": {
         "stream": false,
         "temperature": 0.6,
         "maxTokens": "2000"
       },
       "messages": [
         {
           "role": "system",
           "text": "Найди ошибки в тексте и исправь их"
         },
         {
           "role": "user",
           "text": "Ламинат подойдет для укладке на кухне или в детской комнате – он не боиться влаги и механических повреждений благодаря защитному слою из облицованных меламиновых пленок толщиной 0,2 мм и обработанным воском замкам."
         }
       ]
     }
     ```

     Где:

     {% include [api-parameters](../../_includes/foundation-models/yandexgpt/api-parameters.md) %}

  1. Отправьте запрос нейросети с помощью метода [completion](../text-generation/api-ref/TextGeneration/completion.md), выполнив команду:

     ```bash
     export FOLDER_ID=<идентификатор_каталога>
     export IAM_TOKEN=<IAM-токен>
     curl \
       --request POST \
       --header "Content-Type: application/json" \
       --header "Authorization: Bearer ${IAM_TOKEN}" \
       --header "x-folder-id: ${FOLDER_ID}" \
       --data "@prompt.json" \
       "https://llm.{{ api-host }}/foundationModels/v1/completion"
     ```

     Где:

     * `FOLDER_ID`— идентификатор каталога, на который у вашего аккаунта есть роль `{{ roles-yagpt-user }}` или выше.
     * `IAM_TOKEN` — IAM-токен, полученный [перед началом работы](#before-begin).

     В ответе сервис вернет сгенерированный текст:

     ```json
     {
       "result": {
         "alternatives": [
           {
             "message": {
               "role": "assistant",
               "text": "Ламинат подходит для укладки на кухне и в детской комнате. Он не боится влажности и механических повреждений, благодаря защитному слою, состоящему из меланиновых плёнок толщиной 0.2 мм, и обработанным воском замкам."
             },
             "status": "ALTERNATIVE_STATUS_TRUNCATED_FINAL"
           }
         ],
         "usage": {
           "inputTextTokens": "67",
           "completionTokens": "50",
           "totalTokens": "117"
         },
         "modelVersion": "06.12.2023"
       }
     }
     ```

{% endlist %}

#### Что дальше {#what-is-next}

* [Узнайте подробнее о сервисе](../concepts/index.md)
* [Прочитайте про способы аутентификации в API](../api-ref/authentication.md)
* [Посмотрите библиотеку промтов](../prompts/yandexgpt/index.md)