# Сервисные роли для работы с метаданными в {{ data-catalog-full-name }}

{% note info %}

{% include [preview-tp](../../_includes/preview-tp.md) %}

{% endnote %}

С помощью сервисных ролей {{ data-catalog-full-name }} вы можете просматривать информацию о каталогах и управлять ими.

## {{ roles.data-catalog.catalog.auditor }} {#managed-data-catalog-auditor}

{% include [data-catalog.catalog.auditor](../../_roles/data-catalog/catalogs/auditor.md) %}

## {{ roles.data-catalog.catalog.viewer }} {#managed-data-catalog-viewer}

{% include [data-catalog.catalog.viewer](../../_roles/data-catalog/catalogs/viewer.md) %}

## {{ roles.data-catalog.catalog.editor }} {#managed-data-catalog-editor}

{% include [data-catalog.catalog.editor](../../_roles/data-catalog/catalogs/editor.md) %}

## {{ roles.data-catalog.catalog.admin }} {#managed-data-catalog-admin}

{% include [data-catalog.catalog.admin](../../_roles/data-catalog/catalogs/admin.md) %}

## Какие роли мне необходимы {#choosing-roles}

В таблице ниже перечислено, какие роли нужны для выполнения указанного действия. Вы всегда можете назначить роль, которая дает более широкие разрешения, нежели указанная. Например, назначить `editor` вместо `viewer`.

| Действие                                              | Необходимые роли                |
|-------------------------------------------------------|---------------------------------|
| Просматривать метаданные каталогов                    | `data-catalog.catalogs.auditor` |
| Просматривать информацию о правах доступа к каталогам | `data-catalog.catalogs.viewer`  |
| Создавать каталоги                                    | `data-catalog.catalogs.editor`  |
| Редактировать каталоги                                | `data-catalog.catalogs.editor`  |
| Удалять каталоги                                      | `data-catalog.catalogs.editor`  |
| Изменять права доступа к каталогам                    | `data-catalog.catalogs.admin`   |
