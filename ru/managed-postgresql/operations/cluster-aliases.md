---
title: Управление алиасами кластера {{ PG }}
description: Вы можете создать собственное сетевое имя для кластера {{ MY }}, а также перенести имя на другой кластер в вашем каталоге.
---

# Управление алиасами кластера {{ PG }}

Вы можете назначить каждому кластеру {{ PG }} _алиас_ – пользовательское сетевое имя. Алиас соответствует отдельной DNS-записи, всегда указывающей на хост-мастер кластера, привязанного к алиасу. Это позволит обращаться к кластеру по стабильному человекочитаемому имени, независимо от внутреннего FQDN хоста-мастера. Алиас должен быть уникален в рамках каталога. Для каждого кластера можно назначить только один алиас.

Для переключения ваших приложений на другой кластер, расположенный в том же каталоге, достаточно поменять привязку алиаса к кластеру.

Формат алиаса:

```text
c-<имя_алиаса>-pg-<идентификатор_каталога>.rw.{{ dns-zone }}
```

{% note info %}

При создании алиаса задается только его имя.

{% endnote %}


## Получить алиас кластера {#get-alias}

Для просмотра алиаса требуется роль не ниже [managed-postgresql.viewer](../security/index.md#managed-postgresql-viewer) на каталог.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите]({{ link-console-main }}/link/managed-postgresql) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Нажмите на имя нужного кластера.

     Алиас кластера отображается в поле **{{ ui-key.yacloud.mdb.cluster.hosts.section_cname-alias }}**.


{% endlist %}

## Создать алиас кластера {#create-alias}

Для создания алиаса требуется роль не ниже [managed-postgresql.editor](../security/index.md#managed-postgresql-editor) на каталог.

{% include [dns-time-warn](../../_includes/mdb/note-alias-dns-time.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите]({{ link-console-main }}/link/managed-postgresql) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Нажмите на имя нужного кластера и в секции **{{ ui-key.yacloud.mdb.cluster.hosts.section_cname-alias }}** нажмите кнопку ![image-link](../../_assets/console-icons/link.svg).
  1. В открывшемся окне укажите имя алиаса кластера. Допускаются строчные буквы латинского алфавита, цифры и дефисы. Длина алиаса до 63 символов.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.hosts.action_create-alias }}**.


{% endlist %}

## Переместить алиас между кластерами {#move-alias}

Переместить алиас между кластерами можно только в рамках одного каталога. Для перемещения алиаса требуется роль не ниже [managed-postgresql.editor](../security/index.md#managed-postgresql-editor) на каталог.

{% include [dns-time-warn](../../_includes/mdb/note-alias-dns-time.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите]({{ link-console-main }}/link/managed-postgresql) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Вы можете переместить алиас одним из двух способов:

     * В настройках кластера с алиасом.

        1. Нажмите на имя кластера, чей алиас вы хотите переместить в другой кластер в вашем каталоге, и в секции **{{ ui-key.yacloud.mdb.cluster.hosts.section_cname-alias }}** нажмите кнопку ![image-shuffle](../../_assets/console-icons/shuffle.svg).
        1. В открывшемся окне выберите кластер, к которому нужно привязать алиас.

     * В настройках кластера, на который перемещается алиас.

        1. Нажмите на имя кластера, на который вы хотите переместить алиас другого кластера в вашем каталоге, и в секции **{{ ui-key.yacloud.mdb.cluster.hosts.section_cname-alias }}** нажмите кнопку ![image-shuffle](../../_assets/console-icons/shuffle.svg).
        1. В открывшемся окне выберите кластер, к которому привязан алиас.

  1. Подтвердите перемещение алиаса и нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.hosts.action_move-cluster-alias }}**.


{% endlist %}

## Удалить алиас {#delete-alias}

Для удаления алиаса требуется роль не ниже [managed-postgresql.editor](../security/index.md#managed-postgresql-editor) на каталог.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите]({{ link-console-main }}/link/managed-postgresql) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Нажмите на имя нужного кластера и в секции **{{ ui-key.yacloud.mdb.cluster.hosts.section_cname-alias }}** нажмите кнопку ![image-link](../../_assets/console-icons/link-slash.svg).
  1. В открывшемся окне подтвердите удаление алиаса.


{% endlist %}
