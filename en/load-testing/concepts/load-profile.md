# Load profile

To figure out the load to be generated on the server when [creating a test](../operations/create-test-bucket.md#create-test), a _load profile_ is used. The profile determines how the load will be modified and maintained.

Most tools have their own formats for load profiles. When configuring a test via the UI, you can get the final profile by adding sections in the correct order.

## Load profiles {#load-profiles}

{% list tabs group=load_generator %}

- Pandora {#pandora}

    #### line {#line}

    Linearly increases the load in a given range over a certain period of time.

    For example:

    ```
    {duration: 180s, type: line, from: 1, to: 10000} # the load increases from 1 to 10000 requests per second over 180 seconds
    ```

    #### const {#const}

    Maintains the specified load for a certain time.

    For example:

    ```
    {duration: 300s, type: const, ops: 10000} # generates 10000 requests per second for 300 seconds
    ```

    #### step {#step}

    Increases the load with the specified increment size from one value to another for a certain time.

    For example:

    ```
    {duration: 30s, type: step, from: 10, to: 100, step: 5} # the load increases from 10 to 100 requests per second in increments of 5 and with a step duration of 30 seconds
    ```

    #### once {#once}

    Sends the specified number of requests once and completes the test. There are no restrictions on the number of requests.

    For example:

    ```
    {type: once, times: 133} # sends 133 requests at the start of this test section and completes the test
    ```

    #### unlimited {#unlimited}

    {% note info %}

    You can set the `unlimited` load profile only with the help of a [configuration file](testing-stream.md#config_example).

    {% endnote %}

    Sends as many requests as the target can accept within the established connections without restrictions during the specified time.

    For example:

    ```
    {type: unlimited, duration: 30s} # unlimited load for 30 seconds
    ```

- Phantom {#phantom}

    #### line {#line}

    Linearly increases the load in a given range over a certain period of time.

    For example:

    ```
    line(1, 10000, 180) # the load increases from 1 to 10000 requests per second over 180 seconds
    ```

    #### const {#const}

    Maintains the specified load for a certain time.

    For example:

    ```
    const(10000, 300) # generates 10000 requests per second for 300 seconds
    ```

    #### step {#step}

    Increases the load with the specified increment size from one value to another for a certain time.

    For example:

    ```
    step(10, 100, 5, 30) # the load increases from 10 to 100 requests per second in increments of 5 and with a step duration of 30 seconds
    ```

{% endlist %}
