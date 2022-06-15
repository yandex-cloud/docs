# Dictionaries

_Dictionaries_ in {{ CH }} are key-value data stores that are fully or partially loaded to the {{ CH }} server memory.
Dictionary data is accessed using a [set of functions](https://{{ ch-domain }}/docs/en/query_language/functions/ext_dict_functions/) that are faster than standard SQL queries. Access to dictionaries is read-only. You can't write data to a dictionary using {{ CH }}.

The main advantage of dictionaries is that they're faster compared to JOIN operations. Dictionaries are useful when you have to frequently access reference lists to get a set of values from a key.

As their data sources, dictionaries can use [{{ CH }} internal dictionaries](https://{{ ch-domain }}/docs/en/query_language/dicts/internal_dicts/) or [external sources](https://{{ ch-domain }}/docs/en/query_language/dicts/external_dicts/), including HTTP(s) resources or other DBMS ({{ MY }}, {{ CH }}, {{ MG }}, and {{ PG }}).


## Internal dictionaries {#internal-dicts}

{{ mch-name }} contains a built-in geobase dictionary and a set of functions to work with it. The dictionary lets you:

* Get the name of a region in the required language by ID.
* Get the ID of a city, region, federal district, country, and continent by the region ID.
* Check whether one region is part of another.
* Get a chain of parent regions.

Learn more about the built-in dictionary features in the [{{ CH }} documentation](https://{{ ch-domain }}/docs/en/query_language/functions/ym_dict_functions/).

If you're not satisfied with the built-in geobase, you can add your own to {{ CH }}: For more information about how to do this, see [{#T}](../operations/internal-dictionaries.md).


## External dictionaries {#external-dicts}

For external dictionaries, HTTP(s) resources and other DBMS ({{ MY }}, {{ CH }}, {{ MG }}, {{ PG }}) can be used as data sources.

Depending on the dictionary settings, {{ CH }} fully or partially stores dictionaries in RAM, periodically updates them, and dynamically loads the missing values.

To learn how to add and configure a dictionary using {{ mch-full-name }}, see [Adding external dictionaries](../operations/dictionaries.md).
