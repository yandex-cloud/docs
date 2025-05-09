# Расширение x-yc-apigateway-authorizer:jwt

Расширение `x-yc-apigateway-authorizer:jwt` используется внутри схем компонента [securityScheme](https://swagger.io/docs/specification/authentication/) с типом [OpenId Connect](https://swagger.io/docs/specification/authentication/openid-connect-discovery/). Для авторизации HTTP-запроса {{ api-gw-short-name }} валидирует токен, а также проверяет его подпись при помощи публичных ключей, ссылка на которые указывается в расширении. Подробнее о [стандарте JWT](https://www.rfc-editor.org/rfc/rfc7519).

## Поддерживаемые параметры {#parameters}

{% include [param-table](../../../_includes/api-gateway/parameters-table.md) %}


Параметр                            | Тип              | Параметр обязателен   | Описание
------------------------------------|------------------|-----------------------|---------
`jwksUri`                           | `string`         | Нет                   | Адрес, по которому можно получить публичный ключ для проверки подписи JWT. Ключи должны быть описаны в формате [JWKS](https://www.rfc-editor.org/rfc/rfc7517). Если параметр не указан, используется адрес, который указан в файле конфигурации, в поле `jwks_uri`. Файл конфигурации доступен по адресу из стандартного параметра `openIdConnectUrl`.
`identitySource`                    | `IdentitySource` | Да                    | Указывает на место, где в запросе находится токен.
`issuers`                           | `string[]`       | Нет                   | Возможные значения поля `iss`  валидируемого токена.
`audiences`                         | `string[]`       | Нет                   | Возможные значения поля `aud`  валидируемого токена.
`requiredClaims`                    | `string[]`       | Нет                   | Поля тела JWT, которые должны присутствовать в каждом валидируемом токене.
`authorizer_result_ttl_in_seconds`  | `int`            | Нет                   | Время, в течение которого результат авторизации хранится в локальном кеше {{ api-gw-short-name }}. Если параметр не указан, ответ не кешируется.
`authorizer_result_caching_mode`    | `string`         | Нет                   | Режим кеширования результата авторизации. Для использования необходимо также указать параметр `authorizer_result_ttl_in_seconds`. Возможные значения: `path`, `uri`.
`jwkTtlInSeconds`                   | `int`            | Нет                   | Время, в течение которого публичный ключ из ответа на запрос, адрес которого указан в параметре `jwksUri`, хранится в локальном кеше {{ api-gw-short-name }}. Если параметр не указан, ключ не кешируется.

При этом указывать стандартный для [спецификации OpenAPI 3.0](https://github.com/OAI/OpenAPI-Specification) параметр `openIdConnectUrl`  необязательно, если указан параметр `jwksUri`.

Объект `IdentitySource` может содержать следующие параметры:

Параметр | Тип | Описание
----|----|----
`in` | `string` | Местонахождение токена. Возможные значения: `header`, `query`, `cookie` — токен лежит в заголовке, параметре запроса или куки соответственно.
`name` | `string` | Название переменной, в которой лежит токен. Например, название заголовка или переменной запроса.
`prefix` | `string` | Необязательный параметр. Префикс токена. Значение по умолчанию: пустая строка.

## Поддерживаемые алгоритмы подписи {#algorithms}

Алгоритм подписи | Значение поля `alg`
----|----
`RSASSA-PKCS1-v1_5` и `SHA-256` | `RS256`
`RSASSA-PKCS1-v1_5` и `SHA-384` | `RS384`
`RSASSA-PKCS1-v1_5` и `SHA-512` | `RS512`
`ECDSA` с функцией `P-256` и `SHA-256` | `ES256`
`ECDSA` с функцией `P-384` и `SHA-384` | `ES384`
`ECDSA` с функцией `P-521` и `SHA-512` | `ES512`

## Алгоритм авторизации вызова API {#authorizing-alg}

Авторизация запросов с помощью JWT выполняется по следующему алгоритму:

1. {{ api-gw-short-name }} проверяет наличие токена в `identitySource` и удаляет из него префикс, если он указан в спецификации.
1. Если в спецификации разрешено кеширование результата авторизации и время жизни закешированной записи не истекло, {{ api-gw-short-name }} возвращает закешированный результат авторизации. Иначе — декодирует заголовок и тело токена.
1. {{ api-gw-short-name }} определяет адрес получения публичного ключа, необходимого для валидации [электронной подписи JWS](https://en.wikipedia.org/wiki/JSON_Web_Signature) токена. Для этого используется значение параметра `jwksUri`. Если в спецификации не указан параметр `jwksUri`, {{ api-gw-short-name }}, используя значение стандартного для OpenAPI параметра `openIdConnectUrl`, делает запрос на указанный в параметре адрес и извлекает адрес публичных ключей из поля `jwks_uri`, расположенного в теле ответа.
1. Если в спецификации разрешено кеширование публичных ключей и время жизни закешированной записи не истекло, {{ api-gw-short-name }} использует адрес получения публичных ключей и идентификатор публичного ключа (задан в [поле](https://www.rfc-editor.org/rfc/rfc7515#section-4.1.4) `kid` заголовка JWT), чтобы попытаться извлечь публичный ключ из локального кеша. Иначе — делает запрос на получение публичного ключа по адресу. Из тела ответа выбирается публичный ключ, идентификатор которого соответствует значению поля `kid` в заголовке JWT. Полученный публичный ключ кешируется, если это предусматривает спецификация.
1. {{ api-gw-short-name }} проверяет соответствие алгоритмов подписи токена и публичного ключа.
1. {{ api-gw-short-name }} проверяет подпись токена.
1. {{ api-gw-short-name }} проверяет поля тела токена:
    * `exp` — должно быть больше текущего времени в UTC.
    * `nbf` — должно быть меньше текущего времени в UTC.
    * `iat` — должно быть меньше текущего времени в UTC.
    * `iss` — должно иметь одно из значений, указанных в параметре спецификации `issuers`.
    * `aud` — должно иметь одно из значений, указанных в параметре спецификации `audiences`.

    Подробнее о полях читайте в [стандарте JWT](https://www.rfc-editor.org/rfc/rfc7519).
1. {{ api-gw-short-name }} проверяет, что в теле токена содержатся поля, указанные в параметре спецификации `requiredClaims`.
1. {{ api-gw-short-name }} проверяет, что у владельца токена (значение поля `scope` токена) есть все права, которые необходимы, чтобы получить запрашиваемый ресурс.

Если хотя бы одна из проверок не пройдена, {{ api-gw-short-name }} отказывает в доступе к запрашиваемому ресурсу и возвращает статус-код 403.

## Спецификация расширения {#spec}

Пример спецификации расширения:
```yaml
paths:
  /jwt/header/authorize:
    get:
      summary: Authorized operation with OpenId Connect security scheme and JWT in header
      operationId: httpOpenIdAuthorizeWithJwtInHeader
      security:
        - jwtHeaderAuthorizer:
          - profile:read
          - profile:write
      x-yc-apigateway-integration:
        type: dummy
        content:
          '*': "Authorized!"
        http_code: 200
        http_headers:
          'Content-Type': "text/plain"
components:
  securitySchemes:
    jwtHeaderAuthorizer:
      type: openIdConnect
      openIdConnectUrl: https://example.com/.well-known/openid-configuration
      x-yc-apigateway-authorizer:
        type: jwt
        authorizer_result_ttl_in_seconds: 3000
        jwkTtlInSeconds: 5000
        jwksUri: https://example.com/.well-known/jwks.json
        issuers:
          - https://example.com
          - https://example2.com
        audiences:
          - audience-1
          - audience-2
        identitySource:
          in: header
          name: Authorization
          prefix: "Bearer "
        requiredClaims:
          - role
          - email
```

В данном примере при обращении к ресурсу с названием `/jwt/query/authorize` {{ api-gw-short-name }} валидирует токен, находящийся в заголовке `Authorization`. Чтобы получить токен, из значения целевого заголовка удаляется префикс `Bearer`.

Для успешной авторизации:
* подпись токена и стандартные поля должны быть корректны;
* токен должен содержать поля `role` и `email`;
* значение поля `iss` должно быть равно `https://example.com` или `https://example2.com`;
* значение поля `aud` должно быть равно `audience-1` или `audience-2`;
* в токене должны быть указаны права `profile:read` и `profile:write`.

## Кеширование результата авторизации {#response-caching}

Результат авторизации сохраняется в локальном кеше {{ api-gw-short-name }}, если в расширении задан параметр `authorizer_result_ttl_in_seconds`. Если в течение времени, указанного в параметре `authorizer_result_ttl_in_seconds`, повторно придет HTTP-запрос с аналогичными составляющими ключа кеширования, {{ api-gw-short-name }} использует ответ, сохраненный в кеше, и не будет проверять подпись токена.

Состав ключа кеширования зависит от значения параметра `authorizer_result_caching_mode`.

Режим кеширования `path`  | Режим кеширования `uri` | Режим кеширования не указан
--------------------------|-------------------------|----------------------------
`path`, `operation` (HTTP-метод) и токен | `uri`, `operation` (HTTP-метод) и токен | `path`, `operation` (HTTP-метод) и токен

Например, для идентификатора ресурса в спецификации `/user/{id}` и в запросе `/user/1234` при значении параметра `authorizer_result_caching_mode`, равном `path`, для формирования ключа кеширования будет использоваться `/user/{id}`, а при значении, равном `uri`, — `/user/123`.

## Кеширование публичных ключей {#jwks-caching}

Публичный ключ, получаемый при обращении по адресу, указанному в параметре `jwksUri` или в поле `jwks_uri` файла конфигурации, сохраняется в локальном кеше {{ api-gw-short-name }}, если в расширении задан параметр `jwkTtlInSeconds`.

При формировании ключа кеширования используется идентификатор публичного ключа (значение поля `kid` из заголовка JWT) и адрес, по которому получен публичный ключ.

Если в течение времени, заданного в параметре `jwkTtlInSeconds`, повторно придет HTTP-запрос, для проверки которого требуется получение публичного ключа с аналогичным адресом и идентификатором ключа `kid`, {{ api-gw-short-name }} использует ответ, сохраненный в кеше, и не будет повторно запрашивать публичный ключ.

## Контекст авторизации {#context}

Если авторизация прошла успешно, при вызове пользовательской функции-интеграции контекст JWT-авторизации будет передан в запросе внутри поля `requestContext.authorizer.jwt`. Контекст JWT-авторизации содержит следующие параметры:

Параметр | Тип | Описание
----|-----|----
`claims` | `map[string]string` | Поля тела токена.
`scopes` | `list` | Права доступа владельца токена.

## Возможные ошибки {#errors}

* `401 Unauthorized` — клиент не передал в HTTP-запросе авторизационные данные или передаваемый токен некорректен, например подпись невалидна, пропущены требуемые поля, истек срок жизни токена и прочее.
* `403 Forbidden` — в токене отсутствуют права (поле `scope`), необходимые для доступа к запрашиваемому ресурсу.
* `500 Internal Server Error` — {{ api-gw-short-name }} не смог получить конфигурацию OpenID Connect или публичный ключ или возвращенное значение имеет некорректную структуру.

## Примеры использования {#examples}

* [{#T}](../../tutorials/jwt-authorizer-firebase.md)
