# Профили безопасности

_Профиль безопасности_ — основной элемент сервиса {{ sws-name }}. Профиль состоит из набора [правил](rules.md), каждое из которых содержит [условия](conditions.md) для применения определенных [действий](rules.md#rule-action) к HTTP-запросам, приходящим к защищаемому ресурсу.

Для создания профилей предусмотрены варианты:
  * _{{ ui-key.yacloud.smart-web-security.title_default-template }}_. Преднастроенный профиль содержит:
    * [базовое правило](rules.md#base-rules) по умолчанию, включенное для всего трафика;
    * [правило Smart Protection](rules.md#smart-protection-rules), включенное для всего трафика, с типом действия — _{{ ui-key.yacloud.smart-web-security.overview.cell_mode-full }}_.
  * _{{ ui-key.yacloud.smart-web-security.title_no-template }}_. Профиль содержит только базовое правило по умолчанию, включенное для всего трафика. 

Вы можете подключить профиль безопасности к [виртуальным хостам](../../application-load-balancer/concepts/http-router.md#virtual-host) L7-балансировщика [{{ alb-full-name }}](../../application-load-balancer/). Подробнее см. [Управление подключениями к виртуальным хостам](../operations/#hosts).

Подробности о работе с профилями см. в [Управление профилями безопасности](../operations/#profiles).
