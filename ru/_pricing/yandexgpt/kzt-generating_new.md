#|
|| **Модель** | **Цена за 1000 токенов в синхронном режиме,</br>вкл. НДС** | **Цена за 1000 токенов в асинхронном режиме,</br>вкл. НДС** ||
|| {{ gpt-lite }} | {{ sku|KZT|foundation_models.text_generation.v1|string }} | {% calc [currency=KZT] round((0,5 × {{ sku|KZT|foundation_models.text_generation.v1|number }}) × 100) / 100 %} ||
|| {{ gpt-pro }} 5 или младше | {% calc [currency=KZT] round((6 × {{ sku|KZT|foundation_models.text_generation.v1|number }}) × 100) / 100 %} | {% calc [currency=KZT] round((3 × {{ sku|KZT|foundation_models.text_generation.v1|number }}) × 100) / 100 %} ||
|| {{ gpt-pro }} 5.1 | {% calc [currency=KZT] round((2 × {{ sku|KZT|foundation_models.text_generation.v1|number }}) × 100) / 100 %} ^1^ | {% calc [currency=KZT] round((1 × {{ sku|KZT|foundation_models.text_generation.v1|number }}) × 100) / 100 %} ^1^ ||
|| {{ llama }} 8B | {{ sku|KZT|foundation_models.text_generation_alt.v1|string }} | {% calc [currency=KZT] round((0,5 × {{ sku|KZT|foundation_models.text_generation_alt.v1|number }}) × 100) / 100 %} ||
|| {{ llama }} 70B | {% calc [currency=KZT] round((6 × {{ sku|KZT|foundation_models.text_generation_alt.v1|number }}) × 100) / 100 %} | {% calc [currency=KZT] round((3 × {{ sku|KZT|foundation_models.text_generation_alt.v1|number }}) × 100) / 100 %} ||
|| Qwen3 235B | {% calc [currency=KZT] round((2,5 × {{ sku|KZT|foundation_models.text_generation_alt.v1|number }}) × 100) / 100 %} ^1^ | —  || 
|| gpt-oss-120b | {% calc [currency=KZT] round((1,5 × {{ sku|KZT|foundation_models.text_generation_alt.v1|number }}) × 100) / 100 %} | —  || 
|| gpt-oss-20b | {% calc [currency=KZT] round((0,5 × {{ sku|KZT|foundation_models.text_generation_alt.v1|number }}) × 100) / 100 %} | —  || 
|| Gemma3 27B | {% calc [currency=KZT] round((2 × {{ sku|KZT|foundation_models.text_generation.v1|number }}) × 100) / 100 %} ^1^ | — ||
|#

^1^ Цена указана с учетом действующей скидки 50%. 