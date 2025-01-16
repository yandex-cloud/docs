| Service | Price for 15 seconds of audio,<br/>without VAT |
| --- | --- |
| [Streaming recognition](../../{{ speechkit-slug }}/stt/streaming.md)                                | {{ sku|USD|speechkit.stt.v1|string }} |
| [Synchronous file recognition](../../{{ speechkit-slug }}/stt/request.md)                           | {{ sku|USD|speechkit.stt.v1|string }} |
| [Asynchronous file recognition](../../{{ speechkit-slug }}/stt/transcribation.md)^*^                | {% calc [currency=USD] {{ sku|USD|speechkit.stt_long_running.v1|number }} × 15 %} |
| [Asynchronous file recognition, deferred mode](../../{{ speechkit-slug }}/stt/models#tags) model^*^ | {% calc [currency=USD] {{ sku|USD|speechkit.stt_long_running_deferred.v1|number }} × 15 %} |

^*^ Per-second billing starts from the 16th second.
