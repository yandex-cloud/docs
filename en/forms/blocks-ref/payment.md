# Payment

This block lets users transfer money to a wallet in the YooMoney payment system (previously, Yandex.Money). For example, as payment for attending an event.

From the **Payment** block, the user is redirected to the company's website [ЮMoney]({{ link-yoomoney }}) to complete the payment. {{ forms-full-name }} only register the user's transition to the payment page. You can get information about payments and fees from YooMoney.

{% note warning %}

You can only use the **Payment** block to accept payments to a registered or identified wallet belonging to an individual. The transfer fee is deducted from the recipient.

{% endnote %}

## Block settings {#sec_settings}

### Question {#param-question}

Enter the payment field name. For example, state the purpose of the payment.

- To add an image to the title, click ![](../../_assets/forms/add-picture.png).

- To add a comment or hint to the prompt, click **+ Add comment**. The comment is displayed in a small font.

- To format the field header or comment, use [Markdown](../appearance.md#section_pzm_m1j_j3b).

### Question ID {#param-question-id}

Use the question ID to [pre-fill forms](../pre-fill.md). You can edit the ID. All questions in the same form must have unique IDs.

### Required prompt {#param-question-perm}

Turn this option on to mark required prompts with an <q>asterisk</q>. If the user doesn't respond to this prompt, they can't submit the completed form.

### Hidden question {#param-question-hide}

Turn on this option if you don't want to show a prompt on the form. You can use hidden questions to [send technical parameters](../pre-fill.md#hidden-query).

{% note warning %}

Don't turn on **Hidden question** and **Required prompt** at the same time, otherwise users won't be able to submit the completed form.

{% endnote %}

### Amount {#param-sum}

Specify the payment amount.

### Fixed amount {#param-sum-static}

Turn this option on so the user can't change the payment amount.

### Recipient's wallet number {#param-wallet-in}

Specify the number of the YooMoney wallet you will use to accept payments.

