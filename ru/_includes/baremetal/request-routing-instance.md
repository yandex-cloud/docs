[Обратитесь]({{ link-console-support }}/tickets/create) в службу технической поддержки для создания `Routing Instance` в вашем каталоге.

Оформите ваше обращение следующим образом:

```text
Тема: [CIC для BareMetal] Создать Routing Instance.

Текст обращения:
Прошу Создать Routing Instance в указанном облачном каталоге со следующими параметрами:

folder_id: <идентификатор_каталога>

vpc:
  vpc_net_id: <идентификатор_сети>
    vpc_subnets: 
      {{ region-id }}-a: [CIDR_a1, CIDR_a2, ..., CIDR_an]
      {{ region-id }}-b: [CIDR_b1, CIDR_b2, ..., CIDR_bn]
      {{ region-id }}-d: [CIDR_d1, CIDR_d2, ..., CIDR_dn]
```

Где:
* `folder_id` — [идентификатор](../../resource-manager/operations/folder/get-id.md) каталога.
* `vpc_net_id` — [идентификатор](../../vpc/operations/network-get-info.md) облачной сети.
* `vpc_subnets` — список [анонсируемых](../../interconnect/concepts/priv-con.md#prc-announce) адресных префиксов для каждой из [зон доступности](../../overview/concepts/geo-scope.md). Например, для созданной ранее подсети {{ vpc-short-name }} вы укажете `{{ region-id }}-b: [192.168.11.0/24]`.

    Допускается анонсирование адресных префиксов с [агрегированием](../../interconnect/concepts/priv-con.md#agg-subnets).

{% note info %}

Создание `Routing Instance` службой технической поддержки может занять до 24 часов. В результате вы сможете получить идентификатор созданного `Routing Instance`, выполнив команду [{{ yandex-cloud }} CLI](../../cli/index.yaml) `yc cloudrouter routing-instance list`.

{% endnote %}