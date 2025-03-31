> {{ sku|RUB|speechsense.analysis.text.v2|string }} × 100 000 + {{ sku|RUB|speechsense.analysis.text.v2|pricingRate.100000|string }} × 400 000 + {{ sku|RUB|speechsense.analysis.text.v2|pricingRate.500000|string }} × 185 000 = {% calc [currency=RUB] round(({{ sku|RUB|speechsense.analysis.text.v2|number }} × 100 000 + {{ sku|RUB|speechsense.analysis.text.v2|pricingRate.100000|number }} × 400 000 + {{ sku|RUB|speechsense.analysis.text.v2|pricingRate.500000|number }} × 185 000) × 100) / 100 %}
>
> Итого: {% calc [currency=RUB] round(({{ sku|RUB|speechsense.analysis.text.v2|number }} × 100 000 + {{ sku|RUB|speechsense.analysis.text.v2|pricingRate.100000|number }} × 400 000 + {{ sku|RUB|speechsense.analysis.text.v2|pricingRate.500000|number }} × 185 000) × 100) / 100 %} — стоимость аналитики 685 000 000 символов текстовых диалогов.

Где:
* {{ sku|RUB|speechsense.analysis.text.v2|string }} — стоимость анализа тысячи символов текста для первых 100 000 тысяч.
* {{ sku|RUB|speechsense.analysis.text.v2|pricingRate.100000|string }} — стоимость анализа тысячи символов текста для последующих 400 000 тысяч.
* {{ sku|RUB|speechsense.analysis.text.v2|pricingRate.500000|string }} — стоимость анализа тысячи символов текста для последующих 185 000 тысяч.
