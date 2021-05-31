---
editable: false
---

# FederationService

Набор методов для управления федерациями.

| Вызов | Описание |
| --- | --- |
| [Get](#Get) | Возвращает указанную федерацию. |
| [List](#List) | Возвращает список федераций в указанном каталоге. |
| [Create](#Create) | Создает федерацию в указанном каталоге. |
| [Update](#Update) | Изменяет указанную федерацию. |
| [Delete](#Delete) | Удаляет указанную федерацию. |
| [AddUserAccounts](#AddUserAccounts) | Добавляет пользователей в указанную федерацию. |
| [ListUserAccounts](#ListUserAccounts) | Возвращает список пользователей для указанной федерации. |
| [ListOperations](#ListOperations) | Возвращает список операций для указанной федерации. |

## Вызовы FederationService {#calls}

## Get {#Get}

Возвращает указанную федерацию. <br>Чтобы получить список доступных федераций, используйте запрос [List](#List).

**rpc Get ([GetFederationRequest](#GetFederationRequest)) returns ([Federation](#Federation))**

### GetFederationRequest {#GetFederationRequest}

Поле | Описание
--- | ---
federation_id | **string**<br>Идентификатор возвращаемой федерации. Чтобы получить идентификатор федерации, используйте запрос [FederationService.List](#List). Максимальная длина строки в символах — 50.


### Federation {#Federation}

Поле | Описание
--- | ---
id | **string**<br>Обязательное поле. Идентификатор федерации. Максимальная длина строки в символах — 50.
organization_id | **string**<br>Идентификатор организации, которому принадлежит федерация. 
name | **string**<br>Обязательное поле. Имя федерации. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Описание федерации. Максимальная длина строки в символах — 256.
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 
cookie_max_age | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Время жизни файлов cookie в браузере в секундах. Если время жизни cookie не истекло, то консоль управления сразу аутентифицирует пользователя и отправляет на главную страницу. Допустимые значения — от 10m до 12h включительно.
auto_create_account_on_login | **bool**<br>Добавлять новых пользователей автоматически при успешной аутентификации. Пользователи становится членами организации автоматически, но остальные роли надо будет назначить самостоятельно. <br>Если значение `false`, то пользователь, которого не добавили в облако, не сможет войти, даже если пройдет аутентификацию на вашем сервере. 
issuer | **string**<br>Обязательное поле. Идентификатор IdP-сервера, который будет использоваться для аутентификации. Этот же идентификатор сервер IdP указывает в ответе после того, как пользователь проходит аутентификацию. Максимальная длина строки в символах — 8000.
sso_binding | enum **BindingType**<br>Тип привязки для Single Sign-on. Большинство поставщиков поддерживают тип привязки `POST`. <br>Привязка — это отображение сообщения протокола SAML на стандартные форматы сообщений и / или протоколы связи. <ul><li>`POST`: Привязка HTTP POST.</li><li>`REDIRECT`: Привязка перенаправлением HTTP.</li><li>`ARTIFACT`: Привязка артефактом HTTP.</li><ul/>
sso_url | **string**<br>Обязательное поле. URL для Single sign-on. Укажите здесь ссылку на страницу для входа в IdP. Максимальная длина строки в символах — 8000.
security_settings | **[FederationSecuritySettings](#FederationSecuritySettings)**<br>Настройки безопасности федерации. 
case_insensitive_name_ids | **bool**<br>Использовать нечувствительные к регистру Name ID пользователей. 


### FederationSecuritySettings {#FederationSecuritySettings}

Поле | Описание
--- | ---
encrypted_assertions | **bool**<br>Включить шифрование утверждений. 


## List {#List}

Возвращает список федераций в указанном каталоге.

**rpc List ([ListFederationsRequest](#ListFederationsRequest)) returns ([ListFederationsResponse](#ListFederationsResponse))**

### ListFederationsRequest {#ListFederationsRequest}

Поле | Описание
--- | ---
organization_id | **string**<br>Обязательное поле. Идентификатор организации, для которого запрашивается список федераций. Чтобы получить идентификатор организации, используйте запрос [yandex.cloud.organizationmanager.v1.OrganizationService.List](/docs/organization-manager/api-ref/grpc/organization_service#List). Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListFederationsResponse.next_page_token](#ListFederationsResponse), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100. Допустимые значения — от 0 до 1000 включительно.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListFederationsResponse.next_page_token](#ListFederationsResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 50.
filter | **string**<br><ol><li>Имя поля. В настоящее время фильтрация осуществляется только по полю [Federation.name](#Federation1). </li><li>Оператор. Операторы `=` или `!=` для одиночных значений, `IN` или `NOT IN` для списков значений. </li><li>Значение. Значение длиной от 3 до 63 символов, совпадающее с регулярным выражением `^[a-z][-a-z0-9]{1,61}[a-z0-9]$`.</li></ol> Максимальная длина строки в символах — 1000.


### ListFederationsResponse {#ListFederationsResponse}

Поле | Описание
--- | ---
federations[] | **[Federation](#Federation1)**<br>Список федераций. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListFederationsRequest.page_size](#ListFederationsRequest), используйте `next_page_token` в качестве значения параметра [ListFederationsRequest.page_token](#ListFederationsRequest) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


### Federation {#Federation1}

Поле | Описание
--- | ---
id | **string**<br>Обязательное поле. Идентификатор федерации. Максимальная длина строки в символах — 50.
organization_id | **string**<br>Идентификатор организации, которому принадлежит федерация. 
name | **string**<br>Обязательное поле. Имя федерации. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Описание федерации. Максимальная длина строки в символах — 256.
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 
cookie_max_age | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Время жизни файлов cookie в браузере в секундах. Если время жизни cookie не истекло, то консоль управления сразу аутентифицирует пользователя и отправляет на главную страницу. Допустимые значения — от 10m до 12h включительно.
auto_create_account_on_login | **bool**<br>Добавлять новых пользователей автоматически при успешной аутентификации. Пользователи становится членами организации автоматически, но остальные роли надо будет назначить самостоятельно. <br>Если значение `false`, то пользователь, которого не добавили в облако, не сможет войти, даже если пройдет аутентификацию на вашем сервере. 
issuer | **string**<br>Обязательное поле. Идентификатор IdP-сервера, который будет использоваться для аутентификации. Этот же идентификатор сервер IdP указывает в ответе после того, как пользователь проходит аутентификацию. Максимальная длина строки в символах — 8000.
sso_binding | enum **BindingType**<br>Тип привязки для Single Sign-on. Большинство поставщиков поддерживают тип привязки `POST`. <br>Привязка — это отображение сообщения протокола SAML на стандартные форматы сообщений и / или протоколы связи. <ul><li>`POST`: Привязка HTTP POST.</li><li>`REDIRECT`: Привязка перенаправлением HTTP.</li><li>`ARTIFACT`: Привязка артефактом HTTP.</li><ul/>
sso_url | **string**<br>Обязательное поле. URL для Single sign-on. Укажите здесь ссылку на страницу для входа в IdP. Максимальная длина строки в символах — 8000.
security_settings | **[FederationSecuritySettings](#FederationSecuritySettings1)**<br>Настройки безопасности федерации. 
case_insensitive_name_ids | **bool**<br>Использовать нечувствительные к регистру Name ID пользователей. 


### FederationSecuritySettings {#FederationSecuritySettings1}

Поле | Описание
--- | ---
encrypted_assertions | **bool**<br>Включить шифрование утверждений. 


## Create {#Create}

Создает федерацию в указанном каталоге.

**rpc Create ([CreateFederationRequest](#CreateFederationRequest)) returns ([operation.Operation](#Operation))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateFederationMetadata](#CreateFederationMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Federation](#Federation2)<br>

### CreateFederationRequest {#CreateFederationRequest}

Поле | Описание
--- | ---
organization_id | **string**<br>Идентификатор организации, в котором создается федерация. Чтобы получить идентификатор организации, используйте запрос [yandex.cloud.organizationmanager.v1.OrganizationService.List](/docs/organization-manager/api-ref/grpc/organization_service#List). Максимальная длина строки в символах — 50.
name | **string**<br>Название федерации. Имя должно быть уникальным в облаке. Значение должно соответствовать регулярному выражению ` [a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>Описание федерации. Максимальная длина строки в символах — 256.
cookie_max_age | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Время жизни файлов cookie в браузере в секундах. Если время жизни cookie не истекло, то консоль управления сразу аутентифицирует пользователя и отправляет на главную страницу. Значение по умолчанию — `8h`. Допустимые значения — от 10m до 12h включительно.
auto_create_account_on_login | **bool**<br>Добавлять новых пользователей автоматически при успешной аутентификации. Пользователи становится членами организации автоматически, но остальные роли надо будет назначить самостоятельно. <br>Если значение `false`, то пользователь, которого не добавили в облако, не сможет войти, даже если пройдет аутентификацию на вашем сервере. 
issuer | **string**<br>Обязательное поле. Идентификатор IdP-сервера, который будет использоваться для аутентификации. Этот же идентификатор сервер IdP указывает в ответе после того, как пользователь проходит аутентификацию. Максимальная длина строки в символах — 8000.
sso_binding | enum **BindingType**<br>Тип привязки для Single Sign-on. Большинство поставщиков поддерживают тип привязки `POST`. <br>Привязка — это отображение сообщения протокола SAML на стандартные форматы сообщений и / или протоколы связи. <ul><li>`POST`: Привязка HTTP POST.</li><li>`REDIRECT`: Привязка перенаправлением HTTP.</li><li>`ARTIFACT`: Привязка артефактом HTTP.</li><ul/>
sso_url | **string**<br>Обязательное поле. URL для Single sign-on. Укажите здесь ссылку на страницу для входа в IdP. Максимальная длина строки в символах — 8000.
security_settings | **[FederationSecuritySettings](#FederationSecuritySettings2)**<br>Настройки безопасности федерации. 
case_insensitive_name_ids | **bool**<br>Использовать нечувствительные к регистру Name ID пользователей. 


### FederationSecuritySettings {#FederationSecuritySettings2}

Поле | Описание
--- | ---
encrypted_assertions | **bool**<br>Включить шифрование утверждений. 


### Operation {#Operation}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateFederationMetadata](#CreateFederationMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Federation](#Federation2)>**<br>в случае успешного выполнения операции. 


### CreateFederationMetadata {#CreateFederationMetadata}

Поле | Описание
--- | ---
federation_id | **string**<br>Идентификатор создаваемой федерации. 


### Federation {#Federation2}

Поле | Описание
--- | ---
id | **string**<br>Обязательное поле. Идентификатор федерации. Максимальная длина строки в символах — 50.
organization_id | **string**<br>Идентификатор организации, которому принадлежит федерация. 
name | **string**<br>Обязательное поле. Имя федерации. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Описание федерации. Максимальная длина строки в символах — 256.
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 
cookie_max_age | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Время жизни файлов cookie в браузере в секундах. Если время жизни cookie не истекло, то консоль управления сразу аутентифицирует пользователя и отправляет на главную страницу. Допустимые значения — от 10m до 12h включительно.
auto_create_account_on_login | **bool**<br>Добавлять новых пользователей автоматически при успешной аутентификации. Пользователи становится членами организации автоматически, но остальные роли надо будет назначить самостоятельно. <br>Если значение `false`, то пользователь, которого не добавили в облако, не сможет войти, даже если пройдет аутентификацию на вашем сервере. 
issuer | **string**<br>Обязательное поле. Идентификатор IdP-сервера, который будет использоваться для аутентификации. Этот же идентификатор сервер IdP указывает в ответе после того, как пользователь проходит аутентификацию. Максимальная длина строки в символах — 8000.
sso_binding | enum **BindingType**<br>Тип привязки для Single Sign-on. Большинство поставщиков поддерживают тип привязки `POST`. <br>Привязка — это отображение сообщения протокола SAML на стандартные форматы сообщений и / или протоколы связи. <ul><li>`POST`: Привязка HTTP POST.</li><li>`REDIRECT`: Привязка перенаправлением HTTP.</li><li>`ARTIFACT`: Привязка артефактом HTTP.</li><ul/>
sso_url | **string**<br>Обязательное поле. URL для Single sign-on. Укажите здесь ссылку на страницу для входа в IdP. Максимальная длина строки в символах — 8000.
security_settings | **[FederationSecuritySettings](#FederationSecuritySettings3)**<br>Настройки безопасности федерации. 
case_insensitive_name_ids | **bool**<br>Использовать нечувствительные к регистру Name ID пользователей. 


### FederationSecuritySettings {#FederationSecuritySettings3}

Поле | Описание
--- | ---
encrypted_assertions | **bool**<br>Включить шифрование утверждений. 


## Update {#Update}

Изменяет указанную федерацию.

**rpc Update ([UpdateFederationRequest](#UpdateFederationRequest)) returns ([operation.Operation](#Operation1))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateFederationMetadata](#UpdateFederationMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Federation](#Federation3)<br>

### UpdateFederationRequest {#UpdateFederationRequest}

Поле | Описание
--- | ---
federation_id | **string**<br>Идентификатор федерации для обновления. Чтобы получить идентификатор федерации, используйте запрос [FederationService.List](#List). Максимальная длина строки в символах — 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Маска, определяющая, какие поля указанной федерации будут обновлены. 
name | **string**<br>Название федерации. Имя должно быть уникальным в облаке. Значение должно соответствовать регулярному выражению ` |[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>Описание федерации. Максимальная длина строки в символах — 256.
cookie_max_age | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Время жизни файлов cookie в браузере в секундах. Если время жизни cookie не истекло, то консоль управления сразу аутентифицирует пользователя и отправляет на главную страницу. Значение по умолчанию — `8h`. Допустимые значения — от 10m до 12h включительно.
auto_create_account_on_login | **bool**<br>Добавлять новых пользователей автоматически при успешной аутентификации. Пользователи становится членами организации автоматически, но остальные роли надо будет назначить самостоятельно. <br>Если значение `false`, то пользователь, которого не добавили в облако, не сможет войти, даже если пройдет аутентификацию на вашем сервере. 
issuer | **string**<br>Обязательное поле. Идентификатор IdP-сервера, который будет использоваться для аутентификации. Этот же идентификатор сервер IdP указывает в ответе после того, как пользователь проходит аутентификацию. Максимальная длина строки в символах — 8000.
sso_binding | enum **BindingType**<br>Тип привязки для Single Sign-on. Большинство поставщиков поддерживают тип привязки `POST`. <br>Привязка — это отображение сообщения протокола SAML на стандартные форматы сообщений и / или протоколы связи. <ul><li>`POST`: Привязка HTTP POST.</li><li>`REDIRECT`: Привязка перенаправлением HTTP.</li><li>`ARTIFACT`: Привязка артефактом HTTP.</li><ul/>
sso_url | **string**<br>Обязательное поле. URL для Single sign-on. Укажите здесь ссылку на страницу для входа в IdP. Максимальная длина строки в символах — 8000.
security_settings | **[FederationSecuritySettings](#FederationSecuritySettings4)**<br>Настройки безопасности федерации. 
case_insensitive_name_ids | **bool**<br>Использовать нечувствительные к регистру Name ID пользователей. 


### FederationSecuritySettings {#FederationSecuritySettings4}

Поле | Описание
--- | ---
encrypted_assertions | **bool**<br>Включить шифрование утверждений. 


### Operation {#Operation1}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateFederationMetadata](#UpdateFederationMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Federation](#Federation3)>**<br>в случае успешного выполнения операции. 


### UpdateFederationMetadata {#UpdateFederationMetadata}

Поле | Описание
--- | ---
federation_id | **string**<br>Идентификатор федерации, которая обновляется. 


### Federation {#Federation3}

Поле | Описание
--- | ---
id | **string**<br>Обязательное поле. Идентификатор федерации. Максимальная длина строки в символах — 50.
organization_id | **string**<br>Идентификатор организации, которому принадлежит федерация. 
name | **string**<br>Обязательное поле. Имя федерации. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Описание федерации. Максимальная длина строки в символах — 256.
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 
cookie_max_age | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Время жизни файлов cookie в браузере в секундах. Если время жизни cookie не истекло, то консоль управления сразу аутентифицирует пользователя и отправляет на главную страницу. Допустимые значения — от 10m до 12h включительно.
auto_create_account_on_login | **bool**<br>Добавлять новых пользователей автоматически при успешной аутентификации. Пользователи становится членами организации автоматически, но остальные роли надо будет назначить самостоятельно. <br>Если значение `false`, то пользователь, которого не добавили в облако, не сможет войти, даже если пройдет аутентификацию на вашем сервере. 
issuer | **string**<br>Обязательное поле. Идентификатор IdP-сервера, который будет использоваться для аутентификации. Этот же идентификатор сервер IdP указывает в ответе после того, как пользователь проходит аутентификацию. Максимальная длина строки в символах — 8000.
sso_binding | enum **BindingType**<br>Тип привязки для Single Sign-on. Большинство поставщиков поддерживают тип привязки `POST`. <br>Привязка — это отображение сообщения протокола SAML на стандартные форматы сообщений и / или протоколы связи. <ul><li>`POST`: Привязка HTTP POST.</li><li>`REDIRECT`: Привязка перенаправлением HTTP.</li><li>`ARTIFACT`: Привязка артефактом HTTP.</li><ul/>
sso_url | **string**<br>Обязательное поле. URL для Single sign-on. Укажите здесь ссылку на страницу для входа в IdP. Максимальная длина строки в символах — 8000.
security_settings | **[FederationSecuritySettings](#FederationSecuritySettings5)**<br>Настройки безопасности федерации. 
case_insensitive_name_ids | **bool**<br>Использовать нечувствительные к регистру Name ID пользователей. 


### FederationSecuritySettings {#FederationSecuritySettings5}

Поле | Описание
--- | ---
encrypted_assertions | **bool**<br>Включить шифрование утверждений. 


## Delete {#Delete}

Удаляет указанную федерацию.

**rpc Delete ([DeleteFederationRequest](#DeleteFederationRequest)) returns ([operation.Operation](#Operation2))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteFederationMetadata](#DeleteFederationMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteFederationRequest {#DeleteFederationRequest}

Поле | Описание
--- | ---
federation_id | **string**<br>Идентификатор федерации, которую следует удалить. Чтобы получить идентификатор федерации, используйте запрос [FederationService.List](#List). Максимальная длина строки в символах — 50.


### Operation {#Operation2}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteFederationMetadata](#DeleteFederationMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>в случае успешного выполнения операции. 


### DeleteFederationMetadata {#DeleteFederationMetadata}

Поле | Описание
--- | ---
federation_id | **string**<br>Идентификатор удаляемой федерации. 


## AddUserAccounts {#AddUserAccounts}

Добавляет пользователей в указанную федерацию.

**rpc AddUserAccounts ([AddFederatedUserAccountsRequest](#AddFederatedUserAccountsRequest)) returns ([operation.Operation](#Operation3))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[AddFederatedUserAccountsMetadata](#AddFederatedUserAccountsMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[AddFederatedUserAccountsResponse](#AddFederatedUserAccountsResponse)<br>

### AddFederatedUserAccountsRequest {#AddFederatedUserAccountsRequest}

Поле | Описание
--- | ---
federation_id | **string**<br>Идентификатор федерации для добавления пользователей. Максимальная длина строки в символах — 50.
name_ids[] | **string**<br>Name ID пользователей, которые возвращает поставщик удостоверений (IdP) после успешной аутентификации. Это могут быть UPN или email пользователей. Максимальная длина строки в символах для каждого значения — 1000.


### Operation {#Operation3}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[AddFederatedUserAccountsMetadata](#AddFederatedUserAccountsMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[AddFederatedUserAccountsResponse](#AddFederatedUserAccountsResponse)>**<br>в случае успешного выполнения операции. 


### AddFederatedUserAccountsMetadata {#AddFederatedUserAccountsMetadata}

Поле | Описание
--- | ---
federation_id | **string**<br>Идентификатор изменяемой Федерации. 


### AddFederatedUserAccountsResponse {#AddFederatedUserAccountsResponse}

Поле | Описание
--- | ---
user_accounts[] | **[UserAccount](./#UserAccount)**<br>Список пользователей, созданных с помощью запроса [FederationService.AddUsers](./saml/federation_service#AddUsers). 


### UserAccount {#UserAccount}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор аккаунта пользователя 
user_account | **oneof:** `yandex_passport_user_account` или `saml_user_account`<br>
&nbsp;&nbsp;yandex_passport_user_account | **YandexPassportUserAccount**<br>Ресурс YandexPassportUserAccount. 
&nbsp;&nbsp;saml_user_account | **SamlUserAccount**<br>Пользователь федерации. 


### YandexPassportUserAccount {#YandexPassportUserAccount}

Поле | Описание
--- | ---
login | **string**<br>Логин аккаунта Яндекс.Паспорта. 
default_email | **string**<br>Email используемый по умолчанию для пользователя с аккаунтом Яндекс.Паспорта. 


### SamlUserAccount {#SamlUserAccount}

Поле | Описание
--- | ---
federation_id | **string**<br>Обязательное поле. Идентификатор федерации, которой принадлежит пользователь. Максимальная длина строки в символах — 50.
name_id | **string**<br>Обязательное поле. Идентификатор имени пользоваетля федерации. Идентификатор имени должен быть уникальным в федерации. Длина 1-256 символов. Длина строки в символах должна быть от 1 до 256.
attributes | **map<string,Attribute>**<br>Дополнительные атрибуты пользователя. 


### Attribute {#Attribute}

Поле | Описание
--- | ---
value[] | **string**<br> 


## ListUserAccounts {#ListUserAccounts}

Возвращает список пользователей для указанной федерации.

**rpc ListUserAccounts ([ListFederatedUserAccountsRequest](#ListFederatedUserAccountsRequest)) returns ([ListFederatedUserAccountsResponse](#ListFederatedUserAccountsResponse))**

### ListFederatedUserAccountsRequest {#ListFederatedUserAccountsRequest}

Поле | Описание
--- | ---
federation_id | **string**<br>Обязательное поле. Идентификатор федерации для перечисления пользователей. Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListFederatedUserAccountsResponse.next_page_token](#ListFederatedUserAccountsResponse), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100. Допустимые значения — от 0 до 1000 включительно.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListFederatedUserAccountsResponse.next_page_token](#ListFederatedUserAccountsResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.


### ListFederatedUserAccountsResponse {#ListFederatedUserAccountsResponse}

Поле | Описание
--- | ---
user_accounts[] | **[UserAccount](./#UserAccount1)**<br>Список пользователей для указанной федерации. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListFederatedUserAccountsRequest.page_size](#ListFederatedUserAccountsRequest), используйте `next_page_token` в качестве значения параметра [ListFederatedUserAccountsRequest.page_token](#ListFederatedUserAccountsRequest) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


### UserAccount {#UserAccount1}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор аккаунта пользователя 
user_account | **oneof:** `yandex_passport_user_account` или `saml_user_account`<br>
&nbsp;&nbsp;yandex_passport_user_account | **YandexPassportUserAccount**<br>Ресурс YandexPassportUserAccount. 
&nbsp;&nbsp;saml_user_account | **SamlUserAccount**<br>Пользователь федерации. 


### YandexPassportUserAccount {#YandexPassportUserAccount1}

Поле | Описание
--- | ---
login | **string**<br>Логин аккаунта Яндекс.Паспорта. 
default_email | **string**<br>Email используемый по умолчанию для пользователя с аккаунтом Яндекс.Паспорта. 


### SamlUserAccount {#SamlUserAccount1}

Поле | Описание
--- | ---
federation_id | **string**<br>Обязательное поле. Идентификатор федерации, которой принадлежит пользователь. Максимальная длина строки в символах — 50.
name_id | **string**<br>Обязательное поле. Идентификатор имени пользоваетля федерации. Идентификатор имени должен быть уникальным в федерации. Длина 1-256 символов. Длина строки в символах должна быть от 1 до 256.
attributes | **map<string,Attribute>**<br>Дополнительные атрибуты пользователя. 


### Attribute {#Attribute1}

Поле | Описание
--- | ---
value[] | **string**<br> 


## ListOperations {#ListOperations}

Возвращает список операций для указанной федерации.

**rpc ListOperations ([ListFederationOperationsRequest](#ListFederationOperationsRequest)) returns ([ListFederationOperationsResponse](#ListFederationOperationsResponse))**

### ListFederationOperationsRequest {#ListFederationOperationsRequest}

Поле | Описание
--- | ---
federation_id | **string**<br>Идентификатор федерации для перечисления операций. Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListFederationOperationsOperationsResponse.next_page_token], которое можно использовать для получения следующей страницы. Значение по умолчанию: 100. Допустимые значения — от 0 до 1000 включительно.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListFederationOperationsResponse.next_page_token](#ListFederationOperationsResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.


### ListFederationOperationsResponse {#ListFederationOperationsResponse}

Поле | Описание
--- | ---
operations[] | **[operation.Operation](#Operation4)**<br>Список операций для указанной федерации. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListFederationOperationsRequest.page_size](#ListFederationOperationsRequest), используйте `next_page_token` в качестве значения параметра [ListFederationOperationsRequest.page_token](#ListFederationOperationsRequest) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


### Operation {#Operation4}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**<br>Результат операции в случае успешного завершения. Если исходный метод не возвращает никаких данных при успешном завершении, например метод Delete, поле содержит объект [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty). Если исходный метод — это стандартный метод Create / Update, поле содержит целевой ресурс операции. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `response`. 


