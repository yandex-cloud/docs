# Customize the result page

After filling out the form or completing the test, the user is taken to the results page, the contents of which can be customized:

- Display a message, like to thank the user for filling out your form.

- Show response statistics for prompts in the form.

- For a [test](tests.md), you can show the number of points scored.

- Invite the user to visit a certain site.

## Add a message {#message}

To show a message to the user after they fill out the form, like to thank them for participating:

1. Select the form and go to **Settings** → **Text and submit logic**.

1. In the **Event after submit** section, type the title and text of your message.

1. Click **Save**.

## Show response statistics {#answers}

If you have a vote or test, after the user fills out the form, you can display response statistics: this shows them how other users responded to the prompts.

Statistics are displayed for prompts with preset response options: <q>Drop-down list</q>, <q>One answer</q>, <q>Multiple answers</q>, and <q>Rate on a scale</q>.

To show statistics:

1. Select the form and go to **Settings** → **Text and submit logic**.

1. Turn on **Show response statistics after submitting the form**.

1. Click **Save**.

## Show test results {#test}

After the user completes the [test](tests.md), you can show them how many points they scored:

1. Select the form and go to **Settings** → **Tests and quizzes**.

1. Turn on **Show the test results**.

1. To show which responses are correct or incorrect, turn on **Show correct and incorrect answers in test results**.

1. Set up [rules for scoring the test](tests.md#test-result).

1. Click **Save**.

{% note warning %}

If you show test results, you can't [redirect users to a site](success-page.md#sec_redirect) or display a [message](success-page.md#message) when they submit the form.

{% endnote %}

## Set up redirection {#sec_redirect}

After the user fills out the form, you can suggest that they go to your site for more information or to make an order:

1. Select the form and go to **Settings** → **Text and submit logic**.

1. Turn on **Redirect to site**.

1. Give a link to the site that you want the user to visit after submitting their response.

1. Choose how you want the user to go to the site:

    - **On click**: The user needs to click a button to go to the site.

    - **Delayed**: The user is automatically redirected five seconds after submitting their response. They can also go to the site by clicking the button.

1. In the **Button text** field, enter the name of the redirect button.

1. If you publish a form using an [embed code](publish.md#section_c21_gdb_42b), you can turn on the **Redirect to form in the same frame** option:

    - If this option is on, the site loads in a frame on the same page that the form is embedded in.

    - If this option is off, the site opens in a new browser tab.

    {% note warning %}

    Many sites don't support loading in a frame. We recommend turning on this option for content that is intended for embedding on third-party sites. For example, enable it for {{ forms-full-name }} or Youtube videos.

    {% endnote %}

1. Click **Save**.

> Let's say you've embedded a form on your landing page for collecting customer requests. After the user fills out the request form, they must be redirected to a second form to confirm their phone number. You want the user to stay on your landing page instead of going to {{ forms-full-name }}. To do this, go to the settings for your request form and turn on **Redirect to form in the same frame**.

