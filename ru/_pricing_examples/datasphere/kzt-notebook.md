> 72 × 600 = 43 200 юнитов за использование ВМ
> 43&nbsp;200&nbsp;×&nbsp;{{ sku|KZT|ai.datasphere.computing.v1|string }} = {% calc [currency=KZT] 43200 × {{ sku|KZT|ai.datasphere.computing.v1|number }} %}
>
> Итого: {% calc [currency=KZT] 43200 × {{ sku|KZT|ai.datasphere.computing.v1|number }} %} — стоимость использования {{ ml-platform-name }}.

Где:

* 72 — количество юнитов за конфигурацию g1.1.
* 600 — время использования ВМ в секундах.
* {{ sku|KZT|ai.datasphere.computing.v1|string }} — стоимость 1 юнита.