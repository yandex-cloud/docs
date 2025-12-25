#### До 31 декабря 2025 года {#prices-text-2025}

| Аналитика текстовых диалогов, тысяч символов в месяц | Цена за 1 000 символов,<br>вкл. НДС |
|---|---|
| от 0 до 100 000           | {{ sku|RUB|speechsense.analysis.text.v2|string }} |
| от 100 001 до 500 000     | {{ sku|RUB|speechsense.analysis.text.v2|pricingRate.100000|string }} |
| от 500 001 до 1 000 000   | {{ sku|RUB|speechsense.analysis.text.v2|pricingRate.500000|string }} |
| от 1 000 001 до 2 500 000 | {{ sku|RUB|speechsense.analysis.text.v2|pricingRate.1000000|string }} |
| от 2 500 001              | {{ sku|RUB|speechsense.analysis.text.v2|pricingRate.2500000|string }} |

#### С 1 января 2026 года {#prices-text-2026}

| Аналитика текстовых диалогов, тысяч символов в месяц | Цена за 1 000 символов,<br>вкл. НДС |
|---|---|
| от 0 до 100 000           | {% calc [currency=RUB] round(({{ sku|RUB|speechsense.analysis.text.v2|number }} / 120 × 122) × 100) / 100 %} |
| от 100 001 до 500 000     | {% calc [currency=RUB] round(({{ sku|RUB|speechsense.analysis.text.v2|pricingRate.100000|number }} / 120 × 122) × 100) / 100 %} |
| от 500 001 до 1 000 000   | {% calc [currency=RUB] round(({{ sku|RUB|speechsense.analysis.text.v2|pricingRate.500000|number }} / 120 × 122) × 100) / 100 %} |
| от 1 000 001 до 2 500 000 | {% calc [currency=RUB] round(({{ sku|RUB|speechsense.analysis.text.v2|pricingRate.1000000|number }} / 120 × 122) × 100) / 100 %} |
| от 2 500 001              | {% calc [currency=RUB] round(({{ sku|RUB|speechsense.analysis.text.v2|pricingRate.2500000|number }} / 120 × 122) × 100) / 100 %} |