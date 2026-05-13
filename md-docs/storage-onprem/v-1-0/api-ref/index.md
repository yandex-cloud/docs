# Руководство по использованию gRPC API

Это руководство описывает, как использовать gRPC API для работы с S3-хранилищем в системе On-premises Yandex Object Storage. Основное внимание уделено процессу авторизации.

1. [Обзор архитектуры](#architecture-overview)
1. [Процесс авторизации](#authorization-process)
1. [Использование API](#api-usage)
1. [Примеры кода](#code-examples)


## Обзор архитектуры {#architecture-overview}

Система использует многоуровневую авторизацию:

1. **OAuth 2.0 Device Flow** — для первичной аутентификации пользователя.
1. **JWT-токены** — для работы с gRPC сервисами.
1. **Service-specific-токены** — для доступа к конкретным сервисам (Grestin, Bender, Fry).


### Компоненты системы {#system-components}

* **Grestin** (`storage.grestin`) — управление тенантами.
* **Bender** (`storage.bender`) — управление бакетами, сервисными аккаунтами, ключами доступа.
* **Fry** (`storage.fry`) — управление пользователями и членством в тенантах.


## Процесс авторизации {#authorization-process}

### Шаг 1: Получение конфигурации {#step-1}

Получите конфигурацию от консоли управления.

**Пример с cURL**

```bash
curl https://console.example.com/.config/client
```

**Ответ**

```json
{
  "client_id": "2682687935********@onprem",
  "scopes": ["openid", "email", "offline_access", "urn:zitadel:iam:org:id:2682687935********"],
  "oidc_config_url": "https://idp.example.com/.well-known/openid-configuration",
  "grpc_endpoint": "grpc.example.com:9090"
}
```


### Шаг 2: Получение OIDC конфигурации {#step-2}

Загрузите OIDC конфигурацию по URL из предыдущего [шага](#step-1).

**Пример с cURL**

```bash
# Используйте oidc_config_url из предыдущего ответа
curl https://idp.example.com/.well-known/openid-configuration
```

**Ответ**

```json
{
  "issuer": "https://idp.example.com",
  "token_endpoint": "https://idp.example.com/oauth/v2/token",
  "device_authorization_endpoint": "https://idp.example.com/oauth/v2/device",
  "authorization_endpoint": "https://idp.example.com/oauth/v2/authorize",
  "userinfo_endpoint": "https://idp.example.com/oidc/v1/userinfo"
}
```


### Шаг 3: Инициация Device Flow {#step-3}

Запустите OAuth 2.0 Device Authorization Flow.

**Пример с cURL**

```bash
# Замените значения на полученные из шага 1
CLIENT_ID="<идентификатор_клиента>@onprem"
SCOPES="openid email offline_access urn:zitadel:iam:org:id:<идентификатор_клиента>"
DEVICE_ENDPOINT="https://idp.example.com/oauth/v2/device"

curl -X POST "$DEVICE_ENDPOINT" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "client_id=$CLIENT_ID" \
  -d "scope=$SCOPES"
```

**Ответ**

```json
{
  "device_code": "GmYi4NKJ-8Iyg-OHtr-ow-OJ...",
  "user_code": "****-****",
  "verification_uri": "https://idp.example.com/device",
  "verification_uri_complete": "https://idp.example.com/device?user_code=****-****",
  "expires_in": 600,
  "interval": 5
}
```


### Шаг 4: Аутентификация пользователя {#step-4}

Откройте `verification_uri_complete` в браузере.

Аутентификация произойдет автоматически. Если этого не случилось, [настройте SAML-аутентификацию](../quickstart.md#configure-saml).


### Шаг 5: Получение OAuth-токена {#step-5}

Периодически опрашивайте token endpoint для получения токена (каждые 5 секунд согласно `interval` из [шага 3](#step-3)).

**Пример с cURL**

```bash
# Используйте device_code из шага 3 и client_id из шага 1
DEVICE_CODE="GmYi4NKJ-8Iyg-OHtr-ow-OJ..."
CLIENT_ID="<идентификатор_клиента>@onprem"
TOKEN_ENDPOINT="https://idp.example.com/oauth/v2/token"

curl -X POST "$TOKEN_ENDPOINT" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "grant_type=urn:ietf:params:oauth:grant-type:device_code" \
  -d "device_code=$DEVICE_CODE" \
  -d "client_id=$CLIENT_ID"
```

**Ответ**

* Пока пользователь не авторизовался:

    ```json
    {
      "error": "authorization_pending",
      "error_description": "..."
    }
    ```

* После успешной авторизации:

    ```json
    {
      "access_token": "eyJhbGciOiJSUzI1NiIsImtpZCI6IjI2ODI2ODc5MzU5NjM3OTM5NyIsInR5cCI6IkpXVCJ9...",
      "token_type": "Bearer",
      "expires_in": 43199,
      "refresh_token": "v2.local.Gj3Kcs...",
      "id_token": "eyJhbGciOiJSUzI1NiIsImtpZCI6IjI2ODI2ODc5MzU5NjM3OTM5NyIsInR5cCI6IkpXVCJ9...",
      "scope": "openid profile email offline_access urn:zitadel:iam:org:id:2682687935********"
    }
    ```


### Шаг 6: Обмен OAuth-токена на JWT {#step-6}

Подключитесь к gRPC endpoint и вызовите метод `Authenticate`.

**Пример с grpcurl**

```bash
# Используйте access_token из шага 5 и grpc_endpoint из шага 1
ACCESS_TOKEN="eyJhbGciOiJSUzI1NiIsImtpZCI6IjI2ODI2ODc5MzU5NjM3OTM5NyIsInR5cCI6IkpXVCJ9..."
GRPC_ENDPOINT="grpc.example.com:9090"

grpcurl \
  -H "authorization: Bearer $ACCESS_TOKEN" \
  -d '{}' \
  $GRPC_ENDPOINT \
  grestin.TokenService/Authenticate
```

**Protobuf определение**

```protobuf
service TokenService {
  rpc Authenticate(AuthenticateRequest) returns (AuthenticateResponse);
}

message AuthenticateRequest {}

message AuthenticateResponse {
  string token = 1;
  google.protobuf.Timestamp expires_at = 2;
}
```

**Ответ**

```json
{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "expiresAt": "2026-03-03T16:00:00Z"
}
```

**Ответ содержит JWT-токен** для дальнейшей работы с API.


### Шаг 7: Получение service-specific-токенов {#step-7}

Для работы с конкретными сервисами нужно получить специализированные токены.


#### Для глобальных операций {#global-operations}

**Пример с grpcurl**

```bash
# Используйте JWT-токен из шага 6
JWT_TOKEN="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
GRPC_ENDPOINT="grpc.example.com:9090"

# Для работы с тенантами (storage.grestin)
grpcurl \
  -H "authorization: JWT $JWT_TOKEN" \
  -d '{"audience": ["storage.grestin"]}' \
  $GRPC_ENDPOINT \
  grestin.TokenService/Auth

# Для работы с бакетами (storage.bender)
grpcurl \
  -H "authorization: JWT $JWT_TOKEN" \
  -d '{"audience": ["storage.bender"]}' \
  $GRPC_ENDPOINT \
  grestin.TokenService/Auth

# Для работы с пользователями (storage.fry)
grpcurl \
  -H "authorization: JWT $JWT_TOKEN" \
  -d '{"audience": ["storage.fry"]}' \
  $GRPC_ENDPOINT \
  grestin.TokenService/Auth
```

**Protobuf определение**

```protobuf
service TokenService {
  rpc Auth(AuthRequest) returns (AuthResponse);
}

message AuthRequest {
  repeated string audience = 1;  // ["storage.bender"] или ["storage.fry"] или ["storage.grestin"]
}

message AuthResponse {
  string token = 1;
  string username = 2;
}
```

**Ответ**

```json
{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "username": "admin"
}
```


#### Для операций в рамках тенанта {#tenant-operations}

**Пример с grpcurl**

```bash
# Используйте JWT-токен из шага 6 и ID тенанта
JWT_TOKEN="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
TENANT_ID="<идентификатор_тенанта>"
GRPC_ENDPOINT="grpc.example.com:9090"

# Для работы с бакетами конкретного тенанта
grpcurl \
  -H "authorization: JWT $JWT_TOKEN" \
  -d '{"audience": ["storage.bender"], "tenant": "'$TENANT_ID'"}' \
  $GRPC_ENDPOINT \
  grestin.TokenService/TenantAuth
```

**Protobuf определение**

```protobuf
service TokenService {
  rpc TenantAuth(TenantAuthRequest) returns (TenantAuthResponse);
}

message TenantAuthRequest {
  repeated string audience = 1;  // ["storage.bender"]
  string tenant = 2;              // ID тенанта
}

message TenantAuthResponse {
  string token = 1;
  string username = 2;
}
```


**Ответ**

```json
{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "username": "admin"
}
```


## Использование API {#api-usage}

### Примеры вызовов API с grpcurl {#grpcurl-examples}

После получения service-specific-токена в [шаге 7](#step-7), вы можете вызывать методы API.


#### Список тенантов {#list-tenants}

```bash
SERVICE_TOKEN="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
GRPC_ENDPOINT="grpc.example.com:9090"

grpcurl \
  -H "authorization: Bearer $SERVICE_TOKEN" \
  -d '{}' \
  $GRPC_ENDPOINT \
  grestin.TenantsService/ListTenants
```


#### Получить информацию о тенанте {#get-tenant}

```bash
grpcurl \
  -H "authorization: Bearer $SERVICE_TOKEN" \
  -d '{"id": "<идентификатор_тенанта>"}' \
  $GRPC_ENDPOINT \
  grestin.TenantsService/GetTenant
```


#### Список бакетов {#list-buckets}

```bash
# Используйте токен для storage.bender с tenant scope
grpcurl \
  -H "authorization: Bearer $SERVICE_TOKEN" \
  -d '{"tenant": "<идентификатор_тенанта>"}' \
  $GRPC_ENDPOINT \
  bender.BucketsService/ListBuckets
```


#### Создать бакет {#create-bucket}

```bash
grpcurl \
  -H "authorization: Bearer $SERVICE_TOKEN" \
  -d '{"tenant": "<идентификатор_тенанта>", "name": "<имя_бакета>"}' \
  $GRPC_ENDPOINT \
  bender.BucketsService/CreateBucket
```


#### Список пользователей {#list-users}

```bash
# Используйте токен для storage.fry
grpcurl \
  -H "authorization: Bearer $SERVICE_TOKEN" \
  -d '{}' \
  $GRPC_ENDPOINT \
  fry.UsersService/ListUsers
```


### Подключение к gRPC {#grpc-connection}

```go
import (
    "google.golang.org/grpc"
    "google.golang.org/grpc/credentials"
    "google.golang.org/grpc/metadata"
)

// Создание TLS credentials с сертификатом сервера
rootCA := x509.NewCertPool()
rootCA.AppendCertsFromPEM([]byte(serverCert))

conn, err := grpc.Dial(
    grpcEndpoint,
    grpc.WithTransportCredentials(credentials.NewTLS(&tls.Config{
        RootCAs: rootCA,
    })),
)
```


### Обновление токенов {#token-refresh}

OAuth-токены имеют ограниченный срок действия. Для обновления используйте refresh token.

**Пример с cURL**

```bash
REFRESH_TOKEN="v2.local.Gj3Kcs..."
CLIENT_ID="<идентификатор_клиента>@onprem"
TOKEN_ENDPOINT="https://idp.example.com/oauth/v2/token"

curl -X POST "$TOKEN_ENDPOINT" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "grant_type=refresh_token" \
  -d "refresh_token=$REFRESH_TOKEN" \
  -d "client_id=$CLIENT_ID"
```

**Ответ**

```json
{
  "access_token": "eyJhbGciOiJSUzI1NiIsImtpZCI6IjI2ODI2ODc5MzU5NjM3OTM5NyIsInR5cCI6IkpXVCJ9...",
  "token_type": "Bearer",
  "expires_in": 43199,
  "refresh_token": "v2.local.NewRefreshToken...",
  "id_token": "eyJhbGciOiJSUzI1NiIsImtpZCI6IjI2ODI2ODc5MzU5NjM3OTM5NyIsInR5cCI6IkpXVCJ9...",
  "scope": "openid profile email offline_access urn:zitadel:iam:org:id:2682687935********"
}
```


## Примеры кода {#code-examples}

### Пример 1: Полный цикл авторизации {#example-1-full-auth}

```go
package main

import (
    "context"
    "crypto/tls"
    "crypto/x509"
    "fmt"
    "golang.org/x/oauth2"
    "google.golang.org/grpc"
    "google.golang.org/grpc/credentials"
    "google.golang.org/grpc/metadata"
)

func main() {
    ctx := context.Background()
    
    // 1. Получить конфигурацию
    config := loadConsoleConfig("https://localhost:8990")
    
    // 2. Настроить OAuth2
    oauth2Config := oauth2.Config{
        ClientID: config.ClientID,
        Scopes:   config.Scopes,
        Endpoint: oauth2.Endpoint{
            TokenURL:      config.TokenURL,
            DeviceAuthURL: config.DeviceAuthURL,
        },
    }
    
    // 3. Запустить Device Flow
    deviceAuth, err := oauth2Config.DeviceAuth(ctx)
    if err != nil {
        panic(err)
    }
    
    fmt.Printf("Перейдите по ссылке: %s\n", deviceAuth.VerificationURIComplete)
    
    // 4. Дождаться токена
    oauthToken, err := oauth2Config.DeviceAccessToken(ctx, deviceAuth)
    if err != nil {
        panic(err)
    }
    
    // 5. Подключиться к gRPC
    rootCA := x509.NewCertPool()
    rootCA.AppendCertsFromPEM([]byte(config.ServerCert))
    
    conn, err := grpc.Dial(
        config.GRPCEndpoint,
        grpc.WithTransportCredentials(credentials.NewTLS(&tls.Config{
            RootCAs: rootCA,
        })),
    )
    if err != nil {
        panic(err)
    }
    defer conn.Close()
    
    // 6. Получить JWT-токен
    tokenClient := grestinpb.NewTokenServiceClient(conn)
    
    md := metadata.Pairs("authorization", "Bearer "+oauthToken.AccessToken)
    ctx = metadata.NewOutgoingContext(ctx, md)
    
    authResp, err := tokenClient.Authenticate(ctx, &grestinpb.AuthenticateRequest{})
    if err != nil {
        panic(err)
    }
    
    jwtToken := authResp.Token
    
    // 7. Получить service-specific-токен
    md = metadata.Pairs("authorization", "JWT "+jwtToken)
    ctx = metadata.NewOutgoingContext(ctx, md)
    
    serviceAuthResp, err := tokenClient.Auth(ctx, &grestinpb.AuthRequest{
        Audience: []string{"storage.grestin"},
    })
    if err != nil {
        panic(err)
    }
    
    serviceToken := serviceAuthResp.Token
    
    // 8. Использовать API
    tenantsClient := grestinpb.NewTenantsServiceClient(conn)
    
    md = metadata.Pairs("authorization", "Bearer "+serviceToken)
    ctx = metadata.NewOutgoingContext(ctx, md)
    
    tenants, err := tenantsClient.ListTenants(ctx, &grestinpb.ListTenantsRequest{})
    if err != nil {
        panic(err)
    }
    
    fmt.Printf("Найдено тенантов: %d\n", len(tenants.Tenants))
}
```


### Пример 2: Работа с бакетами {#example-2-buckets}

```go
// Получить токен для Bender сервиса
md := metadata.Pairs("authorization", "JWT "+jwtToken)
ctx := metadata.NewOutgoingContext(ctx, md)

serviceAuthResp, err := tokenClient.TenantAuth(ctx, &grestinpb.TenantAuthRequest{
    Audience: []string{"storage.bender"},
    Tenant:   "tenant-id-here",
})
if err != nil {
    panic(err)
}

// Создать клиент для работы с бакетами
bucketsClient := benderpb.NewBucketsServiceClient(conn)

md = metadata.Pairs("authorization", "Bearer "+serviceAuthResp.Token)
ctx = metadata.NewOutgoingContext(ctx, md)

// Список бакетов
buckets, err := bucketsClient.ListBuckets(ctx, &benderpb.ListBucketsRequest{
    Tenant: "tenant-id-here",
})
if err != nil {
    panic(err)
}

// Создать бакет
createResp, err := bucketsClient.CreateBucket(ctx, &benderpb.CreateBucketRequest{
    Tenant: "tenant-id-here",
    Name:   "<имя_бакета>",
})
if err != nil {
    panic(err)
}
```


### Пример 3: Работа с пользователями {#example-3-users}

```go
// Получить токен для Fry сервиса (глобальный)
md := metadata.Pairs("authorization", "JWT "+jwtToken)
ctx := metadata.NewOutgoingContext(ctx, md)

serviceAuthResp, err := tokenClient.Auth(ctx, &grestinpb.AuthRequest{
    Audience: []string{"storage.fry"},
})
if err != nil {
    panic(err)
}

// Создать клиент для работы с пользователями
usersClient := frypb.NewUsersServiceClient(conn)

md = metadata.Pairs("authorization", "Bearer "+serviceAuthResp.Token)
ctx = metadata.NewOutgoingContext(ctx, md)

// Список пользователей
users, err := usersClient.ListUsers(ctx, &frypb.ListUsersRequest{})
if err != nil {
    panic(err)
}
```


## Диаграмма последовательности авторизации {#auth-sequence-diagram}

```text
┌─────────┐      ┌─────────┐      ┌──────┐      ┌────────┐      ┌─────────┐
│ Клиент  │      │ Консоль │      │ IDP  │      │  gRPC  │      │ Сервис  │
└────┬────┘      └────┬────┘      └───┬──┘      └───┬────┘      └────┬────┘
     │                │               │             │                │
     │ 1. GET config  │               │             │                │
     ├───────────────>│               │             │                │
     │<───────────────┤               │             │                │
     │                │               │             │                │
     │ 2. GET OIDC config             │             │                │
     ├───────────────────────────────>│             │                │
     │<───────────────────────────────┤             │                │
     │                │               │             │                │
     │ 3. POST device auth            │             │                │
     ├───────────────────────────────>│             │                │
     │<───────────────────────────────┤             │                │
     │                │               │             │                │
     │ 4. Открыть URL в браузере      │             │                │
     │───────────────────────────────>│             │                │
     │                │               │             │                │
     │ 5. Логин/пароль                │             │                │
     │───────────────────────────────>│             │                │
     │                │               │             │                │
     │ 6. Poll token endpoint         │             │                │
     ├───────────────────────────────>│             │                │
     │<───────────────────────────────┤             │                │
     │     (OAuth token)              │             │                │
     │                │               │             │                │
     │ 7. Authenticate (OAuth token)  │             │                │
     ├─────────────────────────────────────────────>│                │
     │<─────────────────────────────────────────────┤                │
     │     (JWT token)                │             │                │
     │                │               │             │                │
     │ 8. Auth/TenantAuth (JWT token) │             │                │
     ├─────────────────────────────────────────────>│                │
     │<─────────────────────────────────────────────┤                │
     │     (Service token)            │             │                │
     │                │               │             │                │
     │ 9. API call (Service token)    │             │                │
     ├──────────────────────────────────────────────────────────────>│
     │<──────────────────────────────────────────────────────────────┤
     │                │               │             │                │
```


## Важные замечания {#important-notes}

1. **Время жизни токенов**
    *  OAuth access token: обычно 1 час.
    *  JWT token: проверяйте поле `expires_at`.
    *  Service tokens: время жизни зависит от конфигурации.

1. **Обновление токенов** CLI автоматически обновляет токены за 10 минут до истечения.
1. **Audience значения**
    *  `storage.grestin` — для работы с тенантами.
    *  `storage.bender` — для работы с бакетами, сервисными аккаунтами, ключами.
    *  `storage.fry` — для работы с пользователями и членством.

1. **Формат заголовков авторизации**
    *  OAuth: `Bearer <access_token>`.
    *  JWT: `JWT <jwt_token>`.
    *  Service: `Bearer <service_token>`.