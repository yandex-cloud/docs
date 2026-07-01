# Использование Yandex API Gateway для настройки синтеза речи в Yandex SpeechKit


С помощью serverless-технологий можно создать собственную интеграцию с сервисами Yandex Cloud.

Пользовательская интеграция, создаваемая в данном руководстве, представляет собой [API-шлюз](../concepts/index.md), сконфигурированный по стандарту [OpenAPI 3.0](https://github.com/OAI/OpenAPI-Specification) c [HTTP-интеграцией](../concepts/extensions/http.md). 

Запросы на синтез речи от пользователей поступают в API-шлюз, который с помощью HTTP-интеграции вызывает [API SpeechKit](https://aistudio.yandex.ru/docs/ru/speechkit/concepts/api) и получает от SpeechKit синтезированную речь.

Чтобы настроить синтез речи SpeechKit с помощью API-шлюза Yandex API Gateway:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте сервисный аккаунт](#create-service-account).
1. [Создайте API-шлюз](#create-gateway).
1. [Проверьте результат](#check-out).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Перед началом работы {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки создаваемой инфраструктуры входит:

* плата за количество запросов к API-шлюзу и исходящий трафик ([тарифы Yandex API Gateway](../../api-gateway/pricing.md));
* плата за использование SpeechKit ([тарифы SpeechKit](https://aistudio.yandex.ru/docs/ru/speechkit/pricing)).


## Создайте сервисный аккаунт {#create-service-account}

[Создайте](../../iam/operations/sa/create.md) сервисный аккаунт `speechkit-sa` с [ролью](https://aistudio.yandex.ru/docs/ru/speechkit/security/index#ai-speechkit-tts-user) `ai.speechkit-tts.user` на [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы создаете инфраструктуру:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором хотите создать сервисный аккаунт.
  1. Перейдите в сервис **Identity and Access Management**.
  1. Нажмите кнопку **Создать сервисный аккаунт**.
  1. Введите имя сервисного аккаунта: `speechkit-sa`.
  1. Нажмите ![image](../../_assets/console-icons/plus.svg) **Добавить роль** и выберите роль `ai.speechkit-tts.user`.
  1. Нажмите кнопку **Создать**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Создайте сервисный аккаунт `speechkit-sa`:

      ```bash
      yc iam service-account create speechkit-sa
      ```

      Результат:

      ```
      id: nfersamh4sjq********
      folder_id: b1gc1t4cb638********
      created_at: "2023-09-21T10:36:29.726397755Z"
      name: speechkit-sa
      ```

      Сохраните идентификатор сервисного аккаунта `speechkit-sa` (`id`) и каталога, в котором его создали (`folder_id`).

      Подробнее о команде `yc iam service-account create` читайте в [справочнике CLI](../../cli/cli-ref/iam/cli-ref/service-account/create.md).

  1. Назначьте сервисному аккаунту роль `ai.speechkit-tts.user` на каталог, указав сохраненные ранее идентификаторы каталога и сервисного аккаунта:

      ```bash
      yc resource-manager folder add-access-binding <идентификатор_каталога> \
        --role ai.speechkit-tts.user \
        --subject serviceAccount:<идентификатор_сервисного_аккаунта>
      ```

      Подробнее о команде `yc resource-manager folder add-access-binding` читайте в [справочнике CLI](../../cli/cli-ref/resource-manager/cli-ref/folder/add-access-binding.md).

- API {#api}

  Чтобы создать сервисный аккаунт, воспользуйтесь методом [create](../../iam/api-ref/ServiceAccount/create.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/Create](../../iam/api-ref/grpc/ServiceAccount/create.md).

  Чтобы назначить сервисному аккаунту роль `ai.speechkit-tts.user` на каталог, воспользуйтесь методом [setAccessBindings](../../iam/api-ref/ServiceAccount/setAccessBindings.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/SetAccessBindings](../../iam/api-ref/grpc/ServiceAccount/setAccessBindings.md).

{% endlist %}


## Создайте API-шлюз {#create-gateway}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором необходимо создать API-шлюз.
  1. Перейдите в сервис **API Gateway**.
  1. Нажмите кнопку **Создать API-шлюз**.
  1. В поле **Имя** введите `speechkit-api-gw`.
  1. В блок **Спецификация** добавьте следующую спецификацию, указав [идентификатор](../../iam/operations/sa/get-id.md) сервисного аккаунта `speechkit-sa` в параметре `service_account_id`:

      ```yaml
      openapi: 3.0.0
      info:
        title: Sample API
        version: 1.0.0
      
      paths:
        /synthesis:
          post:
            requestBody:
              description: "/synthesis"
              content:
                application/json:
                  schema:
                    type: object
                    x-yc-schema-mapping:
                      type: static
                      template:
                        text: "${.text}"
                        hints:
                          - voice: "lera"
                          - role: "friendly"
                          - audioTemplate:
                              audio:
                                audioSpec:
                                  containerAudio:
                                    containerAudioType: "MP3"
            responses:
              200:
                description: "/synthesis"
                content:
                  application/json:
                    schema:
                      type: object
                      x-yc-schema-mapping:
                        type: static
                        template:
                          data: "${.result.audioChunk.data}"
            x-yc-apigateway-integration:
              http_method: post
              type: http
              url: https://tts.api.cloud.yandex.net/tts/v3/utteranceSynthesis
              service_account_id: "<идентификатор_сервисного_аккаунта>"
      ```

  1. Нажмите кнопку **Создать**.
  1. Подождите, пока статус созданного API-шлюза изменится на `running`, и нажмите на строку с именем API-шлюза.
  1. В открывшемся окне скопируйте значение поля **Служебный домен**. Оно понадобится для проверки работы API-шлюза.

- CLI {#cli}

  1. Сохраните следующую спецификацию в файл `speechkit-gw.yaml`, указав [идентификатор](../../iam/operations/sa/get-id.md) сервисного аккаунта `speechkit-sa` в параметре `service_account_id`:

      ```yaml
      openapi: 3.0.0
      info:
        title: Sample API
        version: 1.0.0
      
      paths:
        /synthesis:
          post:
            requestBody:
              description: "/synthesis"
              content:
                application/json:
                  schema:
                    type: object
                    x-yc-schema-mapping:
                      type: static
                      template:
                        text: "${.text}"
                        hints:
                          - voice: "lera"
                          - role: "friendly"
                          - audioTemplate:
                              audio:
                                audioSpec:
                                  containerAudio:
                                    containerAudioType: "MP3"
            responses:
              200:
                description: "/synthesis"
                content:
                  application/json:
                    schema:
                      type: object
                      x-yc-schema-mapping:
                        type: static
                        template:
                          data: "${.result.audioChunk.data}"
            x-yc-apigateway-integration:
              http_method: post
              type: http
              url: https://tts.api.cloud.yandex.net/tts/v3/utteranceSynthesis
              service_account_id: "<идентификатор_сервисного_аккаунта>"
      ```

  1. Выполните команду:

     ```bash
     yc serverless api-gateway create \
       --name speechkit-api-gw \
       --spec=speechkit-gw.yaml
     ```

     Где:
     * `--name` — имя API-шлюза.
     * `--spec` — путь к файлу со спецификацией.

     Результат:

     ```text
     done (2s)
     id: d5ddbmungf72********
     folder_id: b1gt6g8ht345********
     created_at: "2024-08-19T18:58:32.101Z"
     name: speechkit-api-gw
     status: ACTIVE
     domain: d5dm1lba80md********.i9******.apigw.yandexcloud.net
     connectivity: {}
     log_options:
       folder_id: b1gt6g8ht345********
     execution_timeout: 300s
     ```

  Сохраните служебный домен созданного API-шлюза (значение поля `domain`). Он понадобится для проверки работы API-шлюза.

  Подробнее о команде `yc serverless api-gateway create` читайте в [справочнике CLI](../../cli/cli-ref/serverless/cli-ref/api-gateway/create.md).

- API {#api}

  Чтобы создать API-шлюз, воспользуйтесь методом REST API [create](../apigateway/api-ref/ApiGateway/create.md) для ресурса [ApiGateway](../apigateway/api-ref/ApiGateway/index.md) или вызовом gRPC API [ApiGatewayService/Create](../apigateway/api-ref/grpc/ApiGateway/create.md).

{% endlist %}


## Проверьте результат {#check-out}

{% note info %}

Чтобы проверить работу API-шлюза, вам потребуются утилиты [cURL](https://curl.haxx.se) и [jq](https://github.com/jqlang/jq).

{% endnote %}

Отправьте запрос к API-шлюзу, указав сохраненное ранее значение служебного домена:

```bash
curl --verbose \
  https://<служебный_домен>/synthesis \
  --data '{"text": "Привет! В С+ерверлесс Апи Гейтв+эй появилась новая функция - трансформация Аш Ти Ти Пи тела запроса или ответа!"}' \
  | jq -r  '.data' | while read chunk; do base64 -d <<< "$chunk" >> audio.mp3; done
```

В результате выполнения команды синтезированная речь будет сохранена в файл `audio.mp3` в текущей директории. Прослушать созданный файл можно в браузере, например в [Яндекс Браузере](https://browser.yandex.ru) или [Mozilla Firefox](http://www.mozilla.org).

Подробнее о формате передаваемого в параметре `-d` текста смотрите в [документации Yandex SpeechKit](https://aistudio.yandex.ru/docs/ru/speechkit/tts/request).


## Как удалить созданные ресурсы {#clear-out}

Если созданные ресурсы вам больше не нужны:

* [Удалите API-шлюз](../operations/api-gw-delete.md).
* [Удалите сервисный аккаунт](../../iam/operations/sa/delete.md).