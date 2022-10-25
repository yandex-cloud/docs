# Unknown field

`ERR.DS_API.FIELD.NOT_FOUND`

Nonexistent field used.

This error occurs whenever a chart uses a field with an identifier that is not in the dataset. For example, when a field has been deleted or its data type has been changed.

To fix this error:

1. {% if product == "yandex-cloud" %}[Update the dataset fields](../../operations/dataset/update-field.md){% else %}Update the dataset fields{% endif %}.
1. {% if product == "yandex-cloud" %}[Replace](../../operations/dataset/update-field.md#replace-field){% else %}Replace{% endif %} or delete the fields highlighted in red.
1. Save the dataset.
