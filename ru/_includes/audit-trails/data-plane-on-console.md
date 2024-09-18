(опционально) В блоке **{{ ui-key.yacloud.audit-trails.label_event-filter-section }}** задайте параметры сбора аудитных логов уровня сервисов:

  * **{{ ui-key.yacloud.audit-trails.label_collecting-logs }}** — выберите `{{ ui-key.yacloud.common.enabled }}`.
  * Выберите [сервисы](../../audit-trails/concepts/events-data-plane.md), для которых вы хотите собирать аудитные логи.
  * Для каждого выбранного сервиса укажите [область](../../audit-trails/concepts/trail.md#collecting-area) сбора аудитных логов и тип фильтра событий:

      * `Получать все` — чтобы получать все события сервиса.
      * `Выбранные` — чтобы получать только выбранные события. Затем выберите [события](../../audit-trails/concepts/events-data-plane.md#dns).
      * `Исключить` — чтобы получать все события, кроме выбранных. Затем выберите события.
