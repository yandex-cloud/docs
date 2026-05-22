# HTTP-взаимодействия

Если вы используете [автоматическую инструментацию](auto.md), спаны создаются и атрибуты заполняются автоматически. При [ручной инструментации](manual.md) следуйте конвенциям, описанным ниже.

## Конвенция именования {#naming}

* **Клиентский спан** — `<метод>` если шаблон URL неизвестен, или `<метод> <url.template>` если известен, например `GET /users/{user_id}`.
* **Серверный спан** — `<метод> <http.route>`, например `GET /users/:user_id`.

Если клиент не использует шаблонизированные URL, имя спана содержит только метод. Если шаблон известен — он включается в имя через атрибут `url.template`. Серверный спан включает шаблонизированный маршрут (`/users/:user_id`), а не конкретный путь (`/users/321`). Подробнее см. в [спецификации именования HTTP-спанов](https://opentelemetry.io/docs/specs/semconv/http/http-spans/#name).

## Атрибуты {#attributes}

#|
|| Атрибут | Описание ||
|| `http.request_method` | HTTP-метод: `GET`, `POST` и др. ||
|| `http.response.status_code` | Код ответа: `200`, `404` и др. ||
|| `http.route` | Шаблонизированный маршрут на стороне сервера: `/users/:user_id` ||
|| `url.scheme` | Схема запроса: `http` или `https` ||
|| `url.full` | Полный URL запроса ||
|| `url.template` | Шаблонизированный URL на стороне клиента: `/users/{user_id}` ||
|| `server.address` | Имя хоста или IP-адрес целевого сервера ||
|| `server.port` | Порт целевого сервера ||
|| `client.address` | IP-адрес клиента ||
|#

## Пример {#example}

Сервис `order-service` запрашивает данные пользователя у `user-service` по HTTP:

#|
|| Атрибут | Клиентский спан | Серверный спан ||
|| Name | `GET` | `GET /users/:user_id` ||
|| Kind | `CLIENT` | `SERVER` ||
|| Status | `OK` | `OK` ||
|| `http.request_method` | `GET` | `GET` ||
|| `http.route` | — | `/users/:user_id` ||
|| `url.template` | `/users/{user_id}` | — ||
|| `http.response.status_code` | `200` | `200` ||
|| `url.scheme` | `https` | `https` ||
|| `url.full` | `https://user-service.example.com/users/321` | — ||
|| `server.address` | `user-service.example.com` | — ||
|| `server.port` | `443` | — ||
|| `client.address` | — | `192.0.2.4` ||
|#
