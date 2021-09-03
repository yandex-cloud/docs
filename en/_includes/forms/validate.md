Use validation if you need to check that the entered response matches the specified format. For example, you can make sure responses are in Russian or that there aren't any forbidden characters in them. If the response doesn't match the specified format, a warning appears that the field is filled out incorrectly.

Select a validation method:

* **No validation**: The response can contain any characters. If you select this validation method, the prompt type changes to <q>Short text</q>.

{% if audience == "internal" %}

* **External validator**: Validate the response using an external service. When selecting this option in the form settings, specify the [validation server address](../../forms/validation.md).
{% endif %}

* **Validation of fractional numbers**: The response must contain an integer or a decimal. If you select this validation method, the prompt type changes to <q>Number</q>.

* **TIN validation**: The response must contain a valid taxpayer ID. If you select this validation method, the prompt type changes to <q>TIN</q>.

* **Validation of letters from the Cyrillic alphabet**: The response can only contain letters in the Russian alphabet, numbers, and spaces. If you select this validation method, the prompt type changes to <q>Short text</q>.

* **Validation using regular expressions**: You can make your own [regular expression]({{  link-wikipedia-expressions }}) used to check responses. Examples:
    * A regular expression that only allows Latin letters, numbers, and spaces:

        ```
        ^[A-Za-z0-9\s]+$
        ```
    * A regular expression that allows any characters except numbers and certain special characters:

        ```
        ^[^0-9@#$%^&*]+$
        ```

    If you select this validation method, the prompt type changes to <q>Short text</q>.

