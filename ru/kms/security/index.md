# Управление доступом

В этом разделе вы узнаете:
* [на какие ресурсы можно назначить роль](#resources);
* [какие роли действуют в сервисе](#roles-list);
* [какие роли необходимы](#choosing-roles) для того или иного действия.

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## На какие ресурсы можно назначить роль {#resources}

Роль можно назначить на [облако](../../resource-manager/concepts/resources-hierarchy.md#cloud), [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder) или [ключ](../concepts/key). Эти роли будут действовать и на вложенные ресурсы.
 
## Какие роли действуют в сервисе {#roles-list}

Управлять доступом к ключам {{ kms-short-name }} можно как с помощью сервисных, так и с помощью примитивных ролей. На диаграмме показано, какие роли есть в сервисе и как они наследуют разрешения друг друга. Например, в `editor` входят все разрешения `viewer`. После диаграммы дано описание каждой роли.

![image](../../_assets/kms/service-roles-hierarchy.svg)

### Сервисные роли {#service}

Сервисные роли обеспечивают более гранулярный, учитывающий специфику сервиса, контроль над ключами {{ kms-short-name }}: предполагают строгое разделение субъектов на администраторов ключей (роль `kms.admin`) и пользователей (роль `kms.keys.encrypterDecrypter`).

Пользователи, у которых отсутствует роль `resource-manager.clouds.owner` или роль `admin`, не могут назначать роли через консоль управления.

Список сервисных ролей:
* `kms.keys.encrypterDecrypter` – позволяет осуществлять операции шифрования и расшифровки данных, а также просматривать информацию о ключах.
* `kms.admin` – позволяет управлять ключами (просмотр, создание, изменение, удаление, ротация, шифрование и расшифровка данных). Также позволяет назначать роль `kms.keys.encrypterDecrypter` на ключи с помощью CLI и API.


### Примитивные роли {#primitive}

Примитивные роли – общие для всех ресурсов {{ yandex-cloud }}. Назначение любой из них дает некоторые разрешения как в {{ kms-short-name }}, так и в других облачных сервисах. Например, роль `admin`, назначенная на каталог, позволяет удалять любые ключи {{ kms-short-name }} в каталоге, а также дает возможность изменять сам каталог или ресурсы в нем. Управлять примитивными ролями можно с помощью консоли управления.

Список примитивных ролей:
* {% include [viewer](../../_includes/iam/roles/short-descriptions/viewer.md) %}
* {% include [editor](../../_includes/iam/roles/short-descriptions/editor.md) %}
* {% include [admin](../../_includes/iam/roles/short-descriptions/admin.md) %}

## Какие роли мне необходимы {#choosing-roles}

**Пример разграничения доступа к ключам**

С ролями рекомендуется работать следующим образом:
1. Владелец (роль `resource-manager.clouds.owner`) или администратор (роль `admin`) облака назначает роль `kms.admin` администратору {{ kms-short-name }}. 
1. Администратор {{ kms-short-name }} создает необходимое количество ключей и назначает (с помощью CLI или API) роли для их использования: субъекты, представляющие разные команды, получают роль `kms.keys.encrypterDecrypter` на необходимые им ключи.

Хорошей практикой является хранение ключей {{ kms-short-name }} в выделенном каталоге, отдельно от других ресурсов {{ yandex-cloud }}.

Действие | Методы | Необходимые роли
----- | ----- | -----
**KMS** | | 
Получение информации о ключах и версиях | `get`, `listVersions` | `kms.keys.encrypterDecrypter` на ключ
Операции [шифрования и расшифровки](../api-ref/SymmetricCrypto/) | `encrypt`, `decrypt`, `reEncrypt`, `generateDataKey` | `kms.keys.encrypterDecrypter` на ключ
Получение списка ключей в каталоге | `list` | `kms.admin` на ключ
[Создание](../operations/key.md#create) и [изменение](../operations/key.md#update) ключа | `create`, `update` | `kms.admin` на ключ
[Ротация ключа](../operations/key.md#rotate) и [смена основной версии](../operations/version.md#make-primary) | `rotate`, `setPrimaryVersion` | `kms.admin` на ключ
[Удаление ключей](../operations/key.md#delete) и [удаление версий](../operations/version.md#delete)| `delete`, `scheduleVersionDestruction`, `cancelVersionDestruction` | `kms.admin` на ключ
[Назначение роли](../../iam/operations/roles/grant.md), [отзыв роли](../../iam/operations/roles/revoke.md) и просмотр назначенных ролей на ключ | `setAccessBindings`, `updateAccessBindings`, `listAccessBindings` | `kms.admin` на ключ

#### Что дальше {#what-is-next}

* [Безопасное использование {{ yandex-cloud }}](../../iam/best-practices/using-iam-securely.md)
* [Как назначить роль](../../iam/operations/roles/grant.md).
* [Как отозвать роль](../../iam/operations/roles/revoke.md).
* [Подробнее об управлении доступом в {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Подробнее о наследовании ролей](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).
