---
editable: false
---

# Правила тарификации для {{ ml-platform-name }}



{% include [prices](../_includes/datasphere/migration/pricing.md) %}

### Использование кластеров {{ dataproc-name }} {#data-proc}

Стоимость использования интеграции с сервисом {{ dataproc-name }} учитывает:
* Вычислительные ресурсы конфигурации c1.4 {{ ml-platform-name }}.
  Эти ресурсы создаются для обеспечения интеграции с кластером {{ dataproc-name }} и тарифицируются пока на кластере идут вычисления.
* Все время существования кластера {{ dataproc-name }} по [правилам тарификации {{ dataproc-full-name }}](../data-proc/pricing.md).

Подробнее об [интеграции с {{ dataproc-name }}](concepts/data-proc.md).

### Использование дискового пространства {#storage}

Каждый проект {{ ml-platform-name }} имеет хранилище, в рамках которого хранение данных не тарифицируется. При увеличении [квоты]({{ link-console-quotas }}) на размер проекта [объем хранилища](#project-data) свыше {{ ml-project-size }} оплачивается отдельно. Подробнее с квотами и лимитами сервиса можно ознакомиться в разделе [{#T}](concepts/limits.md).

[Хранение данных внутри датасетов](#prices-datasets) оплачивается отдельно.

Если вам требуется хранить большие объемы данных, вы можете использовать сервис {{ objstorage-full-name }}. В этом случае хранение данных будет тарифицироваться по [правилам тарификации {{ objstorage-name }}](../storage/pricing.md).

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

Цены за месяц использования формируются из расчета 720 часов в месяц.

## Цены {#prices}


{% include [rub-unit-and-resource.md](../_pricing/datasphere/rub-unit-and-resource.md) %}




### Выполнение фоновых операций {#async}

Подробнее про [фоновые операции](../datasphere/concepts/async.md).


{% include [rub-async.md](../_pricing/datasphere/rub-async-new.md) %}




### Хранение данных внутри {{ ml-platform-name }} {#prices-storage}

#### Хранение данных проекта {#project-data}


{% include [rub-storage.md](../_pricing/datasphere/rub-storage.md) %}




#### Датасеты {#prices-datasets}


{% include [rub-data-storage.md](../_pricing/datasphere/rub-dataset.md) %}




### Исходящий трафик {#prices-traffic}


{% include notitle [rub-egress-traffic.md](../_pricing/rub-egress-traffic.md) %}




