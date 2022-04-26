{{ mch-name }} lets you `INSERT` and `SELECT` data in different formats. Most of those formats are _self-descriptive_. This means that they already contain a _format schema_ that describes acceptable data types, their order, and representation in this format. For example, it lets you directly insert data from a file.

{% note info %}

_Format schema_ describes the format of data input or output and the _data schema_ describes the structure and layout of the {{ CH }} databases and tables that store this data. These concepts are not interchangeable.

{% endnote %}

[Cap'n Proto](https://capnproto.org/) and [Protobuf](https://developers.google.com/protocol-buffers/) data formats (including [ProtobufSingle](https://{{ ch-domain }}/docs/en/interfaces/formats/#protobufsingle)) don't contain a format schema: the data is presented in binary format without any structural details. Before you begin processing data in these formats (for example, before inserting data in a table), add a format schema to the {{ mch-name }} cluster. It will help you correctly interpret the number, order, and type of values when processing binary data.

You can add one or more such format schemas to a {{ mch-name }} cluster and use them to input and output data in the relevant formats.

{% note warning %}

To use the format schemas you added, insert the data into {{ mch-name }} using the [HTTP interface](https://{{ ch-domain }}/docs/en/interfaces/http/): in this case, data serialization and deserialization is performed on the server side based on the schemas you added.

{% endnote %}

For more information about data formats, see the [{{ CH }} documentation](https://{{ ch-domain }}/docs/en/interfaces/formats/).

