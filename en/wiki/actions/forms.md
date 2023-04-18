# Forms from {{ forms-full-name }}

[{{ forms-full-name }}]({{ link-forms-b2b }}) is a service that enables you to administer surveys, tests and quizzes, collect feedback, and accept applications. You can read more about the service features in the [{{ forms-full-name }} documentation](../../forms/).

## Adding a response to a {{ wiki-name }} page {#forms-wiki}

To save user responses on your {{ wiki-name }} page, set up [integration with {{ wiki-name }} using a form](../../forms/send-wiki.md).

## Adding a form to a {{ wiki-name }} page {#insert-form}

Use the `forms` block to add a form to your [page](../pages-types.md#page).

```
{{forms id="form_id"}}
```

For information about how to get the form embed code, see the [{{ forms-full-name }} documentation](../../forms/publish#section_xvx_g2c_tbb).

## Adding a form in the new editor {#wysiwyg}

To add a form to your page using the [new editor](../pages-types.md#wysiwyg):

1. Get the iframe embed code for the form. For more information, see the [{{ forms-full-name }}documentation](../../forms/publish.md#section_c21_gdb_42b).

1. Copy the `src` attribute value from the `iframe` tag.

1. In the visual editor's toolbar, click ![](../../_assets/wiki/svg/wysiwyg/iframe.svg).

1. Paste the copied form URL into the **Link** field and set the iframe dimensions.