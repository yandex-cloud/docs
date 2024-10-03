---
title: How to customize the results page in {{ forms-full-name }}
description: Follow this guide to customize the results page.
---

# Customizing the results page

After filling out a form or completing a test, the user is redirected to the results page, the contents of which can be customized:

- Displaying a message, e.g., to thank the user for filling out your form.

- Showing response statistics for prompts in the form.

- For a [test](tests.md), you can show the number of points scored.

- Inviting the user to visit a certain website.


## Adding a message {#message}

To show a message to the user after they fill out the form, e.g., to thank them for completing it:

1. Select a form and go to **Settings** → **Text and submit logic**.

1. Under **Event after submit**, type the title and text of your message.

1. Click **{{ ui-key.yacloud.common.save }}**.


## Show response statistics {#answers}

If you hold a vote or conduct a test, after the user fills out the form, you can display response statistics: this shows them how other users responded to the prompts.

Statistics are displayed for prompts with preset response options: <q>Drop-down list</q>, <q>One answer</q>, <q>Multiple answers</q>, and <q>Rate on a scale</q>.

To show statistics:

1. Select a form and go to **Settings** → **Text and submit logic**.

1. Enable **Show response statistics after submitting the form**.

1. Click **{{ ui-key.yacloud.common.save }}**.


## Show test results {#test}

After the user completes a [test](tests.md), you can show them how many points they scored:

1. Select a form and go to **Settings** → **Tests and quizzes**.

1. Enable **Show test results**.

1. To show which responses are correct or incorrect, enable **Show correct and incorrect answers in test results**.

1. Set up [rules for scoring the test](tests.md#test-result).

1. Click **{{ ui-key.yacloud.common.save }}**.

{% note warning %}

If you show test results, you cannot [redirect users to a website](success-page.md#sec_redirect) or display a [message](success-page.md#message) when they submit the form.

{% endnote %}


## Set up a redirect {#sec_redirect}

After the user fills out the form, you can suggest that they go to your website for more information or to make an order:

1. Select a form and go to **Settings** → **Text and submit logic**.

1. Enable **Redirect to site**.

1. Give a link to the website that you want the user to visit after submitting their response.


1. In the **Button text** field, enter a name for the redirect button.

1. If you publish a form using an [embed code](publish.md#publlish-site), you can turn on the **Redirect to form in the same frame** option:

   - If this option is enabled, the website loads in a frame on the same page that the form is embedded in.

   - If this option is disabled, the website opens in a new browser tab.

   {% note warning %}

   Many websites do not support loading in a frame. We recommend enabling this option for content to be embedded in third-party websites. For example, enable it for {{ forms-full-name }} or YouTube videos.

   {% endnote %}

1. Click **{{ ui-key.yacloud.common.save }}**.

> Let's assume you have embedded a form in your landing page for collecting customer requests. After the user fills out the request form, they must be redirected to a second form to confirm their phone number. You want the user to stay on your landing page instead of going to {{ forms-full-name }}. To do this, open the settings of your request form and enable **Redirect to form in the same frame**.