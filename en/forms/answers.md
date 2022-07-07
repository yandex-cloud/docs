# Get responses

You can view responses in the {{ forms-full-name }} interface, download them as a file, or save them to Yandex.Disk.

To have responses sent to your mailbox, [set up integration with email](send-mail.md).

## Download or view all responses {#download}

  1. Select a form and go to the **Responses** tab.

  1. On the **Summary** tab, configure the content and format of the response list you want to view or save:

       * In the **Download responses** block, choose the prompts you want to get responses for. To get responses for all prompts, select **All**.

       * If you want to download the responses file or save it on Yandex.Disk, select the file format.

       * To get responses that were submitted during a specific time period, click **Select dates** and set the start and end of the period.

       * To make the list of responses include data from users who completed the form and additional response parameters, click **Show additional parameters**.

  1. Choose how to get responses:

       {% cut "View recent responses" %}

       Click **View**. You'll see a list that contains a maximum of 100 recent responses to your prompts.

       {% endcut %}


       {% cut "Download responses in a file" %}

       Click **Download**. A file with responses in the format that you selected will be downloaded to your computer.

       {% endcut %}


       {% cut "Save responses on Yandex.Disk" %}

       Click **Upload to Yandex.Disk**. To save attachments from the form to Yandex.Disk, select **Save to Yandex.Disk with attached files**.
       * If you choose the XLSX file format, the table with responses opens in the Yandex.Disk online editor.
       * If you select the CSV or JSON format, a folder on Yandex.Disk containing the saved file opens.
       * If new tabs are blocked from opening in your browser, a link to the saved file appears next to the **Upload to Yandex.Disk** button.
       * The attached files will be available in the `Yandex.Forms/<Form ID>/Files` folder on Yandex.Disk and via the [link from the list of responses](#files).

       You can access the responses saved on Yandex.Disk from any device, and you can share them with other users. To learn more about using Yandex.Disk, go to [Help]({{ support-disk-main }}).

       {% endcut %}


## View responses individually {#answer-in-detail}


{% note warning %}

If the responses to the form [have been moved to the archive](#archive), you won't be able to view individual responses.

{% endnote %}


1. Select a form and go to the **Responses** tab.

1. Select **By responses**.

1. To view responses that were submitted during a specific time period, click **Select dates** and set the start and end of the period.

1. To switch between responses, use the ![](../_assets/forms/icon-prev.png) and ![](../_assets/forms/icon-next.png) buttons.
Responses to [tests and quizzes](tests.md) are color-coded:
    * If the user gave a correct response, it's green.
    * If the user gave an incorrect response, it's red.

1. To send a link to another user, select a response and click **Share**.

   Any user will be able to access the response via the link without logging in.

## Get files that are attached to the form {#files}

Files that users attached to the form are available via links that you can find in the list of responses:

1. [Open the list of recent responses, download the responses in a file, or save them to Yandex.Disk](#download).

1. In the list, find the response that has a link to a file and click it.

{% cut "If files are uploaded to Yandex.Disk" %}

When you click the link, the file page opens on Yandex.Disk. In this case, image and document preview is unavailable.

Files are stored to Yandex.Disk for an indefinite length of time. You can share them with other users.

- To download or share a file, click ![](../_assets/forms/drag-answer.png).

- To view a list of all files attached to the form, go to the folder by clicking ![](../_assets/forms/icon-back.png).

{% endcut %}

{% cut "If files are stored on the {{ forms-full-name }} server" %}

When you click the link, the file opens for viewing in your browser or downloads to your computer.

If you send a link to another user, they'll need to [log in to their Yandex account]({{ link-passport }}) to view the file.

{% endcut %}

{% note warning %}

Attached files are stored on the {{ forms-full-name }} server for 3 months, after which the files are deleted. We recommend [uploading files to Yandex.Disk](#download) or saving them to your computer.

{% endnote %}

## View response statistics {#view}

To view brief response statistics:

1. Select a form and go to the **Responses** tab.

1. Scroll down to the list of prompts.

You can see how many responses each prompt has. For multiple-choice prompts, you can see the vote distribution.


## Archiving responses {#archive}

Responses for the form's prompts are automatically archived if you haven't viewed or downloaded them in more than three months. If the form is [linked to an organization](forms-settings.md#add-connect), responses are not archived.

After archiving:

* You can [view the list of recent responses, download them in a file, or save them to Yandex.Disk](#download). However, it takes several minutes to retrieve responses from the archive.

* [You can't view individual responses](#answer-in-detail) this way.



## Delete responses {#clear-answers}

You can't delete responses in {{ forms-full-name }}. If you want to reset all received responses and use the same form again, create a copy of the form:

1. In the upper panel in {{ forms-name }}, go to **My forms**.

1. Select a form and hover over it.

1. Click ![](../_assets/forms/context-menu.png) and select **Copy**. All [prompts](add-questions.md) and [settings](appearance.md) will be moved to the new form, but there won't be any responses in it.

1. At the top of the page, you'll see a notification that the form has been copied. Click **Go to form**.

1. [Share](publish.md) a new link to the form.

