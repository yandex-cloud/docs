
> 1 ВМ × {{ sku|KZT|backup.protected_vms.v2|month|string }} + 50 ГБ × {{ sku|KZT|backup.used_space.v1|month|string }} = {% calc [currency=KZT] 1 × {{ sku|KZT|backup.protected_vms.v2|month|number }} + 50 × {{ sku|KZT|backup.used_space.v1|month|number }} %}

> Итого: {% calc [currency=KZT] 1 × {{ sku|KZT|backup.protected_vms.v2|month|number }} + 50 × {{ sku|KZT|backup.used_space.v1|month|number }} %} — стоимость использования {{ backup-name }} для защиты 1 ВМ с суммарным размером резервных копий 50 ГБ за один месяц, вкл. НДС.

Где:
* 1 — количество ВМ, привязанных к политикам резервного копирования.
* {{ sku|KZT|backup.protected_vms.v2|month|string }} — цена за подключение 1 ВМ к {{ backup-name }} в месяц, вкл. НДС.
* 50 ГБ — суммарный объем резервных копий.
* {{ sku|KZT|backup.used_space.v1|month|string }} — цена за хранение 1 ГБ резервных копий в месяц, вкл. НДС.


