The _protection mode_ determines which profile rules apply to traffic. For each rule, you need to [select the modes](../../smartwebsecurity/operations/rule-add.md) it will apply in. By default, rules apply in all modes.

Modes in ascending order of protection:

* **{{ ui-key.yacloud.smart-web-security.PanicModeLabel.mode-name_green_5oA4f }}**: Rules for standard load.
* **{{ ui-key.yacloud.smart-web-security.PanicModeLabel.mode-name_yellow_sc1Te }}**: Rules for suspicious increase in load.
* **{{ ui-key.yacloud.smart-web-security.PanicModeLabel.mode-name_red_iPa4X }}**: Rules for an attack or critical load.

Under **{{ ui-key.yacloud.smart-web-security.SecurityProfileForm.AdaptiveProtectionSection.sectionTitle }}**, select how to switch between protection modes:

* **{{ ui-key.yacloud.smart-web-security.SecurityProfileForm.AdaptiveProtectionSection.controlModeAutomatic }}**: The service will select a mode based on the incoming load.

  The mode used by default is **{{ ui-key.yacloud.smart-web-security.PanicModeLabel.mode-name_green_5oA4f }}**. For the **{{ ui-key.yacloud.smart-web-security.PanicModeLabel.mode-name_yellow_sc1Te }}** and **{{ ui-key.yacloud.smart-web-security.PanicModeLabel.mode-name_red_iPa4X }}** modes, configure the following:

  1. Activation threshold: In the **{{ ui-key.yacloud.smart-web-security.SecurityProfileForm.AdaptiveProtectionSection.thresholdLabelBefore }}** field, specify the number of incoming requests and select the counting interval. The mode will get activated if the number of requests during this interval exceeds the threshold.
  1. Mode retention time: In the **{{ ui-key.yacloud.smart-web-security.SecurityProfileForm.AdaptiveProtectionSection.holdLabel }}** field, specify the delay before going back to normal mode after the load falls below the threshold. This helps avoid frequent mode changes during load fluctuations.

  To set thresholds:

  * Analyze your typical traffic peaks on the [Inbound total RPS](../../smartwebsecurity/operations/monitoring.md#monitoring-dashboards) chart which plots incoming requests per second. Select an attack-free period that includes weekdays, weekends, and peak hours. Allow for expected traffic growth, e.g., during promo campaigns.
  * For the **{{ ui-key.yacloud.smart-web-security.PanicModeLabel.mode-name_yellow_sc1Te }}** mode, set a threshold above normal peaks with a margin for acceptable spikes.
  * For the **{{ ui-key.yacloud.smart-web-security.PanicModeLabel.mode-name_red_iPa4X }}** mode, set a higher threshold but keep it below the load level where the application starts to slow down or throw errors. Find this level based on the application metrics or load testing results.

* **{{ ui-key.yacloud.smart-web-security.SecurityProfileForm.AdaptiveProtectionSection.controlModeManual }}**: Select the preferred mode. It will remain active regardless of the load until you select a different mode or enable automatic management.
