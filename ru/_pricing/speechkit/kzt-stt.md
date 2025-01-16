| Услуга | Цена за 15 секунд аудио,<br/>вкл. НДС |
| --- | --- |
| [Потоковое распознавание](../../{{ speechkit-slug }}/stt/streaming.md)                                          | {{ sku|KZT|speechkit.stt.v1|string }} |
| [Синхронное распознавание файлов](../../{{ speechkit-slug }}/stt/request.md)                                    | {{ sku|KZT|speechkit.stt.v1|string }} |
| [Асинхронное распознавание файлов](../../{{ speechkit-slug }}/stt/transcribation.md)^*^                         | {% calc [currency=KZT] {{ sku|KZT|speechkit.stt_long_running.v1|number }} × 15 %} |
| Асинхронное распознавание файлов, [отложенный режим](../../{{ speechkit-slug }}/stt/transcribation.md#modes)^*^ | {% calc [currency=KZT] {{ sku|KZT|speechkit.stt_long_running_deferred.v1|number }} × 15 %} |

^*^ Посекундная тарификация с 16 секунды.
