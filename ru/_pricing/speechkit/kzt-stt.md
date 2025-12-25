| Услуга | Цена за 15 секунд аудио до 31.12.2025,<br/>вкл. НДС | Цена за 15 секунд аудио с 1.01.2026,<br/>вкл. НДС |
| --- | --- | --- |
| [Потоковое распознавание](../../{{ speechkit-slug }}/stt/streaming.md)                                          | {{ sku|KZT|speechkit.stt.v1|string }} | {% calc [currency=KZT] round(({{ sku|KZT|speechkit.stt.v1|number }} / 112 × 116) × 100) / 100 %} |
| [Синхронное распознавание файлов](../../{{ speechkit-slug }}/stt/request.md)                                    | {{ sku|KZT|speechkit.stt.v1|string }} | {% calc [currency=KZT] round(({{ sku|KZT|speechkit.stt.v1|number }} / 112 × 116) × 100) / 100 %} |
| [Асинхронное распознавание файлов](../../{{ speechkit-slug }}/stt/transcribation.md)^*^                         | {% calc [currency=KZT] {{ sku|KZT|speechkit.stt_long_running.v1|number }} × 15 %} | {% calc [currency=KZT] round(({{ sku|KZT|speechkit.stt_long_running.v1|number }} × 15 / 112 × 116) × 100) / 100 %} |
| Асинхронное распознавание файлов, [отложенный режим](../../{{ speechkit-slug }}/stt/transcribation.md#modes)^*^ | {% calc [currency=KZT] {{ sku|KZT|speechkit.stt_long_running_deferred.v1|number }} × 15 %} | {% calc [currency=KZT] round(({{ sku|KZT|speechkit.stt_long_running_deferred.v1|number }} × 15 / 112 × 116) × 10000) / 10000 %} |

^*^ Посекундная тарификация с 16 секунды.
