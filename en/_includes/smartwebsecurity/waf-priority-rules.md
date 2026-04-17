Security profile rules apply to traffic based on priority: the lower the number, the higher the priority.

**Recommended order of priority**

1. Allowing rule for captcha service routes.
1. Allowing rules with traffic conditions.
1. Blocking rules with traffic conditions.
1. Smart Protection and WAF + Smart Protection rules in _API protection_ mode with traffic conditions for endpoints where you cannot show captcha.
1. Smart Protection and WAF + Smart Protection rules in _Full protection_ mode with traffic conditions.
1. Smart Protection and WAF + Smart Protection rules in _Full protection_ mode for the whole traffic.

**Rule configuration example**

Priority | Rule name | Action | Rule description
--- | --- | --- | ---
8000 | allow-captcha | Allow | Rule to allow captcha service routes
9000 | allow-by-list | Allow | Basic for white IP addresses
9100 | block-by-list | Deny | Basic for black IP addresses
9200 | block-by-geo | Deny | Basic by regions
900000  | api-protection | API protection | Smart Protection for the public API
999900 | sp-rule-1 | Full protection | Smart Protection from a ready-made template
1000000 |  | Allow | Basic default

The `Allow` action is set for the basic default rule, while other rules are in the `Logging only` (dry run) mode. When switching rules to regular operation mode, set the `Deny` action for the basic default rule.