In {{ mch-name }}, you can `INSERT` and `SELECT` data in different formats. Most of these formats are _self-descriptive_. This means that they already contain a _format schema_ that describes valid data types, their order, and representation in this format. Thus, for example, you can insert data directly from a file.

{% note info %}

A _format schema_ describes the format of data input or output, while a _data schema_ describes the structure and layout of {{ CH }} databases and tables storing this data. These concepts are not interchangeable.

{% endnote %}

[Cap'n Proto](https://capnproto.org/) and [Protobuf](https://developers.google.com/protocol-buffers/) (including [ProtobufSingle]({{ ch.docs }}/interfaces/formats/#protobufsingle)) data formats do not contain a format schema: data is presented in binary format without any structural details. Before using data in these formats, e.g., inserting data into a table, add a format schema to your {{ mch-name }} cluster. Thus you will be able to correctly interpret the number, order, and type of values when processing binary data.

You can add one or multiple format schemas to your {{ mch-name }} cluster and use them to input and output data in the relevant formats.

{% note warning %}

To use the format schemas you added, insert the data into {{ mch-name }} via the [HTTP interface]({{ ch.docs }}/interfaces/http/). In this case, data serialization and deserialization is performed on the server side based on the schemas you added.

{% endnote %}

For more information about data formats, see [this {{ CH }} guide]({{ ch.docs }}/interfaces/formats/).
