Пусть за месяц использования {{ speechsense-name }} было распознано и проанализировано 115 000 минут аудиозаписей.

**Стоимость распознавания**

> {% calc [currency=RUB] {{ sku|RUB|speechsense.analysis.audio|number }} × 60 %} × 100 000 + {% calc [currency=RUB] {{ sku|RUB|speechsense.analysis.audio|pricingRate.6000000|number }} × 60 %} × 15 000 = {% calc [currency=RUB] {{ sku|RUB|speechsense.analysis.audio|number }} × 60 × 100 000 + {{ sku|RUB|speechsense.analysis.audio|pricingRate.6000000|number }} × 60 × 15 000 %}
>
> Итого: {% calc [currency=RUB] {{ sku|RUB|speechsense.analysis.audio|number }} × 60 × 100 000 + {{ sku|RUB|speechsense.analysis.audio|pricingRate.6000000|number }} × 60 × 15 000 %} — стоимость 115 000 минут распознавания двухканальных аудиофайлов.

Где:
* {% calc [currency=RUB] {{ sku|RUB|speechsense.analysis.audio|number }} × 60 %} — стоимость распознавания минуты аудио для первых 100 000 минут.
* {% calc [currency=RUB] {{ sku|RUB|speechsense.analysis.audio|pricingRate.6000000|number }} × 60 %} — стоимость распознавания минуты аудио для последующих 15 001 минуты.

**Стоимость аналитики**

> {% calc [currency=RUB] {{ sku|RUB|speechsense.analysis.v1|number }} × 60 %} × 100 000 + {% calc [currency=RUB] {{ sku|RUB|speechsense.analysis.v1|pricingRate.6000000|number }} × 60 %} × 15 000 = {% calc [currency=RUB] {{ sku|RUB|speechsense.analysis.v1|number }} × 60 × 100 000 + {{ sku|RUB|speechsense.analysis.v1|pricingRate.6000000|number }} × 60 × 15 000 %}
>
> Итого: {% calc [currency=RUB] {{ sku|RUB|speechsense.analysis.v1|number }} × 60 × 100 000 + {{ sku|RUB|speechsense.analysis.v1|pricingRate.6000000|number }} × 60 × 15 000 %} — стоимость 115 000 минут аналитики двухканальных аудиофайлов.

Где:
* {% calc [currency=RUB] {{ sku|RUB|speechsense.analysis.v1|number }} × 60 %} — стоимость анализа минуты аудио для первых 100 000 минут.
* {% calc [currency=RUB] {{ sku|RUB|speechsense.analysis.v1|pricingRate.6000000|number }} × 60 %} — стоимость анализа минуты аудио для последующих 15 000 минуты.

**Расчет итоговой стоимости** 
  
> {% calc [currency=RUB] {{ sku|RUB|speechsense.analysis.audio|number }} × 60 × 100 000 + {{ sku|RUB|speechsense.analysis.audio|pricingRate.6000000|number }} × 60 × 15 000 %} + {% calc [currency=RUB] {{ sku|RUB|speechsense.analysis.v1|number }} × 60 × 100 000 + {{ sku|RUB|speechsense.analysis.v1|pricingRate.6000000|number }} × 60 × 15 000 %} = {% calc [currency=RUB] {{ sku|RUB|speechsense.analysis.audio|number }} × 60 × 100 000 + {{ sku|RUB|speechsense.analysis.audio|pricingRate.6000000|number }} × 60 × 15 000 + {{ sku|RUB|speechsense.analysis.v1|number }} × 60 × 100 000 + {{ sku|RUB|speechsense.analysis.v1|pricingRate.6000000|number }} × 60 × 15 000 %}
>
> Итого: {% calc [currency=RUB] {{ sku|RUB|speechsense.analysis.audio|number }} × 60 × 100 000 + {{ sku|RUB|speechsense.analysis.audio|pricingRate.6000000|number }} × 60 × 15 000 + {{ sku|RUB|speechsense.analysis.v1|number }} × 60 × 100 000 + {{ sku|RUB|speechsense.analysis.v1|pricingRate.6000000|number }} × 60 × 15 000 %} — стоимость 115 000 минут использования сервиса {{ speechsense-name }}.

Где:
* {% calc [currency=RUB] {{ sku|RUB|speechsense.analysis.audio|number }} × 60 × 100 000 + {{ sku|RUB|speechsense.analysis.audio|pricingRate.6000000|number }} × 60 × 15 000 %} — стоимость 115 000 минут распознавания двухканальных аудиофайлов.
* {% calc [currency=RUB] {{ sku|RUB|speechsense.analysis.v1|number }} × 60 × 100 000 + {{ sku|RUB|speechsense.analysis.v1|pricingRate.6000000|number }} × 60 × 15 000 %} — стоимость 115 000 минут аналитики двухканальных аудиофайлов.
