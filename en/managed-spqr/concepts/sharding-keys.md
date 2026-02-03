---
title: Sharding keys
description: 'The _sharding key_ is one or more table columns the system uses to determine which shard will store a row. Row sharding follows the selected strategy: hash or range.'
keywords:
  - keyword: SPQR sharding keys
  - keyword: PostrgeSQL shard
  - keyword: SPQR
---

# Sharding keys

Sharding is a horizontal scaling method for distributed databases that splits the database into multiple parts called [shards](index.md). In {{ mspqr-name }}, each shard is a separate {{ mpg-name }} cluster that stores a portion of the system data.

You can find more information about sharding in {{ mspqr-name }} [here](sharding.md).

The _sharding key_ is one or more table columns the system uses to determine which shard will store a row. A key that includes more than one column is called a [composite key](#composite_keys).

Key columns may have the following data types:

* `int` and `bigint`
* `varchar`
* `UUID`
* `CITY` and `MURMUR` (for integers only)

## Sharding strategies {#sharding-strategies}

Row distribution across shards follows the [strategy you choose](sharding-method.md):

* _Range_ strategy assigns rows to shards based on value ranges. A row goes to a shard if its key value falls within that shard’s range. Rows with close key values be placed on the same shard.

  > For example, one shard will store rows with key values from `1` to `1000`, and another, from `1001` to `2000`, etc.

  The drawback of this strategy is that data may be distributed unevenly.
  
  Learn more about the range strategy in {{ SPQR }} [here](https://docs.pg-sharding.tech/sharding/ranged).

* _Hash_ strategy uses a hash function applied to the key value to select a shard. The resulting hash value determines the shard the row will go to. Compared to the range strategy, this approach distributes data more evenly across shards. However, range queries become more complex because rows with similar values may reside on different shards.
  
  Learn more about the hash strategy in {{ SPQR }} [here](https://docs.pg-sharding.tech/sharding/hashed).
  
## Composite sharding keys {#composite-keys}

A composite key uses multiple columns, and their order matters during sharding.

Composite keys are used for sharding data whose uniqueness depends on a combination of multiple columns. For example, such data may include:

* Time series
* Geographic data stored across several related columns

When using a composite key, the system determines the target shard for a row as follows:

* For the range strategy, it lists all combinations of column values.

  > Example of configuring sharding rules for the range strategy:
  >
  > ```sql
  > CREATE DISTRIBUTION ds1 COLUMN TYPES integer, integer;
  > CREATE KEY RANGE FROM 100,100 ROUTE TO sh4 FOR DISTRIBUTION ds1;
  > CREATE KEY RANGE FROM 100,0 ROUTE TO sh3 FOR DISTRIBUTION ds1;
  > CREATE KEY RANGE FROM 0,100 ROUTE TO sh2 FOR DISTRIBUTION ds1;
  > CREATE KEY RANGE FROM 0,0 ROUTE TO sh1 FOR DISTRIBUTION ds1;
  > ```

* For the hash strategy, it applies the hash function to each key column individually, then adds together the resulting numbers, and applies the hash function to the total.

  > Example of configuring sharding rules for the hash strategy:
  >
  > ```sql
  > CREATE RELATION tr(MURMUR [id1 INT HASH, id2 VARCHAR HASH]);
  >  
  > CREATE KEY RANGE FROM 3221225472 ROUTE TO sh4;
  > CREATE KEY RANGE FROM 2147483648 ROUTE TO sh3;
  > CREATE KEY RANGE FROM 1073741824 ROUTE TO sh2;
  > CREATE KEY RANGE FROM 0 ROUTE TO sh1;
  > ```

  Using the hash strategy makes it easier to configure sharding rules.

Learn more about composite sharding keys in {{ SPQR }} [here](https://docs.pg-sharding.tech/sharding/composite_keys).

### Best practices for using composite keys {#best-practices}

* List the column most frequently used in queries first. If using the range strategy, the first column should be the one that is used in queries most frequently and has as few unique values as possible.
* Make sure the `WHERE` conditions cover all composite key columns. Queries missing any column will be blocked if [query_routing.default_route_behaviour](https://docs.pg-sharding.tech/configuration/router#query-routing-settings) is set to `BLOCK`.