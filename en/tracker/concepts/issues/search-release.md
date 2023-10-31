---
sourcePath: ru/tracker/api-ref/concepts/issues/search-release.md
---
# Освободить ресурсы просмотра прокрутки

Запрос позволяет освободить ресурсы после просмотра слепка поиска в запросе [{#T}](search-issues.md).

## Формат запроса {#section_rnm_x4j_p1b}

Перед выполнением запроса [получите доступ к API](../access.md).

Для освобождения результатов прокрутки используйте HTTP-запрос с методом `POST`:

```json
POST /v2/system/search/scroll/_clear
Host: {{ host }}
Authorization: OAuth <OAuth-токен>
{{ org-id }}

{
    "srollId": "scrollToken"
}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Параметры тела запроса" %}

**Обязательные параметры**

Параметр | Описание | Тип данных
----- | ----- | -----
scrollId | Идентификатор страницы результатов прокрутки. Значение идентификатора указывается из заголовка `X-Scroll-Id` ответа на запрос [{#T}](search-issues.md). | Строка
scrollToken | Токен, удостоверяющий принадлежность запроса текущему пользователю. Значение идентификатора указывается из заголовка `X-Scroll-Token` ответа на запрос [{#T}](search-issues.md). | Строка

В запросе необходимо передать все пары `"srollId": "scrollToken"` вашего запроса. Количество таких пар равно количеству страниц с результатами поискового запроса.

{% endcut %}

> Освобождение результатов прокрутки:
> 
> - Используется HTTP-метод POST.
> 
> ```
> POST /v2/system/search/scroll/_clear HTTP/1.1
> Host: {{ host }}
> Authorization: OAuth <OAuth-токен>
> {{ org-id }}
> 
> {
>   "cXVlcnlUaGVuRmV0Y2g7NjsyNDU5MzpmQ0gwd0JOM1RvQ2NPM3ZJRkpfTnFBOzI0NTkyOmZDSDB3Qk4zVG9DY08zdklGSl9OcUE7MjQ1OTU6ZkNIMHdCTjNUb0NjTzN2SUZKX05xQTsyNDU5NDpmQ0gwd0JOM1RvQ2NPM3ZJRkpfTnFBOzIwMzg2OkNfVnFZdHZCU3Y2VUowT0N6dGVGdFE7MjAzODE6U3RqelpvSWZTYmVFX2VZYWRBcXlzZzswOw==": "c44356850f446b88e5b5cd65a34a1409aaaa0ec1b93f8925d6b1c91da0fe3804:1450339762515",
>   "cXVlcnlUaGVuRmV0Y2g7NjsyMDQ0MzpTdGp6Wm9JZlNiZUVfZVlhZEFxeXNnOzIwNDQ1OkNfVnFZdHZCU3Y2VUowT0N6dGVGdFE7MjA0NDI6U3RqelpvSWZTYmVFX2VZYWRBcXlzZzsyMDQ0NDpDX1ZxWXR2QlN2NlVKME9DenRlRnRROzI0NjcxOmZDSDB3Qk4zVG9DY08zdklGSl9OcUE7MjQ2NzI6ZkNIMHdCTjNUb0NjTzN2SUZKX05xQTswOw==": "b8e1c56966f037d9c4e241af40d31dc80af186fa079d75022822b2be88f785dc:1450344216969"
> }
> ```

## Формат ответа {#section_xc3_53j_p1b}

{% list tabs %}

- Запрос выполнен успешно

  {% include [answer-200](../../../_includes/tracker/api/answer-200.md) %}

- Запрос выполнен с ошибкой

    Если запрос не был успешно обработан, API возвращает ответ с кодом ошибки:

    {% include [answer-error-400](../../../_includes/tracker/api/answer-error-400.md) %}

    {% include [answer-error-401](../../../_includes/tracker/api/answer-error-401.md) %}

    {% include [answer-error-403](../../../_includes/tracker/api/answer-error-403.md) %}

{% endlist %}