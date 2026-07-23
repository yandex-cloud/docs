

1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
1. In the left-hand panel, select ![Database-Magnifier](../../_assets/console-icons/database-magnifier.svg) **{{ ui-key.yacloud_org.security-center.label_dspm }}**.
1. On the **{{ ui-key.yacloud_org.security-center.dspm.label_dspm }}** module page, select `{{ ui-key.yacloud_org.security.dspm.DspmPageLayout.title_prefix_iWUEX }}{{ ui-key.yacloud_org.security.dspm.DspmPageLayout.title_discovery_kkTCM }}` and navigate to the **{{ ui-key.yacloud_org.security.dspm.DiscoveryScanCreatePage.label_scan-scopes_1wnUU }}** tab.
1. Click **{{ ui-key.yacloud_org.dspm.scan.action_create-scan }}** or **{{ ui-key.yacloud_org.security.dspm.DiscoveryScansPage.action_new-scan-scope_puKvy }}** if you already have a scan running. The scan scope creation window will open.
1. Select the buckets, folders, or clouds you want scanned and click **{{ ui-key.yacloud_org.security.discovery.action_include-in-scan_2wT6B }}**. 
1. Under **{{ ui-key.yacloud_org.security.dspm.DiscoveryScanSelectorCard.title_resources_2FDpG }}**, specify locations requiring continuous monitoring:
    1. In the **{{ ui-key.yacloud_org.security.dspm.label_resources_9BVEB }}** line, specify clouds or folders: `{{ ui-key.yacloud_org.component.filters.label_select-all }}` or `{{ ui-key.yacloud_org.security.dspm.selected_resources_fbUsF }}`. Select clouds or folders as needed.
    1. In the **{{ ui-key.yacloud_org.security.dspm.label_include_in_scan_discovery_4wwj7 }}** line, select `{{ ui-key.yacloud_org.dspm.scan-resource-group.title_all_buckets }}` or `{{ ui-key.yacloud_org.dspm.scan-resource-group.title_public_buckets }}`.
    1. Optionally, configure `{{ ui-key.yacloud_org.security.dspm.button_file_filter_jXXxv }}`:
        * Add formats.
        * Set maximum and minimum size limits.
        * Specify a regular expression to check the path against.
  Optionally, add another resource group. You can add several resource groups, each with filters of its own.
1. Under **{{ ui-key.yacloud_org.security.dspm.search-categories_section_title_cPyLn }}**, specify the data to search in. You can select both **{{ ui-key.yacloud_components.security.dspm.card_title_text }}** and **{{ ui-key.yacloud_components.security.dspm.card_title_image }}** data. Enable `{{ ui-key.yacloud_components.security.dspm.card_field_title }}` to search for all sensitive data or select a specific data type:

   {% include [scan-data-types](scan-data-types.md) %}

1. Under **{{ ui-key.yacloud_org.security.dspm.section_settings_title_igA6u }}**, enter a name for the scan scope in the **{{ ui-key.yacloud_components.security.dspm.column_name }}** field. It can describe the controlled area, include criticality, sensitive data search settings, and other useful information.

1. Click **{{ ui-key.yacloud_org.forms.action.create }}**.

{{ dspm-name }} will begin continuous monitoring of changes within the scan scope for effective and targeted control of your sensitive data.
