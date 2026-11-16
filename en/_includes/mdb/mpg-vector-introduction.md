The extension supports:

* Exact and approximate nearest neighbor search.
* Various vector types: single-precision, half-precision, binary, and sparse vectors.
* Several vector comparison metrics: L2 (Euclidean distance), cosine distance, dot product, L1 (Manhattan distance), Hamming and Jaccard distance.
* Any programming language that supports a connection to {{ PG }}.

Vector search can be combined with familiar {{ PG }} and SQL features.

By default, `vector` performs exact search where it compares all vectors. For large data volumes, you can create vector indexes and use approximate search. This search is faster, but the results may prove less accurate.

`vector` supports two index types:

* HNSW, which organizes vectors into a data structure which allows you to go from one similar vector to the next and find nearest neighbors without going through the entire table. This structure is based on a multilayer graph.
* IVFFlat, which breaks all vectors up into several groups (lists). The search does not scan all groups but only those that are closest to the target vector. Compared to HNSW, this index is built faster and uses less memory; however, it is inferior in terms of quality and search speed.
