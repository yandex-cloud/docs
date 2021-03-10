# Изменить зону DNS

После создания [зону DNS](../concepts/dns-zone.md) можно изменить: переименовать, добавить описание или выбрать другие сети для зоны.

Чтобы изменить зону DNS:

{% list tabs %}

- Консоль управления

  1. Откройте раздел **{{ dns-name }}** в каталоге, где требуется изменить зону DNS.
  1. Нажмите значок ![image](../../_assets/options.svg) в строке зоны, которую требуется изменить.
  1. В открывшемся меню нажмите кнопку **Редактировать**.
  1. Измените параметры зоны, например, измените ее видимость или добавьте ее в другие сети.
  1. Нажмите кнопку **Сохранить**.

- CLI

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить зону DNS:

  1. Посмотрите описание команды CLI для изменения зоны:

     ```
     yc dns zone update --help
     ```

  1. Измените видимость зоны в сетях:

     ```
     yc dns zone update <имя или идентификатор зоны> \
     --private-visibility network-ids=c645mh47vscba1d64tbs,
     ```

     Результат выполнения команды:

     ```
     id: aet29qhara5jeg45tbjg
     folder_id: aoerb349v3h4bupphtaf
     created_at: "2021-02-21T09:21:03.935Z"
     name: <новое имя зоны>
     zone: staging.
     private_visibility:
       network_ids:
       - c645mh47vscba1d64tbs
     ```

{% endlist %}
