Security profile rules apply to all traffic according to the priority: the lower the number, the higher the priority. The sequence in which the rules will apply is provided in the table below.

Priority | Rule name | Action | Rule description
--- | --- | --- | ---
8000 | allow-captcha | Allow | Basic for captcha
9000 | allow-by-list | Allow | Basic for white IP addresses
9100 | block-by-list | Deny | Basic for black IP addresses
9200 | block-by-geo | Deny | Basic by regions
900000  | api-protection | API protection | Smart Protection for the public API
999900 | sp-rule-1 | Full protection | Smart Protection from a ready-made template
1000000 |  | Allow | Basic default

The `Allow` action is set for the basic default rule, while other rules are in the `Logging only` (dry run) mode. When switching rules to regular operation mode, set the `Deny` action for the basic default rule.