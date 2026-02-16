* В блоке **{{ ui-key.yacloud.backup.policy-form.title_retention-section }}** задайте политику [хранения копий](../../backup/concepts/policy.md#retention):

  * `{{ ui-key.yacloud.backup.policy-form.value_retention-variant-save-all }}` — будут храниться все копии, созданные по этой политике резервного копирования.
  * `{{ ui-key.yacloud.backup.policy-form.value_retention-variant-save-last-f }}` — укажите количество последних копий, которые нужно хранить, или количество дней, недель или месяцев, копии за которые нужно хранить. Остальные копии будут удаляться автоматически.

      {% note info %}

      При создании политики с помощью консоли управления последующие изменения настроек хранения резервных копий применяются только после создания очередной резервной копии. Если изменения не вступили в силу, то [отвяжите](../../backup/operations/policy-vm/detach-vm.md) политику от ВМ или сервера {{ baremetal-name }} и после [привяжите](../../backup/operations/policy-vm/attach-and-detach-vm.md) ее заново.

      {% endnote %}