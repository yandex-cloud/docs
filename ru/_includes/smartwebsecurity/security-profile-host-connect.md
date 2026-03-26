  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится нужный [профиль безопасности](../../smartwebsecurity/concepts/profiles.md).
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите ![shield-check](../../_assets/console-icons/shield-check.svg) **{{ ui-key.yacloud.smart-web-security.title_profiles }}**.
  1. Выберите профиль безопасности, который вы хотите подключить к [виртуальному хосту](../../application-load-balancer/concepts/http-router.md#virtual-host) сервиса [{{ alb-full-name }}](../../application-load-balancer/).
  1. Нажмите кнопку ![plug](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.smart-web-security.overview.action_attach-to-host }}**.
  1. В открывшемся окне нажмите **{{ ui-key.yacloud.smart-web-security.AttachSecurityProfileDialog.label_add-resource_v4U3g }}** и выберите **{{ ui-key.yacloud.smart-web-security.AttachSecurityProfileDialog.label_virtual-host_tYim5 }}**.
  1. Последовательно установите значения в полях [**{{ ui-key.yacloud.smart-web-security.attach-dialog.label_balancer }}**](../../application-load-balancer/concepts/application-load-balancer.md), [**{{ ui-key.yacloud.smart-web-security.attach-dialog.label_http-router }}**](../../application-load-balancer/concepts/http-router.md) и [**{{ ui-key.yacloud.smart-web-security.attach-dialog.label_virtual-host }}**](../../application-load-balancer/concepts/http-router.md#virtual-host). Вы можете подключить профиль безопасности сразу к нескольким хостам.

      Чтобы подключить профиль к еще одному L7-балансировщику, нажмите кнопку **{{ ui-key.yacloud.smart-web-security.AttachSecurityProfileDialog.label_add-resource_v4U3g }}** и выберите **{{ ui-key.yacloud.smart-web-security.AttachSecurityProfileDialog.label_virtual-host_tYim5 }}**.
    
  1. Нажмите кнопку **{{ ui-key.yacloud.smart-web-security.attach-dialog.action_connect }}**. Если выбранные хосты уже подключены к другому профилю безопасности, подтвердите подключение.

      В разделе ![cubes-3-overlap](../../_assets/console-icons/cubes-3-overlap.svg) **{{ ui-key.yacloud.common.connected_resources }}** появятся подключенные виртуальные хосты.