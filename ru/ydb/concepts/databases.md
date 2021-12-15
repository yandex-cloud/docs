
{% include [intro.md](../oss/public/_includes/concepts/databases/intro.md) %}

{% include [database.md](../oss/public/_includes/concepts/databases/database.md) %}

{% if audience == "external" %}
В Yandex.Cloud БД привязывается к определенному каталогу в облаке, а также доступны Serverless базы данных на базе {{ ydb-short-name }}, не требующие выделения ресурсов пользователям, и использующие совместно ресурсы БД {{ ydb-short-name }}, в которой они обслуживаются.

Описание порядка получения БД в Yandex.Cloud описано в разделе ["Создание БД"](../operations/create_manage_database.md)
{% endif %}

{% include [cluster.md](../oss/public/_includes/concepts/databases/cluster.md) %}

{% if audience == "external" %}
В Yandex.Cloud обслуживанием кластеров занимается команда облака, а разработчики приложений взаимодействуют напрямую с БД {{ ydb-short-name }}.
{% endif %}

{% if audience == "tech" %}
  {% include [base_hierarchy.md](../oss/public/_includes/concepts/databases/base_hierarchy.md) %}
{% endif %}

{% include [regions.md](../oss/public/_includes/concepts/databases/regions.md) %}

{% if audience == "external" %}
Облачные БД {{ ydb-short-name }} в Yandex.Cloud предоставляются в геораспределенном регионе центральной России `ru-central1`, с тремя зонами доступности. Подробнее о регионах и зонах доступности Yandex.Cloud читайте в разделе [{#T}](../../overview/concepts/geo-scope.md).
{% endif %}

{% if audience == "internal" %}
Для размещения внутренних БД в Yandex доступны однодатацентровые [кластеры](clusters.md), расположенные в датацентрах VLA (Владимир), MYT (Мытищи), MAN (Мянтсяля, Финляндия) и SAS (Сасово). Также доступны геораспределенные кластеры, каждый из которых расположен в трех датацентрах — VLA-SAS-MAN и VLA-SAS-MYT. Если для проекта важно низкое время выполнения запросов на запись (латентности транзакций), то следует использовать однодатацентровые кластера. Для проектов с повышенными требованиями к надежности (при необходимости выдержать выход из строя одного из датацентров) следует использовать геораспределенные кластера. Одна БД целиком располагается на одном кластере. На одном кластере может быть расположено множество баз данных.

{% note warning %}

В текущей инсталляции {{ ydb-short-name }} доступен кластер *ydb-ru*, расположенный в датацентрах VLA-SAS-MYT.

{% endnote %}
{% endif %}

{% include [compute.md](../oss/public/_includes/concepts/databases/compute.md) %}

{% if audience == "external" %}
### БД {{ ydb-short-name }} в Yandex.Cloud на выделенных ресурсах (Dedicated)

БД {{ ydb-short-name }} в Yandex.Cloud предоставляется на виртуальных машинах, которые могут быть созданы на любой из платформ, которые поддерживает {{ compute-name }}. Подробное описание платформ приведено в разделе [{#T}](../../compute/concepts/vm-platforms.md).

Доступны следующие виды виртуальных машин:

Платформа | Вычислительный ресурс | Количество vCPU | Гарантированная доля vCPU | RAM, ГБ
----- | ----- | ----- | ----- | -----
**Intel Cascade Lake** | medium | 8 | 100%| 32
**Intel Cascade Lake** | medium-m64 | 8 | 100%| 64
**Intel Cascade Lake** | medium-m96 | 8 | 100%| 96

Оплата за БД на выделенных вычислительных ресурсах производится на почасовой основе. Дополнительно оплачивается объем хранилища данных под БД (см. [Группы хранения](#storage-groups) ниже).

### Бессерверная БД {{ ydb-short-name }} в Yandex.Cloud (Serverless)

Вычислительные ресурсы для бессерверных БД {{ ydb-short-name }} в Yandex.Cloud предоставляются автоматически для выполнения запросов к БД. Оплата производится на основании расчета фактически использованных CPU и операций ввода-вывода, потребовавшихся для исполнения запроса к БД. Дополнительно оплачивается объем хранимых в БД данных.
{% endif %}

{% if audience == "internal" or audience == "tech" %}

  {% include [slots.md](../oss/public/_includes/concepts/databases/slots.md) %}

  {% if audience == "internal" %}
Подробнее использование команды `discovery` описано в [документации по CLI](../getting_started/ydb_cli.md#discovery_list).
  {% endif %}
{% endif %}

{% include [storage_groups.md](../oss/public/_includes/concepts/databases/storage_groups.md) %}

{% if audience == "external" %}
В облачных БД {{ ydb-short-name }} Yandex.Cloud используется по 3 диска в каждой из 3 зон доступности, как для БД на выделенных ресурсах, так и для бессерверных БД. Такая конфигурация гарантирует устойчивость при отказе одной из зон или отказе одного из дисков, а также обеспечивает избыточность с коэффициентом 3.
{% endif %}
