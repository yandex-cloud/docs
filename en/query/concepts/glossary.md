# Terms and definitions {{ yq-full-name }}

## Query {#query}

A _query_ is an expression that is written in [YQL]{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/syntax/){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/syntax/){% endif %}, an SQL dialect, and used for unified execution of streaming and analytical data queries.

A query consists of query text written in YQL, information about a [connection](#connection) to a [data source](#source), and a [data schema](#schema) in the source.


## Connection {#connection}

A _connection_ is a set of parameters necessary for connecting {{ yq-full-name }} to a [data source](#source). For example, if a file from {{ objstorage-full-name }} is used as a data source, a connection contains the name of a bucket and its authorization parameters.

For more information, see [{#T}](../operations/connection.md).


## Data bindings {#binding}

The same YQL query can be run on data from different [sources](#source) (such as for streaming and batch processing). In this case, for each source, you can create a _data binding_ that is a resource that contains information about a [connection](connection), data format, and [data schema](#schema).

For more information, see [{#T}](../operations/binding.md).


## Information about executed queries {#job}

{{ yq-full-name }} saves the following information for each executed `query`:

* Query execution results.
* Query execution status.
* Query execution start date and time.
* Query execution duration.
* Name of the user who ran the query.
* Query execution metrics.

{% note info %}

Execution results are saved only for the last execution of a YQL query.

{% endnote %}

## Data source {#source}

A _data source_ is an object with structured data. The following can be used as data sources in {{ yq-full-name }}:

* [{{yds-full-name}}](../../data-streams/concepts/index.md) streams.
* Files in [{{ objstorage-full-name }}](../../storage/concepts/index.md).


## Data schema {#schema}

A _data schema_ is a list of input data fields and types to be used in a query.

## Checkpoint {#checkpoint}

Streaming analysis systems handle infinite (without beginning or end) data streams. To avoid processing all data in a stream from the beginning every time, when a query is rerun {{yq-full-name}} remembers offsets in processed data. If processing is paused and then restarted, {{yq-full-name}} rewinds the data stream to the saved offset and resumes processing data from that point.

Checkpoints contain information about a streaming query, including offsets in data streams.

If you add instructions to access new streaming sources of data to the text of a query, checkpoints won't contain information about offsets within data streams. As a result, some data may be read from existing streams starting from the last checkpoint, while other data may be read once new messages appear in new data streams.

{% note info %}

Query execution method settings (whether to process data starting from a checkpoint or anew) are specified when [running a query](../operations/query.md#run).

{% endnote %}
