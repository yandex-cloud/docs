---
editable: false
---

# Правила тарификации для {{ ml-platform-name }}

{% include [link-on-new-ui-datasphere-in-old-ui](../_includes/datasphere/datasphere-old-note.md) %}

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

{% if region == "ru"%}

{% include [rub-unit-and-resource.md](../_pricing/datasphere/rub-unit-and-resource.md) %}

{% endif %}

{% if region == "kz"%}

{% include [kzt-unit-and-resource.md](../_pricing/datasphere/kzt-unit-and-resource.md) %}

{% endif %}

{% if region == "int"%}

{% include [usd-unit-and-resource.md](../_pricing/datasphere/usd-unit-and-resource.md) %}

{% endif %}

### Выполнение фоновых операций {#async}

Подробнее про [фоновые операции](concepts/async.md).

{% if region == "ru"%}

{% include [rub-async.md](../_pricing/datasphere/rub-async-new.md) %}

{% endif %}

{% if region == "kz"%}

{% include [kzt-async.md](../_pricing/datasphere/kzt-async-new.md) %}

{% endif %}

{% if region == "int"%}

{% include [usd-async.md](../_pricing/datasphere/usd-async-new.md) %}

{% endif %}

### Хранение данных внутри {{ ml-platform-name }} {#prices-storage}

#### Хранение данных проекта {#project-data}

{% if region == "ru"%}

{% include [rub-storage.md](../_pricing/datasphere/rub-storage.md) %}

{% endif %}

{% if region == "kz"%}

{% include [kzt-storage.md](../_pricing/datasphere/kzt-storage.md) %}

{% endif %}

{% if region == "int"%}

{% include [usd-storage.md](../_pricing/datasphere/usd-storage.md) %}

{% endif %}

#### Датасеты {#prices-datasets}

{% if region == "ru"%}

{% include [rub-data-storage.md](../_pricing/datasphere/rub-dataset.md) %}

{% endif %}

{% if region == "kz"%}

{% include [kzt-data-storage.md](../_pricing/datasphere/kzt-dataset.md) %}

{% endif %}

{% if region == "int"%}

{% include [usd-data-storage.md](../_pricing/datasphere/usd-dataset.md) %}

{% endif %}

### Исходящий трафик {#prices-traffic}

{% if region == "ru" %}

{% include notitle [rub-egress-traffic.md](../_pricing/rub-egress-traffic.md) %}

{% endif %}

{% if region == "kz" %}

{% include notitle [kzt-egress-traffic.md](../_pricing/kzt-egress-traffic.md) %}

{% endif %}

{% if region == "int" %}

{% include notitle [usd-egress-traffic.md](../_pricing/usd-egress-traffic.md) %}

{% endif %}

### Разметка аудио {#markup}

В этом разделе указана стоимость [разметки аудио](tutorials/markup.md). Стоимость указана за единицу тарификации, итоговая стоимость разметки зависит от объема данных и будет посчитана после загрузки данных.

{% if region == "ru" %}

| Услуга                                               | Цена за единицу тарификации,<br>вкл. НДС |
|------------------------------------------------------|------------------------------------------|
| [Разметка аудио](tutorials/markup.md) | {{ sku|RUB|ai.speech.transcribe.human.v1|string }} |

{% endif %}

{% if region == "kz" %}

| Услуга                                                    | Цена за единицу тарификации,<br>вкл. НДС |
|-----------------------------------------------------------|------------------------------------------|
| [Разметка аудио](tutorials/markup.md) | {{ sku|KZT|ai.speech.transcribe.human.v1|string }} |

{% endif %}

