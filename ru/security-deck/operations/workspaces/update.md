---
title: Изменение окружения {{ sd-full-name }}
description: Из этой инструкции вы узнаете, как изменить окружение в {{ sd-full-name }}.
---

# Изменить окружение {{ sd-name }} и его компоненты

{% include [note-preview](../../../_includes/note-preview.md) %}

## Изменить окружение {#update-workspace}

Чтобы изменить [окружение](../../concepts/workspace.md) {{ sd-name }}:

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите ![sliders](../../../_assets/console-icons/sliders.svg) **{{ ui-key.yacloud_org.security-center.label_settings }}** и перейдите на вкладку **{{ ui-key.yacloud_org.security.settings.SettingsPageLayout.workspacesLabel_kZyU1 }}**.
  1. В открывшемся списке нажмите на нужное окружение, чтобы изменить его настройки.

      {% note tip %}

      Чтобы быстрее найти нужное окружение, воспользуйтесь фильтром.

      {% endnote %}

  1. (Опционально) Перейдите на вкладку **{{ ui-key.yacloud_org.security.workspaces.WorkspaceEditPageLayout.tabGeneralParams_xc2v2 }}** и измените базовые параметры окружения:

      1. В блоке **{{ ui-key.yacloud_org.security.workspaces.WorkspaceGeneralParamsForm.workspace_title_365xt }}** измените имя и описание окружения.
      1. {% include [workspace-create-step1-substep1](../../../_includes/security-deck/workspace-create-step1-substep1.md) %}
      1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**, чтобы сохранить внесенные изменения.
  1. (Опционально) Перейдите на вкладку **{{ ui-key.yacloud_org.security.workspaces.WorkspaceEditPageLayout.tabResources_vJuSN }}**, чтобы изменить список ресурсов, контролируемых окружением:

      1. Измените список ресурсов. Вы можете сделать это с текущими настройками [коннектора](../../concepts/workspace.md#connectors), изменив настройки коннектора или заменив коннектор на другой:

          {% list tabs %}

          - Текущие настройки

            1. В блоке с именем коннектора нажмите кнопку ![circle-plus](../../../_assets/console-icons/circle-plus.svg) **{{ ui-key.yacloud_org.security.workspaces.WorkspaceResourcesForm.buttonSelectCloudCatalog }}**, чтобы изменить ресурсы ([облака](../../../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталоги](../../../resource-manager/concepts/resources-hierarchy.md#folder)), безопасность в которых будет контролироваться в окружении. В появившемся окне:

                1. Отметьте ресурсы, безопасность которых вы хотите контролировать в окружении. Для выбора доступны только те ресурсы, к которым есть доступ у привязанного к коннектору сервисного аккаунта.
                1. Нажмите кнопку **{{ ui-key.yacloud_org.security.workspaces.ServiceAccountResourceSelectDialog.action_save }}**.

          - Изменить настройки

            1. В блоке с именем коннектора нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud_org.security.workspaces.WorkspaceResourcesForm.actionEditConnector }}**. В открывшемся окне:

                {% include [workspace-create-step2-edit-connector](../../../_includes/security-deck/workspace-create-step2-edit-connector.md) %}

             1. {% include [workspace-create-step2-add-resources](../../../_includes/security-deck/workspace-create-step2-add-resources.md) %}

          - Заменить коннектор

            1. В блоке с именем коннектора нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![trash-bin](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
            1. Нажмите на поле **{{ ui-key.yacloud_org.security.workspaces.ConnectorAddField.addResourcesPlaceholder }}** ![chevron-down](../../../_assets/console-icons/chevron-down.svg) и в появившемся списке выберите нужный коннектор.

                {% include [workspace-create-step2-create-connector](../../../_includes/security-deck/workspace-create-step2-create-connector.md) %}

            1. {% include [workspace-create-step2-add-resources](../../../_includes/security-deck/workspace-create-step2-add-resources.md) %}

          {% endlist %}

      1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**, чтобы сохранить внесенные изменения.
  1. (Опционально) Перейдите на вкладку **{{ ui-key.yacloud_org.security.workspaces.WorkspaceEditPageLayout.tabStandards_wSeaW }}**, чтобы изменить список стандартов, на соответствие которым будут проверяться контролируемые окружением ресурсы:

      1. В блоке **{{ ui-key.yacloud_org.security.workspaces.WorkspaceStandardsForm.standards_title_dBBXP }}** выберите нужные стандарты:
      
          {% include [workspace-sec-standard-list](../../../_includes/security-deck/workspace-sec-standard-list.md) %}
      
          Вы можете выбрать одновременно несколько стандартов. При этом в блоке **{{ ui-key.yacloud_org.security.workspaces.WorkspaceStandardsForm.modules_title_s8LDi }}** будут добавляться модули {{ sd-name }}, которые будут активированы в создаваемом окружении для проверки ресурсов на соответствие выбранным стандартам.
      1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**, чтобы сохранить внесенные изменения.
  1. (Опционально) Перейдите на вкладку **{{ ui-key.yacloud_org.security.workspaces.WorkspaceEditPageLayout.tabKubernetes_rC2uU }}**, чтобы изменить настройки контроля безопасности использования кластеров {{ k8s }}.

{% endlist %}

{% note info %}

Каталог, который окружение использует для хранения своих ресурсов и настроек, изменить нельзя.

{% endnote %}

## Изменить коннектор {#update-connector}

Чтобы изменить [коннектор](../../concepts/workspace.md#connectors) {{ sd-name }}:

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите ![sliders](../../../_assets/console-icons/sliders.svg) **{{ ui-key.yacloud_org.security-center.label_settings }}** и перейдите на вкладку **{{ ui-key.yacloud_org.security.settings.SettingsPageLayout.connectorsLabel_2NoP9 }}**.

      {% note tip %}

      Чтобы быстрее найти нужный коннектор, воспользуйтесь фильтром.

      {% endnote %}

  1. В открывшемся списке в строке с нужным коннектором нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud_org.actions.edit }}**. В открывшемся окне:

      {% include [workspace-create-step2-edit-connector](../../../_includes/security-deck/workspace-create-step2-edit-connector.md) %}

{% endlist %}

## Изменить приемник алертов {#update-alert-sink}

Чтобы изменить [приемник алертов](../../concepts/workspace.md#alert-sinks) {{ sd-name }}:

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите ![sliders](../../../_assets/console-icons/sliders.svg) **{{ ui-key.yacloud_org.security-center.label_settings }}** и перейдите на вкладку **{{ ui-key.yacloud_org.security.settings.SettingsPageLayout.alertSinkLabel_gvxBa }}**.

      {% note tip %}

      Чтобы быстрее найти нужный приемник алертов, воспользуйтесь фильтром.

      {% endnote %}
  1. В открывшемся списке в строке с нужным коннектором нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud_org.actions.edit }}**.
  1. В открывшемся окне измените настройки приемника алертов и нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

#### См. также {#see-also}

* [{#T}](../../concepts/workspace.md)
* [{#T}](./create.md)
* [{#T}](./view-dashboard.md)
* [{#T}](./manage-access.md)
* [{#T}](./delete.md)