# Метод upload

Загружает конфигурацию хостинга статического сайта для корзины.


## Запрос {#request}

```
PUT /{bucket}?website HTTP/1.1
```

### Path параметры {#path-parameters}

Параметр | Описание
----- | -----
`bucket` | Имя корзины.


### Query параметры {#request-params}

Параметр | Описание
----- | -----
`website` | Обязательный параметр для обозначения типа операции.


### Заголовки {#request-headers}

Используйте в запросе необходимые [общие заголовки](../common-request-headers.md).

### Схема данных {#request-scheme}

Корзину можно сконфигурировать:

- Как сайт.
- Для редиректа всех запросов.

Соответственно конфигурации будут иметь различный набор элементов.

```
<!--Конфигурация корзины как сайта-->
<WebsiteConfiguration>
    <IndexDocument>
        <Suffix>index.html</Suffix>
    </IndexDocument>
    <ErrorDocument>
        <Key>Error.html</Key>
    </ErrorDocument>
</WebsiteConfiguration>
```

```
<!--Конфигурация для редиректа всех запросов-->
<WebsiteConfiguration>
    <RedirectAllRequestsTo>
        <HostName>example.com</HostName>
    </RedirectAllRequestsTo>
</WebsiteConfiguration>
```


Описания возможных элементов представлены в таблице ниже.

Элемент | Описание
----- | -----
`RedirectAllRequestsTo` | Содержит конфигурацию редиректов всех запросов.<br/><br/>Путь: `/WebsiteConfiguration/RedirectAllRequestsTo`.
`HostName` | Хост, на который перенаравляются все запросы к корзине.<br/><br/>Путь: `/WebsiteConfiguration/RedirectAllRequestsTo/HostName`.
`Protocol` | Протокол, который используется при при перенаправлении: `http`, `https`. Необязательный элемент.<br/><br/>Путь: `/WebsiteConfiguration/RedirectAllRequestsTo/Protocol`.
`IndexDocument/Suffix` | Стартовый документ сайта.
`ErrorDocument/Key` | Документ, который пользователь увидит при возникновении ошибок с кодом 4xx.

## Ответ {#response}

### Заголовки {#response-headers}

Ответ может содержать только [общие заголовки](../common-response-headers.md).

### Коды ответов {#response-codes}

Перечень возможных ответов смотрите в разделе [[!TITLE]](../response-codes.md).
