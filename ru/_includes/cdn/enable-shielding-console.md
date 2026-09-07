1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором расположен ресурс.
1. [Перейдите]({{ link-console-main }}/link/cdn) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
1. Нажмите на имя необходимого ресурса.
1. Перейдите на вкладку ![image](../../_assets/console-icons/file.svg) **{{ ui-key.yacloud.cdn.label_shielding }}**.
1. Чтобы задействовать экранирование источников, в правом верхнем углу нажмите ![image](../../_assets/console-icons/power.svg) **{{ ui-key.yacloud.cdn.button_activate-shielding }}**.
1. В окне **{{ ui-key.yacloud.cdn.label_shielding-settings-title }}** в поле **{{ ui-key.yacloud.cdn.label_shielding-location }}** выберите необходимую локацию.
1. Нажмите кнопку **{{ ui-key.yacloud.cdn.button_activate-shielding }}**.

После включения статус экранирования изменится с `Not activated` на `Active`.

{% note tip %}

Аналогично вы можете выключить экранирование источников. Для этого на странице ресурса на вкладке ![image](../../_assets/console-icons/file.svg) **{{ ui-key.yacloud.cdn.label_shielding }}** в правом верхнем углу нажмите ![image](../../_assets/console-icons/square-xmark.svg) **{{ ui-key.yacloud.cdn.button_deactivate-shielding }}**.

После отключения статус экранирования изменится с `Active` на `Not activated`.

{% endnote %}
