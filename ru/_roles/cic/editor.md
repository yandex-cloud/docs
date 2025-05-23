Роль `cic.editor` позволяет управлять транковыми подключениями, приватными и публичными соединениями, а также просматривать информацию о квотах, ресурсах и операциях с ресурсами сервиса.

{% cut "Пользователи с этой ролью могут:" %}

* управлять [транковыми подключениями](../../interconnect/concepts/trunk.md) — создание, изменение, удаление
* управлять [приватными соединениями](../../interconnect/concepts/priv-con.md) — создание, изменение, удаление
* управлять [публичными соединениями](../../interconnect/concepts/pub-con.md) — создание, изменение, удаление
* просматривать информацию о [точках присутствия](../../interconnect/concepts/pops.md)
* просматривать информацию о [партнерах CIC](../../interconnect/concepts/partners.md)
* просматривать информацию о [транковых подключениях](../../interconnect/concepts/trunk.md)
* просматривать информацию о [приватных соединениях](../../interconnect/concepts/priv-con.md)
* просматривать информацию о [публичных соединениях](../../interconnect/concepts/pub-con.md)
* просматривать информацию о [квотах](../../interconnect/concepts/limits.md#interconnect-quotas) сервиса {{ interconnect-name }}
* просматривать информацию об [облаке](../../resource-manager/concepts/resources-hierarchy.md#cloud);
* просматривать информацию о [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder).
* просматривать информацию об операциях с ресурсами сервиса {{ interconnect-name }}

{% endcut %}

Включает разрешения, предоставляемые ролью `cic.viewer`.
