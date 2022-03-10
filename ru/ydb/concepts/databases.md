---
sourcePath: ru/ydb/overlay/concepts/databases.md
---
{% include [intro.md](_includes/databases/intro.md) %}

{% include [database.md](_includes/databases/database.md) %}

В {{ yandex-cloud }} БД привязывается к определенному каталогу в облаке, а также доступны Serverless базы данных на базе {{ ydb-short-name }}, не требующие выделения ресурсов пользователям, и использующие совместно ресурсы БД {{ ydb-short-name }}, в которой они обслуживаются.

Описание порядка получения БД в {{ yandex-cloud }} описано в разделе ["Создание БД"](../operations/create_manage_database.md)

{% include [cluster.md](_includes/databases/cluster.md) %}

В {{ yandex-cloud }} обслуживанием кластеров занимается команда облака, а разработчики приложений взаимодействуют напрямую с БД {{ ydb-short-name }}.

{% include [regions.md](_includes/databases/regions.md) %}

Облачные БД {{ ydb-short-name }} в {{ yandex-cloud }} предоставляются в геораспределенном регионе центральной России `ru-central1`, с тремя зонами доступности. Подробнее о регионах и зонах доступности {{ yandex-cloud }} читайте в разделе [{#T}](../../overview/concepts/geo-scope.md).

{% include [compute.md](_includes/databases/compute.md) %}

### БД {{ ydb-short-name }} в {{ yandex-cloud }} на выделенных ресурсах (Dedicated)

БД {{ ydb-short-name }} в {{ yandex-cloud }} предоставляется на виртуальных машинах, которые могут быть созданы на любой из платформ, которые поддерживает {{ compute-name }}. Подробное описание платформ приведено в разделе [{#T}](../../compute/concepts/vm-platforms.md).

Доступны следующие виды виртуальных машин:

Платформа | Вычислительный ресурс | Количество vCPU | Гарантированная доля vCPU | RAM, ГБ
----- | ----- | ----- | ----- | -----
**Intel Cascade Lake** | medium | 8 | 100%| 32
**Intel Cascade Lake** | medium-m64 | 8 | 100%| 64
**Intel Cascade Lake** | medium-m96 | 8 | 100%| 96

Оплата за БД на выделенных вычислительных ресурсах производится на почасовой основе. Дополнительно оплачивается объем хранилища данных под БД (см. [Группы хранения](#storage-groups) ниже).

### Бессерверная БД {{ ydb-short-name }} в {{ yandex-cloud }} (Serverless)

Вычислительные ресурсы для бессерверных БД {{ ydb-short-name }} в {{ yandex-cloud }} предоставляются автоматически для выполнения запросов к БД. Оплата производится на основании расчета фактически использованных CPU и операций ввода-вывода, потребовавшихся для исполнения запроса к БД. Дополнительно оплачивается объем хранимых в БД данных.

{% include [storage_groups.md](_includes/databases/storage_groups.md) %}

В облачных БД {{ ydb-short-name }} {{ yandex-cloud }} используется по 3 диска в каждой из 3 зон доступности, как для БД на выделенных ресурсах, так и для бессерверных БД. Такая конфигурация гарантирует устойчивость при отказе одной из зон или отказе одного из дисков, а также обеспечивает избыточность с коэффициентом 3.
