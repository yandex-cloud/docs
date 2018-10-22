# Cписок поддерживаемых языков

Получение списка направлений перевода, поддерживаемых сервисом.

## Запрос {#request}

```
POST https://translate.api.cloud.yandex.net/translate/v1/languages
```

### Параметры в теле запроса

Максимальный размер тела POST-запроса 30 КБ.


Параметр | Описание
----- | -----
`folderId` | Обязательный параметр.<br/>Идентификатор вашего каталога.<br/>Подробнее о том, как узнать идентификатор каталога читайте в разделе [Авторизация в API](../concepts/auth.md).


## Ответ {#response}

Ответ возвращается в формате JSON.

```json
{
   "languages": [
        {"language": <код текста>},
        ...
        {"language": <код текста>}
   ]
} 
```


## Примеры {#examples}

### Пример запроса

```no-highlight
curl -X POST \
     -H "Authorization: Bearer <IAM-token>" \
     -d "folderId=<folder id>" \
     "https://translate.api.cloud.yandex.net/translate/v1/languages"
```

### Пример ответа

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


