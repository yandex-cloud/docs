---
title: Работать с алертами в {{ sd-full-name }}
description: В данном разделе вы узнаете, как в {{ sd-full-name }} работать с алертами.
---

# Работа с алертами

{% include [table-columns-tip](../../../_includes/security-deck/table-columns-tip.md) %}

## Изменить статус алерта {#status}

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите ![alerts](../../../_assets/security-deck/alerts.svg) **{{ ui-key.yacloud_org.security-center.label_alerts }}**.
  1. В верхней части окна выберите [окружение](../../concepts/workspace.md).
  1. Нажмите на строку таблицы с именем [алерта](../../concepts/alerts.md).
  1. В открывшемся окне в левом верхнем углу выберите статус.

{% endlist %}


## Изменить несколько алертов {#update-batch}

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите ![alerts](../../../_assets/security-deck/alerts.svg) **{{ ui-key.yacloud_org.security-center.label_alerts }}**.
  1. В верхней части окна выберите [окружение](../../concepts/workspace.md).
  1. Выберите один или несколько алертов с помощью опций слева от названий алертов.
  1. На панели внизу выберите действие.
  1. В открывшемся окне внесите изменения и нажмите **{{ ui-key.yacloud.common.save }}**.

{% endlist %}


## Проанализировать алерт с помощью ИИ {#ai-analysis}

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите ![alerts](../../../_assets/security-deck/alerts.svg) **{{ ui-key.yacloud_org.security-center.label_alerts }}**.
  1. В верхней части окна выберите [окружение](../../concepts/workspace.md).
  1. Нажмите на строку таблицы с именем алерта.
  1. В открывшемся окне нажмите ![sparkles](../../../_assets/console-icons/sparkles-fill.svg) **{{ ui-key.yacloud_org.security-center.alert.action_alert_analysis }}**.

      Справа откроется панель диалога с AI-ассистентом и его анализом.

{% endlist %}


## Оставить комментарий к алерту {#comment}

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите ![alerts](../../../_assets/security-deck/alerts.svg) **{{ ui-key.yacloud_org.security-center.label_alerts }}**.
  1. В верхней части окна выберите [окружение](../../concepts/workspace.md).
  1. Нажмите на строку таблицы с именем алерта.
  1. В открывшемся окне перейдите на вкладку **{{ ui-key.yacloud_org.security-center.alerts.title_alert_comments }}**.
  1. Введите и оформите комментарий, затем нажмите ![paper-plane](../../../_assets/console-icons/paper-plane.svg) **{{ ui-key.yacloud_org.security.alerts.comment_form.send }}**.

{% endlist %}


## Создать исключение из алерта {#create-exception}

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите ![alerts](../../../_assets/security-deck/alerts.svg) **{{ ui-key.yacloud_org.security-center.label_alerts }}**.
  1. В верхней части окна выберите [окружение](../../concepts/workspace.md).
  1. Выберите алерт.
  1. В открывшемся окне:

      * Чтобы создать исключение для всех ресурсов алерта, нажмите кнопку ![slasheye](../../../_assets/console-icons/eye-slash.svg) **{{ ui-key.yacloud_org.security.alerts-base.action_create-exception_kyUtB }}**.
      * Чтобы создать исключение только для части ресурсов, на вкладке **{{ ui-key.yacloud_org.security-center.alerts.title_alert_overview }}** в блоке **Затронутые ресурсы** выберите ресурсы и нажмите кнопку ![slasheye](../../../_assets/console-icons/eye-slash.svg) **{{ ui-key.yacloud_org.security.alerts-base.action_create-exception_kyUtB }}**.

  1. В открывшемся окне заполните параметры исключения в зависимости от модуля:

      {% list tabs %}

      - {{ cspm-name }}

        1. В блоке **{{ ui-key.yacloud_org.security.controls.ExceptionOverview.info_type_1dxbZ }}** выберите вариант действия для создаваемого исключения:

            {% include [cspm-exception-types](../../../_includes/security-deck/cspm-exception-types.md) %}

        1. В блоке **{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.ExceptionRulesSection.section-title }}** выберите правила модуля {{ cspm-name }}, для которых не должны проводиться проверки выбранных ресурсов:

            * `{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.ExceptionRulesSection.rules-select_option_all }}` — чтобы исключить для выбранных ресурсов проверку на соответствие всем правилам модуля {{ cspm-name }}.
            * `{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.ExceptionRulesSection.rules-select_option_selected }}` — чтобы исключить для выбранных ресурсов проверку на соответствие заданному набору правил. Чтобы выбрать правила:

                * Нажмите кнопку ![circle-plus](../../../_assets/console-icons/circle-plus.svg) **{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.ExceptionRulesSection.action_select-rules }}**.
                * В открывшемся окне выберите правила, проверку на соответствие которым вы хотите исключить. При необходимости воспользуйтесь фильтром или поиском в верхней части окна.
                * Нажмите кнопку **{{ ui-key.yacloud_org.security.workspaces.ServiceAccountResourceSelectDialog.action_save }}**.

        1. В блоке **{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.section-title_3YcSF }}** в свободной форме укажите причину, по которой вы создаете исключение.
        1. Нажмите кнопку **{{ ui-key.yacloud_org.security.controls.ControlsExceptionsPage.action_create }}**.

      - {{ kspm-name }}

        1. В блоке **{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.ExceptionRulesSection.section-title }}** выберите правила контроля {{ k8s }}, по которым не должны проводиться проверки выбранных ресурсов:

            * `{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.ExceptionRulesSection.rules-select_option_all }}` — чтобы исключить для выбранных ресурсов проверку на соответствие всем правилам контроля {{ k8s }}.
            * `{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.ExceptionRulesSection.rules-select_option_selected }}` — чтобы исключить для выбранных ресурсов проверку на соответствие заданному набору правил. Чтобы выбрать правила:

                * Нажмите кнопку ![circle-plus](../../../_assets/console-icons/circle-plus.svg) **{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.ExceptionRulesSection.action_select-rules }}**.
                * В открывшемся окне выберите правила, проверку на соответствие которым вы хотите исключить. При необходимости воспользуйтесь фильтром или поиском в верхней части окна.
                * Нажмите кнопку **{{ ui-key.yacloud_org.security.workspaces.ServiceAccountResourceSelectDialog.action_save }}**.

        1. В блоке **{{ ui-key.yacloud_org.security.workspaces.section-title_9BLTm }}** при помощи пространства имен укажите объекты, которые будут исключены из проверки:
            * Включите опцию **{{ ui-key.yacloud_org.security.workspaces.namespace-checkbox_85krx }}**.
            * Введите имя объекта из пространства имен. Требования к имени:

              {% include [name-format](../../../_includes/name-format.md) %}

            Чтобы исключить несколько объектов сразу, используйте запись wildcard. Например, если указать `*-ns`, из проверки будут исключены объекты с суффиксом `ns`: `prod-ns` и `test-ns`.

        1. В блоке **{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.section-title_3YcSF }}** в свободной форме укажите причину, по которой вы создаете исключение.
        1. Выберите ![image](../../../_assets/console-icons/toggle-on.svg) **{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.label_active-exclusion_fjPgA }}**.
        1. Нажмите кнопку **{{ ui-key.yacloud_org.security.controls.ControlsExceptionsPage.action_create }}**.

      {% endlist %}

{% endlist %}

Созданное исключение отобразится в разделе ![file-text](../../../_assets/console-icons/file-text.svg) **{{ ui-key.yacloud_org.app.security.control_rules_rWmUV }}** соответствующего модуля.
