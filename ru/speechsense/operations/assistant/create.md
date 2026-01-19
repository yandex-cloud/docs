---
title: Создать ассистента
description: Следуя данной инструкции, вы сможете создать ассистента для проекта.
---

# Создать ассистента

[Ассистента](../../concepts/assistants.md) можно создать только в [проекте](../../concepts/resources-hierarchy.md#project). Для этого нужна роль `{{ roles-speechsense-admin }}` или `{{ roles-speechsense-editor }}` в проекте.

## Создать ассистента {#new-assistant}

1. Откройте [главную страницу]({{ link-speechsense-main }}) {{ speechsense-name }}.
1. Перейдите в нужное пространство, затем выберите проект.
1. Выберите вкладку **{{ ui-key.yc-ui-talkanalytics.assistants.assistants }}**.
1. Нажмите кнопку **{{ ui-key.yc-ui-talkanalytics.assistants.create-assistant }}**.
1. Задайте параметры ассистента:

   * (Опционально) Введите название и описание ассистента.
   * В блоке **{{ ui-key.yc-ui-talkanalytics.assistants.prompt }}**:
      * Введите текст инструкции. При необходимости можно воспользоваться готовыми шаблонами.
      * Выберите модель, которая будет использоваться для ассистента.
      * Опционально можно добавить [базу знаний](../../concepts/assistants.md#tools), которую будет использовать ассистент при выполнении инструкции.
      * Нажмите кнопку **{{ ui-key.yc-ui-talkanalytics.assistants.generate-prompt }}**. Система отредактирует вашу инструкцию в соответствии с особенностями выбранной модели.
   * В блоке **{{ ui-key.yc-ui-talkanalytics.assistants.result }}** добавьте одно или несколько полей. В эти поля будут записаны и распределены все значения, найденные в диалогах с учетом инструкции:
      * Введите название поля.
      * Выберите тип поля.
      * В качестве описания укажите информацию из инструкции, которую необходимо отслеживать в этом поле.
   
   {% note tip %}
   
   Вы можете воспользоваться готовыми шаблонами для блоков **{{ ui-key.yc-ui-talkanalytics.assistants.prompt }}** и **{{ ui-key.yc-ui-talkanalytics.assistants.result }}**. Для этого в блоке **{{ ui-key.yc-ui-talkanalytics.assistants.prompt }}** нажмите кнопку **{{ ui-key.yc-ui-talkanalytics.assistants.templates }}** и выберите подходящий шаблон.
   
   {% endnote %}

1. Включите блок **{{ ui-key.yc-ui-talkanalytics.assistants.applying }}**, чтобы активировать ассистента. 

   {% note warning %}

   [Тарификация](../../pricing.md) за использование ассистента начинается с момента его включения. Использование ассистента в проекте включается вручную. Анализируются только диалоги, загруженные после активации ассистента.

   {% endnote %}

   Выберите диалоги, которые будет анализировать ассистент:
   * **{{ ui-key.yc-ui-talkanalytics.assistants.all-dialogs }}** — ассистент будет анализировать все диалоги в проекте.
   * **{{ ui-key.yc-ui-talkanalytics.assistants.filtered-dialogs }}** — ассистент будет анализировать диалоги, которые соответствуют условиям, указанным в фильтрах.
      Добавьте необходимые фильтры с помощью кнопки ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yc-ui-talkanalytics.common.add-filter }}**.

1. В блоке **{{ ui-key.yc-ui-talkanalytics.assistants.testing }}** вы можете протестировать ассистента перед созданием на выборке диалогов. Для этого добавьте необходимые фильтры с помощью кнопки ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yc-ui-talkanalytics.common.add-filter }}**.

1. Нажмите кнопку **{{ ui-key.yc-ui-talkanalytics.common.create }}**.
   
   