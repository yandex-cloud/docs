{% list tabs %}

* За месяц работы мастера

  Тип мастера | Цена за месяц, вкл. НДС
  --- | ---
  Зональный | {{ sku|ILS|mk8s.master.zonal.small|month|string }}
  Региональный | {{ sku|ILS|mk8s.master.regional.small|month|string }}

* За 1 час работы мастера

  Тип мастера | Цена за 1 час, вкл. НДС
  --- | ---
  Зональный | {{ sku|ILS|mk8s.master.zonal.small|string }}
  Региональный | {{ sku|ILS|mk8s.master.regional.small|string }}

{% endlist %}