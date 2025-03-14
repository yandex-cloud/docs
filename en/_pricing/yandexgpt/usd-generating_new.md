| Number | Cost, <br>without VAT |
| ----- | ----- |
| 1,000 units | {{ sku|USD|foundation_models.text_generation.v1|string }} |

<br>

| Model parameters | Number of units per token | Cost per 1,000 tokens, </br> without VAT |
|---------------------------------------------------------|:-------:|----------------------------------------|
| {{ gpt-lite }}, synchronous mode | 1 | {{ sku|USD|foundation_models.text_generation.v1|string }} |
| {{ gpt-lite }}, asynchronous mode | 0.5 | $0.0008 |
| {{ gpt-pro }}, synchronous mode | 6 | $0.0096 |
| {{ gpt-pro }}, asynchronous mode | 3 | $0.0048 |
| Models fine-tuned in {{ ml-platform-name }}, synchronous mode | 6 | $0.0096 |
| Models fine-tuned in {{ ml-platform-name }}, asynchronous mode | 3 | $0.0048 |
| {{ llama }} 8b^1^, synchronous mode | 1 | {{ sku|USD|foundation_models.text_generation_alt.v1|string }} |
| {{ llama }} 8b, asynchronous mode | 0.5 | $0.0008 |
| {{ llama }} 70b^1^, synchronous mode | 6 | $0.0096 |
| {{ llama }} 70b, asynchronous mode | 3 | $0.0048 |