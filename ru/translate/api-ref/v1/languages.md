---
title: "Список поддерживаемых языков"
description: "Получение списка направлений перевода, поддерживаемых сервисом."
---

# Список поддерживаемых языков

{% include [speechkit-v1-disclaimer.md](../../../_includes/speechkit-v1-disclaimer.md) %}

Получение списка направлений перевода, поддерживаемых сервисом.

## Запрос {#request}

```
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
        {"language": <код языка>},
        ...
        {"language": <код языка>}
   ]
}
```


## Примеры {#examples}

### Пример запроса {#sample-request}

```httpget
export FOLDER_ID=<folder id>
export TOKEN=<IAM-token>
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


