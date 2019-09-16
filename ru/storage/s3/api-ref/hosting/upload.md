# Метод upload

Загружает конфигурацию хостинга статического сайта для бакета.


## Запрос {#request}

```
PUT /{bucket}?website HTTP/1.1
```

### Path параметры {#path-parameters}

Параметр | Описание
----- | -----
`bucket` | Имя бакета.


### Query параметры {#request-params}

Параметр | Описание
----- | -----
`website` | Обязательный параметр для обозначения типа операции.


### Заголовки {#request-headers}

Используйте в запросе необходимые [общие заголовки](../common-request-headers.md).

### Схема данных {#request-scheme}

Бакета можно сконфигурировать:

{% list tabs %}

- Как сайт

  Пример конфигурации:

  ```
  <WebsiteConfiguration xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
      <IndexDocument>
          <Suffix>index.html</Suffix>
      </IndexDocument>
      <ErrorDocument>
          <Key>Error.html</Key>
      </ErrorDocument>
  </WebsiteConfiguration>
  ```

  Возможные элементы:

  Элемент | Описание
  ----- | -----
  `IndexDocument/Suffix` | Главная страница сайта.<br/><br/>Путь: `/WebsiteConfiguration/IndexDocument/Suffix`.
  `ErrorDocument/Key` | Документ, который пользователь увидит при возникновении ошибок с кодом 4xx.<br/><br/>Путь: `/WebsiteConfiguration/ErrorDocument/Key`.

- Для редиректа всех запросов

  Пример конфигурации:

  ```
  <!--Конфигурация для редиректа всех запросов-->
  <WebsiteConfiguration xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
      <RedirectAllRequestsTo>
          <HostName>example.com</HostName>
          <Protocol>http</Protocol>
      </RedirectAllRequestsTo>
  </WebsiteConfiguration>
  ```

  Возможные элементы:

  Элемент | Описание
  ----- | -----
  `RedirectAllRequestsTo` | Содержит конфигурацию редиректов всех запросов.<br/><br/>Путь: `/WebsiteConfiguration/RedirectAllRequestsTo`.
  `HostName` | Хост, на который перенаравляются все запросы к бакету.<br/><br/>Путь: `/WebsiteConfiguration/RedirectAllRequestsTo/HostName`.
  `Protocol` | Протокол, который используется при перенаправлении: `http`, `https`. Необязательный элемент.<br/><br/>Путь: `/WebsiteConfiguration/RedirectAllRequestsTo/Protocol`.

{% endlist %}


## Ответ {#response}

### Заголовки {#response-headers}

Ответ может содержать только [общие заголовки](../common-response-headers.md).

### Коды ответов {#response-codes}

Перечень возможных ответов смотрите в разделе [{#T}](../response-codes.md).
