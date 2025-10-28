# Управление доступом в {{ cloud-logging-name }}

Для управления правами доступа в {{ cloud-logging-name }} используются [роли](../../iam/concepts/access-control/roles.md).

В этом разделе вы узнаете:

* [на какие ресурсы можно назначить роль](#resources);
* [какие роли действуют в сервисе](#roles-list).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

Назначать роли на ресурс могут пользователи, у которых на этот ресурс есть роль `logging.admin` или одна из следующих ролей:

{% include [roles-list](../../_includes/iam/roles-list.md) %}

## На какие ресурсы можно назначить роль {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

Вы также можете назначать роли на отдельные ресурсы сервиса:

{% list tabs group=instructions %}

- CLI {#cli}

  Через [{{ yandex-cloud }} CLI](../../cli/cli-ref/logging/cli-ref/index.md) вы можете назначить роли на следующие ресурсы:

  * [Лог-группа](../concepts/log-group.md)
  * [Приемник логов](../operations/create-sink.md)

- API {#api}

  Через [API {{ yandex-cloud }}](../api-ref/authentication.md) вы можете назначить роли на следующие ресурсы:

  {% include notitle [logging-resources](../../_includes/iam/resources-with-access-control/logging.md) %}

{% endlist %}

## Какие роли действуют в сервисе {#roles-list}

Ниже перечислены все роли, которые учитываются при проверке прав доступа в сервисе {{ cloud-logging-name }}.

{% include [logging](../../_mermaid/roles/logging.md) %}

### Сервисные роли {#service-roles}

#### logging.viewer {#logging-viewer}

{% include [logging.viewer](../../_roles/logging/viewer.md) %}

#### logging.editor {#logging-editor}

{% include [logging.editor](../../_roles/logging/editor.md) %}

#### logging.reader {#logging-reader}

{% include [logging.reader](../../_roles/logging/reader.md) %}

#### logging.writer {#logging-writer}

{% include [logging.writer](../../_roles/logging/writer.md) %}

#### logging.admin {#logging-admin}

{% include [logging.admin](../../_roles/logging/admin.md) %}

### Примитивные роли {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}