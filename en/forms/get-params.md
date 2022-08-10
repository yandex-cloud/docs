# GET parameters

You can use GET parameters to add attributes to the [URL address]({{link-wikipedia-url}}) of a form. GET parameters allow you to automatically fill in the fields of the form that you publish using a link or [embed in a page using iframe](publish.md#section_c21_gdb_42b):

1. Get the [question ID and response ID](question-id.md) (for questions with multiple response options).

1. Append a question mark `?` to the form URL. The format of the parameter depends on the question type:

    * For questions with an input field like <q>Short text</q> or <q>Email</q>:
        ```
        <question id>=<response text>
        ```

        If there are multiple words in the response text, replace the spaces with a `+` sign. Examples:

        ```
        {{ link-forms }}u/5e2ac2d850bdb705c38ed14f/?answer_short_text_1685088=Planet+Earth
        ```
    * For questions with response options like <q>One answer</q> or <q>Several answers</q>:
        ```
        <question id>=<response id>
        ```

        Examples:

        ```
        {{ link-forms }}u/5e2ac2d850bdb705c38ed14f/?answer_choices_1685184=1958524
        ```
    * For a <q>Date</q> question:
        ```
        <question id>=YYYY-MM-DD
        ```

        Examples:

        ```
        {{ link-forms }}u/5e2ac2d850bdb705c38ed14f/?answer_date_1685200=2020-01-27
        ```
    * For a <q>Yes/No</q> question:
        ```
        <question id>=True
        ```

        Examples:

        ```
        {{ link-forms }}u/5e2ac2d850bdb705c38ed14f/?answer_boolean_1685199=True
        ```
    * For a <q>Rate on a scale</q> question.
        Select a response for one criterion:

        ```
        <question id>=<response id>
        ```

        Select responses for multiple criteria:

        ```
        <question id>[<X criterion id>]=<X response id>&<question id>[<Y criterion id>]=<Y response id>
        ```

        Examples:

        ```
        {{ link-forms }}u/5e2ac2d850bdb705c38ed14f/?answer_choices_1686274=231035_231038
        ```

        ```
        {{ link-forms }}u/5e2ac2d850bdb705c38ed14f/?answer_choices_1686274[231034]=231034_231037&answer_choices_1686274[231035]=231035_231038
        ```

1. To fill in multiple form fields at once, add multiple GET parameters separated by the `&` symbol:

    ```
    {{ link-forms }}u/5e2ac2d850bdb705c38ed14f/?answer_short_text_1685088=John+Smith&answer_choices_1685184=1958524
    ```

URLs can contain no more than 32,000 characters, the remaining data is discarded. Keep this in mind when entering long queries.

