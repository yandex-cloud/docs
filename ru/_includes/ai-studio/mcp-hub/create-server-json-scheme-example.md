JSON-схема:

```json
{
  properties?: { [key: string]: object };
  required?: string[];
  type: “object”;
}
```

{% cut "Пример JSON-структуры" %}

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