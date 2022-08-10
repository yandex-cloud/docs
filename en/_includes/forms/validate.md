Use validation if you need to check that the entered response matches the specified format. For example, you can make sure responses are in Russian or that there aren't any forbidden characters in them. If the response doesn't match the specified format, a warning appears that the field is filled out incorrectly.

Select a validation method:

* **No validation**: The response can contain any characters. If you select this validation method, the entered data is not checked.

* **Validation of fractional numbers**: The response must contain an integer or a decimal.

* **TIN validation**: The response must contain a valid taxpayer ID: 10 or 12 digits corresponding to the control checks. 

* **Validation of letters from the Cyrillic alphabet**: The response can only contain letters in the Russian alphabet, numbers, spaces and symbols `. , ; ( )`. 

* **Validation using regular expressions**: You can make your own [regular expression]({{  link-wikipedia-expressions }}) used to check responses. Examples:
    * A regular expression that only allows Latin letters, numbers, and spaces:

        ```
        ^[A-Za-z0-9\s]+$
        ```
    * A regular expression that allows any characters except numbers and certain special characters:

        ```
        ^[^0-9@#$%^&*]+$
        ```
