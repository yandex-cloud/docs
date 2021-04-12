---
editable: false
---
# Pricing policy for Managed Service for Elasticsearch

## Cluster status {#running-stopped}

Pricing is applied differently depending on the cluster status:

* For a `Running` cluster, you pay both for the computing resources and storage size.
* For a `Stopped` cluster, you pay only for the storage size.

{% include [pricing-status-warning.md](../_includes/mdb/pricing-status-warning.md) %}

## What goes into the cost of using {{ mes-short-name }} {#rules}

The cost of {{ mes-name }} usage is based on:

* {{ ES }} edition used.

* Computing resources allocated to cluster hosts (including hosts with the `Master node` role).

* Storage type and size (disk space).

* Outgoing traffic from {{ yandex-cloud }} to the internet.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Using cluster hosts {#rules-hosts-uptime}

The cost is calculated for each hour of operation of the host in accordance with the allocated computing resources and {{ ES }} edition used. Supported resource configurations are listed in the [{#T}](concepts/instance-types.md) section, prices for using vCPU and RAM — in the [Prices](#prices) section.

You can select the host class both for the hosts with the `Data node` role and hosts with the `Master node` role.

The minimum billing unit is one hour (for example, the cost of 1.5 hours of operation is the same as the cost of 2 hours of operation). You are not charged for time when the {{ ES }} host is not performing its main functions.

### Disk space usage {#rules-storage}

You pay for the storage allocated for DB clusters. The cost is specified for one month of use.  The minimum billing unit is 1 GB per hour (for example, the cost of storing 1 GB for 1.5 hours is equal to the cost of storage for 2 hours).

{% if audience == "draft" %}

### Example of cluster cost calculation {#example}

For example, you created a cluster:

* With 3 hosts with the `Data node` role that have the `s2.micro` class (2 vCPU, 8 GB RAM).
* With 3 hosts with the `Master node` role that have the `s2.micro` class (2 vCPU, 8 GB RAM).
* With 100 GB of standard network storage.

Cost per hour for the hosts: `3 × (2 × ₽1.05 + 8 × ₽0.28) + 3 × (2 × ₽0.49 + 4 × ₽0.20) = ₽18.36`

Total cost per cluster per month (hosts and storage): `720 × ₽18.36 + 100 × ₽2.2881 = ₽13,448.01`

{% endif %}

## Discount for committed volumes of services (CVoS) {#cvos}

You can get a guaranteed discount on Yandex.Cloud resource usage when you plan for one or three years ahead.

{{mes-name}} provides four types of CVoS:

* For vCPU.
* For RAM in the BASIC edition.
* For RAM in the GOLD edition.
* For RAM in the PLATINUM edition.

A CVoS guarantees a discount on usage, but doesn't guarantee the availability of the resources ordered. To enable CVoS, contact [support](../support/overview.md).

Read more about CVoS in the [Billing documentation](../billing/concepts/cvos.md).

{% note info %}

You can't order storage or internet traffic using the CVoS model.

{% endnote %}

## Pricing {#prices}

All prices are shown without VAT.

### Host computing resources {#prices-hosts}

The cost for computing resources depends on the selected {{ ES }} edition.

{% list tabs %}

- BASIC

   | Resource | Cost for 1 hour | Cost with CVoS for 1 year | Cost with CVoS for 3 years |
   | ----- | ----- | ----- | ----- |
   | **Intel Cascade Lake** |
   | 100% vCPU | $0.013462 | $0.009615 (-29%) | $0.007436 (-45%) |
   | RAM (for 1 GB) | $0.016795 | $0.015769 (-6%) | $0.015256 (-9%) |

- GOLD

   | Resource | Cost for 1 hour | Cost with CVoS for 1 year | Cost with CVoS for 3 years |
   | ----- | ----- | ----- | ----- |
   | **Intel Cascade Lake** |
   | 100% vCPU | $0.013462 | $0.009615 (-29%) | $0.007436 (-45%) |
   | RAM (for 1 GB) | $0.019744 | $0.018590 (-6%) | $0.017949 (-9%) |

- PLATINUM

   | Resource | Cost for 1 hour | Cost with CVoS for 1 year | Cost with CVoS for 3 years |
   | ----- | ----- | ----- | ----- |
   | **Intel Cascade Lake** |
   | 100% vCPU | $0.013462 | $0.009615 (-29%) | $0.007436 (-45%) |
   | RAM (for 1 GB) | $0.022692 | $0.021410 (-6%) | $0.020641 (-9%) |

{% endlist %}

### Storage {#prices-storage}

| Service | Cost of 1 GB per month |
| ----- | ----- |
| Standard network storage | $0.029335 |
| Fast network storage | $0.104303 |
| Fast local storage | $0.104303 |

### Outgoing traffic {#prices-traffic}

When using the service, you pay for the traffic from Yandex.Cloud to the internet. Traffic between Yandex.Cloud services and incoming internet traffic are free.

The minimum charging unit is 1 MB.

  | Resource category | Cost of 1 GB|
  | ----- | -----
  | Outgoing traffic, <10 GB | $0 |
  | Outgoing traffic, >10 GB | $0.012307 |

## Estimated prices for host classes {#calculated-host-price}

Prices for host uptime are calculated based on [host classes](concepts/instance-types.md) and the above prices for using vCPU and RAM for the corresponding platform. To accurately calculate the cost of the desired cluster, use the [calculator](https://cloud.yandex.com/services/managed-elasticsearch#calculator).

{% include [host-class-price-alert](../_includes/mdb/pricing-host-class-alert.md) %}

All prices are shown without VAT.

- For a month of host operation at the rate of 720 hours per month, rounded to an integer, USD:

  {% list tabs %}

  - BASIC

    Host class | Cost per month | Cost with CVoS for 1 year | Cost with CVoS for 3 years
    ----- | ----- | ----- | ----- 
    **Intel Cascade Lake** |
    {{ s2-micro }}              | $116	| $105	| $99
    {{ s2-small }}              | $232	| $209	| $197
    {{ s2-medium }}             | $464	| $419	| $394
    {{ s2-large }}              | $697	| $628	| $592
    {{ s2-xlarge }}             | $929	| $837	| $789
    {{ s2-2xlarge }}            | $1393	| $1256	| $1183
    {{ s2-3xlarge }}            | $1858	| $1675	| $1577
    {{ s2-4xlarge }}            | $2322	| $2094	| $1972
    {{ s2-5xlarge }}            | $2787	| $2512	| $2366
    {{ s2-6xlarge }}            | $3716	| $3350	| $3155
    {{ m2-micro }}              | $213	| $196	| $186
    {{ m2-small }}              | $426	| $391	| $373
    {{ m2-medium }}             | $639	| $587	| $559
    {{ m2-large }}              | $851	| $782	| $746
    {{ m2-xlarge }}             | $1277	| $1173	| $1119
    {{ m2-2xlarge }}            | $1703	| $1564	| $1492
    {{ m2-3xlarge }}            | $2554	| $2346	| $2238
    {{ m2-4xlarge }}            | $3406	| $3128	| $2983
    {{ m2-5xlarge }}            | $4257	| $3910	| $3729
    {{ m2-6xlarge }}            | $5109	| $4692	| $4475


  - GOLD

    Host class | Cost per month | Cost with CVoS for 1 year | Cost with CVoS for 3 years
    ----- | ----- | ----- | ----- 
    **Intel Cascade Lake** |
    {{ s2-micro }}              | $133	| $121	| $114
    {{ s2-small }}              | $266	| $242	| $228
    {{ s2-medium }}             | $532	| $484	| $456
    {{ s2-large }}              | $799	| $726	| $685
    {{ s2-xlarge }}             | $1065	| $967	| $913
    {{ s2-2xlarge }}            | $1597	| $1451	| $1369
    {{ s2-3xlarge }}            | $2130	| $1935	| $1825
    {{ s2-4xlarge }}            | $2662	| $2418	| $2282
    {{ s2-5xlarge }}            | $3195	| $2902	| $2738
    {{ s2-6xlarge }}            | $4259	| $3870	| $3651
    {{ m2-micro }}              | $247	| $228	| $217
    {{ m2-small }}              | $494	| $456	| $435
    {{ m2-medium }}             | $740	| $684	| $652
    {{ m2-large }}              | $987	| $912	| $870
    {{ m2-xlarge }}             | $1481	| $1368	| $1305
    {{ m2-2xlarge }}            | $1975	| $1824	| $1740
    {{ m2-3xlarge }}            | $2962	| $2736	| $2610
    {{ m2-4xlarge }}            | $3949	| $3648	| $3480
    {{ m2-5xlarge }}            | $4937	| $4560	| $4350
    {{ m2-6xlarge }}            | $5924	| $5472	| $521

  - PLATINUM

    Host class | Cost per month | Cost with CVoS for 1 year | Cost with CVoS for 3 years
    ----- | ----- | ----- | ----- 
    **Intel Cascade Lake** |
    {{ s2-micro }}              | $150	| $137	| $130
    {{ s2-small }}              | $300	| $274	| $259
    {{ s2-medium }}             | $600	| $549	| $518
    {{ s2-large }}              | $901	| $823	| $778
    {{ s2-xlarge }}             | $1201	| $1097	| $1037
    {{ s2-2xlarge }}            | $1801	| $1646	| $1555
    {{ s2-3xlarge }}            | $2401	| $2195	| $2074
    {{ s2-4xlarge }}            | $3002	| $2743	| $2592
    {{ s2-5xlarge }}            | $3602	| $3292	| $3110
    {{ s2-6xlarge }}            | $4803	| $4389	| $4147
    {{ m2-micro }}              | $281	| $260	| $248
    {{ m2-small }}              | $562	| $521	| $497
    {{ m2-medium }}             | $842	| $781	| $745
    {{ m2-large }}              | $1123	| $1042	| $994
    {{ m2-xlarge }}             | $1685	| $1563	| $1491
    {{ m2-2xlarge }}            | $2246	| $2084	| $1988
    {{ m2-3xlarge }}            | $3370	| $3126	| $2982
    {{ m2-4xlarge }}            | $4493	| $4168	| $3976
    {{ m2-5xlarge }}            | $5616	| $5210	| $4970
    {{ m2-6xlarge }}            | $6739	| $6252	| $5964

  {% endlist %}

- Per host per hour:

  {% list tabs %}

  - BASIC

    Host class | Cost of 1 hour | Cost with CVoS for 1 year | Cost with CVoS for 3 years 
    ----- | ----- | ----- | ----- 
    **Intel Cascade Lake** |
    {{ s2-micro }}              | $0.161282	| $0.145385	| $0.136923
    {{ s2-small }}              | $0.322564	| $0.290769	| $0.273846
    {{ s2-medium }}             | $0.645128	| $0.581538	| $0.547692
    {{ s2-large }}              | $0.967692	| $0.872308	| $0.821538
    {{ s2-xlarge }}             | $1.290256	| $1.163077	| $1.095385
    {{ s2-2xlarge }}            | $1.935385	| $1.744615	| $1.643077
    {{ s2-3xlarge }}            | $2.580513	| $2.326154	| $2.190769
    {{ s2-4xlarge }}            | $3.225641	| $2.907692	| $2.738462
    {{ s2-5xlarge }}            | $3.870769	| $3.489231	| $3.286154
    {{ s2-6xlarge }}            | $5.161026	| $4.652308	| $4.381539
    {{ m2-micro }}              | $0.295641	| $0.271538	| $0.258974
    {{ m2-small }}              | $0.591282	| $0.543077	| $0.517949
    {{ m2-medium }}             | $0.886923	| $0.814615	| $0.776923
    {{ m2-large }}              | $1.182564	| $1.086154	| $1.035897
    {{ m2-xlarge }}             | $1.773846	| $1.629231	| $1.553846
    {{ m2-2xlarge }}            | $2.365128	| $2.172308	| $2.071795
    {{ m2-3xlarge }}            | $3.547692	| $3.258462	| $3.107692
    {{ m2-4xlarge }}            | $4.730256	| $4.344615	| $4.143590
    {{ m2-5xlarge }}            | $5.912821	| $5.430769	| $5.179487
    {{ m2-6xlarge }}            | $7.095385	| $6.516923	| $6.215385

  - GOLD

    Host class | Cost of 1 hour | Cost with CVoS for 1 year | Cost with CVoS for 3 years 
    ----- | ----- | ----- | ----- 
    **Intel Cascade Lake** |
    {{ s2-micro }}              | $0.184872	| $0.167949	| $0.158462
    {{ s2-small }}              | $0.369744	| $0.335897	| $0.316923
    {{ s2-medium }}             | $0.739487	| $0.671795	| $0.633846
    {{ s2-large }}              | $1.109231	| $1.007692	| $0.950769
    {{ s2-xlarge }}             | $1.478974	| $1.343590	| $1.267692
    {{ s2-2xlarge }}            | $2.218462	| $2.015385	| $1.901538
    {{ s2-3xlarge }}            | $2.957949	| $2.687180	| $2.535385
    {{ s2-4xlarge }}            | $3.697436	| $3.358974	| $3.169231
    {{ s2-5xlarge }}            | $4.436923	| $4.030769	| $3.803077
    {{ s2-6xlarge }}            | $5.915898	| $5.374359	| $5.070769
    {{ m2-micro }}              | $0.342821	| $0.316667	| $0.302051
    {{ m2-small }}              | $0.685641	| $0.633333	| $0.604103
    {{ m2-medium }}             | $1.028462	| $0.950000	| $0.906154
    {{ m2-large }}              | $1.371282	| $1.266667	| $1.208205
    {{ m2-xlarge }}             | $2.056923	| $1.900000	| $1.812308
    {{ m2-2xlarge }}            | $2.742564	| $2.533333	| $2.416410
    {{ m2-3xlarge }}            | $4.113846	| $3.800000	| $3.624615
    {{ m2-4xlarge }}            | $5.485128	| $5.066667	| $4.832821
    {{ m2-5xlarge }}            | $6.856410	| $6.333333	| $6.041026
    {{ m2-6xlarge }}            | $8.227692	| $7.600000	| $7.249231

  - PLATINUM

    Host class | Cost of 1 hour | Cost with CVoS for 1 year | Cost with CVoS for 3 years 
    ----- | ----- | ----- | ----- 
    **Intel Cascade Lake** |
    {{ s2-micro }}              | $0.208462	| $0.190513	| $0.180000
    {{ s2-small }}              | $0.416923	| $0.381026	| $0.360000
    {{ s2-medium }}             | $0.833846	| $0.762051	| $0.720000
    {{ s2-large }}              | $1.250769	| $1.143077	| $1.080000
    {{ s2-xlarge }}             | $1.667692	| $1.524103	| $1.440000
    {{ s2-2xlarge }}            | $2.501538	| $2.286154	| $2.160000
    {{ s2-3xlarge }}            | $3.335385	| $3.048205	| $2.880000
    {{ s2-4xlarge }}            | $4.169231	| $3.810256	| $3.600000
    {{ s2-5xlarge }}            | $5.003077	| $4.572308	| $4.320000
    {{ s2-6xlarge }}            | $6.670769	| $6.096410	| $5.760000
    {{ m2-micro }}              | $0.390000	| $0.361795	| $0.345128
    {{ m2-small }}              | $0.780000	| $0.723590	| $0.690256
    {{ m2-medium }}             | $1.170000	| $1.085385	| $1.035385
    {{ m2-large }}              | $1.560000	| $1.447180	| $1.380513
    {{ m2-xlarge }}             | $2.340000	| $2.170769	| $2.070769
    {{ m2-2xlarge }}            | $3.120000	| $2.894359	| $2.761026
    {{ m2-3xlarge }}            | $4.680000	| $4.341539	| $4.141539
    {{ m2-4xlarge }}            | $6.240000	| $5.788718	| $5.522051
    {{ m2-5xlarge }}            | $7.800000	| $7.235898	| $6.902564
    {{ m2-6xlarge }}            | $9.360000	| $8.683077	| $8.283077

  {% endlist %}

