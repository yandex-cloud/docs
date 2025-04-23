| Number | Cost, <br>without VAT |
| ----- | ----- |
| 1,000 units | {{ sku|USD|foundation_models.text_generation.v1|string }} |

| Model parameters | Number of units</br>per token | Cost per 1,000 tokens,</br>without VAT |
|------------------------------------------------------|------------|-----------------------------------------|
| {{ gpt-lite }}, synchronous mode  | 1 | {{ sku|USD|foundation_models.text_generation.v1|string }} |
| {{ gpt-lite }}, asynchronous mode | 0.5 | {% calc [currency=USD] 0,5 × {{ sku|USD|foundation_models.text_generation.v1|number }} %} |
| {{ gpt-pro }}, synchronous mode       | 6 | {% calc [currency=USD] 6 × {{ sku|USD|foundation_models.text_generation.v1|number }} %} |
| {{ gpt-pro }}, asynchronous mode      | 3 | {% calc [currency=USD] 3 × {{ sku|USD|foundation_models.text_generation.v1|number }} %} |
| Model fine-tuned in {{ ml-platform-name }}, synchronous mode | 6 | {% calc [currency=USD] 6 × {{ sku|USD|foundation_models.text_generation.v1|number }} %} |
| Model fine-tuned in {{ ml-platform-name }}, asynchronous mode | 3 | {% calc [currency=USD] 3 × {{ sku|USD|foundation_models.text_generation.v1|number }} %} |
| {{ llama }} 8b^1^, synchronous mode  | 1 | {{ sku|USD|foundation_models.text_generation_alt.v1|string }} |
| {{ llama }} 8b, asynchronous mode | 0.5 | {% calc [currency=USD] 0,5 × {{ sku|USD|foundation_models.text_generation_alt.v1|number }} %} |
| {{ llama }} 70b^1^, synchronous mode       | 6 | {% calc [currency=USD] 6 × {{ sku|USD|foundation_models.text_generation_alt.v1|number }} %} |
| {{ llama }} 70b, asynchronous mode      | 3 | {% calc [currency=USD] 3 × {{ sku|USD|foundation_models.text_generation_alt.v1|number }} %} |