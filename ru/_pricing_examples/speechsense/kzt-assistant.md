**Стоимость распознавания**

> {% calc [currency=KZT] {{ sku|KZT|speechsense.analysis.audio|number }} × 60 %} × 100 000 + {% calc [currency=KZT] {{ sku|KZT|speechsense.analysis.audio|pricingRate.6000000|number }} × 60 %} × 15 000 = {% calc [currency=KZT] {{ sku|KZT|speechsense.analysis.audio|number }} × 60 × 100 000 + {{ sku|KZT|speechsense.analysis.audio|pricingRate.6000000|number }} × 60 × 15 000 %}
>
> Итого: {% calc [currency=KZT] {{ sku|KZT|speechsense.analysis.audio|number }} × 60 × 100 000 + {{ sku|KZT|speechsense.analysis.audio|pricingRate.6000000|number }} × 60 × 15 000 %} — стоимость 115 000 минут распознавания аудиофайлов.

Где:
* {% calc [currency=KZT] {{ sku|KZT|speechsense.analysis.audio|number }} × 60 %} — стоимость распознавания минуты аудио для первых 100 000 минут.
* {% calc [currency=KZT] {{ sku|KZT|speechsense.analysis.audio|pricingRate.6000000|number }} × 60 %} — стоимость распознавания минуты аудио для последующих 15 001 минуты.

**Стоимость аналитики**

> {% calc [currency=KZT] {{ sku|KZT|speechsense.analysis.v1|number }} × 60 %} × 100 000 + {% calc [currency=KZT] {{ sku|KZT|speechsense.analysis.v1|pricingRate.6000000|number }} × 60 %} × 15 000 = {% calc [currency=KZT] {{ sku|KZT|speechsense.analysis.v1|number }} × 60 × 100 000 + {{ sku|KZT|speechsense.analysis.v1|pricingRate.6000000|number }} × 60 × 15 000 %}
>
> Итого: {% calc [currency=KZT] {{ sku|KZT|speechsense.analysis.v1|number }} × 60 × 100 000 + {{ sku|KZT|speechsense.analysis.v1|pricingRate.6000000|number }} × 60 × 15 000 %} — стоимость 115 000 минут аналитики аудиофайлов.

Где:
* {% calc [currency=KZT] {{ sku|KZT|speechsense.analysis.v1|number }} × 60 %} — стоимость анализа минуты аудио для первых 100 000 минут.
* {% calc [currency=KZT] {{ sku|KZT|speechsense.analysis.v1|pricingRate.6000000|number }} × 60 %} — стоимость анализа минуты аудио для последующих 15 000 минуты.

**Стоимость использования ассистента**

> (115 000 × 1 000 + 3 000) × ({{ sku|KZT|speechsense.analysis.assistant.v1|string }} / 1 000) = {% calc [currency=KZT] (115 000 × 1 000 + 3 000) × ({{ sku|KZT|speechsense.analysis.assistant.v1|number }} / 1 000) %}
>
> Итого: {% calc [currency=KZT] (115 000 × 1 000 + 3 000) × ({{ sku|KZT|speechsense.analysis.assistant.v1|number }} / 1 000) %} — стоимость работы ассистента с выбранной моделью YandexGPT Pro для аудиофайлов общей длительностью 115 000 минут.
>

Где:
* 115 000 — общая длительность аудиозаписей в минутах;
* 1 000 — приблизительное количество символов в одной минуте;
* 3 000 — количество символов в инструкции и блоке результата;
* {{ sku|KZT|speechsense.analysis.assistant.v1|string }} — цена за 1 000 символов модели YandexGPT Pro.

**Расчет итоговой стоимости** 

> {% calc [currency=KZT] {{ sku|KZT|speechsense.analysis.audio|number }} × 60 × 100 000 + {{ sku|KZT|speechsense.analysis.audio|pricingRate.6000000|number }} × 60 × 15 000 %} + {% calc [currency=KZT] {{ sku|KZT|speechsense.analysis.v1|number }} × 60 × 100 000 + {{ sku|KZT|speechsense.analysis.v1|pricingRate.6000000|number }} × 60 × 15 000 %} + {% calc [currency=KZT] (115 000 × 1 000 + 3 000) × ({{ sku|KZT|speechsense.analysis.assistant.v1|number }} / 1 000) %} = {% calc [currency=KZT] {{ sku|KZT|speechsense.analysis.audio|number }} × 60 × 100 000 + {{ sku|KZT|speechsense.analysis.audio|pricingRate.6000000|number }} × 60 × 15 000 + {{ sku|KZT|speechsense.analysis.v1|number }} × 60 × 100 000 + {{ sku|KZT|speechsense.analysis.v1|pricingRate.6000000|number }} × 60 × 15 000 + (115 000 × 1 000 + 3 000) × ({{ sku|KZT|speechsense.analysis.assistant.v1|number }} / 1 000) %}
>
> Итого: {% calc [currency=KZT] {{ sku|KZT|speechsense.analysis.audio|number }} × 60 × 100 000 + {{ sku|KZT|speechsense.analysis.audio|pricingRate.6000000|number }} × 60 × 15 000 + {{ sku|KZT|speechsense.analysis.v1|number }} × 60 × 100 000 + {{ sku|KZT|speechsense.analysis.v1|pricingRate.6000000|number }} × 60 × 15 000 + (115 000 × 1 000 + 3 000) × ({{ sku|KZT|speechsense.analysis.assistant.v1|number }} / 1 000) %} — стоимость 115 000 минут аналитики аудиофайлов через ассистента с выбранной моделью YandexGPT Pro.

Где:
* {% calc [currency=KZT] {{ sku|KZT|speechsense.analysis.audio|number }} × 60 × 100 000 + {{ sku|KZT|speechsense.analysis.audio|pricingRate.6000000|number }} × 60 × 15 000 %} — стоимость 115 000 минут распознавания аудиофайлов.
* {% calc [currency=KZT] {{ sku|KZT|speechsense.analysis.v1|number }} × 60 × 100 000 + {{ sku|KZT|speechsense.analysis.v1|pricingRate.6000000|number }} × 60 × 15 000 %} — стоимость 115 000 минут аналитики аудиофайлов.
* {% calc [currency=KZT] (115 000 × 1 000 + 3 000) × ({{ sku|KZT|speechsense.analysis.assistant.v1|number }} / 1 000) %} — стоимость работы ассистента с выбранной моделью YandexGPT Pro для аудиофайлов общей длительностью 115 000 минут.