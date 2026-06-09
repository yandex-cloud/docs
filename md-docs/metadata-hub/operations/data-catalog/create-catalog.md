# Создание каталога


{% note info %}

Эта функциональность находится на стадии [Preview](../../../overview/concepts/launch-stages.md).

{% endnote %}


{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите [каталог ресурсов](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать каталог метаданных.
    1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
    1. На панели слева выберите ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.data-catalog.label_create-catalog }}**.
    1. Задайте параметры каталога:

       * В поле **{{ ui-key.yacloud.common.name }}** задайте уникальное имя каталога.
       * (Опционально) Добавьте описание каталога.
       * (Опционально) Добавьте [метки {{ yandex-cloud }}](../../../resource-manager/concepts/labels.md).

    1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

    {% note info %}
    
    При создании каталога метаданных опция **AI-разметка метаданных** включена по умолчанию.
    
    Когда опция включена, AI-ассистент предлагает описания, [домены](../../concepts/data-catalog.md#domains-and-subdomains), [классификации и теги](../../concepts/data-catalog.md#classifications-and-tags), [глоссарии и термины](../../concepts/data-catalog.md#glossaries-and-terms), а также размечает с их помощью ваши метаданные. Предложения ассистента можно подтвердить, отредактировать или отклонить. Для этого наведите курсор на значок **{{ ui-key.yacloud.data-catalog.label_ai-label }}** рядом с предложением ассистента и выберите нужное действие.
    
    После создания каталога AI-разметкой можно управлять на странице **{{ ui-key.yacloud.common.overview }}** или при [изменении](update-catalog.md) каталога.
    
    {% endnote %}

{% endlist %}