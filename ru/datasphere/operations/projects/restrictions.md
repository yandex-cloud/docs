# Задать ограничения для проекта

В {{ ml-platform-name }} вы можете настроить ограничения потребления для проекта. Пороги потребления для проекта задаются в [юнитах](../../pricing.md#unit).

1. {% include [include](../../../_includes/datasphere/ui-find-project.md) %}
1. Перейдите на вкладку **{{ ui-key.yc-ui-datasphere.project-page.tab.settings }}** и в блоке **{{ ui-key.yc-ui-datasphere.project-page.settings.limits }}** нажмите кнопку ![pencil](../../../_assets/console-icons/pencil-to-line.svg) **{{ ui-key.yc-ui-datasphere.common.edit }}**.
1. Задайте **{{ ui-key.yc-ui-datasphere.edit-project-page.balance }}** — общее количество юнитов, доступных для проекта. После запуска вычислений баланс проекта будет уменьшаться на количество юнитов, необходимых для работы выбранной [конфигурации](../../concepts/configurations.md) до тех пор, пока не выполнится одно из условий:
   * баланс станет меньше или равен нулю. Тогда все запущенные вычисления будут остановлены с предупреждением, что баланса проекта недостаточно.
   * истечет время, указанное в разделе **{{ ui-key.yc-ui-datasphere.common.general }}**.
   * вы самостоятельно остановите ВМ.

1. Нажмите кнопку **{{ ui-key.yc-ui-datasphere.common.save }}**.

#### См. также {#see-also}

* [{#T}](install-dependencies.md)
* [{#T}](control-compute-resources.md)
