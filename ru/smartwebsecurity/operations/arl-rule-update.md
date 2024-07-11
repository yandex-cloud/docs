---
title: "Изменить правило в профиле ARL"
description: "Следуя данной инструкции, вы сможете изменить правило в профиле ARL."
---

# Изменить правило в профиле ARL

В [профиле ARL](../concepts/arl.md) можно изменить только правила ARL. Базовые [правила](../concepts/rules.md), Smart Protection и WAF [изменяются в профиле безопасности](rule-update.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите изменить правило в профиле ARL.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. Перейдите на вкладку ![image](../../_assets/smartwebsecurity/arl.svg) **Профили ARL**.
  1. Выберите профиль, в котором вы хотите изменить правило.
  1. Напротив правила нажмите ![options](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.edit }}**.
  1. Измените основные параметры правила:
      * **{{ ui-key.yacloud.common.name }}**.
      * **{{ ui-key.yacloud.common.description }}**.
      * **Приоритет** правила. Чем меньше значение параметра, тем больший приоритет у правила.
      * Опцию логирования без блокировки запросов (Dry run).
  1. Измените [условия](../concepts/conditions.md), которым должен соответствовать трафик, чтобы попасть под действие правила.
      
      Вы можете задать несколько условий одного типа. Для разных типов условий действуют разные логические операторы: _и_ или _или_. Чтобы добавить более одного условия определенного типа нажмите кнопки ![plus-sign](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.component.condition-column.condition_and }}** или ![plus-sign](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.component.condition-column.condition_or }}**.

      Чтобы удалить условие, нажмите кнопку ![options](../../_assets/console-icons/trash-bin.svg).
  1. Измените способ подсчета запросов и характеристики, по которым запросы будут объединяться в группы.
  1. Нажмите кнопку **Сохранить правило**.

{% endlist %}

### См. также {#see-also}

* [{#T}](rule-delete.md)
