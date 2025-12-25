| Количество | Цена до 31.12.2025, <br>вкл. НДС | Цена с 01.01.2026, <br>вкл. НДС |
| ----- | ----- | ----- |
| 1000 юнитов  | {{ sku|RUB|foundation_models.text_embedding.v1|string }} | {% calc [currency=RUB] round(({{ sku|RUB|foundation_models.text_embedding.v1|number }} / 120 × 122) × 100) / 100 %} |
