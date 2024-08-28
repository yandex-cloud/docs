# Использование {{ api-gw-full-name }} для настройки синтеза речи в {{ speechkit-full-name }}

С помощью serverless-технологий можно создать собственную интеграцию с сервисами {{ yandex-cloud }}.

Пользовательская интеграция, создаваемая в данном руководстве, представляет собой [API-шлюз](../../api-gateway/concepts/index.md), сконфигурированный по стандарту [OpenAPI 3.0](https://github.com/OAI/OpenAPI-Specification) c [HTTP-интеграцией](../../api-gateway/concepts/extensions/http.md). 

Запросы на синтез речи от пользователей поступают в API-шлюз, который с помощью HTTP-интеграции вызывает [API {{ speechkit-name }}](../../speechkit/concepts/api.md) и получает от {{ speechkit-name }} синтезированную речь.

Чтобы настроить синтез речи {{ speechkit-name }} с помощью API-шлюза {{ api-gw-full-name }}:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте сервисный аккаунт](#create-service-account).
1. [Создайте API-шлюз](#create-gateway).
1. [Проверьте результат](#check-out).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки создаваемой инфраструктуры входит:

* плата за количество запросов к API-шлюзу и исходящий трафик (см. [тарифы {{ api-gw-full-name }}](../../api-gateway/pricing.md));
* плата за использование {{ speechkit-name }} (см. [тарифы {{ speechkit-name }}](../../speechkit/pricing.md)).


## Создайте сервисный аккаунт {#create-service-account}

[Создайте](../../iam/operations/sa/create.md) сервисный аккаунт `speechkit-sa` с [ролью](../../speechkit/security/index.md#ai-speechkit-tts-user) `ai.speechkit-tts.user` на [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы создаете инфраструктуру:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать сервисный аккаунт.
  1. Перейдите на вкладку **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. Введите имя сервисного аккаунта: `speechkit-sa`.
  1. Нажмите ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** и выберите роль `ai.speechkit-tts.user`.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

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

      Подробнее о команде `yc iam service-account create` читайте в [справочнике CLI](../../cli/cli-ref/managed-services/iam/service-account/create.md).

  1. Назначьте сервисному аккаунту роль `ai.speechkit-tts.user` на каталог, указав сохраненные ранее идентификаторы каталога и сервисного аккаунта:

      ```bash
      yc resource-manager folder add-access-binding <идентификатор_каталога> \
        --role ai.speechkit-tts.user \
        --subject serviceAccount:<идентификатор_сервисного_аккаунта>
      ```

      Подробнее о команде `yc resource-manager folder add-access-binding` читайте в [справочнике CLI](../../cli/cli-ref/managed-services/resource-manager/folder/add-access-binding.md).

- API {#api}

  Чтобы создать сервисный аккаунт, воспользуйтесь методом [create](../../iam/api-ref/ServiceAccount/create.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/Create](../../iam/api-ref/grpc/service_account_service.md#Create).

  Чтобы назначить сервисному аккаунту роль `ai.speechkit-tts.user` на каталог, воспользуйтесь методом [setAccessBindings](../../iam/api-ref/ServiceAccount/setAccessBindings.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/SetAccessBindings](../../iam/api-ref/grpc/service_account_service.md#SetAccessBindings).

{% endlist %}


## Создайте API-шлюз {#create-gateway}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором необходимо создать API-шлюз.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.gateways.list.button_create }}**.
  1. В поле **{{ ui-key.yacloud.serverless-functions.gateways.form.field_name }}** введите `speechkit-api-gw`.
  1. В блок **{{ ui-key.yacloud.serverless-functions.gateways.form.field_spec }}** добавьте следующую спецификацию, указав [идентификатор](../../iam/operations/sa/get-id.md) сервисного аккаунта `speechkit-sa` в параметре `service_account_id`:

      {% include [api-gw-yaml-spec](../_tutorials_includes/speechkit-integrarion-via-agi-gw/api-gw-yaml-spec.md) %}

  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.gateways.form.button_create-gateway }}**.
  1. Подождите, пока статус созданного API-шлюза изменится на `running`, и нажмите на строку с именем API-шлюза.
  1. В открывшемся окне скопируйте значение поля **{{ ui-key.yacloud.serverless-functions.gateways.overview.label_domain }}**. Оно понадобится для проверки работы API-шлюза.

- CLI {#cli}

  1. Сохраните следующую спецификацию в файл `speechkit-gw.yaml`, указав [идентификатор](../../iam/operations/sa/get-id.md) сервисного аккаунта `speechkit-sa` в параметре `service_account_id`:

      {% include [api-gw-yaml-spec](../_tutorials_includes/speechkit-integrarion-via-agi-gw/api-gw-yaml-spec.md) %}

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
     domain: d5ddbmungf72********.apigw.yandexcloud.net
     connectivity: {}
     log_options:
       folder_id: b1gt6g8ht345********
     execution_timeout: 300s
     ```

  Сохраните служебный домен созданного API-шлюза (значение поля `domain`). Он понадобится для проверки работы API-шлюза.

  Подробнее о команде `yc serverless api-gateway create` читайте в [справочнике CLI](../../cli/cli-ref/managed-services/serverless/api-gateway/create.md).

- API {#api}

  Чтобы создать API-шлюз, воспользуйтесь методом REST API [create](../../api-gateway/apigateway/api-ref/ApiGateway/create.md) для ресурса [ApiGateway](../../api-gateway/apigateway/api-ref/ApiGateway/index.md) или вызовом gRPC API [ApiGatewayService/Create](../../api-gateway/apigateway/api-ref/grpc/apigateway_service.md#Create).

{% endlist %}


## Проверьте результат {#check-out}

{% note info %}

Чтобы проверить работу API-шлюза, вам потребуются утилиты [cURL](https://curl.haxx.se) и [jq](https://github.com/jqlang/jq).

{% endnote %}

Отправьте запрос к API-шлюзу, указав сохраненное ранее значение служебного домена:

```bash
curl -v \
  https://<служебный_домен>/synthesis \
  -d '{"text": "Привет! В С+ерверлесс Апи Гейтв+эй появилась новая функция - трансформация Аш Ти Ти Пи тела запроса или ответа!"}' \
  | jq -r  '.data' | while read chunk; do base64 -d <<< "$chunk" >> audio.mp3; done
```

В результате выполнения команды синтезированная речь будет сохранена в файл `audio.mp3` в текущей директории. Прослушать созданный файл можно в браузере, например в [Яндекс Браузере](https://browser.yandex.ru) или [Mozilla Firefox](http://www.mozilla.org).

Подробнее о формате передаваемого в параметре `-d` текста см. в [документации {{ speechkit-full-name }}](../../speechkit/tts/request.md).


## Как удалить созданные ресурсы {#clear-out}

Если созданные ресурсы вам больше не нужны:

* [Удалите API-шлюз](../../api-gateway/operations/api-gw-delete.md).
* [Удалите сервисный аккаунт](../../iam/operations/sa/delete.md).