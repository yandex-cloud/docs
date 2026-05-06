The `ycdr.admin` role enables viewing dashboards and managing {{ ycdr-name }} resources within an SIEM instance, including queries, investigations, and datasets.

{% cut "Users with this role can:" %}

* View info on URL addresses for embedding {{ ycdr-name }} dashboards.
* View info on [investigations](../../yandex-siem/concepts/investigations.md), as well as create, update, delete, and conduct them.
* View info on [datasets](../../yandex-siem/concepts/investigations.md#datasets-schema), as well as create, update, and delete them.
* View info on [queries](../../yandex-siem/concepts/queries.md), as well as create, update, delete, and run them.
* View info on [{{ yandex-siem-full-name }}](../../yandex-siem/concepts/index.md) and [{{ ycdr-name }}](../../ycdr/concepts/index.md) instances.

{% endcut %}

You need to assign this role for the organization.

For {{ ycdr-full-name }} to process alerts from {{ sd-name }}, you also need to assign the `security-deck.editor` role for the folder from which alerts are being collected.

This role includes the `ycem.inspector` permissions.
