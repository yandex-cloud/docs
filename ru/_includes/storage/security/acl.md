# Список управления доступом (ACL)

{% include [full-overview](./full-overview.md) %}

ACL {{ objstorage-name }} — список разрешений для каждого объекта и бакета, хранящийся непосредственно в {{ objstorage-name }}.

Разрешения, выданные на бакет, распространяются на все находящиеся в нем объекты. Также ACL позволяет расширить доступы к отдельному объекту.

{% note warning %}

Бакет [наследует](#inheritance) такие же права доступа в сервисе {{ iam-short-name }}, как у каталога и облака, в котором он находится.

{% endnote %}

> Например, если у пользователя в сервисе {{ iam-short-name }} есть роль `viewer` на каталог с бакетом, то он может просматривать его содержимое, даже если это не отражено в ACL бакета.

По умолчанию для каждого нового объекта или бакета {{ objstorage-name }} создает пустой ACL. Пользователь, обладающий соответствующими правами, может отредактировать или загрузить ACL для бакетов и объектов {{ objstorage-name }}.

С помощью ACL можно выдать разрешения пользователю {{ yandex-cloud }}, [сервисному аккаунту](../../../iam/concepts/users/service-accounts.md), [группе пользователей](../../../organization/concepts/groups.md) или [публичной группе](#public-groups) (группе всех пользователей интернета, группе всех аутентифицированных пользователей {{ yandex-cloud }}), при этом необходимо знать [идентификатор получателя разрешений](#accounts-ids). При выдаче разрешений вы можете использовать [предопределенные ACL](#predefined-acls), которые содержат популярные наборы доступов.


{% include [console-sa-acl-note](../console-sa-acl-note.md) %}

Описание структуры ACL смотрите в разделе [XML-схема ACL](../../../storage/s3/api-ref/acl/xml-config.md). В одном ACL вы можете задать не более 100 правил.

{% note info %}

ACL, загруженный для объектов, применяется мгновенно. ACL, загруженный для бакетов, и доступы, измененные в {{ iam-short-name }}, применяются с задержкой. Подробнее про задержки читайте в [документации {{ iam-short-name }}](../../../iam/concepts/access-control/index.md).

{% endnote %}

## Идентификатор получателя разрешений {#accounts-ids}

* Пользователь {{ yandex-cloud }}

  Идентификатор можно получить:
  * В разделе [IAM]({{ link-console-access-management }}) консоли управления.
  * С помощью [CLI или API {{ iam-short-name }}](../../../iam/operations/users/get.md).
* [Сервисный аккаунт](../../../iam/concepts/users/service-accounts)

  Для получения идентификатора перейдите в раздел **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}** консоли управления.

* [Публичная группа](#public-groups)

  Для выдачи разрешений используйте URI публичной группы.

* [Группа пользователей](../../../organization/concepts/groups.md)

  Для получения идентификатора перейдите на вкладку [**{{ ui-key.yacloud_org.pages.groups }}**]({{ link-org-main }}groups) в интерфейсе {{ org-name }}.

  Задать группу пользователей можно с помощью {{ yandex-cloud }} CLI, AWS CLI, {{ TF }} и API. Подробнее см. на страницах [Редактирование ACL бакета](../../../storage/operations/buckets/edit-acl.md) и [Редактирование ACL объекта](../../../storage/operations/objects/edit-acl.md).

## Операции с ACL {#acl-operations}

* В консоли управления вы можете редактировать ACL для [бакетов](../../../storage/operations/buckets/edit-acl.md) и [объектов](../../../storage/operations/objects/edit-acl.md).
* С помощью [API](../../../glossary/rest-api.md), совместимого с Amazon S3, вы можете [загрузить или скачать](../../../storage/s3/api-ref/acl.md) ACL для бакета или объекта.

  Удалить ACL невозможно. Чтобы удалить все разрешения, загрузите пустой ACL.

## Виды разрешений {#permissions-types}

Разрешения соответствуют ролям пользователей в {{ iam-short-name }}.

Название разрешения | Роль в {{ iam-short-name }} | Описание
--- |--- |---
`READ` | `viewer` | Для бакета: разрешение на получение списка объектов в бакете, чтение различных настроек бакета (жизненный цикл, CORS, статический хостинг), чтение всех объектов в бакете.<br>Для объекта: разрешение на чтение.
`WRITE` | `editor` | Для бакета: запись, перезапись и удаление объектов в бакете.<br>Используется обязательно вместе с `READ`, отдельно указать разрешение `WRITE` нельзя.<br>Для объекта: разрешение не имеет смысла, при записи объекта проверяются разрешения для бакета.
`FULL_CONTROL` | `admin` | Полный доступ к объектам и бакетам.
`READ_ACP` | `viewer` | Разрешение на чтение ACL. Только для объектов.
`WRITE_ACP` | `editor` | Разрешение на запись ACL. Только для объектов.

{% note info %}

Если при оформлении ACL указать доступ `WRITE`, но при этом не указать `READ`, то {{ objstorage-name }} ответит с кодом `501 Not Implemented`.

{% endnote %}

## Предопределенные ACL {#predefined-acls}

ACL | Описание
--- |---
`private`<br>`bucket-owner-full-control` | Пользователи {{ yandex-cloud }} получают разрешения в соответствии со своими ролями в {{ iam-short-name }}.
`public-read` | Публичная группа `AllUsers` получает разрешение `READ`.
`public-read-write` | Публичная группа `AllUsers` получает разрешения `READ` и `WRITE`.
`authenticated-read` | Публичная группа `AuthenticatedUsers` получает разрешение `READ`.

Предопределенные ACL могут применяться как к объектам, так и к бакетам. ACL `public-read-write`, примененный к объекту, эквивалентен `public-read`.

Загрузить предопределенный ACL можно только с помощью [HTTP API, совместимого с Amazon S3](../../../storage/s3/api-ref/acl.md). При загрузке ACL используйте HTTP-заголовок `X-Amz-Acl`.

## Публичные группы {#public-groups}

### AllUsers {#all-users}

Включает в себя всех пользователей интернета.

Разрешение для `AllUsers` выглядит следующим образом:

```xml
<Grantee xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="Group">
    <URI>http://acs.amazonaws.com/groups/global/AllUsers</URI>
</Grantee>
```

### AuthenticatedUsers {#authenticated-users}

Включает в себя всех аутентифицированных пользователей {{ yandex-cloud }}: как из вашего облака, так и из облаков других пользователей.

Разрешение для `AuthenticatedUsers` выглядит следующим образом:

```xml
<Grantee xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="Group">
    <URI>http://acs.amazonaws.com/groups/global/AuthenticatedUsers</URI>
</Grantee>
```

## Наследование прав доступа к бакету публичными группами {{ yandex-cloud }} {#inheritance}

Бакет наследует такие же права доступа в сервисе {{ iam-short-name }}, как у каталога и облака, в котором он находится. Если у пользователя есть права доступа к каталогу или облаку, которым принадлежит бакет, то у него будут права доступа и к самому бакету.

{% note warning %}

Назначение ролей [публичным группам](../../../iam/concepts/access-control/public-group.md) `All users` и `All authenticated users` на каталог или облако, которым принадлежит бакет, эквивалентно выдаче **публичного доступа** к бакету:
* `All authenticated users` — доступ к бакету получат все аутентифицированные пользователи {{ yandex-cloud }}: как из вашего облака, так и из облаков других пользователей.
* `All users` — доступ получат все пользователи.

Аналогичный доступ к бакету можно выдать, добавив в ACL бакета права для групп `AuthenticatedUsers` и `AllUsers`.

{% endnote %}

### Как посмотреть права на бакет, наследуемые от каталога {#examples}

Бакет наследует права от каталога. Если вы хотите знать, какие именно права унаследовал бакет, получите список ролей на каталог. Также вы можете в любой момент отозвать эти роли.

* Чтобы получить список ролей на каталог, выполните команду:

  ```bash
  yc resource-manager folder list-access-bindings \
    --id b1g7gvsi89m3********
  ```

  Результат:

  ```text
  +---------+--------------+-----------------------+
  | ROLE ID | SUBJECT TYPE |      SUBJECT ID       |
  +---------+--------------+-----------------------+
  | viewer  | system       | allAuthenticatedUsers |
  | viewer  | system       | allUsers              |
  +---------+--------------+-----------------------+
  ```

  В выводе присутствует `allAuthenticatedUsers` и `allUsers`. Это значит, что пользователи этих групп имеют права на данный каталог и все содержащиеся в нем ресурсы, в том числе бакеты.

* Чтобы отозвать роль у публичной группы `All authenticated users` выполните команду:

  ```bash
  yc resource-manager folder remove-access-binding \
    --id b1g7gvsi89m3******** \
    --role viewer \
    --allAuthenticatedUsers
  ```

* Чтобы отозвать роль у публичной группы `All users` выполните команду:

  ```bash
  yc resource-manager folder remove-access-binding \
    --id b1g7gvsi89m3******** \
    --role viewer \
    --allUsers
  ```

### См. также {#see-also}

* [{#T}](../../../storage/operations/buckets/edit-acl.md)
* [{#T}](../../../storage/operations/objects/edit-acl.md)