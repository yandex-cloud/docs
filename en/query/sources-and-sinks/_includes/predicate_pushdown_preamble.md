{{ yq-full-name }} can transfer processing of request parts to the data source system. This means that filter expressions are provided through {{ yq-full-name }} directly to the database for processing; these are typically the query conditions specified in `WHERE`. This kind of processing is called `filter pushdown`.

Filter pushdown is possible when using: