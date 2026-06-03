# {{ CH }} dictionaries

_Dictionaries_ in {{ CH }} are mappings of key-value pairs that are fully or partially stored in the {{ CH }} server memory.
To access dictionary data, you need to use [dedicated functions]({{ ch.docs }}{{ lang }}/sql-reference/functions), which run faster than standard SQL queries. You can only read data in dictionaries. {{ CH }} does not support data writes to a dictionary. 

The main advantage of dictionaries is that you can get results faster compared to `JOIN` operations. Opt for dictionaries if you frequently query references to get values by a key.

As their data sources, dictionaries can use [{{ CH }} internal dictionaries]({{ ch.docs }}{{ lang }}/sql-reference/statements/create/dictionary/embedded) or [external sources]({{ ch.docs }}{{ lang }}/sql-reference/statements/create/dictionary): an HTTP(s) resource or any other DBMS, such as {{ MY }}, {{ CH }}, {{ SD }}, and {{ PG }}.


## Internal dictionaries {#internal-dicts}

{{ mch-name }} contains an embedded geobase dictionary and functions to work with it. With this dictionary, you can:

* Get the name of a region in the required language by the region ID.
* Get the ID of a city, district, state/province, country, and continent by the region ID.
* Check whether one region is part of another.
* Get a chain of parent regions.

For more about the functions for working with internal dictionaries, see [this {{ CH }} guide]({{ ch.docs }}{{ lang }}/sql-reference/functions/ym-dict-functions).

If the built-in geobase does not fit your purpose, you can add a [custom geobase](../operations/geobase.md) to {{ CH }}.


## External dictionaries {#external-dicts}

External dictionaries can use HTTP(s) resources and other DBMS's, such as {{ MY }}, {{ CH }}, {{ SD }}, and {{ PG }}, as data sources.

Depending on the dictionary settings, {{ CH }} fully or partially stores dictionaries in RAM, updates them on a regular basis, and dynamically loads the missing values.

To learn how to connect and configure a dictionary using {{ mch-full-name }}, see [Connecting external dictionaries](../operations/dictionaries.md).

## Use cases {#examples}

* [{#T}](../operations/dictionaries.md)

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}