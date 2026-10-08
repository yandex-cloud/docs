---
title: Квоты и лимиты в {{ datalens-platform-full-name }}
description: Узнайте, какие квоты и лимиты действуют для кластеров {{ TR }} и {{ SPRK }} в {{ datalens-platform-short-name }}, как проверить квоты и запросить их увеличение.
editable: false
---

# Квоты и лимиты в {{ datalens-platform-full-name }}

Ресурсы {{ datalens-platform-short-name }} создаются в облаке {{ yandex-cloud }}, выбранном в [окружении](clusters/index.md#environments). Для них действуют следующие виды ограничений:

{% include [quotes-limits-def.md](../../../_includes/quotes-limits-def.md) %}

## Проверка и увеличение квот {#manage-quotas}

Квоты задаются для облака {{ yandex-cloud }} и используются совместно всеми окружениями этого облака. Создание еще одного окружения в том же облаке не увеличивает доступную квоту.

Чтобы проверить квоты, [найдите облако в настройках окружения](../operations/clusters/manage-environment.md#billing-and-quotas), перейдите на [страницу квот в консоли управления]({{ link-console-quotas }}) и выберите это облако. Изменение квот выполняется только через консоль управления {{ yandex-cloud }}.

Если ресурсов не хватает, можно:

* Запросить увеличение квот существующего облака.
* [Создать окружение](../operations/clusters/manage-environment.md#create-environment) в другом облаке для отдельной группы ресурсов. В этом случае будут использоваться квоты другого облака.

{% note info %}

Связанные кластеры и REST-каталоги должны находиться в одном облаке и в одном окружении. Окружение в другом облаке подходит для независимой группы ресурсов.

{% endnote %}

{% include [increase-quotas.md](../../../_includes/increase-quotas.md) %}

## Кластеры {{ TR }} {#trino}

### Квоты {#trino-quotas}

{% include notitle [mtr-quotas](../../../_includes/managed-trino/limits.md#quotas) %}

### Лимиты {#trino-limits}

{% include notitle [mtr-limits](../../../_includes/managed-trino/limits.md#limits) %}

## Кластеры {{ SPRK }} {#spark}

### Квоты {#spark-quotas}

{% include notitle [msp-quotas](../../../_includes/managed-spark/limits.md#quotas) %}

### Лимиты {#spark-limits}

{% include notitle [msp-limits](../../../_includes/managed-spark/limits.md#limits) %}
