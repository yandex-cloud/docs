Security profile rules apply to traffic based on priority: the lower the number, the higher the priority.

**Recommended order of priority**

1. Allowing rule for captcha service routes.
1. Allowing rules with traffic conditions.
1. Blocking rules with traffic conditions.
1. Smart Protection and WAF + Smart Protection rules in `{{ ui-key.yacloud.smart-web-security.overview.cell_mode-api }}` mode with traffic conditions for endpoints where you cannot show captcha.
1. Smart Protection and WAF + Smart Protection rules in `{{ ui-key.yacloud.smart-web-security.overview.cell_mode-full }}` mode with traffic conditions.
1. Smart Protection and WAF + Smart Protection rules in `{{ ui-key.yacloud.smart-web-security.overview.cell_mode-full }}` mode for the whole traffic.

**Rule configuration example**

Priority | Rule name | Action | Rule description
--- | --- | --- | ---
8000 | allow-captcha | `{{ ui-key.yacloud.smart-web-security.form.label_action-allow }}` | Rule to allow captcha service routes
9000 | allow-by-list | `{{ ui-key.yacloud.smart-web-security.form.label_action-allow }}` | Basic for white IP addresses
9100 | block-by-list | `{{ ui-key.yacloud.smart-web-security.form.label_action-deny }}` | Basic for black IP addresses
9200 | block-by-geo | `{{ ui-key.yacloud.smart-web-security.form.label_action-deny }}` | Basic by regions
900000 | api-protection | `{{ ui-key.yacloud.smart-web-security.overview.cell_mode-api }}` | Smart Protection for the public API
999900 | sp-rule-1 | `{{ ui-key.yacloud.smart-web-security.overview.cell_mode-full }}` | Smart Protection from a ready-made template
1000000 |  | `{{ ui-key.yacloud.smart-web-security.form.label_action-allow }}` | Basic default

The `{{ ui-key.yacloud.smart-web-security.form.label_action-allow }}` action is set for the basic default rule, while other rules are in the **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }}** mode. When switching rules to regular operation mode, set the `{{ ui-key.yacloud.smart-web-security.form.label_action-deny }}` action for the basic default rule.
