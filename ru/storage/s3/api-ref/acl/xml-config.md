---
title: XML-структура конфигурации ACL. {{ objstorage-name }} API (S3)
description: Описан общий вид XML-структуры конфигурации ACL, а также каждый ил элементов. AccessControlPolicy, Owner, AccessControlList, Grant, Grantee, ID, DisplayName, URI, Permission.
---

# XML-структура конфигурации ACL

Общий вид ACL:

```xml
<AccessControlPolicy>
  <Owner>
    <ID>8caede4d8w78r43d14f2e7fagrbf45c78ejc7c6cde********</ID>
    <DisplayName>CustomersName@amazon.com</DisplayName>
  </Owner>
  <AccessControlList>
    <Grant>
      <Grantee xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
			xsi:type="CanonicalUser">
        <ID>8caede4d8w78r43d14f2e7fagrbf45c78ejc7c6cde********</ID>
        <DisplayName>YandexCloudUserName</DisplayName>
      </Grantee>
      <Permission>WRITE</Permission>
    </Grant>
  </AccessControlList>
</AccessControlPolicy>
```


## Элементы {#elements}

#|
|| **Элемент** | **Описание** ||
|| `AccessControlPolicy` | Корневой элемент.

Путь: `/AccessControlPolicy`. ||
|| `Owner` | Информация о пользователе.

Пользователь может указать этот элемент для запросов методами `objectPutAcl` и `bucketPutAcl`. Если элемент указан, то при загрузке ACL {{ objstorage-name }} проверяет соответствие переданного идентификатора фактическому и если они не совпадают, то отвечает с кодом 403.

Путь: `/AccessControlPolicy/Owner`. ||
|| `AccessControlList` | Список управления доступом. Не может содержать более 100 доступов.

Путь: `/AccessControlPolicy/AccessControlList`. ||
|| `Grant` | Описание доступа.

Путь: `/AccessControlPolicy/AccessControlList/Grant`. ||
|| `Grantee` | Тип получателя разрешений. Возможные значения для `type`:
* `CanonicalUser` — для пользователя, [сервисного аккаунта](../../../../iam/concepts/users/service-accounts.md) или [группы пользователей](../../../../organization/concepts/groups.md).
* `Group` — для [публичной группы](../../../concepts/acl.md#public-groups).

{% include [canonical-user-identification](../../../../_includes/storage/canonical-user-identification.md) %}

Путь: `/AccessControlPolicy/AccessControlList/Grant/Grantee`. ||
|| `ID` | Идентификатор пользователя, [сервисного аккаунта](../../../../iam/concepts/users/service-accounts.md) или [группы пользователей](../../../../organization/concepts/groups.md). Используется с типом получателя разрешений `CanonicalUser`.

Ответ на запрос `bucketGetAcl` содержит идентификатор каталога, в котором находится бакет.

Пути: `/AccessControlPolicy/Owner/ID`, `/AccessControlPolicy/AccessControlList/Grant/Grantee/ID`. ||
|| `DisplayName` | Имя пользователя. Игнорируется для запросов `objectPutAcl` и `bucketPutAcl`.

Пути: `/AccessControlPolicy/Owner/DisplayName`, `/AccessControlPolicy/AccessControlList/Grant/Grantee/DisplayName`. ||
|| `URI` | Идентификатор [публичной группы](../../../concepts/acl.md#public-groups). Используется с типом получателя разрешений `Group`. Возможные значения:
* `http://acs.amazonaws.com/groups/global/AllUsers` — все пользователи интернета.
* `http://acs.amazonaws.com/groups/global/AuthenticatedUsers` — все аутентифицированные пользователи {{ yandex-cloud }}.

Путь: `/AccessControlPolicy/AccessControlList/Grant/Grantee/URI`. ||
|| `Permission` | Разрешения пользователя.

Можно указать: `READ`, `WRITE` и `FULL_CONTROL`, при выдаче разрешений для объекта можно также указать `READ_ACP`, `WRITE_ACP`. Подробнее читайте в разделе [Список управления доступом (ACL)](../../../concepts/acl.md).

Путь: `/AccessControlPolicy/AccessControlList/Grant/Grantee/DisplayName`. ||
|#

#### Связанные статьи {#related-articles}

* [{#T}](../../../concepts/acl.md)

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}
