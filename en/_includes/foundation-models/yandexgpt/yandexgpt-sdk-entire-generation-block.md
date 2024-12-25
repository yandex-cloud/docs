1. Create a file named `generate-text.py` and paste the following code into it:

    {% include [yandexgpt-sdk](../examples/yandexgpt-sdk.md) %}

    Where:

    {% include [the-messages-parameter](../../../_includes/foundation-models/yandexgpt/the-messages-parameter.md) %}

    {% include [sdk-code-legend](../examples/sdk-code-legend.md) %}

1. Run the created file:

    ```bash
    python3 generate-text.py
    ```

    Result:

    ```text
    Alternative(role='assistant', text='Laminate flooring is suitable for installation in the kitchen or in a child's room. It withstands moisture and mechanical damage thanks to a 0.2 mm thick protective layer of melamine films and a wax-treated interlocking system.', status=<AlternativeStatus.FINAL: 3>)
    ```