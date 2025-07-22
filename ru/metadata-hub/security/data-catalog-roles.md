# Сервисные роли для работы с метаданными в {{ data-catalog-full-name }}

{% note info %}

{% include [preview-tp](../../_includes/preview-tp.md) %}

{% endnote %}

С помощью сервисных ролей {{ data-catalog-full-name }} вы можете просматривать информацию о каталогах и управлять ими.

## {{ roles.data-catalog.auditor }} {#data-catalog-auditor}

{% include [data-catalog.auditor](../../_roles/data-catalog/auditor.md) %}

## {{ roles.data-catalog.viewer }} {#data-catalog-viewer}

{% include [data-catalog.viewer](../../_roles/data-catalog/viewer.md) %}

## {{ roles.data-catalog.editor }} {#data-catalog-editor}

{% include [data-catalog.editor](../../_roles/data-catalog/editor.md) %}

## {{ roles.data-catalog.admin }} {#data-catalog-admin}

{% include [data-catalog.admin](../../_roles/data-catalog/admin.md) %}

## {{ roles.data-catalog.dataSteward }} {#data-catalog-dataSteward}

{% include [data-catalog.dataSteward](../../_roles/data-catalog/dataSteward.md) %}

## {{ roles.data-catalog.dataConsumer }} {#data-catalog-dataConsumer}

{% include [data-catalog.dataConsumer](../../_roles/data-catalog/dataConsumer.md) %}

## {{ roles.data-catalog.user }} {#data-catalog-user}

{% include [data-catalog.user](../../_roles/data-catalog/user.md) %}

## {{ roles.data-catalog.catalog.auditor }} {#data-catalog-catalogs-auditor}

{% include [data-catalog.catalog.auditor](../../_roles/data-catalog/catalogs/auditor.md) %}

## {{ roles.data-catalog.catalog.viewer }} {#data-catalog-catalogs-viewer}

{% include [data-catalog.catalog.viewer](../../_roles/data-catalog/catalogs/viewer.md) %}

## {{ roles.data-catalog.catalog.editor }} {#data-catalog-catalogs-editor}

{% include [data-catalog.catalog.editor](../../_roles/data-catalog/catalogs/editor.md) %}

## {{ roles.data-catalog.catalog.admin }} {#data-catalog-catalogs-admin}

{% include [data-catalog.catalog.admin](../../_roles/data-catalog/catalogs/admin.md) %}

## Какие роли мне необходимы {#choosing-roles}

В таблице ниже перечислено, какие роли нужны для выполнения указанного действия. Вы всегда можете назначить роль, которая дает более широкие разрешения, нежели указанная. Например, назначить `editor` вместо `viewer`.

| Действие                                                       | Необходимые роли                |
|----------------------------------------------------------------|---------------------------------|
| Просматривать метаданные каталогов                             | `data-catalog.catalogs.auditor` |
| Просматривать информацию о правах доступа к каталогам и квотах | `data-catalog.catalogs.viewer`  |
| Создавать каталоги                                             | `data-catalog.catalogs.editor`  |
| Редактировать каталоги                                         | `data-catalog.catalogs.editor`  |
| Удалять каталоги                                               | `data-catalog.catalogs.editor`  |
| Изменять права доступа к каталогам                             | `data-catalog.catalogs.admin`   |
| Просматривать и изменять домены, теги и термины                | `data-catalog.user`             |
