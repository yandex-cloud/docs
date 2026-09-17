If multiple rule sets are enabled:

* Select the profile trigger conditions:

    * `{{ ui-key.yacloud.smart-web-security.waf.verdict-at-least-one }}`: At least one rule set has recognized the request as a threat.
    * `{{ ui-key.yacloud.smart-web-security.waf.verdict-all }}`: All added rule sets have recognized the request as a threat.

* Arrange rule sets in the order of priority in which the rules will analyze the request. Top positions indicate higher priority.