  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится нужный [профиль безопасности](../../smartwebsecurity/concepts/profiles.md).
  1. На панели слева выберите ![shield-check](../../_assets/console-icons/shield-check.svg) **{{ ui-key.yacloud.smart-web-security.title_profiles }}**.
  1. Выберите профиль безопасности, который вы хотите подключить к домену.
  1. Нажмите кнопку ![plug](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.smart-web-security.overview.action_attach-to-host }}**.
  1. В открывшемся окне нажмите **{{ ui-key.yacloud.smart-web-security.AttachSecurityProfileDialog.label_add-resource_v4U3g }}** и выберите **{{ ui-key.yacloud.smart-web-security.AttachSecurityProfileDialog.label_domain_9Bo38 }}**.
  1. Последовательно установите значения в полях **{{ ui-key.yacloud.smart-web-security.AttachSecurityProfileDialog.ProxyServerItem.label_proxy-server_w9BGG }}** и **{{ ui-key.yacloud.smart-web-security.AttachSecurityProfileDialog.ProxyServerItem.label_domain_1hgsY }}**. Вы можете подключить профиль безопасности сразу к нескольким доменам.
  1. Нажмите кнопку **{{ ui-key.yacloud.smart-web-security.attach-dialog.action_connect }}**.

      В разделе ![cubes-3-overlap](../../_assets/console-icons/cubes-3-overlap.svg) **{{ ui-key.yacloud.common.connected_resources }}** появятся подключенные домены.