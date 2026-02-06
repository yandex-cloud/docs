---
title: '{{ baremetal-full-name }} pricing policy'
description: This article covers the {{ baremetal-name }} pricing policy.
editable: false
---

# {{ baremetal-full-name }} pricing policy



{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [vat](../_includes/vat.md) %}

In {{ baremetal-name }}, you pay for renting a server of a [certain configuration](concepts/server-configurations.md). A rented server is billable for the entire rent period, whether it is on or off.

You can look up how many servers of particular configurations are available in the [calculator](https://yandex.cloud/en/prices) on the {{ yandex-cloud }} website and in the [management console]({{ link-console-main }}) when selecting a server.

The monthly prices are based on 720 hours per month.

## Prices for the Russia region {#prices}

All prices are per month.

### Cost of stock server configurations {#standard}

{% note info %}

Prices for the BA-i100-H, BA-i101-H, BA-i102-S, BA-i104-SH, and BA-i105-SH configurations are valid until January 4, 2026. Afterwards, billing will be based on LA-i100-H, LA-i101-H, LA-i102-S, LA-i104-SH, and LA-i105-SH prices, respectively.

{% endnote %}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

The cost may depend on the [rent period](../baremetal/concepts/servers.md#server-lease).

The funds are debited **monthly**, irrespective of the rent period.



<MDX>
  <PriceList
    serviceIds={['{{ pcs|baremetal }}']}
    skuIds={['{{ pc|baremetal.server.ba_i100_h.1_day }}', '{{ pc|baremetal.server.ba_i100_h.1_month }}', '{{ pc|baremetal.server.ba_i100_h.3_month }}', '{{ pc|baremetal.server.ba_i100_h.6_month }}', '{{ pc|baremetal.server.ba_i100_h.12_month }}', '{{ pc|baremetal.server.ba_i101_h.1_day }}', '{{ pc|baremetal.server.ba_i101_h.1_month }}', '{{ pc|baremetal.server.ba_i101_h.3_month }}', '{{ pc|baremetal.server.ba_i101_h.6_month }}', '{{ pc|baremetal.server.ba_i101_h.12_month }}', '{{ pc|baremetal.server.ba_i102_s.1_day }}', '{{ pc|baremetal.server.ba_i102_s.1_month }}', '{{ pc|baremetal.server.ba_i102_s.3_month }}', '{{ pc|baremetal.server.ba_i102_s.6_month }}', '{{ pc|baremetal.server.ba_i102_s.12_month }}', '{{ pc|baremetal.server.ba_i103_s_10g.1_day }}', '{{ pc|baremetal.server.ba_i103_s_10g.1_month }}', '{{ pc|baremetal.server.ba_i103_s_10g.3_month }}', '{{ pc|baremetal.server.ba_i103_s_10g.6_month }}', '{{ pc|baremetal.server.ba_i103_s_10g.12_month }}', '{{ pc|baremetal.server.ba_i104_sh.1_day }}', '{{ pc|baremetal.server.ba_i104_sh.1_month }}', '{{ pc|baremetal.server.ba_i104_sh.3_month }}', '{{ pc|baremetal.server.ba_i104_sh.6_month }}', '{{ pc|baremetal.server.ba_i104_sh.12_month }}', '{{ pc|baremetal.server.ba_i105_sh.1_day }}', '{{ pc|baremetal.server.ba_i105_sh.1_month }}', '{{ pc|baremetal.server.ba_i105_sh.3_month }}', '{{ pc|baremetal.server.ba_i105_sh.6_month }}', '{{ pc|baremetal.server.ba_i105_sh.12_month }}', '{{ pc|baremetal.server.ba_i106_sh_10g.1_day }}', '{{ pc|baremetal.server.ba_i106_sh_10g.1_month }}', '{{ pc|baremetal.server.ba_i106_sh_10g.3_month }}', '{{ pc|baremetal.server.ba_i106_sh_10g.6_month }}', '{{ pc|baremetal.server.ba_i106_sh_10g.12_month }}', '{{ pc|baremetal.server.ba_i111_8s_10g.1_day }}', '{{ pc|baremetal.server.ba_i111_8s_10g.1_month }}', '{{ pc|baremetal.server.ba_i111_8s_10g.3_month }}', '{{ pc|baremetal.server.ba_i111_8s_10g.6_month }}', '{{ pc|baremetal.server.ba_i111_8s_10g.12_month }}', '{{ pc|baremetal.server.ba_i112_10s_10g.1_day }}', '{{ pc|baremetal.server.ba_i112_10s_10g.1_month }}', '{{ pc|baremetal.server.ba_i112_10s_10g.3_month }}', '{{ pc|baremetal.server.ba_i112_10s_10g.6_month }}', '{{ pc|baremetal.server.ba_i112_10s_10g.12_month }}', '{{ pc|baremetal.server.ba_i200_h.1_day }}', '{{ pc|baremetal.server.ba_i200_h.1_month }}', '{{ pc|baremetal.server.ba_i200_h.3_month }}', '{{ pc|baremetal.server.ba_i200_h.6_month }}', '{{ pc|baremetal.server.ba_i200_h.12_month }}', '{{ pc|baremetal.server.ba_i201_h.1_day }}', '{{ pc|baremetal.server.ba_i201_h.1_month }}', '{{ pc|baremetal.server.ba_i201_h.3_month }}', '{{ pc|baremetal.server.ba_i201_h.6_month }}', '{{ pc|baremetal.server.ba_i201_h.12_month }}', '{{ pc|baremetal.server.ba_i202_s.1_day }}', '{{ pc|baremetal.server.ba_i202_s.1_month }}', '{{ pc|baremetal.server.ba_i202_s.3_month }}', '{{ pc|baremetal.server.ba_i202_s.6_month }}', '{{ pc|baremetal.server.ba_i202_s.12_month }}', '{{ pc|baremetal.server.ba_i203_s_10g.1_day }}', '{{ pc|baremetal.server.ba_i203_s_10g.1_month }}', '{{ pc|baremetal.server.ba_i203_s_10g.3_month }}', '{{ pc|baremetal.server.ba_i203_s_10g.6_month }}', '{{ pc|baremetal.server.ba_i203_s_10g.12_month }}', '{{ pc|baremetal.server.ba_i204_sh.1_day }}', '{{ pc|baremetal.server.ba_i204_sh.1_month }}', '{{ pc|baremetal.server.ba_i204_sh.3_month }}', '{{ pc|baremetal.server.ba_i204_sh.6_month }}', '{{ pc|baremetal.server.ba_i204_sh.12_month }}', '{{ pc|baremetal.server.ba_i205_sh.1_day }}', '{{ pc|baremetal.server.ba_i205_sh.1_month }}', '{{ pc|baremetal.server.ba_i205_sh.3_month }}', '{{ pc|baremetal.server.ba_i205_sh.6_month }}', '{{ pc|baremetal.server.ba_i205_sh.12_month }}', '{{ pc|baremetal.server.ba_i206_sh_10g.1_day }}', '{{ pc|baremetal.server.ba_i206_sh_10g.1_month }}', '{{ pc|baremetal.server.ba_i206_sh_10g.3_month }}', '{{ pc|baremetal.server.ba_i206_sh_10g.6_month }}', '{{ pc|baremetal.server.ba_i206_sh_10g.12_month }}', '{{ pc|baremetal.server.ba_i207_h.1_day }}', '{{ pc|baremetal.server.ba_i207_h.1_month }}', '{{ pc|baremetal.server.ba_i207_h.3_month }}', '{{ pc|baremetal.server.ba_i207_h.6_month }}', '{{ pc|baremetal.server.ba_i207_h.12_month }}', '{{ pc|baremetal.server.ba_i208_s_10g.1_day }}', '{{ pc|baremetal.server.ba_i208_s_10g.1_month }}', '{{ pc|baremetal.server.ba_i208_s_10g.3_month }}', '{{ pc|baremetal.server.ba_i208_s_10g.6_month }}', '{{ pc|baremetal.server.ba_i208_s_10g.12_month }}', '{{ pc|baremetal.server.ba_i209_ss_1_10g.1_day }}', '{{ pc|baremetal.server.ba_i209_ss_1_10g.1_month }}', '{{ pc|baremetal.server.ba_i209_ss_1_10g.3_month }}', '{{ pc|baremetal.server.ba_i209_ss_1_10g.6_month }}', '{{ pc|baremetal.server.ba_i209_ss_1_10g.12_month }}', '{{ pc|baremetal.server.ba_i211_8s_10g.1_day }}', '{{ pc|baremetal.server.ba_i211_8s_10g.1_month }}', '{{ pc|baremetal.server.ba_i211_8s_10g.3_month }}', '{{ pc|baremetal.server.ba_i211_8s_10g.6_month }}', '{{ pc|baremetal.server.ba_i211_8s_10g.12_month }}', '{{ pc|baremetal.server.ba_i211_8s_25g.1_day }}', '{{ pc|baremetal.server.ba_i211_8s_25g.1_month }}', '{{ pc|baremetal.server.ba_i211_8s_25g.3_month }}', '{{ pc|baremetal.server.ba_i211_8s_25g.6_month }}', '{{ pc|baremetal.server.ba_i211_8s_25g.12_month }}', '{{ pc|baremetal.server.ba_i211_8s_2x25g.1_day }}', '{{ pc|baremetal.server.ba_i211_8s_2x25g.1_month }}', '{{ pc|baremetal.server.ba_i211_8s_2x25g.3_month }}', '{{ pc|baremetal.server.ba_i211_8s_2x25g.6_month }}', '{{ pc|baremetal.server.ba_i211_8s_2x25g.12_month }}', '{{ pc|baremetal.server.ba_i212_10s_10g.1_day }}', '{{ pc|baremetal.server.ba_i212_10s_10g.1_month }}', '{{ pc|baremetal.server.ba_i212_10s_10g.3_month }}', '{{ pc|baremetal.server.ba_i212_10s_10g.6_month }}', '{{ pc|baremetal.server.ba_i212_10s_10g.12_month }}', '{{ pc|baremetal.server.ba_i215_ss_10g.1_day }}', '{{ pc|baremetal.server.ba_i215_ss_10g.1_month }}', '{{ pc|baremetal.server.ba_i215_ss_10g.3_month }}', '{{ pc|baremetal.server.ba_i215_ss_10g.6_month }}', '{{ pc|baremetal.server.ba_i215_ss_10g.12_month }}', '{{ pc|baremetal.server.ba_i216_ss_1_10g.1_day }}', '{{ pc|baremetal.server.ba_i216_ss_1_10g.1_month }}', '{{ pc|baremetal.server.ba_i216_ss_1_10g.3_month }}', '{{ pc|baremetal.server.ba_i216_ss_1_10g.6_month }}', '{{ pc|baremetal.server.ba_i216_ss_1_10g.12_month }}', '{{ pc|baremetal.server.ba-i217-s-1-10g.1_day }}', '{{ pc|baremetal.server.ba-i217-s-1-10g.1_month }}', '{{ pc|baremetal.server.ba-i217-s-1-10g.3_month }}', '{{ pc|baremetal.server.ba-i217-s-1-10g.6_month }}', '{{ pc|baremetal.server.ba-i217-s-1-10g.12_month }}', '{{ pc|baremetal.server.ba_i407_s_10g.1_day }}', '{{ pc|baremetal.server.ba_i407_s_10g.1_month }}', '{{ pc|baremetal.server.ba_i407_s_10g.3_month }}', '{{ pc|baremetal.server.ba_i407_s_10g.6_month }}', '{{ pc|baremetal.server.ba_i407_s_10g.12_month }}', '{{ pc|baremetal.server.ba_i501_h_25g.1_day }}', '{{ pc|baremetal.server.ba_i501_h_25g.1_month }}', '{{ pc|baremetal.server.ba_i501_h_25g.3_month }}', '{{ pc|baremetal.server.ba_i501_h_25g.6_month }}', '{{ pc|baremetal.server.ba_i501_h_25g.12_month }}', '{{ pc|baremetal.server.ba_i506_nh_25g.1_day }}', '{{ pc|baremetal.server.ba_i506_nh_25g.1_month }}', '{{ pc|baremetal.server.ba_i506_nh_25g.3_month }}', '{{ pc|baremetal.server.ba_i506_nh_25g.6_month }}', '{{ pc|baremetal.server.ba_i506_nh_25g.12_month }}', '{{ pc|baremetal.server.ba_i507_nh_2x25g.1_day }}', '{{ pc|baremetal.server.ba_i507_nh_2x25g.1_month }}', '{{ pc|baremetal.server.ba_i507_nh_2x25g.3_month }}', '{{ pc|baremetal.server.ba_i507_nh_2x25g.6_month }}', '{{ pc|baremetal.server.ba_i507_nh_2x25g.12_month }}', '{{ pc|baremetal.server.ba_i511_nh_25g.1_day }}', '{{ pc|baremetal.server.ba_i511_nh_25g.1_month }}', '{{ pc|baremetal.server.ba_i511_nh_25g.3_month }}', '{{ pc|baremetal.server.ba_i511_nh_25g.6_month }}', '{{ pc|baremetal.server.ba_i511_nh_25g.12_month }}', '{{ pc|baremetal.server.ba_i512_nh_2x25g.1_day }}', '{{ pc|baremetal.server.ba_i512_nh_2x25g.1_month }}', '{{ pc|baremetal.server.ba_i512_nh_2x25g.3_month }}', '{{ pc|baremetal.server.ba_i512_nh_2x25g.6_month }}', '{{ pc|baremetal.server.ba_i512_nh_2x25g.12_month }}', '{{ pc|baremetal.server.ba-i523-nh-2x25g.1_day }}', '{{ pc|baremetal.server.ba-i523-nh-2x25g.1_month }}', '{{ pc|baremetal.server.ba-i523-nh-2x25g.3_month }}', '{{ pc|baremetal.server.ba-i523-nh-2x25g.6_month }}', '{{ pc|baremetal.server.ba-i523-nh-2x25g.12_month }}', '{{ pc|baremetal.server.ba-a401-2n2h-25g.1_day }}', '{{ pc|baremetal.server.ba-a401-2n2h-25g.1_month }}', '{{ pc|baremetal.server.ba-a401-2n2h-25g.3_month }}', '{{ pc|baremetal.server.ba-a401-2n2h-25g.6_month }}', '{{ pc|baremetal.server.ba-a401-2n2h-25g.12_month }}', '{{ pc|baremetal.server.ba-a402-2n2h-25g.1_day }}', '{{ pc|baremetal.server.ba-a402-2n2h-25g.1_month }}', '{{ pc|baremetal.server.ba-a402-2n2h-25g.3_month }}', '{{ pc|baremetal.server.ba-a402-2n2h-25g.6_month }}', '{{ pc|baremetal.server.ba-a402-2n2h-25g.12_month }}', '{{ pc|baremetal.server.ba-a612-n-25g.1_day }}', '{{ pc|baremetal.server.ba-a612-n-25g.1_month }}', '{{ pc|baremetal.server.ba-a612-n-25g.3_month }}', '{{ pc|baremetal.server.ba-a612-n-25g.6_month }}', '{{ pc|baremetal.server.ba-a612-n-25g.12_month }}', '{{ pc|baremetal.server.ba-a702-6n-4h-2x25g.1_day }}', '{{ pc|baremetal.server.ba-a702-6n-4h-2x25g.1_month }}', '{{ pc|baremetal.server.ba-a702-6n-4h-2x25g.3_month }}', '{{ pc|baremetal.server.ba-a702-6n-4h-2x25g.6_month }}', '{{ pc|baremetal.server.ba-a702-6n-4h-2x25g.12_month }}', '{{ pc|baremetal.server.ba-a704-4n-2x25g.1_day }}', '{{ pc|baremetal.server.ba-a704-4n-2x25g.1_month }}', '{{ pc|baremetal.server.ba-a704-4n-2x25g.3_month }}', '{{ pc|baremetal.server.ba-a704-4n-2x25g.6_month }}', '{{ pc|baremetal.server.ba-a704-4n-2x25g.12_month }}', '{{ pc|baremetal.server.ha_i302_s_10g.1_day }}', '{{ pc|baremetal.server.ha_i302_s_10g.1_month }}', '{{ pc|baremetal.server.ha_i302_s_10g.3_month }}', '{{ pc|baremetal.server.ha_i302_s_10g.6_month }}', '{{ pc|baremetal.server.ha_i302_s_10g.12_month }}', '{{ pc|baremetal.server.ha-i502-n-25g-gxl4.1_day }}', '{{ pc|baremetal.server.ha-i502-n-25g-gxl4.1_month }}', '{{ pc|baremetal.server.ha-i502-n-25g-gxl4.3_month }}', '{{ pc|baremetal.server.ha-i502-n-25g-gxl4.6_month }}', '{{ pc|baremetal.server.ha-i502-n-25g-gxl4.12_month }}', '{{ pc|baremetal.server.ha-a701-6n-4h-2x25g.1_day }}', '{{ pc|baremetal.server.ha-a701-6n-4h-2x25g.1_month }}', '{{ pc|baremetal.server.ha-a701-6n-4h-2x25g.3_month }}', '{{ pc|baremetal.server.ha-a701-6n-4h-2x25g.6_month }}', '{{ pc|baremetal.server.ha-a701-6n-4h-2x25g.12_month }}', '{{ pc|baremetal.server.ha-a703-4n-2x25g.1_day }}', '{{ pc|baremetal.server.ha-a703-4n-2x25g.1_month }}', '{{ pc|baremetal.server.ha-a703-4n-2x25g.3_month }}', '{{ pc|baremetal.server.ha-a703-4n-2x25g.6_month }}', '{{ pc|baremetal.server.ha-a703-4n-2x25g.12_month }}', '{{ pc|baremetal.server.la-i100-h.1_day }}', '{{ pc|baremetal.server.la-i100-h.1_month }}', '{{ pc|baremetal.server.la-i100-h.3_month }}', '{{ pc|baremetal.server.la-i100-h.6_month }}', '{{ pc|baremetal.server.la-i100-h.12_month }}', '{{ pc|baremetal.server.la-i101-h.1_day }}', '{{ pc|baremetal.server.la-i101-h.1_month }}', '{{ pc|baremetal.server.la-i101-h.3_month }}', '{{ pc|baremetal.server.la-i101-h.6_month }}', '{{ pc|baremetal.server.la-i101-h.12_month }}', '{{ pc|baremetal.server.la-i102-s.1_day }}', '{{ pc|baremetal.server.la-i102-s.1_month }}', '{{ pc|baremetal.server.la-i102-s.3_month }}', '{{ pc|baremetal.server.la-i102-s.6_month }}', '{{ pc|baremetal.server.la-i102-s.12_month }}', '{{ pc|baremetal.server.la-i104-sh.1_day }}', '{{ pc|baremetal.server.la-i104-sh.1_month }}', '{{ pc|baremetal.server.la-i104-sh.3_month }}', '{{ pc|baremetal.server.la-i104-sh.6_month }}', '{{ pc|baremetal.server.la-i104-sh.12_month }}', '{{ pc|baremetal.server.la-i105-sh.1_day }}', '{{ pc|baremetal.server.la-i105-sh.1_month }}', '{{ pc|baremetal.server.la-i105-sh.3_month }}', '{{ pc|baremetal.server.la-i105-sh.6_month }}', '{{ pc|baremetal.server.la-i105-sh.12_month }}', '{{ pc|baremetal.server.la-i107-s-1-10g.1_day }}', '{{ pc|baremetal.server.la-i107-s-1-10g.1_month }}', '{{ pc|baremetal.server.la-i107-s-1-10g.3_month }}', '{{ pc|baremetal.server.la-i107-s-1-10g.6_month }}', '{{ pc|baremetal.server.la-i107-s-1-10g.12_month }}', '{{ pc|baremetal.server.la-i108-s-1-10g.1_day }}', '{{ pc|baremetal.server.la-i108-s-1-10g.1_month }}', '{{ pc|baremetal.server.la-i108-s-1-10g.3_month }}', '{{ pc|baremetal.server.la-i108-s-1-10g.6_month }}', '{{ pc|baremetal.server.la-i108-s-1-10g.12_month }}', '{{ pc|baremetal.server.la_i109_s_1_10g.1_day }}', '{{ pc|baremetal.server.la_i109_s_1_10g.1_month }}', '{{ pc|baremetal.server.la_i109_s_1_10g.3_month }}', '{{ pc|baremetal.server.la_i109_s_1_10g.6_month }}', '{{ pc|baremetal.server.la_i109_s_1_10g.12_month }}', '{{ pc|baremetal.server.la_i110_s_1_10g.1_day }}', '{{ pc|baremetal.server.la_i110_s_1_10g.1_month }}', '{{ pc|baremetal.server.la_i110_s_1_10g.3_month }}', '{{ pc|baremetal.server.la_i110_s_1_10g.6_month }}', '{{ pc|baremetal.server.la_i110_s_1_10g.12_month }}']}
    installationCode="ru"
    currency="USD"
  />
</MDX>


### Cost of custom server configurations {#custom}

The final cost of a custom configuration depends on the server components you select.

{% cut "Component prices" %}



<MDX>
  <PriceList
    serviceIds={['{{ pcs|baremetal }}']}
    skuIds={['{{ pc|baremetal.component.bms-4-body.1-month }}', '{{ pc|baremetal.component.bms-4-body.6-month }}', '{{ pc|baremetal.component.bms-4-body.12-month }}', '{{ pc|baremetal.component.bms-5-body.1-month }}', '{{ pc|baremetal.component.bms-5-body.6-month }}', '{{ pc|baremetal.component.bms-5-body.12-month }}', '{{ pc|baremetal.component.bms-cpu-9374f.1-month }}', '{{ pc|baremetal.component.bms-cpu-9374f.6-month }}', '{{ pc|baremetal.component.bms-cpu-9374f.12-month }}', '{{ pc|baremetal.component.bms-cpu-9654.1-month }}', '{{ pc|baremetal.component.bms-cpu-9654.6-month }}', '{{ pc|baremetal.component.bms-cpu-9654.12-month }}', '{{ pc|baremetal.component.bms-cpu-a74f3.1-month }}', '{{ pc|baremetal.component.bms-cpu-a74f3.6-month }}', '{{ pc|baremetal.component.bms-cpu-a74f3.12-month }}', '{{ pc|baremetal.component.bms-cpu-a7663.1-month }}', '{{ pc|baremetal.component.bms-cpu-a7663.6-month }}', '{{ pc|baremetal.component.bms-cpu-a7663.12-month }}', '{{ pc|baremetal.component.bms-cpu-a7702.1-month }}', '{{ pc|baremetal.component.bms-cpu-a7702.6-month }}', '{{ pc|baremetal.component.bms-cpu-a7702.12-month }}', '{{ pc|baremetal.component.bms-cpu-a7713.1-month }}', '{{ pc|baremetal.component.bms-cpu-a7713.6-month }}', '{{ pc|baremetal.component.bms-cpu-a7713.12-month }}', '{{ pc|baremetal.component.bms-cpu-i6338.1-month }}', '{{ pc|baremetal.component.bms-cpu-i6338.6-month }}', '{{ pc|baremetal.component.bms-cpu-i6338.12-month }}', '{{ pc|baremetal.component.bms-cpu-i6354.1-month }}', '{{ pc|baremetal.component.bms-cpu-i6354.6-month }}', '{{ pc|baremetal.component.bms-cpu-i6354.12-month }}', '{{ pc|baremetal.component.bms-disk-h10t.1-month }}', '{{ pc|baremetal.component.bms-disk-h10t.6-month }}', '{{ pc|baremetal.component.bms-disk-h10t.12-month }}', '{{ pc|baremetal.component.bms-disk-h18t.1-month }}', '{{ pc|baremetal.component.bms-disk-h18t.6-month }}', '{{ pc|baremetal.component.bms-disk-h18t.12-month }}', '{{ pc|baremetal.component.bms-disk-h24t.1-month }}', '{{ pc|baremetal.component.bms-disk-h24t.6-month }}', '{{ pc|baremetal.component.bms-disk-h24t.12-month }}', '{{ pc|baremetal.component.bms-disk-h2t.1-month }}', '{{ pc|baremetal.component.bms-disk-h2t.6-month }}', '{{ pc|baremetal.component.bms-disk-h2t.12-month }}', '{{ pc|baremetal.component.bms-disk-h4t.1-month }}', '{{ pc|baremetal.component.bms-disk-h4t.6-month }}', '{{ pc|baremetal.component.bms-disk-h4t.12-month }}', '{{ pc|baremetal.component.bms-disk-h6t.1-month }}', '{{ pc|baremetal.component.bms-disk-h6t.6-month }}', '{{ pc|baremetal.component.bms-disk-h6t.12-month }}', '{{ pc|baremetal.component.bms-disk-h8t.1-month }}', '{{ pc|baremetal.component.bms-disk-h8t.6-month }}', '{{ pc|baremetal.component.bms-disk-h8t.12-month }}', '{{ pc|baremetal.component.bms-disk-n1.9t.1-month }}', '{{ pc|baremetal.component.bms-disk-n1.9t.6-month }}', '{{ pc|baremetal.component.bms-disk-n1.9t.12-month }}', '{{ pc|baremetal.component.bms-disk-n15t.1-month }}', '{{ pc|baremetal.component.bms-disk-n15t.6-month }}', '{{ pc|baremetal.component.bms-disk-n15t.12-month }}', '{{ pc|baremetal.component.bms-disk-n3.2t.1-month }}', '{{ pc|baremetal.component.bms-disk-n3.2t.6-month }}', '{{ pc|baremetal.component.bms-disk-n3.2t.12-month }}', '{{ pc|baremetal.component.bms-disk-n3.8t.1-month }}', '{{ pc|baremetal.component.bms-disk-n3.8t.6-month }}', '{{ pc|baremetal.component.bms-disk-n3.8t.12-month }}', '{{ pc|baremetal.component.bms-disk-n30t.1-month }}', '{{ pc|baremetal.component.bms-disk-n30t.6-month }}', '{{ pc|baremetal.component.bms-disk-n30t.12-month }}', '{{ pc|baremetal.component.bms-disk-n6.4t.1-month }}', '{{ pc|baremetal.component.bms-disk-n6.4t.6-month }}', '{{ pc|baremetal.component.bms-disk-n6.4t.12-month }}', '{{ pc|baremetal.component.bms-disk-n7.6t.1-month }}', '{{ pc|baremetal.component.bms-disk-n7.6t.6-month }}', '{{ pc|baremetal.component.bms-disk-n7.6t.12-month }}', '{{ pc|baremetal.component.bms-disk-n960g.1-month }}', '{{ pc|baremetal.component.bms-disk-n960g.6-month }}', '{{ pc|baremetal.component.bms-disk-n960g.12-month }}', '{{ pc|baremetal.component.bms-net-2p25g.1-month }}', '{{ pc|baremetal.component.bms-net-2p25g.6-month }}', '{{ pc|baremetal.component.bms-net-2p25g.12-month }}', '{{ pc|baremetal.component.bms-ram4-1024.1-month }}', '{{ pc|baremetal.component.bms-ram4-1024.6-month }}', '{{ pc|baremetal.component.bms-ram4-1024.12-month }}', '{{ pc|baremetal.component.bms-ram4-128.1-month }}', '{{ pc|baremetal.component.bms-ram4-128.6-month }}', '{{ pc|baremetal.component.bms-ram4-128.12-month }}', '{{ pc|baremetal.component.bms-ram4-1536.1-month }}', '{{ pc|baremetal.component.bms-ram4-1536.6-month }}', '{{ pc|baremetal.component.bms-ram4-1536.12-month }}', '{{ pc|baremetal.component.bms-ram4-256.1-month }}', '{{ pc|baremetal.component.bms-ram4-256.6-month }}', '{{ pc|baremetal.component.bms-ram4-256.12-month }}', '{{ pc|baremetal.component.bms-ram4-384.1-month }}', '{{ pc|baremetal.component.bms-ram4-384.6-month }}', '{{ pc|baremetal.component.bms-ram4-384.12-month }}', '{{ pc|baremetal.component.bms-ram4-512.1-month }}', '{{ pc|baremetal.component.bms-ram4-512.6-month }}', '{{ pc|baremetal.component.bms-ram4-512.12-month }}', '{{ pc|baremetal.component.bms-ram4-768.1-month }}', '{{ pc|baremetal.component.bms-ram4-768.6-month }}', '{{ pc|baremetal.component.bms-ram4-768.12-month }}', '{{ pc|baremetal.component.bms-ram5-1024.1-month }}', '{{ pc|baremetal.component.bms-ram5-1024.6-month }}', '{{ pc|baremetal.component.bms-ram5-1024.12-month }}', '{{ pc|baremetal.component.bms-ram5-1152.1-month }}', '{{ pc|baremetal.component.bms-ram5-1152.6-month }}', '{{ pc|baremetal.component.bms-ram5-1152.12-month }}', '{{ pc|baremetal.component.bms-ram5-1536.1-month }}', '{{ pc|baremetal.component.bms-ram5-1536.6-month }}', '{{ pc|baremetal.component.bms-ram5-1536.12-month }}', '{{ pc|baremetal.component.bms-ram5-2304.1-month }}', '{{ pc|baremetal.component.bms-ram5-2304.6-month }}', '{{ pc|baremetal.component.bms-ram5-2304.12-month }}', '{{ pc|baremetal.component.bms-ram5-768.1-month }}', '{{ pc|baremetal.component.bms-ram5-768.6-month }}', '{{ pc|baremetal.component.bms-ram5-768.12-month }}']}
    installationCode="ru"
    currency="USD"
  />
</MDX>


{% endcut %}

#### Server configurations at reduced prices {#promo}

##### Reduced prices from 27/11/2025 to 29/12/2025 {#27-11-19-12-2025}

You can rent servers with these configuration options until December 29, 2025, or as long as they are available. The price is valid once you complete the purchase and for the entire period of use. You can use the servers you rented at a discounted price until you cancel your rent on your own. Once you cancel, you will not be able to get a server at a discounted price again.



<MDX>
  <PriceList
    serviceIds={['{{ pcs|baremetal }}']}
    skuIds={['{{ pc|baremetal.server.bf25_i201_h.1_day }}', '{{ pc|baremetal.server.bf25_i201_h.1_month }}', '{{ pc|baremetal.server.bf25_i201_h.3_month }}', '{{ pc|baremetal.server.bf25_i201_h.6_month }}', '{{ pc|baremetal.server.bf25_i201_h.12_month }}', '{{ pc|baremetal.server.bf25_i202_s.1_day }}', '{{ pc|baremetal.server.bf25_i202_s.1_month }}', '{{ pc|baremetal.server.bf25_i202_s.3_month }}', '{{ pc|baremetal.server.bf25_i202_s.6_month }}', '{{ pc|baremetal.server.bf25_i202_s.12_month }}', '{{ pc|baremetal.server.bf25_i204_s.1_day }}', '{{ pc|baremetal.server.bf25_i204_s.1_month }}', '{{ pc|baremetal.server.bf25_i204_s.3_month }}', '{{ pc|baremetal.server.bf25_i204_s.6_month }}', '{{ pc|baremetal.server.bf25_i204_s.12_month }}', '{{ pc|baremetal.server.bf25_i205_s.1_day }}', '{{ pc|baremetal.server.bf25_i205_s.1_month }}', '{{ pc|baremetal.server.bf25_i205_s.3_month }}', '{{ pc|baremetal.server.bf25_i205_s.6_month }}', '{{ pc|baremetal.server.bf25_i205_s.12_month }}']}
    installationCode="ru"
    currency="USD"
  />
</MDX>


##### Reduced prices from 24/09/2025 to 24/10/2025 as part of Yandex Scale 2025 {#scale2025}

The price is valid from the moment of purchase until 11:59 p.m. on 31/12/2025.



<MDX>
  <PriceList
    serviceIds={['{{ pcs|baremetal }}']}
    skuIds={['{{ pc|baremetal.server.ba-i208-s-10g-p1.1_day }}', '{{ pc|baremetal.server.ba-i208-s-10g-p1.1_month }}', '{{ pc|baremetal.server.ba-i208-s-10g-p1.3_month }}', '{{ pc|baremetal.server.ba-i208-s-10g-p1.6_month }}', '{{ pc|baremetal.server.ba-i208-s-10g-p1.12_month }}', '{{ pc|baremetal.server.ba-i209-ss-1-10g-p1.1_day }}', '{{ pc|baremetal.server.ba-i209-ss-1-10g-p1.1_month }}', '{{ pc|baremetal.server.ba-i209-ss-1-10g-p1.3_month }}', '{{ pc|baremetal.server.ba-i209-ss-1-10g-p1.6_month }}', '{{ pc|baremetal.server.ba-i209-ss-1-10g-p1.12_month }}', '{{ pc|baremetal.server.ba-i507-nh-2x25g-p1.1_day }}', '{{ pc|baremetal.server.ba-i507-nh-2x25g-p1.1_month }}', '{{ pc|baremetal.server.ba-i507-nh-2x25g-p1.3_month }}', '{{ pc|baremetal.server.ba-i507-nh-2x25g-p1.6_month }}', '{{ pc|baremetal.server.ba-i507-nh-2x25g-p1.12_month }}', '{{ pc|baremetal.server.ba-i512-nh-2x25g-p1.1_day }}', '{{ pc|baremetal.server.ba-i512-nh-2x25g-p1.1_month }}', '{{ pc|baremetal.server.ba-i512-nh-2x25g-p1.3_month }}', '{{ pc|baremetal.server.ba-i512-nh-2x25g-p1.6_month }}', '{{ pc|baremetal.server.ba-i512-nh-2x25g-p1.12_month }}', '{{ pc|baremetal.server.ba-i523-nh-2x25g-p1.1_day }}', '{{ pc|baremetal.server.ba-i523-nh-2x25g-p1.1_month }}', '{{ pc|baremetal.server.ba-i523-nh-2x25g-p1.3_month }}', '{{ pc|baremetal.server.ba-i523-nh-2x25g-p1.6_month }}', '{{ pc|baremetal.server.ba-i523-nh-2x25g-p1.12_month }}', '{{ pc|baremetal.server.ba-a612-n-25g-p1.1_day }}', '{{ pc|baremetal.server.ba-a612-n-25g-p1.1_month }}', '{{ pc|baremetal.server.ba-a612-n-25g-p1.3_month }}', '{{ pc|baremetal.server.ba-a612-n-25g-p1.6_month }}', '{{ pc|baremetal.server.ba-a612-n-25g-p1.12_month }}', '{{ pc|baremetal.server.ha-i502-n-25g-gxl4-p1.1_day }}', '{{ pc|baremetal.server.ha-i502-n-25g-gxl4-p1.1_month }}', '{{ pc|baremetal.server.ha-i502-n-25g-gxl4-p1.3_month }}', '{{ pc|baremetal.server.ha-i502-n-25g-gxl4-p1.6_month }}', '{{ pc|baremetal.server.ha-i502-n-25g-gxl4-p1.12_month }}']}
    installationCode="ru"
    currency="USD"
  />
</MDX>


### Dedicated public subnets {#public-subnets}



<MDX>
  <PriceList
    serviceIds={['{{ pcs|baremetal }}']}
    skuIds={['{{ pc|baremetal.public_network.subnet_31 }}', '{{ pc|baremetal.public_network.subnet_29 }}', '{{ pc|baremetal.public_network.subnet_28 }}', '{{ pc|baremetal.public_network.subnet_27 }}', '{{ pc|baremetal.public_network.subnet_26 }}', '{{ pc|baremetal.public_network.subnet_25 }}', '{{ pc|baremetal.public_network.subnet_24 }}']}
    installationCode="ru"
    currency="USD"
  />
</MDX>


### Connecting a bandwidth package for a public network {#bandwidth-package}

_Data size_ is a billing unit equal to the amount of traffic transmitted within a day. Per-day prices are calculated based on 24 hours.

{% include [public-net-bandwidth-restrictions](../_includes/baremetal/public-net-bandwidth-restrictions.md) %}

{% note info %}

To request a bandwidth package of 100 TB, contact [support]({{ link-console-support }}).

{% endnote %}



<MDX>
  <PriceList
    serviceIds={['{{ pcs|baremetal }}']}
    skuIds={['{{ pc|baremetal.data.data-100tb.1sec }}']}
    installationCode="ru"
    currency="USD"
  />
</MDX>


### {{ baremetal-full-name }} network traffic billing when communicating with other {{ yandex-cloud }} services {#traffic-pricing-pecs}

#### {{ vpc-full-name }} {#vpc-traffic}

{% include [bms-vpc-traffic](../_includes/baremetal/bms-vpc-traffic.md) %}

#### {{ objstorage-full-name }} {#storage-traffic}

{% include [bms-s3-free-traffic](../_includes/baremetal/bms-s3-free-traffic.md) %}

#### {{ backup-full-name }} {#backup-traffic}

{% include [bms-backup-free-traffic](../_includes/baremetal/bms-backup-free-traffic.md) %}






