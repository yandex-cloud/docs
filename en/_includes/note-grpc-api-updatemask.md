{% note warning %}

This API method will assign default values to all object parameters not explicitly set in the request. To avoid this, list the settings you want to change in the `update_mask` parameter as an array of `paths[]` strings.

{% cut "Format for listing settings" %}

```yaml
"update_mask": {
    "paths": [
        "<setting_1>",
        "<setting_2>",
        ...
        "<setting_N>"
    ]
}
```

{% endcut %}

{% endnote %}
