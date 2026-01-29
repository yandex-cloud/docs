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