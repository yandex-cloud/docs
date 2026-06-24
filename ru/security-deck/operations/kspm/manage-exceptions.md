---
title: Управлять исключениями из правил контроля безопасности в модуле Контроль {{ k8s }}® ({{ kspm-name }}) в {{ sd-full-name }}
description: Инструкция по управлению исключениями из правил контроля безопасности в модуле {{ kspm-name }}.
---

# Управлять исключениями из правил контроля безопасности модуля {{ kspm-name }}

В исключениях модуля {{ kspm-name }} можно указать объекты, которые будут исключены из проверки по выбранным [правилам контроля](../../concepts/kspm.md): все ресурсы {{ k8s }} в окружении или только определенные объекты.

## Посмотреть список исключений из правил {#view-exceptions-list}

Чтобы посмотреть список действующих для [окружения](../../concepts/workspace.md) исключений из правил контроля {{ k8s }}:

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите ![file-text](../../../_assets/console-icons/file-text.svg) **{{ ui-key.yacloud_org.app.security.control_rules_rWmUV }}**.
  1. В верхней части окна выберите [окружение](../../concepts/workspace.md), для которого хотите посмотреть информацию об исключениях из правил контроля.
  1. На открывшейся странице **{{ ui-key.yacloud_org.security.controls.ControlsPage.security_control_r4yn7 }}** перейдите на вкладку **{{ ui-key.yacloud_org.security.controls.ControlsPage.exceptions_kw1u7 }}**.

      Список исключений для правил {{ k8s }} приведен в блоке **Контроль {{ k8s }}®** и содержит следующие поля:
      * **{{ ui-key.yacloud_org.security.controls.ControlsExceptionTable.field_status }}** — активно или неактивно.
      * **{{ ui-key.yacloud_org.security.controls.ControlsExceptionTable.field_rules }}** — список правил, проверка на соответствие которым исключена.
      * **{{ ui-key.yacloud_org.security.controls.ControlsExceptionTable.field_resources }}** — список ресурсов.
      * **{{ ui-key.yacloud_org.security.controls.ControlsExceptionTable.field_objects_5dGQy }}** — список объектов.
      * **{{ ui-key.yacloud_org.security.controls.ControlsExceptionTable.field_reason }}** — причина исключения.
      * **{{ ui-key.yacloud_org.security.controls.ControlsExceptionTable.field_author }}** — пользователь, создавший исключение, дата и время его создания.

{% endlist %}

## Создать исключение {#create-exception}

Чтобы создать новое исключение для правил контроля {{ k8s }}:

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите ![file-text](../../../_assets/console-icons/file-text.svg) **{{ ui-key.yacloud_org.app.security.control_rules_rWmUV }}**.
  1. В верхней части окна выберите [окружение](../../concepts/workspace.md), в котором вы хотите создать исключение из правил контроля.
  1. На открывшейся странице **{{ ui-key.yacloud_org.security.controls.ControlsPage.security_control_r4yn7 }}** перейдите на вкладку **{{ ui-key.yacloud_org.security.controls.ControlsPage.exceptions_kw1u7 }}**.
  1. В правом верхнем углу экрана нажмите кнопку **{{ ui-key.yacloud_org.security.controls.ControlsExceptionsPage.action_create }}** ![chevron-down](../../../_assets/console-icons/chevron-down.svg) и выберите `Контроль {{ k8s }}®`. На открывшейся странице:
      1. В блоке **{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.ExceptionRulesSection.section-title }}** выберите правила контроля {{ k8s }}, по которым не должны проводиться проверки выбранных ресурсов:

          * `{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.ExceptionRulesSection.rules-select_option_all }}` — чтобы исключить для выбранных ресурсов проверку на соответствие всем правилам контроля {{ k8s }}.
          * `{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.ExceptionRulesSection.rules-select_option_selected }}` — чтобы исключить для выбранных ресурсов проверку на соответствие заданному набору правил. Чтобы выбрать правила, проверка на соответствие которым будет отключена с создаваемым исключением:

              * Нажмите кнопку ![circle-plus](../../../_assets/console-icons/circle-plus.svg) **{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.ExceptionRulesSection.action_select-rules }}**.
              * В открывшемся окне выберите правила, проверку на соответствие которым вы хотите исключить. При необходимости воспользуйтесь фильтром или поиском в верхней части окна.
              * Нажмите кнопку **{{ ui-key.yacloud_org.security.workspaces.ServiceAccountResourceSelectDialog.action_save }}**.
      1. В блоке **{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.scopeOfControl_aRkwB }}** укажите ресурсы, которые требуется исключить при проверке правил контроля {{ k8s }}:

          * `{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.allResources_2ax5E }}` — чтобы исключить из проверки все ресурсы, контролируемые в [окружении](../../concepts/workspace.md).
          * `{{ ui-key.yacloud_org.security.dspm.data-sources.bXXxQ }}` — чтобы исключить из проверки только часть ресурсов. Чтобы выбрать ресурсы, исключаемые из проверки:

              * Нажмите кнопку ![circle-plus](../../../_assets/console-icons/circle-plus.svg) **{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.selectResources_bD5MC }}**.
              * В открывшемся окне выберите ресурсы, исключаемые из правила, и нажмите кнопку **{{ ui-key.yacloud.common.apply }}**.
      1. (Опционально) В блоке **{{ ui-key.yacloud_org.security.workspaces.section-title_9BLTm }}** уточните объекты, для которых должно действовать исключение. Можно ввести несколько значений — разделяйте их запятой, пробелом или `Enter`. Чтобы задать произвольное значение параметра или его части, используйте символ подстановки `*` в именах и метках.

          * Включите опцию **{{ ui-key.yacloud_org.security.workspaces.namespace-checkbox_85krx }}** и введите имя пространства имен. Требования к имени:

            * длина — не более 63 символов;
            * может содержать только строчные латинские буквы, цифры, дефисы и символ подстановки `*`.

          * Включите опцию **{{ ui-key.yacloud_org.security.workspaces.workload-names-checkbox_Wn4Cb }}** и введите имя рабочей нагрузки. Требования к имени:

            * длина — не более 63 символов;
            * может содержать только строчные латинские буквы, цифры, дефисы и символ подстановки `*`;
            * первый и последний символ — буква, цифра или символ подстановки `*`.

          * Включите опцию **{{ ui-key.yacloud_org.security.workspaces.workload-types-checkbox_Wt4Cb }}** и введите тип рабочей нагрузки. Примеры типов: `Deployment`, `StatefulSet`, `DaemonSet`, `Job`, `CronJob`, `ReplicaSet`, `Pod`. Требования к формату:

            * длина — не более 63 символов;
            * может содержать только латинские буквы и цифры.

          * Включите опцию **{{ ui-key.yacloud_org.security.workspaces.workload-labels-checkbox_Wl4Cb }}** и введите метку пода. Требования к формату:

            * метка должна быть в формате `ключ=значение`;
            * длина ключа и значения — не более 63 символов каждый.
            * в ключе и значении допустимы латинские буквы, цифры, дефис, нижнее подчеркивание и точка;
            * в ключе допустима прямая косая черта;
            * в значении допустим символ подстановки `*`;
            * первый и последний символ — буква или цифра. 

      1. В блоке **{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.section-title_3YcSF }}** в свободной форме укажите причину, по которой вы создаете исключение.
      1. Выберите ![image](../../../_assets/console-icons/toggle-on.svg) **{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.label_active-exclusion_fjPgA }}**.
      1. Нажмите кнопку **{{ ui-key.yacloud_org.security.controls.ControlsExceptionsPage.action_create }}**.

{% endlist %}

В результате созданное исключение отобразится в блоке **Контроль {{ k8s }}®** на вкладке **{{ ui-key.yacloud_org.security.controls.ControlsPage.exceptions_kw1u7 }}** страницы **{{ ui-key.yacloud_org.security.controls.ControlsPage.security_control_r4yn7 }}**.

Исключение также можно создать на странице алерта. Подробнее в разделе [{#T}](../alerts/work.md#create-exception).

## Удалить исключение {#delete-exception}

Чтобы удалить исключение для правил контроля {{ k8s }}:

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите ![file-text](../../../_assets/console-icons/file-text.svg) **{{ ui-key.yacloud_org.app.security.control_rules_rWmUV }}**.
  1. В верхней части окна выберите [окружение](../../concepts/workspace.md), в котором вы хотите удалить исключение из правил контроля.
  1. На открывшейся странице **{{ ui-key.yacloud_org.security.controls.ControlsPage.security_control_r4yn7 }}** перейдите на вкладку **{{ ui-key.yacloud_org.security.controls.ControlsPage.exceptions_kw1u7 }}**.
  1. В блоке **Контроль {{ k8s }}®** в строке с исключением, которое вы хотите удалить, нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![trash-bin](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.

{% endlist %}

В результате исключение будет удалено из [окружения](../../concepts/workspace.md), а заданные им ограничения для проверок на соответствие правилам будут отменены.