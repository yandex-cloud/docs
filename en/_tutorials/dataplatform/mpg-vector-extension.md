# Running a vector search with `vector` in {{ mos-full-name }}

With the [vector](../../managed-postgresql/operations/extensions/vector.md) extension, you can store vector data and run a vector search in [{{ mpg-full-name }}](../../managed-postgresql/index.yaml).

{% include [mpg-vector-introduction](../../_includes/mdb/mpg-vector-introduction.md) %}

The `vector` extension is available in {{ mpg-name }} clusters of version `13` and higher. For more information about `vector`, see [this tutorial](https://github.com/pgvector/pgvector).

To run a vector search in {{ mpg-name }}:

1. [Set up your infrastructure](#infra).
1. [Prepare your test data](#prepare-test-data).
1. [Run search queries](#execute-queries).
1. [Create an index to make your search faster](#add-index).

If you no longer need the resources you created, [delete them](#clear-out).


## Getting started {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

* {{ mpg-name }} cluster: use of computing resources allocated to hosts, as well as the storage and backup size (see [{{ mpg-name }} pricing](../../managed-postgresql/pricing.md)).
* Public IP addresses if public access is enabled for cluster hosts (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).


## Set up your infrastructure {#infra}

1. [Create a cloud network](../../vpc/operations/network-create.md) named `demo-network`.

   
   When creating a network, three subnets in different availability zones are created automatically.



1. In `demo-network`, [create a security group](../../vpc/operations/security-group-create.md) named `mpg-sg` for the {{ mpg-name }} cluster and [add](../../vpc/operations/security-group-add-rule.md) the following inbound rule to the group to allow internet access to the cluster:

    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-mpg }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`.


1. [Create a {{ mpg-name }} cluster](../../managed-postgresql/operations/cluster-create.md) of any suitable configuration with the following settings:

    * **Version**: `13` or higher.
    * **Network**: `demo-network`.

    
    * **Security group**: `mpg-sg`


    * **Database**: `pgdb`.

    
   When creating your cluster, enable host public access.

    {% include [public-access](../../_includes/mdb/note-public-access.md) %}


1. In the {{ mpg-name }} cluster, [add](../../managed-postgresql/operations/extensions/cluster-extensions.md#update-extensions) the `vector` extension to the `pgdb` database.

## Prepare your test data {#prepare-test-data}

1. [Connect to the {{ mpg-name }} cluster](../../managed-postgresql/operations/connect/clients.md).
1. Create a column vector of size `3`:

   ```sql
   CREATE TABLE items (
     id bigserial PRIMARY KEY, 
     embedding vector(3)
   );
   ```

1. Add vectors: 

   ```sql
   INSERT INTO items (embedding) 
   VALUES
   ('[1,2,3]'),
   ('[4,5,6]'),
   ('[7,8,9]'),
   ('[10,11,12]'),
   ('[13,14,15]'),
   ('[16,17,18]');
   ```

## Run search queries {#execute-queries}

1. Find the three nearest neighbors using L2 distance:

   ```sql
   SELECT *
   FROM items
   ORDER BY embedding <-> '[3,1,2]'
   LIMIT 3;
   ```

   To get a distance, the `vector` extension uses the following functions:

   * `<->`: L2 distance (Euclidean distance).
   * `<#>`: Negative dot product.
   * `<=>`: Cosine distance.
   * `<+>`: L1 distance (Manhattan distance).
   * `<~>`: Hamming distance (for binary vectors).
   * `<%>`: Jaccard distance (for binary vectors).

1. Find three lines that bear the closest resemblance to the first one:

   ```sql
   SELECT *
   FROM items
   WHERE id != 1
   ORDER BY embedding <->
   (
   SELECT embedding
   FROM items
   WHERE id = 1
   )
   LIMIT 3;
   ```

1. Find the lines that lie within the boundaries of the set distance:

   ```sql
   SELECT *
   FROM items
   WHERE embedding <-> '[3,1,2]' < 15;
   ```

1. Get the distance between each vector and vector `[3,1,2]`:

   ```sql
   SELECT embedding <-> '[3,1,2]'
   AS distance
   FROM items;
   ```

1. To calculate the dot product, multiply the result by `-1`, since the `<#>` returns the negative dot product:

   ```sql
   SELECT (embedding <#> '[3,1,2]') * -1 AS inner_product
   FROM items;
   ```

1. To find out how similar each vector is to `[3,1,2]` using cosine similarity, use `1 - cosine distance`:

   ```sql
   SELECT 1 - (embedding <=> '[3,1,2]') AS cosine_similarity
   FROM items;
   ```

1. Find the mean vector:

   ```sql
   SELECT AVG(embedding)
   FROM items;
   ```

## Create an index to make your search faster {#add-index}

Create an index of each type: [HNSW](#hnsw-index) and [IVFFlat](#ivfflat-index).

### HNSW {#hnsw-index}

1. Create an HNSW index for L2 distance search:

   ```sql
   CREATE INDEX ON items
   USING hnsw (embedding vector_l2_ops)
   WITH (
   m = 16,
   ef_construction = 64
   );
   ```

   Where:

   * `m`: Maximum number of connections a graph node can have at each layer. The default value is `16`.
   * `ef_construction`: Number of candidates considered when building the graph. The default value is `64`. The higher the value, the greater the probability of finding the most relevant records; however, index build time increases, and insertion operations become slower.

   These parameters are set one time when creating an index. To modify their values, re-create the index.

   You need to create a dedicated HNSW index for each distance calculation function. To learn more, see the `vector` extension [guide](https://github.com/pgvector/pgvector#hnsw).

1. Configure the search settings:

   ```sql
   SET hnsw.ef_search = 3;
   ```

   Where `ef_search` is the number of vectors the algorithm considers during the search. The default value is `40`. The higher the value, the greater the probability of finding the most relevant records; however, the query runs slower.

   Unlike the `m` and `ef_construction` index parameters, the `ef_search` parameter can be modified before running queries.

1. Run a search for the nearest neighbors:

   ```sql
   SELECT *
   FROM items
   ORDER BY embedding <-> '[3,1,2]'
   LIMIT 3;
   ```

   If the search results are not accurate enough, increase the `ef_search` value and repeat the query.

### IVFFlat {#ivfflat-index}

1. Create an IVFFlat index for L2 distance search:

   ```sql
   CREATE INDEX ON items
   USING ivfflat (embedding vector_l2_ops)
   WITH (
   lists = 3
   );
   ```

   Where `lists` is the number of groups (lists) into which the vectors will be divided. The recommended value depends on the amount of data. The more groups there are, the faster the search, but the search quality may decrease.

   This parameter is set one time when creating an index. To change its value, re-create the index.

   You need to create a dedicated IVFFlat index for each distance calculation function. To learn more, see the `vector` extension [guide](https://github.com/pgvector/pgvector#ivfflat).

1. Configure the search settings:

   ```sql
   SET ivfflat.probes = 1;
   ```

   Where `probes` is the number of groups (lists) viewed when running a search. The default value is `1`. The higher the value, the greater the probability of finding the most relevant records; however, the query runs slower.

   Unlike the `lists` index parameter, the `probes` search parameter can be modified before running queries.

1. Run a search for the nearest neighbors:

   ```sql
   SELECT *
   FROM items
   ORDER BY embedding <-> '[3,1,2]'
   LIMIT 3;
   ```

   If the search results are not accurate enough, increase the `probes` value and repeat the query.

## Delete the resources you created {#clear-out}


If you no longer intend to use the {{ mpg-name }} cluster, [delete](../../managed-postgresql/operations/cluster-delete.md) it to avoid paying for it.

