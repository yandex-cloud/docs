{% list tabs %}

- Prices per hour

  | Resource       | Rate for 1 hour,<br>without VAT                        | With CVoS<br>for 6 months,<br>without VAT                                   | With CVoS<br>for 1 year,<br>without VAT                                     |
  |----------------|--------------------------------------------------------:|-----------------------------------------------------------------------------:|-----------------------------------------------------------------------------:|
  | **Intel Broadwell** |
  | 50% vCPU | {{ sku|USD|mdb.keeper.clickhouse.v1.cpu.c50|string }} | − | − |
  | 100% vCPU | {{ sku|USD|mdb.keeper.clickhouse.v1.cpu.c100|string }} | − | − |
  | RAM (for 1 GB) | {{ sku|USD|mdb.keeper.clickhouse.v1.ram|string }} | − | − |
  | Software network acceleration | {{ sku|USD|mdb.keeper.clickhouse.v1.software_accelerated_network.cpu|string }} | − | − |
  | **Intel Cascade Lake** |
  | 50% vCPU | {{ sku|USD|mdb.keeper.clickhouse.v2.cpu.c50|string }} | − | − |
  | 100% vCPU | {{ sku|USD|mdb.keeper.clickhouse.v2.cpu.c100|string }} | − | {{ sku|USD|v1.commitment.special-offer.y1.mdb.ch.keeper.cpu.c100.v2|string }} |
  | RAM (for 1 GB) | {{ sku|USD|mdb.keeper.clickhouse.v2.ram|string }} | − | {{ sku|USD|v1.commitment.special-offer.y1.mdb.ch.keeper.ram.v2|string }} |
  | Software network acceleration | {{ sku|USD|mdb.keeper.clickhouse.v2.software_accelerated_network.cpu|string }} | − | − |
  | **Intel Ice Lake** |
  | 50% vCPU | {{ sku|USD|mdb.keeper.clickhouse.v3.cpu.c50|string }} | − | − |
  | 100% vCPU | {{ sku|USD|mdb.keeper.clickhouse.v3.cpu.c100|string }} | {{ sku|USD|v1.commitment.selfcheckout.m6.mdb.ch.keeper.cpu.c100.v3|string }} | {{ sku|USD|v1.commitment.special-offer.y1.mdb.ch.keeper.cpu.c100.v3|string }} |
  | RAM (for 1 GB) | {{ sku|USD|mdb.keeper.clickhouse.v3.software_accelerated_network.cpu|string }} | {{ sku|USD|v1.commitment.selfcheckout.m6.mdb.ch.ch.keeper.ram.v3|string }} | {{ sku|USD|v1.commitment.special-offer.y1.mdb.ch.keeper.ram.v3|string }} |
  | Software network acceleration | {{ sku|USD|mdb.keeper.clickhouse.v3.software_accelerated_network.cpu|string }} | − | − |
  | **Intel Ice Lake (Compute Optimized)** |
  | 100% vCPU | {{ sku|USD|mdb.keeper.clickhouse.highfreq-v3.cpu.c100|string }} | − | − |
  | RAM (for 1 GB) | {{ sku|USD|mdb.keeper.clickhouse.highfreq-v3.ram|string }} | − | − |
  | **AMD Zen 4** |
  | 100% vCPU | {{ sku|USD|mdb.keeper.clickhouse.v4a.cpu.c100|string }} | − | {{ sku|USD|v1.commitment.special-offer.y1.mdb.ch.keeper.cpu.c100.v4a|string }} |
  | RAM (for 1 GB) | {{ sku|USD|mdb.keeper.clickhouse.v4a.ram|string }} | − | {{ sku|USD|v1.commitment.special-offer.y1.mdb.ch.keeper.ram.v4a|string }} |
  | **AMD Zen 4 HighFreq** |
  | 100% vCPU | {{ sku|USD|mdb.keeper.clickhouse.highfreq-v4a.cpu.c100|string }} | − | − |
  | RAM (for 1 GB) | {{ sku|USD|mdb.keeper.clickhouse.highfreq-v4a.ram|string }} | − | − |
  | Software network acceleration | {{ sku|USD|mdb.software_accelerated_network.keeper.clickhouse.highfreq-v4a.cores|string }} | − | − |

- Prices per month

  | Resource       | Rate for 1 month,<br>without VAT                              | With CVoS for<br>6 months, without VAT                                              | With CVoS<br>for 1 year, without VAT                                               |
  |----------------|--------------------------------------------------------------:|-----------------------------------------------------------------------------------:|-----------------------------------------------------------------------------------:|
  | **Intel Broadwell** |
  | 50% vCPU | {{ sku|USD|mdb.keeper.clickhouse.v1.cpu.c50|month|string }} | − | − |
  | 100% vCPU | {{ sku|USD|mdb.keeper.clickhouse.v1.cpu.c100|month|string }} | − | − |
  | RAM (for 1 GB) | {{ sku|USD|mdb.keeper.clickhouse.v1.ram|month|string }} | − | − |
  | Software network acceleration | {{ sku|USD|mdb.keeper.clickhouse.v1.software_accelerated_network.cpu|month|string }} | − | − |
  | **Intel Cascade Lake** |
  | 50% vCPU | {{ sku|USD|mdb.keeper.clickhouse.v2.cpu.c50|month|string }} | − | − |
  | 100% vCPU | {{ sku|USD|mdb.keeper.clickhouse.v2.cpu.c100|month|string }} | − | {{ sku|USD|v1.commitment.special-offer.y1.mdb.ch.keeper.cpu.c100.v2|month|string }} |
  | RAM (for 1 GB) | {{ sku|USD|mdb.keeper.clickhouse.v2.ram|month|string }} | − | {{ sku|USD|v1.commitment.special-offer.y1.mdb.ch.keeper.ram.v2|month|string }} |
  | Software network acceleration | {{ sku|USD|mdb.keeper.clickhouse.v2.software_accelerated_network.cpu|month|string }} | − | − |
  | **Intel Ice Lake** |
  | 50% vCPU | {{ sku|USD|mdb.keeper.clickhouse.v3.cpu.c50|month|string }} | − | − |
  | 100% vCPU | {{ sku|USD|mdb.keeper.clickhouse.v3.cpu.c100|month|string }} | {{ sku|USD|v1.commitment.selfcheckout.m6.mdb.ch.keeper.cpu.c100.v3|month|string }} | {{ sku|USD|v1.commitment.special-offer.y1.mdb.ch.keeper.cpu.c100.v3|month|string }} |
  | RAM (for 1 GB) | {{ sku|USD|mdb.keeper.clickhouse.v3.software_accelerated_network.cpu|month|string }} | {{ sku|USD|v1.commitment.selfcheckout.m6.mdb.ch.ch.keeper.ram.v3|string }} | {{ sku|USD|v1.commitment.special-offer.y1.mdb.ch.keeper.ram.v3|month|string }} |
  | Software network acceleration | {{ sku|USD|mdb.keeper.clickhouse.v3.software_accelerated_network.cpu|month|string }} | − | − |
  | **Intel Ice Lake (Compute Optimized)** |
  | 100% vCPU | {{ sku|USD|mdb.keeper.clickhouse.highfreq-v3.cpu.c100|month|string }} | − | − |
  | RAM (for 1 GB) | {{ sku|USD|mdb.keeper.clickhouse.highfreq-v3.ram|month|string }} | − | − |
  | **AMD Zen 4** |
  | 100% vCPU | {{ sku|USD|mdb.keeper.clickhouse.v4a.cpu.c100|month|string }} | − | {{ sku|USD|v1.commitment.special-offer.y1.mdb.ch.keeper.cpu.c100.v4a|month|string }} |
  | RAM (for 1 GB) | {{ sku|USD|mdb.keeper.clickhouse.v4a.ram|month|string }} | − | {{ sku|USD|v1.commitment.special-offer.y1.mdb.ch.keeper.ram.v4a|month|string }} |
  | **AMD Zen 4 HighFreq** |
  | 100% vCPU | {{ sku|USD|mdb.keeper.clickhouse.highfreq-v4a.cpu.c100|month|string }} | − | − |
  | RAM (for 1 GB) | {{ sku|USD|mdb.keeper.clickhouse.highfreq-v4a.ram|month|string }} | − | − |
  | Software network acceleration | {{ sku|USD|mdb.software_accelerated_network.keeper.clickhouse.highfreq-v4a.cores|month|string }} | − | − |

{% endlist %}