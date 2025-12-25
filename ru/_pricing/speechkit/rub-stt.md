| Услуга | Цена за 15 секунд аудио до 31.12.2025,<br/>вкл. НДС | Цена за 15 секунд аудио с 1.01.2026,<br/>вкл. НДС |
| --- | --- | --- |
| [Потоковое распознавание](../../{{ speechkit-slug }}/stt/streaming.md)                                          | {{ sku|RUB|speechkit.stt.v1|string }} | {% calc [currency=RUB] round(({{ sku|RUB|speechkit.stt.v1|number }} / 120 × 122) × 100) / 100 %} |
| [Синхронное распознавание файлов](../../{{ speechkit-slug }}/stt/request.md)                                    | {{ sku|RUB|speechkit.stt.v1|string }} | {% calc [currency=RUB] round(({{ sku|RUB|speechkit.stt.v1|number }} / 120 × 122) × 100) / 100 %} |
| [Асинхронное распознавание файлов](../../{{ speechkit-slug }}/stt/transcribation.md)^*^                         | {% calc [currency=RUB] {{ sku|RUB|speechkit.stt_long_running.v1|number }} × 15 %} | {% calc [currency=RUB] round(({{ sku|RUB|speechkit.stt_long_running.v1|number }} × 15 / 120 × 122) × 100) / 100 %} |
| Асинхронное распознавание файлов, [отложенный режим](../../{{ speechkit-slug }}/stt/transcribation.md#modes)^*^ | {% calc [currency=RUB] {{ sku|RUB|speechkit.stt_long_running_deferred.v1|number }} × 15 %} | {% calc [currency=RUB] round(({{ sku|RUB|speechkit.stt_long_running_deferred.v1|number }} × 15 / 120 × 122) × 10000) / 10000 %} |

^*^ Посекундная тарификация с 16 секунды.
