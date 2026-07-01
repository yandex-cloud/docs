

1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
1. На панели слева выберите ![Database-Magnifier](../../_assets/console-icons/database-magnifier.svg) **{{ ui-key.yacloud_org.security-center.label_dspm }}**.
1. На странице модуля **{{ ui-key.yacloud_org.security-center.dspm.label_dspm }}** выберите `{{ ui-key.yacloud_org.security.dspm.DspmPageLayout.title_prefix_iWUEX }}{{ ui-key.yacloud_org.security.dspm.DspmPageLayout.title_discovery_kkTCM }}` и перейдите на вкладку **{{ ui-key.yacloud_org.security.dspm.DiscoveryScanCreatePage.label_scan-scopes_1wnUU }}**.
1. Нажмите **{{ ui-key.yacloud_org.dspm.scan.action_create-scan }}** или **{{ ui-key.yacloud_org.security.dspm.DiscoveryScansPage.action_new-scan-scope_puKvy }}**, если у вас уже есть запущенное сканирование. Откроется окно создания области сканирования.
1. Выберите нужные бакеты, каталоги или облака и нажмите **{{ ui-key.yacloud_org.security.discovery.action_include-in-scan_2wT6B }}**. 
1. В блоке **{{ ui-key.yacloud_org.security.dspm.DiscoveryScanSelectorCard.title_resources_2FDpG }}** укажите конкретные места, которые требуют постоянного мониторинга:
    1. В строке **{{ ui-key.yacloud_org.security.dspm.label_resources_9BVEB }}** определите облака или каталоги: `{{ ui-key.yacloud_org.component.filters.label_select-all }}` или `{{ ui-key.yacloud_org.security.dspm.selected_resources_fbUsF }}`. При необходимости выберите облака или каталоги.
    1. В строке **{{ ui-key.yacloud_org.security.dspm.label_include_in_scan_discovery_4wwj7 }}** выберите `{{ ui-key.yacloud_org.dspm.scan-resource-group.title_all_buckets }}` или `{{ ui-key.yacloud_org.dspm.scan-resource-group.title_public_buckets }}`.
    1. (Опционально) Настройте `{{ ui-key.yacloud_org.security.dspm.button_file_filter_jXXxv }}`:
        * добавьте форматы;
        * ограничьте максимальный и минимальный размер;
        * задайте регулярное выражение, которому будет удовлетворять или не удовлетворять путь.
  При необходимости добавьте еще группу ресурсов. Вы можете добавить несколько групп ресурсов, каждую со своими фильтрами.
1. В блоке **{{ ui-key.yacloud_org.security.dspm.search-categories_section_title_cPyLn }}** укажите, в каких данных будет выполняться поиск. Можно выбрать данные и **{{ ui-key.yacloud_components.security.dspm.card_title_text }}**, и **{{ ui-key.yacloud_components.security.dspm.card_title_image }}**. Включите опцию `{{ ui-key.yacloud_components.security.dspm.card_field_title }}`, чтобы модуль искал все чувствительные данные, или выберите конкретный тип данных:

   {% include [scan-data-types](scan-data-types.md) %}

1. В блоке **{{ ui-key.yacloud_org.security.dspm.section_settings_title_igA6u }}** в поле **{{ ui-key.yacloud_components.security.dspm.column_name }}** введите имя области сканирования. Оно может описывать контролируемую область, включать критичность, настройки поиска чувствительных данных и другую полезную информацию.

1. Нажмите **{{ ui-key.yacloud_org.forms.action.create }}**.

{{ dspm-name }} начнет непрерывно отслеживать изменения только в области сканирования, обеспечивая эффективный и целевой контроль за вашими чувствительными данными.
