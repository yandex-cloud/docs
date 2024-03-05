# Get responses

You can view responses in the {{ forms-full-name }} interface, download them as a file, or save them to Yandex&#160;Disk.

To have responses sent to your mailbox, [set up integration with email](send-mail.md).

## Downloading or viewing the responses {#download}

1. Select the form and open the **{{ ui-key.forms.common.blocks_correct-answers.title }}** tab.

1. Select the response display format:

   {% list tabs %}

   - Statistics

      The tab displays the questions and the relevant response statistics. You can see how many responses each question has. For multiple-choice questions, you can see the vote distribution.

   - Timeline

      The tab displays a sequential response list. Responses are loaded as you scroll down the page. You can collapse or expand a response by clicking ![chevron-up](../_assets/console-icons/chevron-up.svg) or ![chevron-down](../_assets/console-icons/chevron-down.svg) on it.

      To share a response, click ![arrow-up-from-square](../_assets/console-icons/arrow-up-from-square.svg) on it to copy the link.

   {% endlist %}

1. Select the responses you need by using the filters:

   * To select responses for a specific period, click **For all time**, set the start and end of the period and click **Save**. The data on the **Statistics** and **Timeline** tabs will be refreshed.

   * To select responses to certain questions, click **All questions**, select the questions you need from the list and click **Save**. The data on the **Statistics** and **Timeline** tabs will be refreshed.

1. Save the responses you get.

   Responses can be saved in XLSX, CSV, and JSON formats. You can download the responses in a file or save them to Yandex&#160;Disk:

   {% list tabs group=forms_answers %}

   - Downloading a file {#locally}

      To download the responses in XLSX format, click **Download XLSX**.

      To select a different file format:

      1. Click ![horizontal-ellipsis](../_assets/horizontal-ellipsis.svg) and select ![arrow-down-to-line](../_assets/console-icons/arrow-down-to-line.svg) **Download as...**.
      1. In the window that opens, select the file format and the additional data you need to save.
      1. Click **Download**.

      The response file will be saved to your computer.

   - Saving to Yandex Disk {#ya-disk}

      
      {% note warning %}

      If you logged in to [{{ forms-full-name }} for business](forms-for-org.md) via an [identity federation](login.md), saving responses to Yandex&#160;Disk is unavailable.

      {% endnote %}


      To save the responses in XLSX format, click **Disk**. A table with responses will open in the Yandex&#160;Disk online editor.

      To select a different file format or save the files attached to the responses to Yandex Disk:

      1. Click ![horizontal-ellipsis](../_assets/horizontal-ellipsis.svg) and select **Save to Disk as...**.
      1. In the window that opens, select the file format and the additional data you need to save.

         To save attachments from the form responses to Yandex Disk, enable the **Save to Disk with attached files** option.
      1. Click **Save to Disk**.

         A Yandex Disk folder with the saved file will open in the browser.

      If you blocked new tabs opening in your browser, a link to the saved file will appear next to the **Disk** button.

      You can find the attached files in the `Yandex.Forms/<Form_ID>/Files` folder on Yandex&#160;Disk.

      You can access the responses saved on Yandex Disk from any device and share them with other users. For more information about working with Yandex Disk, see [Help]({{ support-disk-main }}).

   {% endlist %}



## Getting files that are attached to a form {#files}

You can view files attached to the form by users in the response list on the **Timeline** tab or download them to Yandex&#160;Disk.

1. [Open the response list or save the responses to Yandex&#160;Disk](#download).

   {% note warning %}

   Files attached to a response are available via links only to the employees with permission to edit the form to which these files were uploaded. These files cannot be downloaded automatically using robots or scripts.

   {% endnote %}

1. Get the files attached to the form:

   {% list tabs group=forms_answers %}

   - Files are stored in {{ forms-full-name }} {#server}

      Find the response you need on the **Timeline** tab and click the name of the relevant attached file. The file will open for viewing in your browser or will be downloaded to your computer.

      
      If you send a file link to another user, they will need to [log in to their Yandex account]({{ link-passport }}) to view the file.


      {% note warning %}

      Attached files are stored on the {{ forms-full-name }} server for 3 months. After this period expires, the files are deleted. We recommend [saving files to Yandex&#160;Disk](#download) or downloading them to your computer.

      {% endnote %}

   - Files are uploaded to Yandex Disk {#ya-disk}

      When saving the response file, the page of this file on Yandex&#160;Disk will open. In this case, you cannot preview images and documents.

      Yandex Disk stores files for an indefinite time. You can share them with other users.
      - To download the file or share it click ![](../_assets/forms/drag-answer.png).
      - To view a list of all files attached to the form, go to the folder by clicking ![](../_assets/forms/icon-back.png).

   {% endlist %}



## Archiving responses {#archive}

Responses to a form are automatically archived if you have not viewed or downloaded them in more than three months. In [{{ forms-full-name }} for business](forms-for-org.md), form responses are not archived.

After archiving, you can [view the response list, download the responses in a file, or save them to Yandex&#160;Disk](#download). However, it takes several minutes to retrieve responses from the archive.




## Deleting responses {#clear-answers}

You cannot delete responses in {{ forms-full-name }}. If you want to reset all the received responses and use the same form again, create a copy of the form:

1. On the {{ forms-full-name }} top panel, select **My forms**.

1. Select the form and hover over it.

1. Click the icon ![](../_assets/forms/context-menu.png) and select **Copy**. All [questions](add-questions.md) and [settings](appearance.md) will be moved to the new form, but there will not be any responses in it.

1. At the top of the page, you will see a notification that the form has been copied. Click **Go to form**.

1. [Share](publish.md) a new link to the form.