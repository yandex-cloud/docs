# Методы в API

Для управления ресурсами в [API {{ yandex-cloud }}](https://github.com/yandex-cloud/cloudapi) определен набор методов. Каждому gRPC-методу ставится в соответствие HTTP-глагол. Например, методу `List` соответствует глагол `GET`,  а методу `Create` — глагол `POST`. Соответствия HTTP-запросам задаются в описании методов, в аннотации [google.api.http](https://github.com/googleapis/googleapis/blob/master/google/api/http.proto).

В API есть два набора методов:

{% include [method-sets](../_includes/method-sets.md) %}
