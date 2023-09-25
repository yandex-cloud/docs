---
title: "Как настроить свою форму для создания задач и встроить ее в интерфейс {{ tracker-name }}"
description: "Следуя данной инструкции, вы сможете настроить свою форму для создания задач и встроить ее в интерфейс {{ tracker-name }}."
---

# Использовать форму как шаблон для создания задач

{% note warning %}

По умолчанию настройка очереди доступна только ее владельцу.

{% endnote %}

С помощью сервиса {{ forms-full-name }} вы можете настроить свою форму для создания задач и встроить ее в интерфейс {{ tracker-name }}. Такая форма будет отображаться на странице создания задачи рядом со стандартной. Она поможет пользователям создавать задачи по определенному шаблону, не отвлекаясь на лишние поля и параметры.

## Шаг 1. Создайте и настройте форму {#section_ovd_5hl_1gb}

1. Перейдите в сервис [{{ forms-full-name }}]({{ link-forms }}). Если сервис не подключен, обратитесь к администратору вашей организации.

1. [Создайте](../../forms/new-form.md) новую форму.
   
   Настройте ее поля так, чтобы собрать данные, которые необходимы для создания задачи.

1. Настройте название формы. Название будет отображаться в интерфейсе {{ tracker-name }} при создании задачи.

1. Настройте для формы [интеграцию с {{ tracker-name }}](../../forms/create-task.md).

1. [Опубликуйте](../../forms/publish.md#section_link) форму и скопируйте ссылку на форму из поля **{{ ui-key.startrek.blocks-desktop_field-create-form.field-type-uri }}**.

## Шаг 2. Подключите форму к очереди {#section_xxj_fll_1gb}

1. Перейдите в [{{ tracker-name }}]({{ link-tracker }}).

1. {% include [go to settings](../../_includes/tracker/transition-page.md) %} 

1. В правом верхнем углу нажмите ![](../../_assets/tracker/svg/queue-settings.svg) **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**.

1. В разделе **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin.tab-title--forms }}** нажмите кнопку **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_forms.add-btn }}**.

1. Вставьте ссылку на форму.

1. Добавьте название и описание формы. Они будут видны в окне выбора формы при создании задачи.

1. Нажмите кнопку **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_form-editor.create-btn }}**.

