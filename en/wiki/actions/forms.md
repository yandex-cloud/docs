# {{ forms-full-name }}

[{{ forms-full-name }}]{% if audience == "external" %}({{ link-forms-b2b }}){% else %}({{ link-forms-int }}){% endif %} is a service where you can conduct surveys and quizzes, collect feedback, and receive requests. To learn more about the service and its features, read [service documentation {{ forms-full-name }}](../../forms/).

## Add response to {{ wiki-name }} {#forms-wiki}

To save user responses on a Wiki page, configure [integration with {{ wiki-name }} in the form](../../forms/send-wiki.md).

## Adding forms to a page {#insert-form}

You can use the `forms` block to embed forms created in {{ forms-full-name }}.

### Calling the block {#forms-call}

```
{{forms id="form_id"}}
```

To find out how to get the embed code for a form, read the [documentation {{ forms-full-name }}](../../forms/publish#section_xvx_g2c_tbb).

