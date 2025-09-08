---
title: Добавить расширение {{ foundation-models-full-name }}
description: Следуя данной инструкции, вы сможете добавить расширение {{ foundation-models-full-name }} с помощью конструктора спецификации.
---

# Добавить расширение x-yc-apigateway-integration:http для интеграции с API генерации текста {{ foundation-models-full-name }}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создали или хотите создать [API-шлюз](../../concepts/index.md).
    1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
    1. Выберите API-шлюз или нажмите кнопку **{{ ui-key.yacloud.serverless-functions.gateways.list.button_create }}**, чтобы создать новый.
    1. В поле **{{ ui-key.yacloud.serverless-functions.gateways.form.field_spec }}** нажмите значок ![image](../../../_assets/api-gateway/spec-constructor/cloud-yagpt.svg).
    1. Укажите в поле:

        {% include [common-spec-constructor](../../../_includes/api-gateway/common-spec-constructor.md) %}

        * **{{ ui-key.yc-serverless-apigw.dynamic-forms.service_account_id_name }}** — сервисный аккаунт для авторизации при обращении к [API генерации текста](../../../foundation-models/concepts/generation/index.md). Если у вас нет сервисного аккаунта, [создайте](../../../iam/operations/sa/create.md) его.

    1. В блоке **{{ ui-key.yc-serverless-apigw.dynamic-forms.foundation_models_model_uri_title }}** выберите модель и укажите:

        * Для модели `{{ ui-key.yc-serverless-apigw.dynamic-forms.foundation_models_model_uri_yagpt_label }}` — идентификатор каталога, который будет указан в URI модели генерации текста.
        * Для модели `{{ ui-key.yc-serverless-apigw.dynamic-forms.foundation_models_model_uri_datasphere_label }}` — идентификатор модели, дообученной в [{{ ml-platform-full-name }}](../../../datasphere/index.yaml).

    1. В блоке **{{ ui-key.yc-serverless-apigw.dynamic-forms.foundation_models_prompt_src_title }}** выберите источник промта и укажите:

        * Для источника `{{ ui-key.yc-serverless-apigw.dynamic-forms.foundation_models_prompt_src_query_option }}` — имя query-параметра, в котором будет передаваться промт для запроса к API генерации текста.
        * Для источника `{{ ui-key.yc-serverless-apigw.dynamic-forms.foundation_models_prompt_src_body_option }}` — имя поля тела запроса, в котором будет передаваться промт для запроса к API генерации текста.
    1. В блоке **{{ ui-key.yc-serverless-apigw.dynamic-forms.foundation_models_api_service_title }}** выберите сценарий использования модели и задайте параметры, соответствующие выбранному сценарию:

        * `{{ ui-key.yc-serverless-apigw.dynamic-forms.foundation_models_api_service_text_generation_hint }}`:

            * (Опционально) **{{ ui-key.yc-serverless-apigw.dynamic-forms.foundation_models_api_service_text_generation_temp_title }}** — определяет вариативность ответа модели: укажите значение от `0` до `1`. Чем выше температура, тем более креативными и случайными будут ответы модели. Значение по умолчанию — `0.3`.
            * (Опционально) **{{ ui-key.yc-serverless-apigw.dynamic-forms.foundation_models_api_service_text_generation_max_tokens_title }}** — максимальное число [токенов](../../../foundation-models/concepts/generation/tokens.md) генерации. По умолчанию `5`. Позволяет при необходимости ограничить объем ответа модели.

        * `{{ ui-key.yc-serverless-apigw.dynamic-forms.foundation_models_api_service_text_classification_hint }}`:

            * **{{ ui-key.yc-serverless-apigw.dynamic-forms.foundation_models_api_service_text_classification_task_desc_title }}** — текстовое описание задания для классификатора.
            * **{{ ui-key.yc-serverless-apigw.dynamic-forms.foundation_models_api_service_text_classification_labels_title }}** — список классов, к которым может относиться текст. Чтобы добавить класс, нажмите значок ![image](../../../_assets/console-icons/plus.svg).

                Чтобы получить корректные результаты, используйте осмысленные названия классов.

            * (Опционально) **{{ ui-key.yc-serverless-apigw.dynamic-forms.foundation_models_api_service_text_classification_samples_title }}** — примеры текстовых запросов для классов в формате `текстовый запрос:класс`. Чтобы добавить пример, нажмите значок ![image](../../../_assets/console-icons/plus.svg). Подробнее см. в разделе [{#T}](../../../foundation-models/concepts/classifier/index.md#few-shot).

    1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

{% include [constructor-result](../../../_includes/api-gateway/constructor-result.md) %}


## Требования к структуре входящего запроса {#requirements}

Чтобы API-шлюз корректно обрабатывал входящие запросы, для них должно быть задано значение заголовка `Content-Type: application/json`. Кроме этого:
* Если в качестве способа передачи промта выбрана опция `Query-параметр`, запрос должен содержать заданный в блоке **{{ ui-key.yc-serverless-apigw.dynamic-forms.foundation_models_prompt_src_title }}** query-параметр и его значение.

    Пример пути для вызова API-шлюза: `<путь_к_интеграции>?<заданный_query-параметр>=<содержимое_промта>`.
* Если в качестве способа передачи промта выбрана опция `Тело запроса`, тело запроса должно содержать поле, заданное в блоке **{{ ui-key.yc-serverless-apigw.dynamic-forms.foundation_models_prompt_src_title }}**, и его значение.
            
    Пример тела запроса: `{"<имя_поля_тела_запроса_>": "<содержимое_промта>"}`.