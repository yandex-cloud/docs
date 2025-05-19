---
title: Настроить политику повторных попыток рабочего процесса {{ sw-name }}
description: Следуя данной инструкции, вы сможете настроить политику повторных попыток для всего рабочего процесса {{ sw-full-name }} с помощью конструктора шагов рабочего процесса.
---

# Настроить политику повторных попыток для рабочего процесса

{% list tabs %}

- Консоль управления {#console}

  1. {% include [integrations-step1](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step1.md) %}
  1. В окне со схемой рабочего процесса нажмите на любую свободную от элементов схемы точку, чтобы снять выделение со всех элементов. Убедитесь, что в правой части экрана отображается блок **{{ ui-key.yacloud.serverless-workflows.workflow-editor_main-settings-label }}**.
  1. В блоке **{{ ui-key.yacloud.serverless-workflows.workflow-editor_main-settings-label }}**:

      1. В поле **{{ ui-key.yacloud.serverless-workflows.workflow-editor_error-list-field }}** выберите ошибки, для которых будут (или, наоборот, не будут) сделаны повторные попытки выполнения шагов рабочего процесса.

          {% include [error-details](../../../../_includes/serverless-integrations/workflows-constructor/error-details.md) %}
      1. В поле **{{ ui-key.yacloud.serverless-workflows.workflow-editor_error-list-mode-field }}** выберите:

          * `INCLUDE` — чтобы делать для шагов рабочего процесса повторные попытки выполнения при возникновении ошибок, указанных в поле **{{ ui-key.yacloud.serverless-workflows.workflow-editor_error-list-field }}**.
          * `EXCLUDE` — чтобы делать для шагов рабочего процесса повторные попытки выполнения при возникновении любых ошибок, за исключением ошибок, указанных в поле **{{ ui-key.yacloud.serverless-workflows.workflow-editor_error-list-field }}**.
      1. (Опционально) В поле **{{ ui-key.yacloud.serverless-workflows.workflow-editor_retry-count-field }}** задайте максимальное количество повторных попыток выполнения шага.
      1. (Опционально) В поле **{{ ui-key.yacloud.serverless-workflows.workflow-editor_initial-delay-field }}** задайте начальное значение задержки между повторными попытками выполнения шага.
      1. (Опционально) В поле **{{ ui-key.yacloud.serverless-workflows.workflow-editor_backoff-rate-field }}** задайте коэффициент, на который будет умножаться время задержки перед каждой повторной попыткой выполнения шага.
      1. (Опционально) В поле **{{ ui-key.yacloud.serverless-workflows.workflow-editor_max-delay-field }}** задайте значение максимальной задержки между повторными попытками выполнения шага.

      Общие настройки политики повторных попыток действуют для всех шагов рабочего процесса, для которых не заданы собственные настройки политики повторных попыток.

{% endlist %}

## См. также {#see-also}

* [{#T}](../workflow/create-constructor.md)
* [{#T}](../workflow/update.md)