---
title: "GET parameters in {{ forms-full-name }}"
description: "You can use GET parameters to add attributes to a form. GET parameters allow you to automatically fill in the fields of the form that you publish using a link or embed in a page using an iframe."
---

# GET parameters

You can use GET parameters to add attributes to a form's [URL]({{link-wikipedia-url}}). GET parameters allow you to automatically fill in the fields of the form that you publish using a link or [embed in a page using an iframe](publish.md#publlish-site):

1. Get the [question ID and response ID](question-id.md) (for multiple choice questions).

1. Add a question mark (`?`) to the form URL. After it, specify the parameter. The format of the parameter depends on the question type:

   * For questions with an input field, such as **Short text**, **{{ ui-key.forms.common.blocks_integration-group.title-email }}**:
      ```
      <question_ID>=<response_text>
      ```
      If there are multiple words in the response text, replace the spaces with a `+` sign. For example:
      ```
      {{ link-forms }}u/5e2ac2d850bdb705********/?answer_short_text_1685088=Planet+Earth
      ```
   * For questions with response options like **One answer** or **Multiple answers**:
      ```
      <question_ID>=<response_ID>
      ```
      For example:
      ```
      {{ link-forms }}u/5e2ac2d850bdb705********/?answer_choices_1685184=1958524
      ```
   * For questions of the **Date** type:
      ```
      <question_ID>=YYYY-MM-DD
      ```
      For example:
      ```
      {{ link-forms }}u/5e2ac2d850bdb705********/?answer_date_1685200=2020-01-27
      ```
   * For **Yes / No** questions:
      ```
      <question_ID>=True
      ```
      For example:
      ```
      {{ link-forms }}u/5e2ac2d850bdb705********/?answer_boolean_1685199=True
      ```
   * For **Rate on a scale** questions.
      Choose a response by one criterion:
      ```
      <question_ID>=<response_ID>
      ```
      Choose a response by multiple criteria:
      ```
      <question_ID>[<X_criterion_ID>]=<X_response_ID>&<question_ID>[<Y_criterion_ID>]=<Y_response_ID>
      ```
      For example:
      ```
      {{ link-forms }}u/5e2ac2d850bdb705********/?answer_choices_1686274=231035_231038
      ```
      ```
      {{ link-forms }}u/5e2ac2d850bdb705********/?answer_choices_1686274[231034]=231034_231037&answer_choices_1686274[231035]=231035_231038
      ```
1. To fill in multiple form fields at once, add multiple GET parameters separated by `&`.
   ```
   {{ link-forms }}u/5e2ac2d850bdb705********/?answer_short_text_1685088=Vasya+Pupkin&answer_choices_1685184=1958524
   ```

URLs may contain no more than 32000 characters, the remaining data is discarded. Keep this in mind when making long queries.