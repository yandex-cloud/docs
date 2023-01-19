---
title: "XML-структура конфигурации ACL. {{ objstorage-name }} API (S3)"
description: "Описан общий вид XML-структуры конфигурации ACL, а также каждый ил элементов. AccessControlPolicy, Owner, AccessControlList, Grant, Grantee, ID, DisplayName, URI, Permission."
---

# XML-структура конфигурации ACL

Общий вид ACL:

```
<AccessControlPolicy>
  <Owner>
    <ID>8caede4d8w78r43d14f2e7fagrbf45c78ejc7c6cdeag4ba89s</ID>
    <DisplayName>CustomersName@amazon.com</DisplayName>
  </Owner>
  <AccessControlList>
    <Grant>
      <Grantee xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
			xsi:type="CanonicalUser">
        <ID>8caede4d8w78r43d14f2e7fagrbf45c78ejc7c6cdeag4ba89s</ID>
        <DisplayName>YandexCloudUserName</DisplayName>
      </Grantee>
      <Permission>WRITE</Permission>
    </Grant>
  </AccessControlList>
</AccessControlPolicy>
```


## Элементы {#elements}

Элемент | Описание
----- | -----
`AccessControlPolicy` | Корневой элемент.<br/><br/>Путь: `/AccessControlPolicy`.
`Owner` | Информация о пользователе.<br/><br/>Пользователь может указать этот элемент для запросов методами `objectPutAcl` и `bucketPutAcl`. Если элемент указан, то при загрузке ACL {{ objstorage-name }} проверяет соответствие переданного идентификатора фактическому и если они не совпадают, то отвечает с кодом 403.<br/><br/>Путь: `/AccessControlPolicy/Owner`.
`AccessControlList` | Список управления доступом. Не может содержать более 100 доступов.<br/><br/>Путь: `/AccessControlPolicy/AccessControlList`.
`Grant` | Описание доступа.<br/><br/>Путь: `/AccessControlPolicy/AccessControlList/Grant`.
`Grantee` | Пользователь или группа для которой выдается доступ.<br/><br/>Путь: `/AccessControlPolicy/AccessControlList/Grant/Grantee`.
`ID` | Идентификатор пользователя.<br/><br/>Ответ на запрос `bucketGetAcl` содержит идентификатор каталога, в котором находится бакет.<br/><br/>Пути: `/AccessControlPolicy/Owner/ID`, `/AccessControlPolicy/AccessControlList/Grant/Grantee/ID`.
`DisplayName` | Имя пользователя. Игнорируется для запросов `objectPutAcl` и `bucketPutAcl`<br/><br/>Пути: `/AccessControlPolicy/Owner/DisplayName`, `/AccessControlPolicy/AccessControlList/Grant/Grantee/DisplayName`.
`URI` | Идентификатор [системной группы](../../../concepts/acl.md#system-groups).<br/><br/>Путь: `/AccessControlPolicy/AccessControlList/Grant/Grantee/URI`.
`Permission` | Разрешения пользователя.<br/><br/>Можно указать: `READ`, `WRITE` и `FULL_CONTROL`, при выдаче разрешений для объекта можно также указать `READ_ACP`, `WRITE_ACP`. Подробнее читайте в разделе [Список управления доступом (ACL)](../../../concepts/acl.md).<br/><br/>Путь: `/AccessControlPolicy/AccessControlList/Grant/Grantee/DisplayName`.
