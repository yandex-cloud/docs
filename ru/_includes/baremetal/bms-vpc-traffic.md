Трафик, передаваемый из {{ vpc-full-name }} на публичные адреса сервиса {{ baremetal-full-name }}, классифицируется как исходящий трафик, и к нему применяются [правила тарификации {{ vpc-short-name }}](../../vpc/pricing.md#prices-traffic).

{% note info %}

Если вам необходимо передавать большие объемы данных между {{ vpc-full-name }} и {{ baremetal-full-name }}, используйте сервис [{{ interconnect-full-name }}](../../interconnect/index.yaml).

Трафик между приватными адресами {{ baremetal-full-name }} и {{ vpc-full-name }}, передаваемый в обоих направлениях через {{ interconnect-full-name }}, не тарифицируется.

{% endnote %}