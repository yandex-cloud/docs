(Optional) Under **{{ ui-key.yacloud.smart-web-security.waf.section_analyze-request }}**, configure the **{{ ui-key.yacloud.smart-web-security.waf.field_analyze-request-body }}** option:
* The default value for the **{{ ui-key.yacloud.smart-web-security.waf.label_size-limit }}** field is `8 kB`. Currently, you cannot change the default value.
* Select the action to be performed when the maximum size is exceeded:

   * `{{ ui-key.yacloud.smart-web-security.waf.label_analyze-request-body-action-ignore }}`​.
   * `{{ ui-key.yacloud.smart-web-security.waf.label_analyze-request-body-action-deny }}`​.