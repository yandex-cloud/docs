* **Transformation rules**:
    * **Processing function**: Select one of the functions created in [{{ sf-full-name }}](../../functions/).

        
        * **SA Account**: Select or [create](../../iam/operations/sa/create.md) a [service account](../../iam/concepts/users/service-accounts.md) that the processing function will start under.


    * **Number of attempts**: Set the number of attempts to invoke the processing function.
    * **Buffer size to send**: Set the size of the buffer (in bytes) which when full data will be transferred to the processing function.

        The maximum buffer size is 3.5 MB. For more information about restrictions that apply when working with functions in {{ sf-name }}, see the [corresponding section](../../functions/concepts/limits.md).

    * **Sending interval**: Set the duration of the interval (in seconds) after the expiration of which the data from the stream should be transferred to the processing function.

        {% note info %}

        If the buffer becomes full or the sending interval expires, the data is transferred to the processing function.

        {% endnote %}

    * **Call timeout**: Set the allowed timeout of the response from the processing function (in seconds).

    {% note warning %}

    Values in the **Sending interval** and **Call timeout** fields are specified with the `s` postfix, for example, `10s`.

    {% endnote %}
    
* **Conversion rules**:

    * **Data format**: Select one of the available formats:
        * `Json`
        * `CSV`

    * **Data schema**: Specify the schema as a list of fields or upload a file with a description of the schema in JSON format.
