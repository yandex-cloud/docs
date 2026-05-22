Under **{{ ui-key.yacloud_org.dspm.scans.section_scan-settings_title }}**:

1. Select **{{ ui-key.yacloud_org.dspm.scans.section_scan-settings_method_label }}**:
   * **{{ ui-key.yacloud_org.dspm.scans.section.scan-method_title_full }}**: Scan all source objects of the supported types. This method ensures high accurracy of sensitive data detection.
   * **{{ ui-key.yacloud_org.dspm.scans.section.scan-method_title_partial }}**: Scan only the selected partial data. Accuracy of sensitive data detection is lower, which is good for processing large amounts of data.

1. In the **{{ ui-key.yacloud_org.dspm.scans.section_scan-settings_schedule_label }}** field, select the frequency for the new scan: `{{ ui-key.yacloud_org.dspm.scans.section_scan-settings_schedule_single }}`, `Every 7 days`, `Every 30 days`, `Every 90 days`, or set your own frequency by selecting `{{ ui-key.yacloud_org.dspm.scans.section_scan-settings_schedule_custom }}`.
1. In the **{{ ui-key.yacloud_org.dspm.scans.section_scan-settings_job-name_label }}** field, specify the name to find your new scan. Follow these naming requirements:

    {% include [name-format](../name-format.md) %}