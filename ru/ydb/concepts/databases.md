
{% include [intro.md](../oss/public/_includes/concepts/databases/intro.md) %}

{% include [database.md](../oss/public/_includes/concepts/databases/database.md) %}

В Yandex.Cloud БД привязывается к определенному каталогу в облаке, а также доступны Serverless базы данных на базе {{ ydb-short-name }}, не требующие выделения ресурсов пользователям, и использующие совместно ресурсы БД {{ ydb-short-name }}, в которой они обслуживаются.

Описание порядка получения БД в Yandex.Cloud описано в разделе ["Создание БД"](../operations/create_manage_database.md)

{% include [cluster.md](../oss/public/_includes/concepts/databases/cluster.md) %}

В Yandex.Cloud обслуживанием кластеров занимается команда облака, а разработчики приложений взаимодействуют напрямую с БД {{ ydb-short-name }}.


{% include [regions.md](../oss/public/_includes/concepts/databases/regions.md) %}

Облачные БД {{ ydb-short-name }} в Yandex.Cloud предоставляются в геораспределенном регионе центральной России `ru-central1`, с тремя зонами доступности. Подробнее о регионах и зонах доступности Yandex.Cloud читайте в разделе [{#T}](../../overview/concepts/geo-scope.md).


{% include [compute.md](../oss/public/_includes/concepts/databases/compute.md) %}

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


{% include [storage_groups.md](../oss/public/_includes/concepts/databases/storage_groups.md) %}

В облачных БД {{ ydb-short-name }} Yandex.Cloud используется по 3 диска в каждой из 3 зон доступности, как для БД на выделенных ресурсах, так и для бессерверных БД. Такая конфигурация гарантирует устойчивость при отказе одной из зон или отказе одного из дисков, а также обеспечивает избыточность с коэффициентом 3.
