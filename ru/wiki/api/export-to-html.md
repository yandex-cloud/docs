# Экспортировать страницу в HTML

Запрос позволяет  экспортировать текст страницы в формате HTML. 

С помощью запроса вы можете получить текст страницы и разместить его на другом веб-ресурсе. Например, на {{ wiki-name }} написана инструкция по работе с сервисом, ее можно отобразить на странице сервиса.

## Доступ к API {#access}

Перед выполнением запроса получите доступ к API {{ wiki-name }}. Для этого перейдите по [ссылке](https://oauth.yandex-team.ru/authorize?response_type=token&client_id=5f671d781aca402ab7460fde4050267b) и скопируйте OAuth-токен для авторизации.

## Формат запроса {#query}

Для экспорта текста страницы в формате HTML используйте HTTP-запрос с методом `GET`:

```json
GET /.html?page=/<section-name>/<page-name>/
Host: https://wiki.yandex-team.ru
Authorization: OAuth <ваш OAuth-токен>
```

{% cut "Ресурс" %}

Параметр | Описание | Тип данных
----- | ----- | -----
\<page-name\> | Адрес страницы относительно корневого раздела {{ wiki-name }}. Например: `/mySection/myPage/`  | Строка

{% endcut %}

## Формат ответа {#answer}

{% list tabs %}

- Запрос выполнен успешно

    {% include [answer-200](../_includes/tracker/api/answer-200.md) %}

    Тело ответа содержит страницу в формате HTML с загруженными динамическими блоками.

- Запрос выполнен с ошибкой

    Если запрос не был успешно обработан, API возвращает ответ с кодом ошибки:

    {% include [answer-error-400](../_includes/tracker/api/answer-error-400.md) %}

    {% include [answer-error-404](../_includes/tracker/api/answer-error-404.md) %}

    {% include [answer-error-500](../_includes/tracker/api/answer-error-500.md) %}

    {% include [answer-error-503](../_includes/tracker/api/answer-error-503.md) %}

{% endlist %}