#|
|| **Model** | **Price per 1,000 characters,<br>without VAT** ||
|| YandexGPT Pro | {{ sku|USD|speechsense.analysis.assistant.v1|string }} ||
|| YandexGPT Lite | {% calc [currency=USD] {{ sku|USD|speechsense.analysis.assistant.v1|number }} / 6 %} ||
|#