# Forms from {{ forms-full-name }}

[{{ forms-full-name }}]{% if audience == "external" %}({{ link-forms-b2b }}){% else %}({{ link-forms-int }}){% endif %} is a service where you can conduct surveys, collect feedback, and accept requests. Read more about the service features in the [{{ forms-full-name }} documentation](../../forms/).

## Add a response to {{ wiki-name }} {#forms-wiki}

To save user responses on your Wiki page, set up [integration with {{ wiki-name }} using the form](../../forms/send-wiki.md).

## Adding a form to a wiki page {#insert-form}

The `forms` section enables you to add a form to your [Wiki page](../pages-types.md#page).

```
{{forms id="form_id"}}
```

Learn about how to get an embed code for the form in the [{{ forms-full-name }} documentation](../../forms/publish#section_xvx_g2c_tbb).

## Adding a form in the visual editor {#wysiwyg}

To add a form to your page using the [visual editor](../pages-types.md#wysiwyg):

1. Get the iframe embed code for the form. Read more in the [{{ forms-full-name }} documentation](../../forms/publish.md#section_c21_gdb_42b).

1. Copy the `src` attribute value from the `iframe` tag.

1. In the visual editor's toolbar, click ![](../../_assets/wiki/svg/wysiwyg/iframe.svg).

1. Paste the copied form URL into the **Link** field and set the frame dimensions.

