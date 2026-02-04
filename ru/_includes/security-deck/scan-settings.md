В блоке **{{ ui-key.yacloud_org.dspm.scans.section_scan-settings_title }}**:

1. Выберите **{{ ui-key.yacloud_org.dspm.scans.section_scan-settings_method_label }}**:
   * **{{ ui-key.yacloud_org.dspm.scans.section.scan-method_title_full }}** — в источнике сканируются все объекты поддерживаемых типов. Этот метод гарантирует высокую точность обнаружения чувствительных данных.
   * **{{ ui-key.yacloud_org.dspm.scans.section.scan-method_title_partial }}** — выборочно сканируется только часть данных. Точность обнаружения чувствительных данных этого метода ниже, подходит для обработки больших объемов данных.

1. В поле **{{ ui-key.yacloud_org.dspm.scans.section_scan-settings_schedule_label }}** выберите подходящую периодичность создаваемого сканирования: `{{ ui-key.yacloud_org.dspm.scans.section_scan-settings_schedule_single }}`, `Каждые 7 дней`, `Каждые 30 дней`, `Каждые 90 дней` или задайте свою периодичность, выбрав `{{ ui-key.yacloud_org.dspm.scans.section_scan-settings_schedule_custom }}`.
1. В поле **{{ ui-key.yacloud_org.dspm.scans.section_scan-settings_job-name_label }}** задайте имя, по которому вы сможете находить создаваемое сканирование. Требования к имени:

    {% include [name-format](../name-format.md) %}