# Управление [!KEYREF PG]-расширениями

[!KEYREF mpg-short-name] поддерживает многие стандартные расширения [!KEYREF PG] и некоторые нестандартные. Полный список доступных расширений [приведен ниже](#postgresql).

## Получить список расширений {#list-extensions}

---

**[!TAB CLI]**

[!INCLUDE [cli-install](../../_includes/cli-install.md)]

[!INCLUDE [default-catalogue](../../_includes/default-catalogue.md)]

Чтобы получить список расширений для определенной базы данных, выполните команду:

```
$ [!KEYREF yc-mdb-pg] database get <имя базы данных> \
     --cluster-name <имя кластера>
```

Включенные расширения будут перечислены в списке `extensions`.


**[!TAB API]**

Получить список расширений для базы данных кластера можно с помощью метода [get](../api-ref/Database/get.md).

---


## Изменить набор расширений {#update-extensions}

---

**[!TAB CLI]**

[!INCLUDE [cli-install](../../_includes/cli-install.md)]

[!INCLUDE [default-catalogue](../../_includes/default-catalogue.md)]

Чтобы включить или выключить [!KEYREF PG]-расширения для базы данных, передайте полный список нужных расширений командой CLI. Включенные расширения, которых не будет в списке, будут отключены.

```
$ [!KEYREF yc-mdb-pg] database update <имя базы данных> \
     --cluster-name <имя кластера>
     --extensions <имя расширения>=<версия>,<имя расширения>=<версия>...
```

> [!NOTE]
>
> Версия расширения не учитывается при обработке команды — в качестве версии можно передать любую непустую строку.


**[!TAB API]**

Передать новый список расширений для базы данных можно с помощью метода [update](../api-ref/Database/update.md).

---


## Поддерживаемые расширения [!KEYREF PG] {#postgresql}

Полный список поддерживаемых расширений:
- [address_standardizer](https://postgis.net/docs/Address_Standardizer.html)
- [address_standardizer_data_us](https://postgis.net/docs/Address_Standardizer.html)
- [autoinc](https://www.postgresql.org/docs/10/static/contrib-spi.html#id-1.11.7.46.7)
- [bloom](https://www.postgresql.org/docs/10/static/bloom.html)
- [btree_gin](https://www.postgresql.org/docs/10/static/btree-gin.html)
- [btree_gist](https://www.postgresql.org/docs/10/static/btree-gist.html)
- [chkpass](https://www.postgresql.org/docs/10/static/chkpass.html)
- [citext](https://www.postgresql.org/docs/10/static/citext.html)
- [cube](https://www.postgresql.org/docs/10/static/cube.html)
- [dblink](https://www.postgresql.org/docs/10/static/dblink.html)
- [dict_int](https://www.postgresql.org/docs/10/static/dict-int.html)
- [dict_xsyn](https://www.postgresql.org/docs/10/static/dict-xsyn.html)
- [earthdistance](https://www.postgresql.org/docs/10/static/earthdistance.html)
- [fuzzystrmatch](https://www.postgresql.org/docs/10/static/fuzzystrmatch.html)
- [hstore](https://www.postgresql.org/docs/10/static/hstore.html)
- [intarray](https://www.postgresql.org/docs/10/static/intarray.html)
- [isn](https://www.postgresql.org/docs/10/static/isn.html)
- [jsquery](https://github.com/postgrespro/jsquery)
- [lo](https://www.postgresql.org/docs/10/static/lo.html)
- [ltree](https://www.postgresql.org/docs/10/static/ltree.html)
- [moddatetime](https://www.postgresql.org/docs/10/static/contrib-spi.html#id-1.11.7.46.9)
- [pg_repack](http://reorg.github.io/pg_repack/)
- [pg_stat_kcache](https://github.com/powa-team/pg_stat_kcache)
- [pg_stat_statements](https://www.postgresql.org/docs/10/pgstatstatements.html)
- [pg_trgm](https://www.postgresql.org/docs/10/static/pgtrgm.html)
- [pgcrypto](https://www.postgresql.org/docs/10/static/pgcrypto.html)
- [pgrouting](http://pgrouting.org/)
- [pgrowlocks](https://www.postgresql.org/docs/10/static/pgrowlocks.html)
- [postgis](https://postgis.net/docs/)
- [postgis_tiger_geocoder](https://postgis.net/docs/postgis_installation.html#loading_extras_tiger_geocoder)
- [postgis_topology](https://postgis.net/docs/Topology.html)
- [postgres_fdw](https://www.postgresql.org/docs/10/static/postgres-fdw.html)
- [seg](https://www.postgresql.org/docs/10/static/seg.html)
- [tablefunc](https://www.postgresql.org/docs/10/static/tablefunc.html)
- [timetravel](https://www.postgresql.org/docs/10/static/contrib-spi.html#id-1.11.7.46.6)
- [unaccent](https://www.postgresql.org/docs/10/static/unaccent.html)
- [uuid-ossp](https://www.postgresql.org/docs/10/static/uuid-ossp.html)
- [xml2](https://www.postgresql.org/docs/10/static/xml2.html)
