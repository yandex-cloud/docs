* Введите имя. Требования к имени:

  {% include [name-format](../../_includes/name-format.md) %}

* В поле **{{ ui-key.yacloud.backup.field_repeat-period-type }}** выберите частоту создания копий:
  * `{{ ui-key.yacloud.backup.value_period-time-hourly }}`.
  * `{{ ui-key.yacloud.backup.value_period-time-daily }}` — укажите время создания копий.
  * `{{ ui-key.yacloud.backup.value_period-time-weekly }}` — укажите дни недели и время создания копий.
  * `{{ ui-key.yacloud.backup.value_period-time-monthly }}` — укажите месяцы, дни месяца и время создания копий.
* Выберите [тип резервных копий](../../backup/concepts/backup.md#types):
  * `{{ ui-key.yacloud.backup.field_type-incremental }}` — сохраняются только отличия от предыдущей копии.
  * `{{ ui-key.yacloud.backup.field_type-full }}` — сохраняются все данные виртуальной машины.
* Выберите [политику хранения копий](../../backup/concepts/policy.md#retention):
  * `{{ ui-key.yacloud.backup.value_retention-save-all }}` — будут храниться все копии, созданные по этой политике резервного копирования.
  * `{{ ui-key.yacloud.backup.value_retention-save-last-f }}` — укажите количество последних копий, которые нужно хранить, или количество дней, недель или месяцев, копии за которые нужно хранить. Остальные копии будут удаляться автоматически.
  
  Если политика создана с помощью консоли управления, последующие изменения настроек правил хранения резервных копий будут задействованы после создания очередной резервной копии.
