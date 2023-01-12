# Get responses

You can view responses in the {{ forms-full-name }} interface, download them as a file, or save them to Yandex&#160;Disk.

To have responses sent to your mailbox, [set up integration with email](send-mail.md).

## Download or view all responses {#download}

1. Select the form and open the **Responses** tab.

1. In the **Summary** tab, configure the content and format of the response list you want to view or save:
   * Under **Download responses**, choose the prompts you want to get responses for. To get the answers to all questions select the **All** option.

   * If you want to download a file with responses or save it on Yandex Disk, select the file format.

   * To get responses that were submitted during a specific time period, click **Select dates** and set the start and end of the period.

   * For the list of responses to include data from users who completed the survey and additional response parameters, click **Show additional parameters**.

1. Choose how to get responses:

   {% cut "View recent responses" %}

   Click **View**. You'll see a list that contains a maximum of 100 recent responses to your prompts.

   {% endcut %}

   {% cut "Download responses in a file" %}

   Click **Download**. A file with responses in the format that you selected will be downloaded to your computer.


   {% endcut %}

   {% cut "Save responses on Yandex Disk" %}

   {% if audience == "external" %}

   {% note warning %}

   If you logged in to [{{ forms-full-name }} for business](forms-for-org.md) via an [identity federation](login.md), saving responses to Yandex&#160;Disk is unavailable.

   {% endnote %}

   {% endif %}

   Click **Save on Yandex Disk**. To save attachments from the form to Yandex Disk, select **Save to Yandex Disk with attached files.**.

   * If you choose the XLSX file format, the table with responses opens in the Yandex&#160;Disk online editor.
   * If you select CSV or JSON, a folder with the saved file opens on Yandex Disk.
   * If new tabs are blocked from opening in your browser, a link to the saved file appears next to the **Save to Yandex Disk** button.
   * The attached files will be available in the `Yandex.Forms/<Form ID>/Files` folder on Yandex&#160;Disk and via the [link from the list of responses](#files).

   You can access the responses saved on Yandex Disk from any device and share them with other users. For more information about working with Yandex Disk, see [Help]({{ support-disk-main }}).

   {% endcut %}

   {% if audience == "internal" %}

   {% note warning %}

   To save files from an external or internal [form constructor](go-to-forms.md) to Yandex Disk, [link your Yandex username to Staff](https://wiki.yandex-team.ru/staff/vodstvo/external-login/#kakpodtverditvneshnijjlogin) and [enable two-factor authentication]({{ support-passport-auth }}) in the account settings.

   If you don't do that, a file will be downloaded to your PC.

   {% endnote %}

   {% endif %}

## View responses individually {#answer-in-detail}

{% if audience == "external" %}

{% note warning %}

If responses to the form are [archived](#archive), you can't view individual responses.

{% endnote %}

{% endif %}

1. Select the form and open the **Responses** tab.

1. Select the **By responses** tab.

1. To view responses that were submitted during a specific time period, click **Select dates** and set the start and end of the period.

1. To switch between responses, use the ![](../_assets/forms/icon-prev.png) and ![](../_assets/forms/icon-next.png) buttons.
   Responses to [tests and quizzes](tests.md) are color-coded:
   * If the user gave a correct response, it's green.
   * If the user gave an incorrect response, it's red.

1. To send a link to another user, select a response and click **Share**.

   {% if audience == "external" %}

   {% note info %}

   In Yandex Forms for business, responses can only be accessed via a link by the organization employees. Responses to personal forms can be accessed via a link by any users without authorization.

   {% endnote %}

   {% endif %}


## Get files that are attached to a form {#files}

Files that users attached to the form are available via links that you can find in the list of responses:

1. [Open the list of recent responses, download the responses in a file, or save them to Yandex&#160;Disk](#download).

1. In the list, find the response that has a link to a file and click it.

{% cut "If files are uploaded to Yandex Disk" %}

When you click the link, the file page opens on Yandex&#160;Disk. In this case, image and document preview is unavailable.

Yandex Disk stores files for an indefinite time. You can share them with other users.
- To download the file or share it click ![](../_assets/forms/drag-answer.png).
- To view a list of all files attached to the form, go to the folder by clicking ![](../_assets/forms/icon-back.png).

{% endcut %}

{% cut "If files are stored on the {{ forms-full-name }} server" %}

When you click the link, the file opens for viewing in your browser or downloads to your computer.

{% if audience == "external" %}

If you send a link to another user, they'll need to [log in to their Yandex account]({{ link-passport }}) to view the file.

{% else %}

{% note warning %}

Access to the files stored on the {{ forms-full-name }} server is restricted. To enable other users to view the files attached, [grant access permissions](access.md#files) to employees, a group, or a department.

{% endnote %}

{% endif %}

{% endcut %}

{% note warning %}

Attached files are stored on the {{ forms-full-name }} server for {% if audience == "external" %}3 months{% else %}1 year{% endif%}. After this period expires, the files are deleted. We recommend [uploading files to Yandex&#160;Disk](#download) or saving them to your computer.

{% endnote %}

## View response statistics {#view}

To view brief response statistics:

1. Select the form and open the **Responses** tab.

1. Scroll down to the list of prompts.

You can see how many responses each prompt has. For multiple-choice prompts, you can see the vote distribution.

{% if audience == "external" %}

## Archive responses {#archive}

Responses to a form's prompts are automatically archived if you haven't viewed or downloaded them in more than three months. In [{{ forms-full-name }} for business](forms-for-org.md), form responses are not archived.

After archiving responses:

* You can [view the list of recent responses, download them in a file, or save them to Yandex&#160;Disk](#download). However, it takes several minutes to retrieve responses from the archive.

* [You can't view individual responses](#answer-in-detail) this way.

{% endif %}

{% if audience == "internal" %}

## Get data from YT {#yt}

Responses to form prompts can be automatically uploaded to [YT](https://yt.yandex-team.ru/docs/) in a Hahn cluster. For each form, a table is created where data is updated once in 15 minutes.

To enable automatic response uploading to YT:

1. Select the form and open the **Settings** → **Additional** tab.

1. Enable the **Export answers to YT.Hahn** option. All the responses received after the form is created will be uploaded.

To find a YT table with data from your form:

1. Select the form and open the **Responses** tab.

1. Under the **Retrieve files from YT** header, click the link to the table.

1. If you are not allowed to access the table, you'll see an error saying <q>Access denied...</q>.

   In this case, request access:
   1. Click **Request permissions**.
   1. Enable **Permissions** → **read** option.
   1. In the **Subjects** field enter your username.
   1. Click **Confirm**. A role request is sent to IDM.

   {% note info %}

   You need to request access to each table individually.

   {% endnote %}

{% endif %}

## Delete responses {#clear-answers}

You can't delete responses in {{ forms-full-name }}. If you want to reset all the received responses and use the same form again, create a copy of the form:

1. On the {{ forms-full-name }} top panel, select **My forms**.

1. Select the form and hover over the trigger.

1. Click the icon ![](../_assets/forms/context-menu.png) and select **Copy**. All [prompts](add-questions.md) and [settings](appearance.md) will be moved to the new form, but there won't be any responses in it.

1. At the top of the page, you'll see a notification that the form has been copied. Click **Go to form**.

1. [Share](publish.md) a new link to the form.