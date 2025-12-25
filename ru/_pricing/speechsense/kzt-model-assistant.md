#### До 31 декабря 2025 года {#prices-model-assistant-2025}

#|
|| **Модель** | **Цена за 1 000 символов,<br>вкл. НДС** ||
|| YandexGPT Pro | {{ sku|KZT|speechsense.analysis.assistant.v1|string }} ||
|| YandexGPT Lite | {% calc [currency=KZT] {{ sku|KZT|speechsense.analysis.assistant.v1|number }} / 6 %} ||
|#

#### С 1 января 2026 года {#prices-model-assistant-2026}

#|
|| **Модель** | **Цена за 1 000 символов,<br>вкл. НДС** ||
|| YandexGPT Pro | {% calc [currency=KZT] round(({{ sku|KZT|speechsense.analysis.assistant.v1|number }} / 112 × 116) × 100) / 100 %} ||
|| YandexGPT Lite | {% calc [currency=KZT] round(({{ sku|KZT|speechsense.analysis.assistant.v1|number }} / 6 / 112 × 116) × 100) / 100 %} ||
|#