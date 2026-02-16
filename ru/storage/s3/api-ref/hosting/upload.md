# Метод upload

Загружает конфигурацию хостинга статического сайта для бакета.

{% include [s3-api-intro-include](../../../../_includes/storage/s3-api-intro-include.md) %}

## Запрос {#request}

```bash
PUT /{bucket}?website HTTP/2
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

Бакет можно сконфигурировать:

{% list tabs %}

- Как сайт

  Пример конфигурации:

  ```xml
  <!--Конфигурация для сайта-->
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
  `WebsiteConfiguration` | Заголовок верхнего уровня описания сайта.
  `IndexDocument/Suffix` | Главная страница сайта.<br/><br/>Путь: `/WebsiteConfiguration/IndexDocument/Suffix`.
  `ErrorDocument/Key` | Документ, который пользователь увидит при возникновении ошибок с кодом `4xx`.<br/><br/>Путь: `/WebsiteConfiguration/ErrorDocument/Key`.

- Для редиректа всех запросов

  Пример конфигурации:

  ```xml
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
  `WebsiteConfiguration` | Заголовок верхнего уровня описания сайта.
  `RedirectAllRequestsTo` | Содержит конфигурацию переадресации всех запросов.<br/><br/>Путь: `/WebsiteConfiguration/RedirectAllRequestsTo`.
  `HostName` | Хост, на который перенаравляются все запросы к бакету.<br/><br/>Путь: `/WebsiteConfiguration/RedirectAllRequestsTo/HostName`.
  `Protocol` | Протокол, который используется при переадресации: `http`, `https`. Необязательный элемент.<br/><br/>Путь: `/WebsiteConfiguration/RedirectAllRequestsTo/Protocol`.

- Для условной переадресации запросов

  Пример конфигурации:

  ```xml
  <!--Конфигурация для условного редиректа запросов-->
  <WebsiteConfiguration xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
      <IndexDocument>
          <Suffix>index.html</Suffix>
      </IndexDocument>
      <ErrorDocument>
          <Key>Error.html</Key>
      </ErrorDocument>
      <RoutingRules>
          <RoutingRule>
              <Condition>
                  <KeyPrefixEquals>k8s/</KeyPrefixEquals>
              </Condition>
              <Redirect>
                  <ReplaceKeyPrefixWith>kubernetes/</ReplaceKeyPrefixWith>
              </Redirect>
          </RoutingRule>
      </RoutingRules>
  </WebsiteConfiguration>
  ```

  Возможные элементы:

  Элемент | Описание
  ----- | -----
  `WebsiteConfiguration` | Заголовок верхнего уровня описания сайта.
  `IndexDocument/Suffix` | Главная страница сайта.
  `ErrorDocument/Key` | Документ, который пользователь увидит при возникновении ошибок с кодом `4xx`.
  `RoutingRules` | Контейнер правил маршрутизации `RoutingRule`.<br/>Должен содержать хотя бы одно правило.
  `RoutingRule` | Правило маршрутизации.<br/>Определяет условия и переадресацию при выполнении условий.
  `Condition` | Контейнер условий, которые должны выполняться для применения переадресации.<br/>Если правило маршрутизации не содержит условий, переадресация применяется ко всем запросам.<br/>Контейнер должен содержать хотя бы одно правило.
  `KeyPrefixEquals` | Условие задает префикс имени объекта, с которого перенаправляются запросы.<br/>`KeyPrefixEquals` обязателен, если `HttpErrorCodeReturnedEquals` не определен. Если `KeyPrefixEquals` и `HttpErrorCodeReturnedEquals` определены, условие выполняется при значении `true` обоих параметров.
  `HttpErrorCodeReturnedEquals` | Условие задает код ошибки, при возникновении которой применяется переадресация.<br/>`HttpErrorCodeReturnedEquals` обязателен, если `KeyPrefixEquals` не определен. Если `KeyPrefixEquals` и `HttpErrorCodeReturnedEquals` определены, условие выполняется при значении `true` обоих параметров.
  `Redirect` | Контейнер переадресаций.<br/>Запрос можно перенаправить на другую страницу, другой хост, а также изменить протокол.<br/>Правило `RoutingRule` должно содержать хотя бы  один элемент `Redirect`.<br/>Переадресация должна содержать хотя бы один из элементов `Protocol`, `HostName`, `ReplaceKeyPrefixWith`, `ReplaceKeyWith` или `HttpRedirectCode`.
  `Protocol` | Переадресация указывает в заголовке ответа `Location`, какой из протоколов `http` или `https` следует использовать.<br/>Параметр необязателен, если применяются другие переадресации.
  `HostName` | Переадресация указывает в заголовке ответа `Location` имя хоста, которое следует использовать.<br/>Параметр необязателен, если применяются другие переадресации.
  `ReplaceKeyPrefixWith` | Переадресация указывает префикс имени ключа объекта, заменяющий значение `KeyPrefixEquals` в запросе перенаправления.<br/>Несовместим с параметром `ReplaceKeyWith`.<br/>Параметр необязателен, если применяются другие переадресации.
  `ReplaceKeyWith` | Переадресация указывает ключ объекта, который будет использоваться в заголовке `Location`.<br/>Несовместим с параметром `ReplaceKeyPrefixWith`.<br/>Параметр необязателен, если применяются другие переадресации.
  `HttpRedirectCode` | Переадресация указывает `HTTP-код` перенаправления в заголовке ответа `Location`.<br/>Возможные значения: любой код `3xx`.<br/>Параметр необязателен, если применяются другие переадресации.

{% endlist %}

## Ответ {#response}

### Заголовки {#response-headers}

Ответ может содержать только [общие заголовки](../common-response-headers.md).

### Коды ответов {#response-codes}

Перечень возможных ответов смотрите в разделе [{#T}](../response-codes.md).

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}