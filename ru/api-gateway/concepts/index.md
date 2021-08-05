---
title: "Взаимосвязь ресурсов сервиса Yandex API Gateway"
description: "API-шлюз — это интерфейс взаимодействия с сервисами внутри Yandex.Cloud или в интернете. API-шлюз задается декларативно при помощи спецификации. Спецификация — это файл в формате JSON или YAML с описанием API-шлюза по стандарту OpenAPI 3.0. В сервисе API Gateway спецификация дополнена расширениями, которые вы можете использовать для интеграции с другими облачными платформами."

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответствует заголовку","Другое"]}
---


# Взаимосвязь ресурсов в {{ api-gw-name }}

_API-шлюз_ — это интерфейс взаимодействия с сервисами внутри {{ yandex-cloud }} или в интернете.

API-шлюз задается декларативно при помощи спецификации. Спецификация — это файл в формате JSON или YAML с описанием API-шлюза по стандарту  [OpenAPI 3.0](https://github.com/OAI/OpenAPI-Specification). В сервисе {{ api-gw-name}} спецификация дополнена расширениями, которые вы можете использовать для интеграции с другими облачными платформами.

Доступные расширения:
* [Статический ответ](../concepts/extensions/dummy.md).
* [Вызов функции](../concepts/extensions/cloud-functions.md).
* [Обращение по HTTP](../concepts/extensions/http.md).
* [Интеграция с Object Storage](../concepts/extensions/object-storage.md).
* [Интеграция с DataSphere](../concepts/extensions/datasphere.md).
* [Жадные параметры](../concepts/extensions/greedy-parameters.md).
* [Обобщенный HTTP-метод](../concepts/extensions/any-method.md).

## Использование доменов {#domains}

Сервис {{ api-gw-short-name }} интегрирован с системой управления доменами сервиса {{ certificate-manager-short-name }}. 

Вы можете использовать домены с подтвержденными правами при обращении к API. При этом для обеспечения TLS-соединения будет использован привязанный к домену сертификат.

Подробнее о доменах читайте в разделе [{#T}](../../certificate-manager/concepts/domains/services.md).

## Авторизация {#authorization}

{{ api-gw-short-name }} позволяет реализовать стандартные [механизмы аутентификации и авторизации](https://swagger.io/docs/specification/authentication/), которые предусмотрены спецификацией [OpenAPI 3.0](https://github.com/OAI/OpenAPI-Specification). На данный момент доступна [авторизация с помощью функции](../concepts/extensions/function-authorizer.md).
 
#### См. также {#see-also}

* [Обзор доступных расширений](extensions/index.md).