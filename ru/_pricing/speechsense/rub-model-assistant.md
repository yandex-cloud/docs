#### До 31 декабря 2025 года {#prices-model-assistant-2025}

#|
|| **Модель** | **Цена за 1 000 символов,<br>вкл. НДС** ||
|| YandexGPT Pro | {{ sku|RUB|speechsense.analysis.assistant.v1|string }} ||
|| YandexGPT Lite | {% calc [currency=RUB] {{ sku|RUB|speechsense.analysis.assistant.v1|number }} / 6 %} ||
|| Qwen3 235B | {% calc [currency=RUB] {{ sku|RUB|speechsense.analysis.assistant.v1|number }} * 2 %} ||
|#

#### С 1 января 2026 года {#prices-model-assistant-2026}

#|
|| **Модель** | **Цена за 1 000 символов,<br>вкл. НДС** ||
|| YandexGPT Pro | {% calc [currency=RUB] round(({{ sku|RUB|speechsense.analysis.assistant.v1|number }} / 120 × 122) × 100) / 100 %} ||
|| YandexGPT Lite | {% calc [currency=RUB] round(({{ sku|RUB|speechsense.analysis.assistant.v1|number }} / 6 / 120 × 122) × 100) / 100 %} ||
|| Qwen3 235B | {% calc [currency=RUB] round(({{ sku|RUB|speechsense.analysis.assistant.v1|number }} * 2 / 120 × 122) × 100) / 100 %} ||
|#