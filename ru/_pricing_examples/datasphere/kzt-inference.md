> 72 × 185 760 × 2 = 26 749 440 юнитов за работу ноды
> 26&nbsp;749&nbsp;440&nbsp;×&nbsp;{{ sku|KZT|ai.datasphere.computing.v1|string }} = {% calc [currency=KZT] 26749440 × {{ sku|KZT|ai.datasphere.computing.v1|number }} %}
>
> Итого: {% calc [currency=KZT] 26749440 × {{ sku|KZT|ai.datasphere.computing.v1|number }} %} – стоимость использования {{ ml-platform-name }}.

Где:
* 72 — количество юнитов за конфигурацию g1.1.
* 185 760 — время работы ноды в секундах.
* 2 — количество инстансов в ноде.
* {{ sku|KZT|ai.datasphere.computing.v1|string }} — стоимость 1 юнита.