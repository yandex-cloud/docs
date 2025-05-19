---
title: Как создать рабочий процесс с помощью конструктора
description: Следуя данной инструкции, вы сможете создать рабочий процесс с помощью конструктора.
---

# Создать рабочий процесс с помощью конструктора

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать [рабочий процесс](../../../concepts/workflows/workflow.md).
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. На панели слева нажмите ![image](../../../../_assets/console-icons/graph-node.svg) **{{ ui-key.yacloud.serverless-workflows.label_service }}**.
  1. В правом верхнем углу нажмите **{{ ui-key.yacloud.serverless-workflows.button_create-workflow }}**.
  1. Выберите способ `{{ ui-key.yacloud.serverless-workflows.spec-editor-type_label_visual-editor }}`.
  1. Добавьте необходимые шаги в рабочий процесс. Подробнее о настройке шагов с помощью конструктора см. раздел [{#T}](../constructor/index.md).
  1. {% include [workflows-additional-console](../../../../_includes/serverless-integrations/workflows-additional-console.md) %}
  1. Нажмите **{{ ui-key.yacloud.common.create }}**.

{% endlist %}