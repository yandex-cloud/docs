# Работа с алертами

## Изменить статус алерта {#status}

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите ![alerts](../../../_assets/security-deck/alerts.svg) **{{ ui-key.yacloud_org.security-center.label_alerts }}**.
  1. В верхней части окна выберите [окружение](../../concepts/workspace.md).
  1. Нажмите на строку таблицы с именем [алерта](../../concepts/alerts.md).
  1. В открывшемся окне в левом верхнем углу выберите статус.

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

            * `{{ ui-key.yacloud_org.security.controls.ResourceExceptionForm.title_reportCompliance_re4wo }}` — при соответствии заданным в исключении условиям ресурс будет генерировать только сигналы о соответствии правилу.
            * `{{ ui-key.yacloud_org.security.controls.ResourceExceptionForm.title_exclude_uK4FD }}` — при соответствии заданным в исключении условиям ресурс не будет генерировать никакие сигналы: ни о соответствии, ни о нарушении правила.

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

              * длина — от 3 до 63 символов;
              * может содержать строчные буквы латинского алфавита, цифры и дефисы;
              * первый символ — буква, последний — не дефис.

            Чтобы исключить несколько объектов сразу, используйте запись wildcard. Например, если указать `*-ns`, из проверки будут исключены объекты с суффиксом `ns`: `prod-ns` и `test-ns`.

        1. В блоке **{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.section-title_3YcSF }}** в свободной форме укажите причину, по которой вы создаете исключение.
        1. Выберите ![image](../../../_assets/console-icons/toggle-on.svg) **{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.label_active-exclusion_fjPgA }}**.
        1. Нажмите кнопку **{{ ui-key.yacloud_org.security.controls.ControlsExceptionsPage.action_create }}**.

      {% endlist %}

{% endlist %}

Созданное исключение отобразится в разделе ![file-text](../../../_assets/console-icons/file-text.svg) **{{ ui-key.yacloud_org.app.security.control_rules_rWmUV }}** соответствующего модуля.