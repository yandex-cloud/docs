Роль `security-deck.auditor` позволяет просматривать информацию о ресурсах модулей {{ dspm-name }}, {{ cspm-name }}, {{ kspm-name }}, {{ vuln-man-short-name }} и {{ td-name }}, а также об алертах и приемниках алертов, о заданиях сканирования и количестве найденных угроз безопасности. Роль не позволяет просматривать замаскированные и необработанные данные.

Пользователи с этой ролью могут:
* просматривать информацию о профилях {{ dspm-name }};
* просматривать информацию об [источниках данных](../../security-deck/concepts/dspm.md#data-source) {{ dspm-name }} и их областях сканирований;
* просматривать информацию о заданиях [сканирования](../../security-deck/concepts/dspm.md#scanning) на наличие чувствительной информации в модуле {{ dspm-name }};
* просматривать информацию о типах и [категориях](../../security-deck/concepts/dspm.md#data-categories) данных;
* просматривать информацию о сканированиях на наличие чувствительной информации в модуле {{ dspm-name }};
* просматривать списки результатов и ошибок сканирований;
* просматривать результаты сканирования {{ dspm-name }} и информацию об обнаруженных угрозах безопасности;
* просматривать информацию о результатах [анализа данных](../../security-deck/concepts/dspm#discovery-mode) модуля {{ dspm-name }};
* просматривать информацию об [окружениях](../../security-deck/concepts/workspace.md) {{ sd-name }} и контролируемых в них ресурсах, а также о назначенных [правах доступа](../../iam/concepts/access-control/index.md) к ним;
* просматривать информацию о [коннекторах](../../security-deck/concepts/workspace.md#connectors);
* просматривать информацию о проверках инфраструктуры на соответствие [стандартам безопасности](../../security-deck/concepts/cspm.md#standards), а также о заданиях таких проверок, указанных в настройках [модуля {{ cspm-name }}](../../security-deck/concepts/cspm.md);
* просматривать информацию о настройках [модуля {{ kspm-name }}](../../security-deck/concepts/kspm.md) и операциях в модуле, а также список исключений из правил;
* просматривать информацию о [приемниках алертов](../../security-deck/concepts/workspace.md#alert-sinks) и назначенных правах доступа к ним;
* просматривать результаты сканирования [модуля {{ vuln-man-short-name }}](../../security-deck/concepts/vulnerability-management.md);
* просматривать информацию о правилах контроля безопасности [модуля {{ td-name }}](../../security-deck/concepts/threat-detector.md) и назначенных правах доступа к нему.

Включает разрешения, предоставляемые ролями `dspm.auditor`, `cspm.auditor`, `kspm.auditor`, `security-deck.alertSinks.auditor`, `vulnerability-manager.auditor` и `threat-detector.auditor`.
