[Документация Yandex Cloud](../../index.md) > [Yandex Identity and Access Management](../index.md) > [Концепции](index.md) > Получение информации о субъектах

# Получение информации о субъектах в системе управления доступом Yandex Cloud

Yandex Identity and Access Management предоставляет инструмент [получения информации о субъектах](../operations/subject-details.md) для одновременного поиска и получения атрибутов различных [типов субъектов](#subject-types) системы управления доступом Yandex Cloud.

Дополнительную гибкость при поиске и получении атрибутов субъектов дает использование фильтров на основе языка [Common Expression Language (CEL)](https://cel.dev/).

Функциональность получения информации о субъектах доступна в интерфейсах Yandex Cloud [CLI](../../cli/cli-ref/iam/cli-ref/subject-details/index.md) и [API](../api-ref/grpc/SubjectDetails/index.md).

## Типы субъектов {#subject-types} 

Функциональность получения информации о субъектах позволяет выполнять поиск одновременно по разным типам субъектов в [организации](*organization):

Тип субъекта | Описание | Минимальная [роль](access-control/roles.md), необходимая для получения информации
--- | --- | ---
`USER_ACCOUNT` | Пользователи [с аккаунтом на Яндексе](users/accounts.md#passport), [локальные](users/accounts.md#local) и [федеративные](users/accounts.md#saml-federation) пользователи | [organization-manager.users.viewer](../../organization/security/index.md#organization-manager-users-viewer) или выше на организацию
`SERVICE_ACCOUNT` | [Сервисные аккаунты](users/service-accounts.md) | [iam.auditor](../security/index.md#iam-auditor) или выше на организацию
`GROUP` | [Группы пользователей](../../organization/concepts/groups.md), [системные](access-control/system-group.md) и [публичные](access-control/public-group.md) группы | [organization-manager.groups.viewer](../../organization/security/index.md#organization-manager-groups-viewer) или выше на организацию
`INVITEE` | Пользователи с аккаунтом на Яндексе, которые были [приглашены](../../organization/operations/add-account.md#send-invitation) в организацию, но еще не приняли приглашение | [organization-manager.users.viewer](../../organization/security/index.md#organization-manager-users-viewer) или выше на организацию

## Доступные методы {#methods}

В Identity and Access Management доступны два метода для получения информации о субъектах: [List](#list) и [BatchGet](#batch-get). 

При вызове обоих методов вы можете передать маску субъектов (`field-mask`), которая определяет, какие атрибуты субъектов необходимо получить. Если не указать маску субъектов, по умолчанию возвращаются только атрибуты `sub` и `type`. Доступные атрибуты зависят от [типа субъекта](#subject-types). Подробнее читайте в разделе [Атрибуты субъектов](#attributes).

Также при вызове обоих методов вы можете использовать гибкий [CEL-фильтр](#filter), чтобы максимально конкретизировать список субъектов, информацию по которым вы хотите получить.

Подробнее об использовании методов получения информации о субъектах читайте в разделе [Получение информации о субъектах в системе управления доступом Yandex Cloud](../operations/subject-details.md).

### List {#list}

Метод `List` предоставляет список и информацию о субъектах организации по ее идентификатору. Вызвать метод `List` можно с помощью [REST API](../api-ref/SubjectDetails/list.md), [gRPC API](../api-ref/grpc/SubjectDetails/list.md) или [команды CLI](../../cli/cli-ref/iam/cli-ref/subject-details/list.md) `yc iam subject-details list`.

При вызове метода `List` обязательно передавайте [идентификатор организации](../../organization/operations/organization-get-id.md), в которой будет выполняться поиск субъектов.

### BatchGet {#batch-get}

Метод `BatchGet` предоставляет информацию о заданных субъектах организации по их идентификаторам. Вызвать метод `BatchGet` можно с помощью [REST API](../api-ref/SubjectDetails/batchGet.md), [gRPC API](../api-ref/grpc/SubjectDetails/batchGet.md) или [команды CLI](../../cli/cli-ref/iam/cli-ref/subject-details/get.md) `yc iam subject-details get`.

Вызов метода `BatchGet` должен обязательно содержать один или более идентификаторов субъектов, информацию о которых необходимо получить.

Чтобы получить список групп, участником которых является пользователь с аккаунтом на Яндексе, обязательно передавайте в метод `BatchGet` [идентификатор организации](../../organization/operations/organization-get-id.md).

## Атрибуты субъектов {#attributes}

С помощью методов `List` и `BatchGet` вы можете получить значения следующих атрибутов субъектов:

{% note info %}

Маска субъектов (`field-mask`), передаваемая в методах `List` и `BatchGet`, должна содержать имена полей без указания имени основного контейнера `subject`. Например: `sub`, `user_account` или `service_account.service_agent.microservice_id`.

{% endnote %}

#|
|| **Поле** | **Тип данных** | **Атрибут** ||
|| **subject** — основной контейнер, содержащий все атрибуты субъекта. | > | > ||
|| `subject.sub` | `string` | [Идентификатор](../../api-design-guide/concepts/resources-identification.md) субъекта. ||
|| `subject.type` | `enum` ^1^ |
[Тип субъекта](#subject-types) в системе управления доступом:
* `1` — пользовательский аккаунт, соответствует возвращаемому значению `USER_ACCOUNT`;
* `2` — сервисный аккаунт, соответствует возвращаемому значению `SERVICE_ACCOUNT`;
* `3` — группа, соответствует возвращаемому значению `GROUP`;
* `4` – приглашенный пользователь, соответствует возвращаемому значению `INVITEE`;
||
|| `subject.created_at` | [timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp) | Дата и время создания субъекта. ||
|| `subject.status` | `enum` ^1^ |
Статус субъекта (только для федеративных и локальных пользователей):
* `1` — активный статус, соответствует возвращаемому значению `ACTIVE`;
* `2` — неактивный статус, соответствует возвращаемому значению `SUSPENDED`.
||
|| `subject.name` | `string` | Имя субъекта. ||
|| `subject.last_authenticated_at` | [timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp) | Дата и время последней аутентификации. ||
|| `subject.external_id` | `string` | Идентификатор субъекта во внешней системе. ||
|| **subject.groups** — набор полей с атрибутами групп, участником которых является пользователь или сервисный аккаунт. ^2^ | > | > ||
|| `subject.groups.type` | `enum` ^1^ |
Тип группы:
* `1` — [публичная группа](access-control/public-group.md), соответствует возвращаемому значению `PUBLIC_ACCESS`;
* `2` — [группа пользователей](../../organization/concepts/groups.md), соответствует возвращаемому значению `EXPLICIT`;
* `3` — [системная группа](access-control/system-group.md), соответствует возвращаемому значению `META`.
||
|| `subject.groups.id` | `string` | Идентификатор группы пользователей, системной или публичной группы. ||
|| `subject.groups.name` | `string` | Имя группы пользователей, системной или публичной группы. ||
|| **subject.user_account** — набор полей с атрибутами, специфичными для субъектов-пользователей. | > | > ||
|| `subject.user_account.given_name` | `string` | Имя. ||
|| `subject.user_account.family_name` | `string` | Фамилия. ||
|| `subject.user_account.preferred_username` | `string` | Логин пользователя. ||
|| `subject.user_account.email` | `string` | Адрес электронной почты пользователя. ||
|| `subject.user_account.phone_number` | `string` | Номер телефона. ||
|| `subject.user_account.expires_at` | [timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp) | Дата и время плановой деактивации пользователя (если установлена). Только для федеративных и локальных пользователей. ||
|| `subject.user_account.modified_at` | [timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp) | Дата и время последнего изменения атрибутов пользователя. ||
|| `subject.user_account.last_id_proof_at` | [timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp) | Дата и время последней верификации пользователя. ||
|| `subject.user_account.suspend_reason` | `string` | Причина деактивации (только для федеративных и локальных пользователей). ||
|| **subject.user_account.subject_container** — набор полей с атрибутами, специфичными для различных типов субъектов-пользователей. | > | > ||
||
`subject.user_account.subject_container.container_type`
| `enum` ^1^ |
В зависимости от типа пользователя:
* `1` — пользователь SAML-совместимой федерации удостоверений, соответствует возвращаемому значению `SAML`;
* `3` — пользователь с аккаунтом на Яндексе, соответствует возвращаемому значению `PASSPORT`;
* `4` — локальный пользователь, соответствует возвращаемому значению `USERPOOL`.
||
|| `subject.user_account.subject_container.id` | `string` |
В зависимости от типа пользователя:
* для локальных пользователей — идентификатор [пула пользователей](../../organization/concepts/user-pools.md);
* для федеративных пользователей — идентификатор [федерации удостоверений](../../organization/concepts/add-federation.md);
* для пользователей с аккаунтом на Яндексе — значение `yandex`.
||
||
`subject.user_account.subject_container.name`
| `string` |
В зависимости от типа пользователя:
* для локальных пользователей — имя пула пользователей;
* для федеративных пользователей — имя федерации удостоверений;
* для пользователей с аккаунтом на Яндексе — значение `yandex`.
||
|| **subject.user_account.job_info** — набор полей с атрибутами, которые содержат информацию о компании и должности пользователя. | > | > ||
|| `subject.user_account.job_info.company_name` | `string` | Название компании. ||
|| `subject.user_account.job_info.department` | `string` | Подразделение. ||
|| `subject.user_account.job_info.job_title` | `string` | Должность. ||
|| `subject.user_account.job_info.employee_id` | `string` | Табельный номер сотрудника. ||
|| **subject.invitee** — набор полей с атрибутами, специфичными для пользователей с аккаунтом на Яндексе, которые были приглашены в организацию, но еще не приняли приглашение. | > | > ||
|| `subject.invitee.email` | `string` | Адрес электронной почты пользователя. ||
|| `subject.invitee.preferred_username` | `string` | Логин пользователя. ||
|| **subject.service_account** — набор полей с атрибутами, специфичными для сервисных аккаунтов. | > | > ||
|| **subject.service_account.cloud** — набор полей с атрибутами, содержащими информацию об облаке, к которому относится сервисный аккаунт. | > | > ||
|| `subject.service_account.cloud.id` | `string` | Идентификатор облака. ||
|| `subject.service_account.cloud.name` | `string` | Имя облака. ||
|| **subject.service_account.folder** — набор полей с атрибутами, содержащими информацию о каталоге, к которому относится сервисный аккаунт. | > | > ||
|| `subject.service_account.folder.id` | `string` | Идентификатор каталога. ||
|| `subject.service_account.folder.name` | `string` | Имя каталога. ||
|| **subject.service_account.service_agent** — набор полей с атрибутами, специфичными для сервисных аккаунтов, которые являются [сервисными агентами](service-control.md#service-agent). | > | > ||
||
`subject.service_account.service_agent.service_id`
| `string` | Идентификатор сервиса, от имени которого действует сервисный агент. ||
||
`subject.service_account.service_agent.microservice_id`
| `string` | Идентификатор микросервиса, от имени которого действует сервисный агент. ||
|| **subject.group** — набор полей с атрибутами, специфичными для групп пользователей, системных и публичных групп. | > | > ||
|| `subject.group.type` | `enum` ^1^ |
Тип группы:
* `1` — [публичная группа](access-control/public-group.md), соответствует возвращаемому значению `PUBLIC_ACCESS`;
* `2` — [группа пользователей](../../organization/concepts/groups.md), соответствует возвращаемому значению `EXPLICIT`;
* `3` — [системная группа](access-control/system-group.md), соответствует возвращаемому значению `META`.
||
|| `subject.group.id` | `string` | Идентификатор группы пользователей, системной или публичной группы. ||
|| `subject.group.name` | `string` | Имя группы пользователей, системной или публичной группы. ||
|#

{sticky-header}

^1^ Значения полей с типом данных `enum`, передаваемые в фильтре (`filter`) запроса, должны указываться в числовом формате.
^2^ Чтобы с помощью метода [BatchGet](#batch-get) получить список групп, участником которых является пользователь с аккаунтом на Яндексе, обязательно передавайте в запросе [идентификатор организации](../../organization/operations/organization-get-id.md).

## Фильтр субъектов {#filter}

При получении списка и информации о субъектах вы можете применять фильтр, который позволяет максимально гибко управлять результатами поиска и выводить только необходимые релевантные результаты.

Фильтр задается в поле `filter` и основан на языке [Common Expression Language (CEL)](https://cel.dev/).

Подробнее о доступных функциях CEL читайте в [официальной документации](https://cel.dev/reference/api-reference).

В дополнение к стандартным функциям CEL в Identity and Access Management реализована функция `icontains`, позволяющая выполнять _регистронезависимую_ проверку вхождения подстроки в строку. Например:

```text
"ABcdEf".icontains("abc") // true
```

Подробнее об использовании фильтров при получении информации о субъектах читайте в разделе [Получение информации о субъектах в системе управления доступом Yandex Cloud](../operations/subject-details.md).

#### Полезные ссылки {#see-also}

* [Получение информации о субъектах в системе управления доступом Yandex Cloud](../operations/subject-details.md)

[*organization]: _Организация_ — это высший ресурс в иерархии ресурсной модели Yandex Cloud, который объединяет ресурсы всех остальных сервисов, а также используется для управления пользователями и параметрами их аутентификации и авторизации. Подробнее читайте в разделе [Организация](../../organization/concepts/organization.md).