# Object Storage API, REST совместимый с Amazon S3: PutBucketWebsite

Загружает конфигурацию хостинга статического сайта для бакета.

{% include [s3-api-intro-include](../../../../_includes/storage/s3-api-intro-include.md) %}

## Запрос {#request}

```bash
PUT /{bucket}?website HTTP/2
```

### Path параметры {#path-parameters}

{% include [path-parameters](../../../_includes_service/storage-path-parameters.md) %}

### Query параметры {#request-params}

{% include [query-parameters](../../../_includes_service/storage-hosting-query-parameters.md) %}

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

  #|
  || **Элемент** | **Описание** ||
  || `WebsiteConfiguration` | Заголовок верхнего уровня описания сайта. ||
  || `IndexDocument/Suffix` | Главная страница сайта.
  
  Путь: `/WebsiteConfiguration/IndexDocument/Suffix`. ||
  || `ErrorDocument/Key` | Документ, который пользователь увидит при возникновении ошибок с кодом `4xx`.
  
  Путь: `/WebsiteConfiguration/ErrorDocument/Key`. ||
  |#

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

  #|
  || **Элемент** | **Описание** ||
  || `WebsiteConfiguration` | Заголовок верхнего уровня описания сайта. ||
  || `RedirectAllRequestsTo` | Содержит конфигурацию переадресации всех запросов.
  
  Путь: `/WebsiteConfiguration/RedirectAllRequestsTo`. ||
  || `HostName` | Хост, на который перенаравляются все запросы к бакету.
  
  Путь: `/WebsiteConfiguration/RedirectAllRequestsTo/HostName`. ||
  || `Protocol` | Протокол, который используется при переадресации: `http`, `https`. Необязательный элемент.
  
  Путь: `/WebsiteConfiguration/RedirectAllRequestsTo/Protocol`. ||
  |#

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

  #|
  || **Элемент** | **Описание** ||
  || `WebsiteConfiguration` | Заголовок верхнего уровня описания сайта. ||
  || `IndexDocument/Suffix` | Главная страница сайта. ||
  || `ErrorDocument/Key` | Документ, который пользователь увидит при возникновении ошибок с кодом `4xx`. ||
  || `RoutingRules` | Контейнер правил маршрутизации `RoutingRule`.
  Должен содержать хотя бы одно правило. ||
  || `RoutingRule` | Правило маршрутизации.
  Определяет условия и переадресацию при выполнении условий. ||
  || `Condition` | Контейнер условий, которые должны выполняться для применения переадресации. Если правило маршрутизации не содержит условий, переадресация применяется ко всем запросам.
  Если запрос соответствует условиям нескольких правил переадресации, сработает последнее подходящее правило. При этом глубина совпадения ключа объекта с указанным в условии префиксом не имеет значения.
  Контейнер должен содержать хотя бы одно правило. ||
  || `KeyPrefixEquals` | Условие задает префикс ключа объекта, с которого перенаправляются запросы.
  `KeyPrefixEquals` обязателен, если `HttpErrorCodeReturnedEquals` не определен. Если `KeyPrefixEquals` и `HttpErrorCodeReturnedEquals` определены, условие выполняется при значении `true` обоих параметров. ||
  || `HttpErrorCodeReturnedEquals` | Условие задает код ошибки, при возникновении которой применяется переадресация.
  `HttpErrorCodeReturnedEquals` обязателен, если `KeyPrefixEquals` не определен. Если `KeyPrefixEquals` и `HttpErrorCodeReturnedEquals` определены, условие выполняется при значении `true` обоих параметров. ||
  || `Redirect` | Контейнер переадресаций.
  Запрос можно перенаправить на другую страницу, другой хост, а также изменить протокол.
  Правило `RoutingRule` должно содержать хотя бы один элемент `Redirect`.
  Переадресация должна содержать хотя бы один из элементов `Protocol`, `HostName`, `ReplaceKeyPrefixWith`, `ReplaceKeyWith` или `HttpRedirectCode`. ||
  || `Protocol` | Переадресация указывает в заголовке ответа `Location`, какой из протоколов `http` или `https` следует использовать.
  Параметр необязателен, если применяются другие переадресации. ||
  || `HostName` | Переадресация указывает в заголовке ответа `Location` имя хоста, которое следует использовать.
  Параметр необязателен, если применяются другие переадресации. ||
  || `ReplaceKeyPrefixWith` | Переадресация указывает префикс ключа объекта, заменяющий значение `KeyPrefixEquals` в запросе перенаправления.
  Несовместим с параметром `ReplaceKeyWith`.
  Параметр необязателен, если применяются другие переадресации. ||
  || `ReplaceKeyWith` | Переадресация указывает ключ объекта, который будет использоваться в заголовке `Location`.
  Несовместим с параметром `ReplaceKeyPrefixWith`.
  Параметр необязателен, если применяются другие переадресации. ||
  || `HttpRedirectCode` | Переадресация указывает `HTTP-код` перенаправления в заголовке ответа `Location`.
  Возможные значения: любой код `3xx`.
  Параметр необязателен, если применяются другие переадресации. ||
  |#

{% endlist %}

## Ответ {#response}

### Заголовки {#response-headers}

Ответ может содержать только [общие заголовки](../common-response-headers.md).

### Коды ответов {#response-codes}

Перечень возможных ответов смотрите в разделе [{#T}](../response-codes.md).

#### Связанные статьи {#related-articles}

[{#T}](../../../operations/hosting/setup.md)

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}
