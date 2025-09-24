В блоке **Параметры инструмента** укажите имена, типы и текстовые описания параметров, которые будут использоваться инструментом.

Вы можете добавить нужные параметры на вкладке ![layout-header-cells-large](../../../_assets/console-icons/layout-header-cells-large.svg) **Форма** по одному с помощью кнопки ![plus](../../../_assets/console-icons/plus.svg) **Добавить** или на вкладке ![code](../../../_assets/console-icons/code.svg) **JSON-схема** в виде [JSON](https://ru.wikipedia.org/wiki/JSON)-структуры.

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