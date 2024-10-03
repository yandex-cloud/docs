---
title: Список поддерживаемых языков
description: Получение списка направлений перевода, поддерживаемых сервисом.
---

# Список поддерживаемых языков

{% include [speechkit-v1-disclaimer.md](../../../_includes/speechkit-v1-disclaimer.md) %}

Получение списка направлений перевода, поддерживаемых сервисом.

При работе с API Translate отправляйте данные для [аутентификации](/docs/translate/api-ref/authentication) в заголовке `Authorization` каждого запроса.

## Запрос {#request}

```http
POST https://translate.{{ api-host }}/translate/v1/languages
```

### Параметры в теле запроса {#parameters-in-the-request-body}

Максимальный размер тела POST-запроса 30 КБ.


Параметр | Описание
----- | -----
`folderId` | Обязательный параметр.<br/>Идентификатор вашего каталога.<br/>


## Ответ {#response}

Ответ возвращается в формате JSON.

```json
{
   "languages": [
        {"language": <код_языка>},
        ...
        {"language": <код_языка>}
   ]
}
```


## Примеры {#examples}

### Пример запроса {#sample-request}

```httpget
export FOLDER_ID=<идентификатор_каталога>
export TOKEN=<IAM-токен>
curl -X POST \
     -H "Authorization: Bearer ${TOKEN}" \
     -d "folderId=${FOLDER_ID}" \
     "https://translate.{{ api-host }}/translate/v1/languages"
```

### Пример ответа {#response-example}

Ответ возвращается в формате JSON.

```json
{
   "languages": [
        {"language": "az"},
        ...
        {"language": "ja"}
   ]
}
```


