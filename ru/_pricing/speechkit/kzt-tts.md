| Услуга | Цена за единицу тарификации до 31.12.2025,<br/>вкл. НДС | Цена за единицу тарификации с 1.01.2026,<br/>вкл. НДС |
| ----- | ----- | ----- |
| Синтез с использованием [API v1](../../{{ speechkit-slug }}/tts/request.md), за 1 млн символов | {{ sku|KZT|speechkit.tts_gpu.v1|string }} | {% calc [currency=KZT] round(({{ sku|KZT|speechkit.tts_gpu.v1|number }} / 112 × 116) × 100) / 100 %} |
| Синтез с использованием [API v3](../../{{ speechkit-slug }}/tts-v3/api-ref/grpc/index.md), за запрос | {{ sku|KZT|speechkit.tts.v3_request.v1|string }} | {% calc [currency=KZT] round(({{ sku|KZT|speechkit.tts.v3_request.v1|number }} / 112 × 116) × 100) / 100 %} |
