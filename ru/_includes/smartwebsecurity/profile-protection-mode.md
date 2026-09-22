[Режим защиты](../../smartwebsecurity/concepts/profiles.md#protection-mode) определяет, какие правила профиля применяются к трафику. Для каждого правила вы [выбираете режимы](../../smartwebsecurity/operations/rule-add.md), в которых оно действует. По умолчанию правило действует во всех режимах.

Режимы в порядке усиления защиты:

* **{{ ui-key.yacloud.smart-web-security.PanicModeLabel.mode-name_green_5oA4f }}** — правила для штатной нагрузки.
* **{{ ui-key.yacloud.smart-web-security.PanicModeLabel.mode-name_yellow_sc1Te }}** — правила для подозрительного роста нагрузки.
* **{{ ui-key.yacloud.smart-web-security.PanicModeLabel.mode-name_red_iPa4X }}** — правила для атаки или критической нагрузки.

В разделе **{{ ui-key.yacloud.smart-web-security.SecurityProfileForm.AdaptiveProtectionSection.sectionTitle }}** выберите способ переключения режимов защиты:

* **{{ ui-key.yacloud.smart-web-security.SecurityProfileForm.AdaptiveProtectionSection.controlModeAutomatic }}** — сервис будет переключать режим в зависимости от входящей нагрузки.

  По умолчанию действует режим **{{ ui-key.yacloud.smart-web-security.PanicModeLabel.mode-name_green_5oA4f }}**. Для режимов **{{ ui-key.yacloud.smart-web-security.PanicModeLabel.mode-name_yellow_sc1Te }}** и **{{ ui-key.yacloud.smart-web-security.PanicModeLabel.mode-name_red_iPa4X }}** настройте:

  1. Порог включения: в поле **{{ ui-key.yacloud.smart-web-security.SecurityProfileForm.AdaptiveProtectionSection.thresholdLabelBefore }}** укажите количество входящих запросов и выберите интервал подсчета. Режим включится, если число запросов за этот интервал превысит порог.
  1. Время сохранения режима: в поле **{{ ui-key.yacloud.smart-web-security.SecurityProfileForm.AdaptiveProtectionSection.holdLabel }}** задайте задержку перед возвратом к нормальному режиму после снижения нагрузки ниже порога. Это поможет избежать частых переключений при колебаниях нагрузки.

  Чтобы подобрать пороги:

  * Оцените обычные пики трафика по графику [Inbound total RPS](../../smartwebsecurity/operations/monitoring.md#monitoring-dashboards) — он показывает число входящих запросов в секунду. Выберите период без атак, включающий будни, выходные и часы пик. Учтите ожидаемый рост трафика, например во время рекламных кампаний.
  * Для режима **{{ ui-key.yacloud.smart-web-security.PanicModeLabel.mode-name_yellow_sc1Te }}** задайте порог выше обычных пиков с запасом на допустимые всплески.
  * Для режима **{{ ui-key.yacloud.smart-web-security.PanicModeLabel.mode-name_red_iPa4X }}** задайте более высокий порог, но ниже уровня нагрузки, при котором приложение начинает замедляться или возвращать ошибки. Определите этот уровень по метрикам приложения или результатам нагрузочного тестирования.

* **{{ ui-key.yacloud.smart-web-security.SecurityProfileForm.AdaptiveProtectionSection.controlModeManual }}** — выберите нужный режим. Он будет действовать независимо от нагрузки, пока вы не выберете другой или не включите автоматическое управление.
