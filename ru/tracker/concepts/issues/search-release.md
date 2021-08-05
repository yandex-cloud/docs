---

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответствует заголовку","Другое"]}
---
# Освободить ресурсы просмотра прокрутки

Запрос позволяет освободить ресурсы после просмотра слепка поиска в запросе [{#T}](search-issues.md).

## Формат запроса {#section_rnm_x4j_p1b}

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

#### Параметры, передаваемые в теле запроса {#req-body-params}

- **srollId**

    Идентификатор страницы результатов прокрутки. Значение идентификатора указывается из заголовка `X-Scroll-Id` ответа запрос [{#T}](search-issues.md).

- **scrollToken**

    Токен, удостоверяющий принадлежность запроса текущему пользователю. Значение идентификатора указывается из заголовка `X-Scroll-Token` ответа на запрос [{#T}](search-issues.md).

В запросе необходимо передать все пары `"srollId": "scrollToken"` вашего запроса. Количество таких пар равно количеству страниц с результатами поискового запроса.

> Освобождение результатов прокрутки:
> 
> - Используется HTTP-метод POST.
> 
> ```
> POST /v2/system/search/scroll/_clear HTTP/1.1
> Host: {{ host }}
> Authorization: OAuth <OAuth-токен>
> {{ org-id }}
> Cache-Control: no-cache
> 
> {
>   "cXVlcnlUaGVuRmV0Y2g7NjsyNDU5MzpmQ0gwd0JOM1RvQ2NPM3ZJRkpfTnFBOzI0NTkyOmZDSDB3Qk4zVG9DY08zdklGSl9OcUE7MjQ1OTU6ZkNIMHdCTjNUb0NjTzN2SUZKX05xQTsyNDU5NDpmQ0gwd0JOM1RvQ2NPM3ZJRkpfTnFBOzIwMzg2OkNfVnFZdHZCU3Y2VUowT0N6dGVGdFE7MjAzODE6U3RqelpvSWZTYmVFX2VZYWRBcXlzZzswOw==": "c44356850f446b88e5b5cd65a34a1409aaaa0ec1b93f8925d6b1c91da0fe3804:1450339762515",
>   "cXVlcnlUaGVuRmV0Y2g7NjsyMDQ0MzpTdGp6Wm9JZlNiZUVfZVlhZEFxeXNnOzIwNDQ1OkNfVnFZdHZCU3Y2VUowT0N6dGVGdFE7MjA0NDI6U3RqelpvSWZTYmVFX2VZYWRBcXlzZzsyMDQ0NDpDX1ZxWXR2QlN2NlVKME9DenRlRnRROzI0NjcxOmZDSDB3Qk4zVG9DY08zdklGSl9OcUE7MjQ2NzI6ZkNIMHdCTjNUb0NjTzN2SUZKX05xQTswOw==": "b8e1c56966f037d9c4e241af40d31dc80af186fa079d75022822b2be88f785dc:1450344216969"
> }
> ```

## Формат ответа {#section_xc3_53j_p1b}

В случае успешно выполненного запроса в ответ приходит пустое сообщение с кодом 200.

## Возможные коды ответа {#section_otf_jrj_p1b}

200
:   Запрос выполнен успешно.

401
:   Пользователь не авторизован. Проверьте, были ли выполнены действия, описанные в разделе [{#T}](../access.md).

403
:   У вас не хватает прав на выполнение этого действия. Наличие прав можно перепроверить в интерфейсе {{ tracker-name }} — для выполнения действия при помощи API и через интерфейс требуются одинаковые права.

