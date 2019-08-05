# Удалить реестр

{% note important %}

Удалить можно только пустой реестр. Не забудьте [удалить устройства из реестра](../device/device-delete.md) перед началом операции.

{% endnote %}

Для обращения к [реестру](../../concepts/index.md#registry) используйте его идентификатор или имя. Как узнать идентификатор или имя реестра, читайте в разделе [{#T}](registry-list.md).

{% list tabs %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  1. Удалите реестр:

      ```
      $ yc iot registry delete my-registry
      ```

  1. Проверьте, что реестр удален:

      ```
      $ yc iot registry list
      +----+------+
      | ID | NAME |
      +----+------+
      +----+------+
      ```
{% endlist %}
