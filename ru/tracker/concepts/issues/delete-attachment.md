# Удалить файл

Запрос позволяет удалить прикрепленный файл.

## Формат запроса {#section_rnm_x4j_p1b}

Чтобы удалить файл, используйте HTTP-запрос с методом `DELETE`:

```
DELETE /{{ ver }}/issues/<issue-id>/attachments/<attachment-id>/
Host: {{ host }}
Authorization: OAuth <OAuth-токен>
{{ org-id }}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

#### Ресурс {#resource}

- **\<issue-id\>**

    Идентификатор или ключ задачи.

- **\<attachment-id\>**

    Уникальный идентификатор файла.

> Запрос на удаление файла, прикрепленного к задаче `JUNE-2`:
> 
> - Используется HTTP-метод DELETE.
> 
> 
> ```
> DELETE /v2/issues/JUNE-2/attachments/4159/ HTTP/1.1
> Host: {{ host }}
> Authorization: OAuth <OAuth-токен>
> {{ org-id }}
> ```

## Формат ответа {#section_xc3_53j_p1b}

В случае успешного выполнения запроса API возвращает ответ с кодом 204.

## Возможные коды ответа {#section_otf_jrj_p1b}

204
:   Запрос с методом DELETE успешно выполнен, объект удален.

404
:   Запрошенный объект не был найден. Возможно, вы указали неверное значение идентификатора или ключа объекта.

