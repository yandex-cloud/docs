Use advanced settings to specify transformation and conversion rules. Data is processed in the following order:

1. **Transformation**. Data in JSON format is provided to a [{{ sf-full-name }}](../../../functions/index.yaml) function. The function body contains metadata and raw data from the queue. The function handles the data and sends it back to {{ data-transfer-name }}.

1. **Conversion**. Data is parsed as a preparation for delivery to the target.

If no transformation rules are set, parsing is applied to raw data from the queue. If no conversion rules are set, the data goes directly to the target.
