---
title: Using `vector` in {{ mpg-name }}
description: How to install the `vector` extension, create HNSW and IVFFlat indexes, and run a vector search in {{ mpg-full-name }}.
---
# Using `vector` in {{ mpg-full-name }}

With the `vector` extension, you can store vector data and run a vector search in [{{ mpg-full-name }}](../../../managed-postgresql/index.yaml).

{% include [mpg-vector-introduction](../../../_includes/mdb/mpg-vector-introduction.md) %}

The `vector` extension is available in {{ mpg-name }} clusters of version `13` and higher.

For more information about `vector`, see [this tutorial](https://github.com/pgvector/pgvector).

## Install the `vector` extension in your {{ mpg-full-name }} cluster {#vector-install}

To install the extension in {{ mpg-name }}, [add the `vector` extension](cluster-extensions.md#update-extensions) to the appropriate database.

## Use cases {#usage-example}

For more information on using `vector`, see [this guide](../../tutorials/mpg-vector-extension.md).

### Run a vector search {#vector-search}

To get a distance, the `vector` extension uses the following functions:

* `<->`: L2 distance (Euclidean distance).
* `<#>`: Negative dot product.
* `<=>`: Cosine distance.
* `<+>`: L1 distance (Manhattan distance).
* `<~>`: Hamming distance (for binary vectors).
* `<%>`: Jaccard distance (for binary vectors).

To find the records closest to the given vector by L2 distance, run the following query:

   ```sql
   SELECT *
   FROM <table_name>
   ORDER BY <column_name> <-> '<query_vector>'
   LIMIT <number_of_results>;
   ```

Where:

* `<query_vector>` is the vector against which the vectors from the column are compared, e.g., `[3, 1, 2]`.
* `<Number>`: Number of results returned.

The `vector` extension also supports the following search queries:

* Searching for records most similar to an existing record.
* Searching for records closer than a given distance.
* Retrieving the distance between vectors.
* Getting the dot product value.
* Getting cosine similarity.
* Calculating the average vector.

An example of running these search queries is provided in [this guide](../../tutorials/mpg-vector-extension.md).

### Create an index {#create-index}

Indexes enable making vector search faster. You need to create a dedicated [HNSW](#HNSW) index and an [IVFFlat](#IVFFlat) index for each distance calculation function.

#### HNSW {#HNSW}

To create an HNSW index for a certain distance, run the following query:

   ```sql
   CREATE INDEX ON <table_name>
   USING hnsw (<column_name> <distance_type>)
   WITH (
   m = <number_of_connections>,
   ef_construction = <number_of_candidates>
   );
   ```

   Where:

   * `<distance_type>`: Distance calculation function, e.g., `vector_l2_ops`. To learn more, see the `vector` extension [guide](https://github.com/pgvector/pgvector#hnsw).
   * `m`: Maximum number of connections a graph node can have at each layer. The default value is `16`.
   * `ef_construction`: Number of candidates considered when building the graph. The default value is `64`. The higher the value, the greater the probability of finding the most relevant records; however, index build time increases, and insertion operations become slower.

     The `m` and `ef_construction` parameters are set one time when creating an index. To modify their values, re-create the index.

To configure search accuracy, run this query:

   ```sql
   SET hnsw.ef_search = <number_of_vectors>;
   ```

   Where `ef_search` is the number of vectors the algorithm considers during the search. The default value is `40`. The higher the value, the greater the probability of finding the most relevant records; however, the query runs slower.

   Unlike the `m` and `ef_construction` index parameters, the `ef_search` parameter can be modified before running queries.

#### IVFFlat {#IVFFlat}

To create an IVFFlat index, run the following query:

   ```sql
   CREATE INDEX ON <table_name>
   USING ivfflat (<column_name> <distance_type>)
   WITH (
   lists = <number_of_groups>
   );
   ```

   Where:

   * `<distance_type>`: Distance calculation function, e.g., `vector_l2_ops`. To learn more, see the `vector` extension [guide](https://github.com/pgvector/pgvector#ivfflat).
   * `lists`: Number of groups (lists) into which the vectors will be divided. The recommended value depends on the amount of data. The more groups there are, the faster the search, but the search quality may decrease.

     The `lists` parameter is set one time when creating an index. To change its value, re-create the index. 

To configure search accuracy, run this query:

   ```sql
   SET ivfflat.probes = <number_of_groups_for_search>;
   ```

   Where `probes` is the number of groups (lists) viewed when running a search. The default value is `1`. The higher the value, the greater the probability of finding the most relevant records; however, the query runs slower. 

   Unlike the `lists` index parameter, the `probes` search parameter can be modified before running queries.
