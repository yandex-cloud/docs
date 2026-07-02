[Документация Yandex Cloud](../../../index.md) > [Yandex MetaData Hub](../../index.md) > Data Catalog > Пошаговые инструкции > Каталог > Изменение каталога

# Изменение каталога


{% note info %}

Эта функциональность находится на стадии [Preview](../../../overview/concepts/launch-stages.md).

{% endnote %}


{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) выберите [каталог ресурсов](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно изменить каталог метаданных.
    1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Yandex MetaData Hub**.
    1. На панели слева выберите ![image](../../../_assets/console-icons/folder-magnifier.svg) **Data Catalog**.
    1. Справа от имени каталога, который вы хотите изменить, нажмите ![horizontal-ellipsis](../../../_assets/horizontal-ellipsis.svg) и выберите **Редактировать**.
    1. В поле **Имя** укажите новое имя каталога.
    1. Измените описание каталога.
    1. Добавьте или удалите [метки Yandex Cloud](../../../resource-manager/concepts/labels.md).
    1. Включите или выключите опцию **AI-разметка метаданных**.
    
        Если AI-разметка включена, AI-ассистент предлагает описания, [домены](../../concepts/data-catalog.md#domains-and-subdomains), [классификации и теги](../../concepts/data-catalog.md#classifications-and-tags), [глоссарии и термины](../../concepts/data-catalog.md#glossaries-and-terms), а также размечает с их помощью ваши метаданные. Предложения ассистента можно подтвердить, отредактировать или отклонить. Для этого наведите курсор на значок **AI** рядом с предложением ассистента и выберите нужное действие.

    1. Нажмите кнопку **Сохранить изменения**.

{% endlist %}