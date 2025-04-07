---
title: Методы в API
description: Из статьи вы узнаете про методы в API {{ yandex-cloud }} и их виды.
---

# Методы в API

Для управления ресурсами в [API {{ yandex-cloud }}](https://github.com/yandex-cloud/cloudapi) определен набор методов. Каждому [gRPC-вызову](../../glossary/grpc) ставится в соответствие HTTP-метод. Например, вызову `List` соответствует метод `GET`,  а вызову `Create` — метод `POST`. Соответствия HTTP-запросам задаются в описании методов, в аннотации [google.api.http](https://github.com/googleapis/googleapis/blob/master/google/api/http.proto).

В API есть два набора методов:

{% include [method-sets](../_includes/method-sets.md) %}
