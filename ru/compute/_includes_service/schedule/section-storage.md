В блоке **{{ ui-key.yacloud.compute.components.SnapshotScheduleFormContent.section_storage-settings_wG5uP }}** выберите политику хранения снимков:
* **{{ ui-key.yacloud.compute.components.SnapshotScheduleFormContent.label_empty-retention-policy_voaWW }}** — будут храниться все снимки, созданные по этому расписанию.
* **{{ ui-key.yacloud.compute.snapshot-schedule-form-next.active-retention-policy-field.message_store-last-begin_few }}** — укажите количество последних снимков, которые нужно хранить, или количество дней, за которые нужно хранить снимки. Остальные снимки, созданные по этому расписанию, будут удаляться автоматически.

{% note info %}

На количество и суммарный объем снимков в облаке действуют [квоты](../../concepts/limits.md#compute-quotas).

{% endnote %}
