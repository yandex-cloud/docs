* In the **{{ ui-key.yacloud_org.security.vm.EndpointScanForm.label_resources_t6Wt8 }}** field, select:

    * `{{ ui-key.yacloud_org.security.vm.EndpointScanForm.resources_option_all_cAPZE }}`: For the target group to include [targets](../../../security-deck/concepts/vulnerability-management.md#endpoint-vulnerability-scan-targets) residing within {{ yandex-cloud }} resources across the entire {{ vuln-man-name }} scope defined in the workspace.
    * `{{ ui-key.yacloud_org.security.vm.EndpointScanForm.resources_option_selected_8L9Ng }}`: To restrict the target discovery scope to specific {{ yandex-cloud }} resources.

        Click ![circle-plus](../../../_assets/console-icons/circle-plus.svg) **{{ ui-key.yacloud_org.security.vm.EndpointScanForm.action_select_resources_pfycc }}** to select individual clouds and folders for analysis.
* In the **{{ ui-key.yacloud_org.security.vm.EndpointScanForm.label_addresses_uxHGp }}** field, select:

    * `{{ ui-key.yacloud_org.security.vm.EndpointScanForm.addresses_option_no_restrictions_ppxAa }}`: To scan all possible paths on the discovered endpoints.
    * `{{ ui-key.yacloud_org.security.vm.EndpointScanForm.addresses_option_ignore_iAJ9J }}`: To specify addresses to exclude from scanning.

        The field supports string values containing a partial path or a regular expression, e.g., `/api` or `[?&](token|auth)=([^&]+)`.

        One field must contain exactly one exclusion. As you type an exclusion into the field, a new field appears automatically for your next exclusion.
