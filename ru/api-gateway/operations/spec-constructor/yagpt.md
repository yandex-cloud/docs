---
title: "Добавить расширение {{ yagpt-name }}"
description: "Следуя данной инструкции, вы сможете добавить расширение {{ yagpt-name }} с помощью конструктора спецификации."
---

# Добавить расширение x-yc-apigateway-integration:http для интеграции с {{ yagpt-name }}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создали или хотите создать [API-шлюз](../../concepts/index.md).
    1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
    1. Выберите API-шлюз или нажмите кнопку **{{ ui-key.yacloud.serverless-functions.gateways.list.button_create }}**, чтобы создать новый.
    1. В поле **{{ ui-key.yacloud.serverless-functions.gateways.form.field_spec }}** нажмите значок ![image](../../../_assets/api-gateway/spec-constructor/cloud-yagpt.svg).
    1. Укажите в поле:

        {% include [common-spec-constructor](../../../_includes/api-gateway/common-spec-constructor.md) %}

        * **Сервисный аккаунт** — сервисный аккаунт для авторизации при обращении к [{{ yagpt-full-name }}](../../../foundation-models/concepts/yandexgpt/index.md). Если у вас нет сервисного аккаунта, [создайте](../../../iam/operations/sa/create.md) его.
        * **URI модели** — URI модели, которая будет использоваться для [генерации](../../../foundation-models/concepts/yandexgpt/models.md#yandexgpt-generation) или [классификации](../../../foundation-models/concepts/classifier/models.md).
        * **Действие** — тип действия и параметры, соответствующие этому типу действия:

            * `Генерация текста`:

                * (Опционально) **Температура** — определяет вариативность ответа модели: укажите значение от `0` до `1`. Чем выше температура, тем более креативными и случайными будут ответы модели. Значение по умолчанию — `0.3`.
                * (Опционально) **Количество токенов** — максимальное число [токенов](../../../foundation-models/concepts/yandexgpt/tokens.md) генерации. По умолчанию `5`. Позволяет при необходимости ограничить объем ответа модели.

            * `Классификация текста`:

                * **Описание задания** — текстовое описание задания для классификатора.
                * **Классы** — список классов, к которым может относиться текст. Чтобы добавить класс, нажмите значок ![image](../../../_assets/console-icons/plus.svg).
                    Чтобы получить корректные результаты, используйте осмысленные названия классов.

                * (Опционально) **Примеры запросов** — примеры текстовых запросов для классов в формате `текстовый запрос:класс`. Чтобы добавить пример, нажмите значок ![image](../../../_assets/console-icons/plus.svg). Подробнее см. в разделе [{#T}](../../../foundation-models/concepts/classifier/index.md#few-shot).

    1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

{% include [constructor-result](../../../_includes/api-gateway/constructor-result.md) %}


## Требования к структуре входящего запроса {#requirements}

Чтобы API-шлюз корректно обрабатывал входящие запросы, для них должно быть задано значение заголовка `Content-Type: application/json`, а тело запроса должно иметь следующую структуру:

* Генерация текста — `{"message": "<текстовый_запрос_к_модели>"}`.
* Классификация текста — `{"text": "<текст_который_нужно_классифицировать>"}`.