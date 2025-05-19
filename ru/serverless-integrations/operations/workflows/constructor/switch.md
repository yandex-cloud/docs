---
title: Добавить выбор дальнейшего пути выполнения Switch в рабочий процесс {{ sw-name }}
description: Следуя данной инструкции, вы сможете добавить выбор дальнейшего пути выполнения Switch в рабочий процесс {{ sw-full-name }} с помощью конструктора шагов рабочего процесса.
---

# Добавить выбор дальнейшего пути выполнения Switch

Управляющий шаг Switch позволяет с помощью задаваемых условий выбрать дальнейший путь выполнения рабочего процесса. При этом выбран может быть только один путь — тот, для которого заданное условие первым вернуло значение `true`.

Если все условия вернули `false`, рабочий процесс будет выполняться по пути, заданному в условии по умолчанию, а при отсутствии условия по умолчанию запуск рабочего процесса завершится с ошибкой.

{% list tabs %}

- Консоль управления {#console}

  1. {% include [integrations-step1](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step1.md) %} 
  1. Из секции **{{ ui-key.yacloud.serverless-workflows.workflow-editor_management-group-label }}** в левой части экрана перетащите элемент ![switch-icon](../../../../_assets/serverless-integrations/switch-icon.svg) **Switch** в нужное место рабочего процесса в окне конструктора.

      {% include [step-drag-destination-desc](../../../../_includes/serverless-integrations/workflows-constructor/step-drag-destination-desc.md) %}
  1. В окне со схемой рабочего процесса нажмите на добавленный блок **Switch**, чтобы выбрать его.
  1. {% include [integrations-step-select-settings-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-select-settings-tab.md) %}

      1. {% include [integrations-name-the-step](../../../../_includes/serverless-integrations/workflows-constructor/integrations-name-the-step.md) %}
  1. {% include [integrations-step-input-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-input-tab.md) %}
  1. Чтобы добавить новую ветку выполнения:
  
      1. В правом нижнем углу блока **Switch** нажмите значок ![circle-plus-fill](../../../../_assets/console-icons/circle-plus-fill.svg).

      1. В открывшемся окне добавьте условие, при котором будет выбрана ветка выполнения. Условие указывается в формате jq. Чтобы добавить условие по умолчанию, включите опцию **{{ ui-key.yacloud.serverless-workflows.edit-switch-choice_default-field }}**. Условие по умолчанию создается автоматически, если Switch не является первым шагом рабочего процесса. После добавления условия нажмите **{{ ui-key.yacloud.common.create }}**. 
  
      Чтобы удалить ветку выполнения, добавьте в нее любой интеграционный шаг и удалите его при помощи кнопки ![circle-xmark-fill](../../../../_assets/console-icons/circle-xmark-fill.svg).

{% endlist %}

## См. также {#see-also}

* [Спецификация YaWL](../../../concepts/workflows/yawl/management/switch.md)
* [{#T}](../workflow/create-constructor.md)
* [{#T}](../workflow/update.md)
