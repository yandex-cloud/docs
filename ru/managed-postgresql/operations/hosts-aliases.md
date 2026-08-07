# Управление алиасами хостов

Вы можете назначить каждому хосту кластера {{ mpg-name }} алиас — пользовательское сетевое имя. Алиас соответствует отдельной DNS-записи, всегда указывающей на хост, который привязан к алиасу. Это позволит обращаться к хосту по стабильному человекочитаемому имени, независимо от внутреннего FQDN хоста. Алиас должен быть уникален в рамках каталога. Для каждого хоста можно назначить только один алиас.

Формат алиаса:

```
h-<имя_алиаса>-pg-<идентификатор_каталога>.rw.{{ dns-zone }}
```

{% note info %}

При создании алиаса задается только его имя.

{% endnote %}

## Получить список алиасов {#list-aliases}

Для получения списка алиасов требуется роль не ниже [managed-postgresql.viewer](../security/index.md#managed-postgresql-viewer) на каталог.


### Получить список алиасов в кластере {#list-aliases-in-cluster}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите]({{ link-console-main }}/link/managed-postgresql) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Нажмите на имя нужного кластера, затем выберите вкладку **{{ ui-key.yacloud.postgresql.cluster.switch_hosts }}**.

      Все созданные в кластере алиасы хостов перечислены в списке хостов в колонке **{{ ui-key.yacloud.mdb.cluster.hosts.field_host_alias }}**.


{% endlist %}


## Получить алиас хоста {#get-host-alias}

Для просмотра алиаса требуется роль не ниже [managed-postgresql.viewer](../security/index.md#managed-postgresql-viewer) на каталог.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите]({{ link-console-main }}/link/managed-postgresql) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Нажмите на имя нужного кластера, затем выберите вкладку **{{ ui-key.yacloud.postgresql.cluster.switch_hosts }}** и найдите в списке хостов нужный хост. Алиас хоста указан в колонке **{{ ui-key.yacloud.mdb.cluster.hosts.field_host_alias }}**.


{% endlist %}


## Создать алиас хоста {#create-alias}

Для создания алиаса требуется роль не ниже [managed-postgresql.editor](../security/index.md#managed-postgresql-editor) на каталог.

{% include [dns-time-warn](../../_includes/mdb/note-alias-dns-time.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите]({{ link-console-main }}/link/managed-postgresql) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Нажмите на имя нужного кластера, затем выберите вкладку **{{ ui-key.yacloud.postgresql.cluster.switch_hosts }}**.
  1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) в строке нужного хоста и выберите пункт **{{ ui-key.yacloud.mdb.cluster.hosts.action_create-alias }}**.
  1. В открывшемся окне введите алиас и нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.hosts.action_create-alias }}**.

      Имя алиаса может содержать строчные буквы латинского алфавита, цифры и дефисы. Длина алиаса до 63 символов.


{% endlist %}

## Удалить алиас {#delete-alias}

Для удаления алиаса требуется роль не ниже [managed-postgresql.editor](../security/index.md#managed-postgresql-editor) на каталог.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите]({{ link-console-main }}/link/managed-postgresql) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Нажмите на имя нужного кластера, затем выберите вкладку **{{ ui-key.yacloud.postgresql.cluster.switch_hosts }}**.
  1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) в строке нужного хоста и выберите пункт **{{ ui-key.yacloud.mdb.cluster.hosts.action_delete-alias }}**.
  1. В открывшемся окне нажмите кнопку **Удалить**.


{% endlist %}
