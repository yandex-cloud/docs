---
title: Изменение каталога метаданных
description: Следуя данной инструкции, вы сможете изменить параметры каталога метаданных в {{ data-catalog-full-name }}.
---

# Изменение каталога


{% note info %}

{% include [preview-pp](../../../_includes/preview-pp.md) %}

{% endnote %}


{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите [каталог ресурсов](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно изменить каталог метаданных.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
    1. На панели слева выберите ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
    1. Справа от имени каталога, который вы хотите изменить, нажмите ![horizontal-ellipsis](../../../_assets/horizontal-ellipsis.svg) и выберите **{{ ui-key.yacloud.common.edit }}**.
    1. В поле **{{ ui-key.yacloud.common.name }}** укажите новое имя каталога.
    1. Измените описание каталога.
    1. Добавьте или удалите [метки {{ yandex-cloud }}](../../../resource-manager/concepts/labels.md).
    1. Включите или выключите опцию **AI-разметка метаданных**.
    
        Если AI-разметка включена, AI-ассистент предлагает описания, [домены](../../concepts/data-catalog.md#domains-and-subdomains), [классификации и теги](../../concepts/data-catalog.md#classifications-and-tags), [глоссарии и термины](../../concepts/data-catalog.md#glossaries-and-terms), а также размечает с их помощью ваши метаданные. Предложения ассистента можно подтвердить, отредактировать или отклонить. Для этого наведите курсор на значок **{{ ui-key.yacloud.data-catalog.label_ai-label }}** рядом с предложением ассистента и выберите нужное действие.

    1. Нажмите кнопку **{{ ui-key.yacloud.common.save-changes }}**.

{% endlist %}
