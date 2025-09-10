In the **{{ ui-key.yacloud.serverless-functions.item.testing.field_payload }}** field, enter the following code and click ![image](../../../_assets/console-icons/play-fill.svg) **{{ ui-key.yacloud.serverless-functions.item.testing.button_run-test }}**:

```json
{
  "queryStringParameters": {
    "content": "iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAAAAAA6fptVAAAACklEQVR4nGNgYAAAAAMAASsJTYQAAAAASUVORK5CYII=",
    "width": 100,
    "height": 100
  }
}
```

The **{{ ui-key.yacloud.serverless-functions.item.testing.label_title-test-result }}** section will show the function's response:

```json
{
    "content": "iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAIAAAD/gAIDAAAACXBIWXMAAAsTAAALEwEAmpwYAAAANElEQVR4nO3BAQ0AAADCoPdPbQ43oAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAujF1lAABe5jSrAAAAABJRU5ErkJggg=="
}
```