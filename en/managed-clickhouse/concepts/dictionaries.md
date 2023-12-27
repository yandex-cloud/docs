# {{ CH }} dictionaries

_Dictionaries_ in {{ CH }} are key-value data stores that are fully or partially loaded to the {{ CH }} server memory.
Dictionary data is accessed using a [set of functions]({{ ch.docs }}/sql-reference/functions/) that are faster than standard SQL queries. Access to dictionaries is read-only. You cannot write data to a dictionary using {{ CH }}.

The main advantage of dictionaries is that they are faster compared to `JOIN` operations. Dictionaries are useful when you have to frequently access reference lists to get a set of values from a key.

As their data sources, dictionaries can use [{{ CH }} internal dictionaries]({{ ch.docs }}/sql-reference/dictionaries/internal-dicts/) or [external sources]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts), such as HTTP(s) resources or other DBMS's: {{ MY }}, {{ CH }}, {{ MG }}, and {{ PG }}.


## Internal dictionaries {#internal-dicts}

{{ mch-name }} contains a built-in geobase dictionary and a set of functions to work with it. This dictionary allows you to:

* Get the name of a region in the required language by the region ID.
* Get the ID of a city, region, state/province, country, and continent by the region ID.
* Check whether one region is part of another.
* Get a chain of parent regions.

You can learn more about the built-in dictionary features in the [{{ CH }} documentation]({{ ch.docs }}/sql-reference/functions/ym-dict-functions).

If you are not satisfied with the built-in geobase, you can add [your own geobase](../operations/geobase.md) to {{ CH }}.


## External dictionaries {#external-dicts}

For external dictionaries, you can use HTTP(s) resources and other DBMS's, such as {{ MY }}, {{ CH }}, {{ MG }}, and {{ PG }}, as data sources.

Depending on the dictionary settings, {{ CH }} fully or partially stores dictionaries in RAM, updates them on a regular basis, and dynamically loads the missing values.

To learn how to add and configure a dictionary using {{ mch-full-name }}, see [Adding external dictionaries](../operations/dictionaries.md).

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
