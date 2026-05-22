Прежде чем начать работать с модулем {{ dspm-name }}, настройте [окружение](../../security-deck/concepts/workspace.md) и задайте каталог по умолчанию для хранения данных модуля [Контроль данных](../../security-deck/concepts/dspm.md) ({{ dspm-name }}):

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#console}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите ![database-magnifier](../../_assets/console-icons/database-magnifier.svg) **{{ ui-key.yacloud_org.security-center.dspm.label_dspm }}**.
  1. Если открылось окно настройки {{ sd-name }}, значит, каталог хранения данных модуля DSPM не настроен. В блоке **{{ ui-key.yacloud_org.security-center.onboarding.label_select-default-folder }}** выберите каталог, в котором по умолчанию будут сохраняться данные модуля, и внизу страницы нажмите **{{ ui-key.yacloud.common.save }}**.
  1. Если открылся интерфейс модуля **{{ ui-key.yacloud_org.security-center.dspm.label_dspm }}**, значит, каталог хранения данных модуля уже настроен, и вы можете продолжить работу.

      Вы можете изменить каталог хранения данных модуля **{{ ui-key.yacloud_org.security-center.dspm.label_dspm }}**. Для этого перейдите на вкладку **{{ ui-key.yacloud_org.security.dspm.DspmPageLayout.settings_wHmWK }}** и в блоке **{{ ui-key.yacloud_org.security-center.settings.general.section_default-storage_label }}** измените выбранный каталог.
  1. Активируйте модуль {{ dspm-name }} в текущем окружении. Для этого справа сверху нажмите кнопку ![wrench](../../_assets/console-icons/wrench.svg) **{{ ui-key.yacloud_org.security.dspm.DiscoveryPageLayout.header_button_text_hefvE }}**.

      В открывшемся окне на вкладке **{{ ui-key.yacloud_org.security.workspaces.WorkspaceEditPageLayout.tabStandards_wSeaW }}** в блоке **{{ ui-key.yacloud_org.security.workspaces.title_security-modules_8MdQg }}** выберите модуль **{{ ui-key.yacloud_org.security.workspaces.module_dspm_xxxxx }}** и нажмите кнопку **{{ ui-key.yacloud.common.save }}**.
  
      Если у вас еще нет окружения, [создайте](../../security-deck/operations/workspaces/create.md) его, активировав модуль **{{ ui-key.yacloud_org.security.workspaces.module_dspm_xxxxx }}** при создании.

{% endlist %}