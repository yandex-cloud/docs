* В поле **{{ ui-key.yacloud_org.security.vm.EndpointScanForm.label_resources_t6Wt8 }}** выберите:

    * `{{ ui-key.yacloud_org.security.vm.EndpointScanForm.resources_option_all_cAPZE }}` — чтобы в группу целей попали [цели](../../../security-deck/concepts/vulnerability-management.md#endpoint-vulnerability-scan-targets), расположенные в ресурсах {{ yandex-cloud }} во всей области действия контроля, которая задана в окружении для модуля {{ vuln-man-name }}.
    * `{{ ui-key.yacloud_org.security.vm.EndpointScanForm.resources_option_selected_8L9Ng }}` — чтобы ограничить ресурсы {{ yandex-cloud }}, в которых будут обнаруживаться цели.

        Нажмите кнопку ![circle-plus](../../../_assets/console-icons/circle-plus.svg) **{{ ui-key.yacloud_org.security.vm.EndpointScanForm.action_select_resources_pfycc }}**, чтобы выбрать отдельные облака и каталоги для анализа.
* В поле **{{ ui-key.yacloud_org.security.vm.EndpointScanForm.label_addresses_uxHGp }}** выберите:

    * `{{ ui-key.yacloud_org.security.vm.EndpointScanForm.addresses_option_no_restrictions_ppxAa }}` — чтобы сканировать все возможные пути на обнаруженных конечных точках.
    * `{{ ui-key.yacloud_org.security.vm.EndpointScanForm.addresses_option_ignore_iAJ9J }}` — чтобы задать адреса, которые будут исключены из сканирования.

        Задать исключение в поле можно в формате строки, содержащей часть пути или регулярное выражение. Например: `/api` или `[?&](token|auth)=([^&]+)`.

        Одно поле должно содержать ровно одно исключение. При заполнении одного поля с исключением дополнительное поле для следующего исключения появляется автоматически.
