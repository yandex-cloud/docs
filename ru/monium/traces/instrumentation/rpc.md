# RPC-вызовы

Если вы используете [автоматическую инструментацию](auto.md), спаны для RPC-вызовов создаются и атрибуты заполняются автоматически. При [ручной инструментации](manual.md) следуйте конвенциям, описанным ниже.

## Конвенция именования {#naming}

Имя спана формируется как `<package>.<service>/<method>`, например `grpc.users.UserService/GetUserInfo`. Если имя пакета отсутствует или неизвестно, часть `<package>.` опускается. Подробнее см. в [спецификации именования RPC-спанов](https://opentelemetry.io/docs/specs/semconv/rpc/rpc-spans/#span-name).

## Атрибуты {#attributes}

#|
|| Атрибут | Описание ||
|| `rpc.system` | Тип RPC-системы: `grpc`, `java_rmi`, `dotnet_wcf` и др. ||
|| `rpc.service` | Имя сервиса: `UserService` ||
|| `rpc.method` | Имя метода: `GetUserInfo` ||
|| `rpc.grpc.status_code` | Код статуса gRPC: `0` (OK), `2` (UNKNOWN) и др. ||
|| `server.address` | Имя хоста или IP-адрес целевого сервера ||
|| `server.port` | Порт целевого сервера ||
|| `client.address` | IP-адрес клиента ||
|| `client.port` | Порт клиента ||
|#

Полный перечень атрибутов см. в [спецификации OpenTelemetry для RPC-спанов](https://opentelemetry.io/docs/specs/semconv/rpc/rpc-spans/).

## Пример {#example}

Сервис `order-service` запрашивает данные пользователя у `user-service` по gRPC:

#|
|| Атрибут | Клиентский спан | Серверный спан ||
|| Name | `grpc.users.UserService/GetUserInfo` | `grpc.users.UserService/GetUserInfo` ||
|| Kind | `CLIENT` | `SERVER` ||
|| Status | `OK` | `OK` ||
|| `rpc.system` | `grpc` | `grpc` ||
|| `rpc.service` | `UserService` | `UserService` ||
|| `rpc.method` | `GetUserInfo` | `GetUserInfo` ||
|| `rpc.grpc.status_code` | `0` | `0` ||
|| `server.address` | `grpc.users.example.com` | — ||
|| `server.port` | `443` | — ||
|| `client.address` | — | `10.1.2.80` ||
|| `client.port` | — | `65123` ||
|#
