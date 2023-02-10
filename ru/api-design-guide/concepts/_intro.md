# Описание архитектуры API

API {{ yandex-cloud }} спроектированы на основе механизма [gRPC](https://grpc.io/docs/). Для описания методов и структуры данных в API используется [Protocol Buffers](https://developers.google.com/protocol-buffers/docs/proto3) (proto 3).

Для взаимодействия с API в {{ yandex-cloud }} включена поддержка JSON REST.
 Когда клиент отправляет HTTP-запросы в API, сервис преобразует входящие запросы
 в gRPC-сообщения. Когда gRPC-ответ будет готов, сервис преобразует его 
 в HTTP-ответ и отправяет его клиенту. Для преобразования REST в gRPC используется механизм [gRPC-JSON transcoder](https://www.envoyproxy.io/docs/envoy/v1.5.0/api-v1/http_filters/grpc_json_transcoder_filter).  

Как в REST, так и в gRPC API используется ресурсо-ориентированный подход.
Принципы, которые действуют в API, описаны в разделе [Основные концепции API](general.md).


