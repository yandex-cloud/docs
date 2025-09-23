---
title: Как начать работать с модулем Контроль {{ k8s }}® (KSPM) в {{ sd-full-name }}
description: Из этой инструкции вы узнаете, как начать работать с модулем Контроль {{ k8s }}® (KSPM) в {{ sd-name }}.
---

# Как начать работать с модулем Контроль {{ k8s }}® (KSPM) в {{ sd-full-name }}

{% include [note-preview-kspm](../../_includes/security-deck/note-preview-kspm.md) %}

{% include [kspm-basic-intro](../../_includes/security-deck/kspm-basic-intro.md) %}

{% note warning %}

Для задействования модуля KSPM у вас должна быть минимальная [роль](../security/index.md#security-deck-admin) `security-deck.admin` на [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), указанный в [окружении](../concepts/workspace.md).

У пользователей, которые будут в дальнейшем отслеживать нарушения в кластерах {{ managed-k8s-name }}, должна быть минимальная [роль](../security/kspm-roles.md#kspm-admin) `kspm.admin` на каталог, указанный в окружении.

{% endnote %}

## Активация модуля KSPM {#enable-kspm}

Чтобы начать работу с модулем KSPM:
1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт, от имени которого модуль KSPM будет просматривать информацию о [кластерах](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) {{ managed-k8s-name }}, устанавливать в них необходимые компоненты и выполняться проверки.
1. [Назначьте](../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту [роль](../security/index.md#security-deck-worker) `security-deck.worker` на организацию, облако или каталог.

    {% note info %}

    KSPM будет иметь доступ только к тем кластерам {{ managed-k8s-name }}, которые размещены в соответствующих организации, облаке или каталоге.

    {% endnote %}

    Если вы назначили роль на конкретный каталог, выдайте сервисному аккаунту также роль `auditor` на облако.

1. [Создайте](../operations/workspaces/create.md) окружение {{ sd-name }} со следующими особенностями:

    * В разделе **{{ ui-key.yacloud_org.security.workspaces.WorkspaceOnboardingForm.resourcesTitle_fE6qp }}** в настройках коннектора:
      * Выберите сервисный аккаунт, созданный ранее.
      * Укажите облака и каталоги, в которых вы хотите контролировать безопасность кластеров {{ managed-k8s-name }}.

        {% note tip %}

        В дальнейшем в настройках KSPM можно будет дополнительно сузить область контроля.

        {% endnote %}

    * В разделе **{{ ui-key.yacloud_org.security.workspaces.WorkspaceOnboardingForm.standartsTitle_cxvJ8 }}** выберите отраслевые стандарты и нормативные акты, на соответствие которым будут проверяться выбранные на предыдущем шаге ресурсы:
      
      {% include [kspm-sec-standard-list](../../_includes/security-deck/kspm-sec-standard-list.md) %}

      Вы можете выбрать одновременно несколько стандартов. При этом в блоке **{{ ui-key.yacloud_org.security.workspaces.WorkspaceStandardsForm.modules_title_s8LDi }}** будут отображаться модули {{ sd-name }}, которые будут активированы в создаваемом окружении для проверки ресурсов на соответствие выбранным стандартам и нормативным актам.
1. Завершите настройку KSPM:
    1. На странице созданного окружения нажмите ![image](../../_assets/console-icons/wrench.svg) **{{ ui-key.yacloud_org.security.workspaces.WorkspacePageLayout.edit_action }}**.
    1. Перейдите на вкладку **{{ ui-key.yacloud_org.security.workspaces.WorkspaceEditPageLayout.tabKubernetes_rC2uU }}**.
    1. В блоке **{{ ui-key.yacloud_org.security.workspaces.WorkspaceKspmResourcesForm.section-title_iYCNY }}** выберите облака, каталоги или кластеры в пределах ресурсов окружения, в которых будет производиться контроль за соблюдением правил безопасности {{ k8s }}.

        {% note warning %}

        Один кластер может входить только в одно окружение {{ sd-name }}. В противном случае будут возникать конфликты.

        {% endnote %}

    1. Нажмите **{{ ui-key.yacloud.common.save }}** и подтвердите действие.

        После этого в кластерах {{ managed-k8s-name }}, которые находятся в области действия контроля, будут автоматически установлены необходимые компоненты в пространстве имен `yc-security`.

        В зависимости от размера кластера установка компонентов может занять от 1 до 10 минут.

{% note tip %}

Чтобы удалить кластеры из области контроля и прекратить отслеживать их безопасность, [удалите](./workspaces/delete.md) окружение {{ sd-name }} или отключите стандарты безопасности, относящиеся к {{ k8s }}.

{% endnote %}

## Работа с модулем KSPM {#use-kspm}

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите ![image](../../_assets/security-deck/kspm.svg) **{{ ui-key.yacloud_org.security-center.label_kspm }}**.
  1. В верхней части окна нажмите кнопку **{{ ui-key.yacloud_components.cloud-center.action_more }}** ![chevron-down](../../_assets/console-icons/chevron-down.svg) и выберите [окружение](../concepts/workspace.md).
  1. На вкладке **{{ ui-key.yacloud_org.security-center.kspm.title_clusters }}** убедитесь, что все кластеры подключены к KSPM и находятся в активном статусе контроля.
  1. Изучите вкладку **{{ ui-key.yacloud_org.security-center.kspm.title_dashboard }}**. На ней размещены следующие блоки:
      * **{{ ui-key.yacloud_org.security.kspm.TopControlsByErrorsWidget.table_controls_rJ32E }}** — содержит самые нарушаемые в области контроля правила и количество нарушений.
      * Блок с общей статистикой по области контроля — содержит количество кластеров с ошибками подключения к KSPM, количество кластеров с предупреждениями по безопасности, а также **{{ ui-key.yacloud_org.kspm.TopClustersByErrorsWidget.table_clusters }}** и количество нарушений.
      * Список алертов с указанием типа угрозы, статуса и временем последнего обновления.

        {% include [kspm-alerts](../../_includes/security-deck/kspm-alerts.md) %}

{% endlist %}

## Правила контроля {{ k8s }} {#rules-info}

Чтобы посмотреть задействованные правила контроля {{ k8s }}:

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите ![file-text](../../_assets/console-icons/file-text.svg) **{{ ui-key.yacloud_org.app.security.control_rules_rWmUV }}**.
  1. В верхней части окна нажмите кнопку **{{ ui-key.yacloud_components.cloud-center.action_more }}** ![chevron-down](../../_assets/console-icons/chevron-down.svg) и выберите [окружение](../concepts/workspace.md), для которого хотите посмотреть информацию о правилах. При необходимости воспользуйтесь поиском.
  1. На открывшейся странице **{{ ui-key.yacloud_org.security.controls.ControlsPage.security_control_r4yn7 }}** перейдите на вкладку **{{ ui-key.yacloud_org.security.controls.ControlsPage.kubernetes_jRCmt }}**. Открывшийся раздел содержит список правил контроля, которые входят в состав заданных для текущего окружения [стандартов безопасности](../concepts/workspace.md#standards).

      Для каждого правила в таблице отображается следующая информация:
      
      {% note tip %}
      
      При необходимости вы можете изменить отображаемые в таблице столбцы с информацией. Для этого в строке с заголовками столбцов таблицы нажмите значок ![gear](../../_assets/console-icons/gear.svg), выберите столбцы с необходимой вам информацией и нажмите кнопку **{{ ui-key.yacloud_org.common.apply }}**.
      
      {% endnote %}
      
      * ![traffic-light](../../_assets/console-icons/traffic-light.svg) — уровень критичности правила: значок, информирующий о том, насколько критичным для безопасности является нарушение правила:
      
          * ![cspm-rule-notice-icon](../../_assets/security-deck/cspm-rule-notice-icon.svg) — {{ ui-key.yacloud_org.shared.components.severity_info_biSRh }};
          * ![cspm-low-severity-icon](../../_assets/security-deck/cspm-low-severity-icon.svg) — {{ ui-key.yacloud_org.shared.components.severity_low_tqf9A }}.
          * ![cspm-moderate-severity-icon](../../_assets/security-deck/cspm-moderate-severity-icon.svg) — {{ ui-key.yacloud_org.shared.components.severity_medium_8LZ4w }}.
          * ![cspm-high-severity-icon](../../_assets/security-deck/cspm-high-severity-icon.svg) — {{ ui-key.yacloud_org.shared.components.severity_high_cahHH }}.
      * **{{ ui-key.yacloud_org.security.controls.rule-result.controlRule_kr2Bv }}** — название правила и его краткая суть.
      * **{{ ui-key.yacloud_org.security.controls.rule-result.standards_iv6a5 }}** — значок (значки), соответствующие [стандартам безопасности](../../security-deck/concepts/workspace.md#standards), которые используют данное правило. Если значок цветной, значит, правило проверяется для соответствующего стандарта. Если значок серый — значит, не проверяется.
      * **{{ ui-key.yacloud_org.security.controls.rule-result.verificationMethod_dS9B2 }}** — тип проверки на соответствие контролируемой в окружении инфраструктуры данному правилу:      
          * `automatic`;
          * `manual`.
      * **{{ ui-key.yacloud_org.security.controls.ExceptionDrawer.resources_field_id }}** — идентификатор правила в {{ yandex-cloud }}.
      * **{{ ui-key.yacloud_org.security.controls.rule-result.violations_q7AcU }}** — количество выявленных нарушений правила.

  1. Чтобы посмотреть подробную информацию о конкретном правиле, нажмите на строку таблицы с его именем. Открывшееся окно с подробными сведениями содержит следующие вкладки с информацией:

      {% list tabs %}

      - {{ ui-key.yacloud_org.security.controls.RulePageLayout.tab_overview_s9riS }}

        В дополнение к сведениям, указанным в таблице с общей информацией о правилах, вкладка **{{ ui-key.yacloud_org.security.controls.RulePageLayout.tab_overview_s9riS }}** содержит:
        * информацию о дате и времени последней проверки безопасности;
        * подробную информацию о контролируемых функциональностях, их параметрах или действиях с ними.

      - {{ ui-key.yacloud_org.security.controls.RulePageLayout.tab_violations_dkbdT }}

        Вкладка **{{ ui-key.yacloud_org.security.controls.RulePageLayout.tab_violations_dkbdT }}** содержит список выявленных в результате проверок нарушений правила безопасности. Обнаруженные нарушения правила не будут включены в этот список, если они удовлетворяют условиям заданных для правила [исключений](../concepts/cspm.md#exceptions).

      - {{ ui-key.yacloud_org.security.controls.RulePageLayout.tab_recommendations_qq61Z }}

        Вкладка **{{ ui-key.yacloud_org.security.controls.RulePageLayout.tab_recommendations_qq61Z }}** содержит инструкции и решения по выполнению действий, предписанных правилом.

      {% endlist %}

{% endlist %}

### Посмотреть список исключений из правил {#view-exceptions-list}

Чтобы посмотреть список действующих для [окружения](../concepts/workspace.md) исключений из правил контроля {{ k8s }}:

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите ![file-text](../../_assets/console-icons/file-text.svg) **{{ ui-key.yacloud_org.app.security.control_rules_rWmUV }}**.
  1. В верхней части окна нажмите кнопку **{{ ui-key.yacloud_components.cloud-center.action_more }}** ![chevron-down](../../_assets/console-icons/chevron-down.svg) и выберите [окружение](../concepts/workspace.md), для которого хотите посмотреть информацию об исключениях из правил контроля. При необходимости воспользуйтесь поиском.
  1. На открывшейся странице **{{ ui-key.yacloud_org.security.controls.ControlsPage.security_control_r4yn7 }}** перейдите на вкладку **{{ ui-key.yacloud_org.security.controls.ControlsPage.exceptions_kw1u7 }}**.

      Список исключений для правил {{ k8s }} приведен в блоке **{{ ui-key.yacloud_org.security.controls.ControlsExceptionsPage.exceptions_header_qJD5D }}** и содержит следующие поля:
      * **Исключение** — причина исключения.
      * **Статус** — активно или неактивно.
      * **Правила** — список правил, проверка на соответствие с которыми исключена.
      * **Автор** — пользователь, создавший исключение.
      * **Дата создания** — дата и время создания исключения.

{% endlist %}

### Создать исключение {#create-exception}

Чтобы создать новое исключение для правил контроля {{ k8s }}:

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите ![file-text](../../_assets/console-icons/file-text.svg) **{{ ui-key.yacloud_org.app.security.control_rules_rWmUV }}**.
  1. В верхней части окна нажмите кнопку **{{ ui-key.yacloud_components.cloud-center.action_more }}** ![chevron-down](../../_assets/console-icons/chevron-down.svg) и выберите [окружение](../concepts/workspace.md), в котором вы хотите создать исключение из правил контроля. При необходимости воспользуйтесь поиском.
  1. На открывшейся странице **{{ ui-key.yacloud_org.security.controls.ControlsPage.security_control_r4yn7 }}** перейдите на вкладку **{{ ui-key.yacloud_org.security.controls.ControlsPage.exceptions_kw1u7 }}**.
  1. В правом верхнем углу экрана нажмите кнопку **{{ ui-key.yacloud_org.security.controls.ControlsExceptionsPage.action_create }}** ![chevron-down](../../_assets/console-icons/chevron-down.svg) и выберите `{{ ui-key.yacloud_org.security.controls.ControlsExceptionsPage.exceptions_header_vqsTb }}`. В открывшемся окне:
      1. В блоке **{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.scopeOfControl_aRkwB }}** укажите ресурсы, которые требуется исключить при проверке правил контроля {{ k8s }}:

          * `{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.allResources_2ax5E }}` — чтобы исключить из проверки все ресурсы, контролируемые в [окружении](../concepts/workspace.md).
          * `Выбранные ресурсы` — чтобы исключить из проверки только часть ресурсов. Чтобы выбрать ресурсы, исключаемые из проверки:

              * Нажмите кнопку ![circle-plus](../../_assets/console-icons/circle-plus.svg) **{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.selectResources_bD5MC }}**.
              * В открывшемся окне выберите ресурсы, исключаемые из правила, и нажмите кнопку **{{ ui-key.yacloud.common.apply }}**.
      1. В блоке **{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.ExceptionRulesSection.section-title }}** выберите правила контроля {{ k8s }}, по которым не должны проводиться проверки выбранных ресурсов:

          * `{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.ExceptionRulesSection.rules-select_option_all }}` — чтобы исключить для выбранных ресурсов проверку на соответствие всем правилам контроля {{ k8s }}.
          * `{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.ExceptionRulesSection.rules-select_option_selected }}` — чтобы исключить для выбранных ресурсов проверку на соответствие заданному набору правил. Чтобы выбрать правила, проверка на соответствие которым будет отключена в соответствии с создаваемым исключением:

              * Нажмите кнопку ![circle-plus](../../_assets/console-icons/circle-plus.svg) **{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.ExceptionRulesSection.action_select-rules }}**.
              * В открывшемся окне выберите правила, проверку на соответствие которым вы хотите исключить. При необходимости воспользуйтесь фильтром или поиском в верхней части окна.
              * Нажмите кнопку **Сохранить выбор**.
      1. В блоке **{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.section-title_3YcSF }}** в свободной форме укажите причину, по которой вы создаете исключение.
      1. Выберите ![image](../../_assets/console-icons/toggle-on.svg) **Активировать исключение**.
      1. Нажмите кнопку **{{ ui-key.yacloud_org.security.controls.ControlsExceptionsPage.action_create }}**

{% endlist %}

В результате созданное исключение отобразится в блоке **{{ ui-key.yacloud_org.security.controls.ControlsExceptionsPage.exceptions_header_vqsTb }}** на вкладке **{{ ui-key.yacloud_org.security.controls.ControlsPage.exceptions_kw1u7 }}** страницы **{{ ui-key.yacloud_org.security.controls.ControlsPage.security_control_r4yn7 }}**.

### Удалить исключение {#delete-exception}

Чтобы удалить исключение для правил контроля {{ k8s}}:

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите ![file-text](../../_assets/console-icons/file-text.svg) **{{ ui-key.yacloud_org.app.security.control_rules_rWmUV }}**.
  1. В верхней части окна нажмите кнопку **{{ ui-key.yacloud_components.cloud-center.action_more }}** ![chevron-down](../../_assets/console-icons/chevron-down.svg) и выберите [окружение](../concepts/workspace.md), в котором вы хотите удалить исключение из правил контроля. При необходимости воспользуйтесь поиском.
  1. На открывшейся странице **{{ ui-key.yacloud_org.security.controls.ControlsPage.security_control_r4yn7 }}** перейдите на вкладку **{{ ui-key.yacloud_org.security.controls.ControlsPage.exceptions_kw1u7 }}**.
  1. В блоке **{{ ui-key.yacloud_org.security.controls.ExceptionOverview.header_caption_cspm_9dTJt }}** в строке с исключением, которое вы хотите удалить, нажмите значок ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите ![trash-bin](../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.

{% endlist %}

В результате исключение будет удалено из [окружения](../concepts/workspace.md), а заданные им ограничения для проверок на соответствие правилам будут отменены.

### См. также {#see-also}

* [{#T}](../concepts/kspm.md)
* [{#T}](../security/kspm-roles.md)
* [{#T}](./workspaces/create.md)
* [{#T}](./cspm/view-rules.md)
* [{#T}](./cspm/manage-exceptions.md)