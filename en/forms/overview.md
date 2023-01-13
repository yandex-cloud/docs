# {{ forms-name }} overview

{{ forms-full-name }} is a service that enables you to administer surveys, tests and quizzes, collect feedback, and accept applications. 

In {{ forms-full-name }}, you can use various types of prompts to easily configure any survey or test. You can place a form on a website or share one with users via a link. You can view responses to your prompts in the {{ forms-name }} interface or have them sent to your email.

Use {{ forms-full-name }} in personal matters: for example, to conduct a survey for your friends and make a menu for a New Year's party. You can also use forms for work or business, such as to accept orders for your online store.

If you want to use the {{ forms-name }} together with your colleagues, create an organization in {{ yandex-cloud }} and connect the {{ forms-full-name }} for business. You can give other users in the organization access to edit your forms and view responses. You can also set up integration with {{ tracker-full-name }} and {{ wiki-full-name }}. For more information, see [{#T}](forms-for-org.md).

## How {{ forms-full-name }} works {#how-to}

### Creating and configuring form {#create}

You can use the constructor to add prompts to your form and set up their parameters. {{ forms-full-name }} support different types of prompts that require certain responses: choosing one or more options from a list, text, number, date, email address, and so on. You can enter the prompt text, add response options (if needed), and set up other parameters.

For more information, see:

- [{#T}](quick-guide.md)

- [{#T}](blocks-ref/blocks-reference.md)

### Prompt and response logic {#restrictions}

In {{ forms-full-name }}, you can set the conditions for showing prompts and restrict responses:

- [Create required prompts](add-questions.md#params): The user won't be able to submit the form without responding to those.

- [Show or hide questions depending on how users answer preceding questions](add-questions.md#conditions). For example, display the field for the email address if the user agreed to subscribe to the newsletter.

- [Add time or quantity restrictions for responses to the form](restrictions.md).

### Publish a form {#publish}

You can [publish a form in several ways](publish.md):

- Using a link: Send a link to the form in a messenger or post it on your social media.

- Embed the form in a website using HTML code. For example, add a feedback form to a company's website.

- Users of [{{ yandex-cloud }} organizations](forms-for-org.md) can embed forms on pages in {{ wiki-full-name }}.

### Getting responses {#answers}

There are [several ways to get user responses](answers.md):

- View responses in the {{ forms-name }} interface.

- Download a file with responses.

- Upload the file with responses to Yandex&#160;Disk.

- Set up forwarding responses to email.

## Learn more about {{ forms-full-name }} features {#details}

- [How to create a form](new-form.md)

- [How to conduct a test](tests.md)

- [How to customize the appearance of form](appearance.md)

- [How to configure the page the user sees after filling out the form](success-page.md)

- [How to publish a form](publish.md)

- [How to set up integration with email and other services](notifications.md)

- [How to set up pre-filling: automatically insert responses into the form](pre-fill.md)

- [How to view responses](answers.md)