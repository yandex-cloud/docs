| Услуга | Цена за 1 млн символов до 31 декабря 2025 года,<br/>вкл. НДС | Цена за 1 млн символов с 1 января 2026 года,<br/>вкл. НДС |
| ----- | ----- | ----- |
| Перевод | {{ sku|RUB|ai.mt.translate|string }} | {% calc [currency=RUB] round(({{ sku|RUB|ai.mt.translate|number }} / 120 × 122) × 100) / 100 %} | 
| Определение языка | {{ sku|RUB|ai.mt.detect|string }} | {% calc [currency=RUB] round(({{ sku|RUB|ai.mt.detect|number }} / 120 × 122) × 100) / 100 %} |
