Under **Tool parameters**, specify the names, types, and text descriptions of parameters the tool will use.

You can add the parameters one by one using the ![plus](../../../_assets/console-icons/plus.svg) **Add** button on the ![layout-header-cells-large](../../../_assets/console-icons/layout-header-cells-large.svg) **Form** tab or provide them on the ![code](../../../_assets/console-icons/code.svg) **JSON schema** tab using the [JSON](https://en.wikipedia.org/wiki/JSON) structure below.

JSON schema:

```json
{
  properties?: { [key: string]: object };
  required?: string[];
  type: "object";
}
```

{% cut "JSON struture example" %}

```json
{
  "type": "object",
  "properties": {
    "location": {
      "type": "string",
      "description": "City name or zip code"
    }
  },
  "required": ["location"]
}
```

{% endcut %}
