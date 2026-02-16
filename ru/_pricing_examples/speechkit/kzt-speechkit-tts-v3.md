> (1 + 2 + 3) × {{ sku|KZT|speechkit.tts.v3_request.v1|string }} = {% calc [currency=KZT] (1 + 2 + 3) × {{ sku|KZT|speechkit.tts.v3_request.v1|number }} %}
>
> Итого: {% calc [currency=KZT] (1 + 2 + 3) × {{ sku|KZT|speechkit.tts.v3_request.v1|number }} %}.

Где:

* 1 — количество единиц тарификации за первый запрос, содержащий 150 символов.
* 2 — количество единиц тарификации за второй запрос, содержащий 300 символов, с использованием режима `unsafe_mode`.
* 3 — количество единиц тарификации за третий запрос, содержащий 600 символов, с использованием режима `unsafe_mode`.
* {{ sku|KZT|speechkit.tts.v3_request.v1|string }} — стоимость единицы тарификации.