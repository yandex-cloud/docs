---
title: Интеграция с {{ marketplace-short-name }} {{ license-manager }} SaaS API
description: Вы научитесь взаимодействовать с API {{ license-manager }} SaaS для интеграции вашего SaaS приложения с {{ marketplace-full-name }}.
---

# Как начать работать с {{ marketplace-short-name }} {{ license-manager }} SaaS API

В этом разделе вы узнаете, как интегрировать SaaS-[продукт](../../../concepts/product.md) c {{ marketplace-full-name }} {{ license-manager }} SaaS API.

## Схема взаимодействия с API {#visualization}


![api-saas-interaction-diagram](../../../../_assets/marketplace/api-saas-interaction-diagram.svg)

На схеме:

1. Пользователь приобретает подписку на SaaS-продукт в {{ marketplace-short-name }}.
1. {{ marketplace-short-name }} передает пользователю ссылку на SaaS-продукт. URL-параметр `token` в передаваемой ссылке содержит JWT-токен.
    Адрес для перехода задается при [создании](../../../operations/create-new-version.md) версии продукта в {{ marketplace-short-name }} в поле **Ссылка на лендинг**.
1. Пользователь переходит по ссылке, в результате SaaS-продукту передается JWT-токен.
1. _Первый вариант аутентификации_: у пользователя уже есть учетная запись в SaaS-продукте. В этом случае он вводит свои учетные данные и входит в систему.
1. _Второй вариант аутентификации_: у пользователя нет учетной записи в SaaS-продукте. В этом случае он создает новую учетную запись и входит в систему.
1. SaaS-продукт отправляет в {{ marketplace-short-name }} запрос `ProductInstanceService.Claim`, содержащий полученный от пользователя токен и идентификатор ресурса в SaaS-продукте.
1. В результате {{ marketplace-short-name }} привязывает подписку к ресурсу и возвращает SaaS-продукту привязку (объект `Lock`).
1. SaaS-продукт сохраняет полученную привязку и начинает предоставлять доступ к ресурсу.
1. SaaS-продукт периодически [запрашивает](#get-lock) привязку в {{ marketplace-short-name }}.
1. {{ marketplace-short-name }} возвращает SaaS-продукту привязку до тех пор, пока подписка активна.

## Перед началом работы {#before-you-begin}

Чтобы начать работать c {{ marketplace-short-name }} {{ license-manager }} SaaS API:

1. [Станьте партнером](../../../quickstart.md#send-application) {{ marketplace-short-name }} и [зарегистрируйте](../../../operations/registration.md) аккаунт юридического лица.
1. В [кабинете партнера]({{ link-cloud-partners }}) создайте [продукт](../../../operations/create-product.md) и [тариф](../../../operations/create-tariff.md) с типом [Subscription](../../../concepts/subscription.md).
1. [Создайте](../../../../iam/operations/sa/create.md) сервисный аккаунт, от имени которого вы будете аутентифицироваться в API.
1. [Назначьте](../../../../iam/operations/sa/assign-role-for-sa.md#binding-role-organization) сервисному аккаунту роли `license-manager.saasSubscriptionSupervisor` и `marketplace.productInstances.saasSupervisor` на [профиль партнера](../../../concepts/publisher.md) или на отдельный [продукт](../../../concepts/product.md).
1. [Получите](../../../../iam/concepts/authorization/iam-token) IAM-токен для сервисного аккаунта, от имени которого вы будете аутентифицироваться в License Manager API.

Чтобы воспользоваться примерами, установите утилиты [cURL](https://curl.haxx.se) и [gRPCurl](https://github.com/fullstorydev/grpcurl) (при использовании [gRPC API](../api-ref/grpc/index.md)).


## Настройте интеграцию с API {#integrate}

Чтобы реализовать бизнес-логику продукта, самостоятельно доработайте код вашего приложения, [настроив интеграцию](../../../operations/license-manager-integration.md) с {{ license-manager }} SaaS API и Product Instance Manager API для проверки статуса и типа подписок:

1. Аутентифицируйтесь в {{ license-manager }} SaaS API и Product Instance Manager API от имени сервисного аккаунта. Для аутентификации используйте [IAM-токен](../../../../iam/concepts/authorization/iam-token.md).
1. Создайте страницу, на которую нужно перенаправить пользователя во время привязки купленной им подписки к сервису. На этой странице пользователь должен будет аутентифицироваться.

    При перенаправлении пользователя на такую страницу в строке запроса в параметре `token` передается JWT-токен (`token`), сгенерированный {{ yandex-cloud }}. JWT-токен действует 15 минут и содержит:

    * идентификатор подписки, которую купил пользователь (`license_instance_id`);
    * идентификатор шаблона подписки, который вы создали в кабинете партнера (`license_template_id`);
    * идентификатор запущенного экземпляра продукта пользователя (`product_instance_id`).

1. Пока действует JWT-токен, на созданной странице авторизуйте пользователя и сохраните уникальный идентификатор экземпляра запущенного продукта (`product_instance_id`).
1. Привяжите уникальный идентификатор экземпляра продукта пользователя (`product_instance_id`) к купленной пользователем подписке (`license_instance_id`).

    Привязать идентификатор к подписке можно с помощью метода REST API [Claim](../../../pim/saas/api-ref/ProductInstance/claim.md) для ресурса [ProductInstance](../../../pim/saas/api-ref/ProductInstance/index.md) или вызова gRPC API [ProductService/Claim](../../../pim/saas/api-ref/grpc/ProductInstance/claim.md).

    Передайте в запросе:

    * JWT-токен (`token`);
    * (опционально) уникальный идентификатор пользователя в вашей системе (`resource_id`);
    * (опционально) дополнительные метаданные (`resource_info`).

    В ответе вы получите идентификатор привязки (`lock_id`) — он находится в параметре `metadata`. Если в ответе ошибка, значит, подписка не привязалась к сервису и нужно попросить пользователя заново пройти все шаги.

1. Организуйте периодическую проверку того, что привязка подписки активна. Используйте для этого идентификатор привязки (`lock_id`), полученный на предыдущем шаге.

    Получить актуальную информацию о привязке подписки можно с помощью:
    * метода REST API [get](../api-ref/Lock/get.md) для ресурса [Lock](../api-ref/Lock/index.md) или вызова gRPC API [LockService/Get](../api-ref/grpc/Lock/get.md).

        В ответе должен возвращаться активный ресурс Lock, для которого `state = LOCKED`, а время окончания действия подписки `end_time` находится в будущем.

    * метода REST API [getByResourceID](../api-ref/Lock/getByResourceID.md) для ресурса [Lock](../api-ref/Lock/index.md) или вызова gRPC API [LockService/Get](../api-ref/grpc/Lock/getByResourceID.md).

        При успешном ответе должен возвращаться активный ресурс Lock, иначе — ошибка `NOT_FOUND`.

    {% note info %}

    Учитывайте, что пользователь может отвязать одну подписку от сервиса и привязать к нему другую. Ваш код должен корректно обрабатывать такие случаи.

    {% endnote %}

1. Организуйте бизнес-логику обработки подписок: учет потребления, ограничения по времени, количеству пользователей и т.п.


### Получите информацию о привязке {#get-lock}

Чтобы получить информацию о привязке, воспользуйтесь методом REST API [Get](../api-ref/Lock/get.md) для ресурса [Lock](../api-ref/Lock/index.md) или вызовом gRPC API [LockService/get](../api-ref/grpc/Lock/get.md):

{% list tabs group=instructions %}

- REST API {#api}

  ```bash
  curl \
    --request GET \
    --url 'https://marketplace.{{ api-host }}/marketplace/license-manager/saas/v1/locks/<идентификатор_привязки>' \
    --header 'Authorization: Bearer <IAM-токен>' \
    --header 'Content-Type: application/json'
  ```

  Где `<идентификатор_привязки>` — значение поля `lockId`.

- gRPC API {#grpc-api}

  ```bash
  grpcurl \
    -rpc-header "Authorization: Bearer <IAM-токен>" \
    -d '{
        "lockId": "<идентификатор_привязки>"
    }' \
    marketplace.{{ api-host }}:443 yandex.cloud.marketplace.licensemanager.saas.v1.LockService/Get
  ```

  Где `lockId` — значение поля `lockId`, полученное на предыдущем шаге.

{% endlist %}

В результате {{ marketplace-short-name }} вернет привязку (объект `Lock`), если подписка активна и привязана к экземпляру продукта пользователя.


### Отследите продление подписки {#track-subscription-renewal}

Чтобы отслеживать продление подписки, необходимо контролировать изменение значения поля `end_time` в экземпляре подписки.

Чтобы получить данные об экземпляре подписки, воспользуйтесь методом REST API [Get](../api-ref/Instance/get.md) для ресурса [Instance](../api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/Get](../api-ref/grpc/Instance/get.md):

{% list tabs group=instructions %}

- REST API {#api}

  ```bash
  curl \
    --request GET \
    --url 'https://marketplace.{{ api-host }}/marketplace/license-manager/saas/v1/instances/<идентификатор_экземпляра>' \
    --header 'Authorization: Bearer <IAM-токен>'
  ```

  Где `<идентификатор_экземпляра>` — идентификатор экземпляра подписки.

- gRPC API {#grpc-api}

  ```bash
  grpcurl \
    -rpc-header "Authorization: Bearer <IAM-токен>" \
    -d '{
        "instanceId": "<идентификатор_экземпляра>"
    }' \
  marketplace.{{ api-host }}:443 yandex.cloud.marketplace.licensemanager.saas.v1.InstanceService/Get
  ```

  Где `instanceId` — идентификатор экземпляра подписки.

{% endlist %}
