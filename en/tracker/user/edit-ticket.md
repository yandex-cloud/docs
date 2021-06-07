# How to edit an issue

To change an issue, go to the issue page. If you don't have sufficient rights to edit the issue, [request permissions](../faq.md#section_xgr_zng_4bb) from the queue owner or{% if audience == "external" %} your organization's{% endif %} administrator.

{% note info %}

Issue pages are updated in real time. If someone edits or adds a comment to an issue that you have open in your browser, you will immediately see a notification on the browser tab.

{% endnote %}

## Change issue descriptions {#section_yrw_npn_jz}

To the right of the issue description, click ![](../../_assets/tracker/icon-edit.png) and edit its text. Use [wiki markup](wiki-markup.md) to format text. To save changes, click **Save**.

You can use the issue description to specify a key for a different issue. {{ tracker-name }} will then link the issues automatically.

{% note info %}

If you need to paste a link to another issue in your comment without actually linking the issues together, include the `st:` parameter before the issue key (for example: `st:TEST-1234`). If you do this, a [magic link](wiki.md#magic-link-descr) will be displayed in the text field, but you won't link issues together.
You can disable automatic linking for issues from different queues in the [queue settings](../manager/edit-queue-general.md).

{% endnote %}

If you close or refresh the page without saving your changes, the new description will still be stored in drafts. You can restore that description by clicking the edit icon ![](../../_assets/tracker/icon-edit.png) again, then clicking ![](../../_assets/tracker/drafts.png) in the toolbar, and choosing the draft.

## Add comment {#sec_comment}

To comment on an issue, enter text in the box at the bottom of the page. In the comments section, you can use [wiki markup](wiki-markup.md) and attach images and files.

You can use the issue description to specify a key for a different issue. {{ tracker-name }} will then link the issues automatically.

If you close or refresh the page without sending your comment, it is still stored in drafts. You can restore the comment text by clicking ![](../../_assets/tracker/drafts.png) in the toolbar above the comment box and choosing the draft.

To learn more about comments, see [{#T}](comments.md).

## Change issue fields {#section_jqw_ppn_jz}

[Issue details](create-param.md#section_ymd_ycj_1gb) are shown in the panel on the right. To change one of the values, click the name of the field. To save changes, click **OK**.

If you don't see the desired fields in the panel on the right, add them by clicking ![](../../_assets/tracker/task-params-btn.png).

## Attach images and files to an issue {#section_qyt_4nx_pz}

To attach a file to an issue description:

1. Click ![](../../_assets/tracker/icon-edit.png) next to the issue description.

1. Drag the files to the area under the description or click **Choose files**. The size of the attached file may not exceed 200 MB.
To insert images attached to the issue in the description text, click ![](../../_assets/tracker/add-image.png).

1. Click **Save**.

You can use the same method to attach files to comments.

The attached files are displayed beneath the issue description or comment.

To view a list of all the files attached to the issue page, go to the **Files** tab under the issue description. Files added to {{ tracker-name }} don't take up space on Yandex.Disk. There's no limit on the amount of data stored in {{ tracker-name }}.

## Add a link to another issue {#section_wz1_rpn_jz}

To link issues:

1. Choose **Actions** → **Add link**.

1. Choose the appropriate type of relationship.

1. Specify the key of the issue to link to. You can find the key on the issue page, under the title (for example, `TEST-1234`).

1. Click **Add link**.

To learn more about links, see [{#T}](ticket-links.md).

{% note info %}

Issue links are created automatically when an issue key is entered into the issue's description or comment body.

{% endnote %}

## Link a commit to an issue {#sec_commit}

You can link an issue to a commit, provided its repository{% if audience == "external" %} is [connected to {{ tracker-name }}](../manager/add-repository.md){% endif %}. To do this, specify the issue key in the commit comment. You can view linked commits the following ways:

- On the **Commits** tab on the issue page.
- On the **Commits** tab on the queue page.

If you don't see the **Commits** tab, make sure it's enabled in your [queue settings](../manager/edit-queue-general.md).

## Set date display type {#section_e2p_zqx_vgb}

Values responsible for date and time can be displayed in the full (day, month, year, time) or simplified (day and month) formats.

If you want to change the display type for these values, do the following:

1. {% if audience == "external" %}On the {{ tracker-name }} top panel, click ![](../../_assets/tracker/tracker-settings.png) → **Personal settings**{% else %}On the {{ tracker-name }} top panel, click on your profile picture and select **Personal settings** or follow the link: [https://st.yandex-team.ru/settings]({{ link-settings-ya }}){% endif %}

    {% if audience == "external" %}

    {% note info %}

    You can also follow this link: [https://tracker.yandex.com/settings]({{ link-settings }}).

    {% endnote %}

    {% endif %}

1. Select the format you need in the **Date format** section.

1. Click **Save**.

## Set user display type {#section_gmp_wn4_xgb}

You can choose how usernames are displayed on the issue page.

1. {% if audience == "external" %}On the {{ tracker-name }} top panel, click ![](../../_assets/tracker/tracker-settings.png) → **Personal settings**.{% else %}On the {{ tracker-name }} top panel, click on your profile picture and select **Personal settings** or follow the link: [https://st.yandex-team.ru/settings]({{ link-settings-ya }}){% endif %}

    {% if audience == "external" %}

    {% note info %}

    You can also follow this link: [https://tracker.yandex.com/settings]({{ link-settings }}).

    {% endnote %}

    {% endif %}

1. Select one or more options:

    |  |  |
    | ----- | ----- |
    | **Display login instead of a name** | The User field will display a user's login. |
    | **Enabling portrait mode for user lists.** | If multiple values are speficied in the User field, user's portraits are displayed instead of their names. For example, the list of users can be located in the **Assignee** field when choosing multiple values. |

1. Click **Save**.

## Move an issue to another queue {#section_xwx_qpn_jz}

{% note alert %}

When you move an issue, its sub-issues remain in the original queue. If the issue has values entered for [local fields](../local-fields.md), they will be deleted when the issued is moved to another queue.

{% endnote %}

To move an issue:

1. Choose **Actions** → **Change queue**.

1. Specify the queue to move the issue to.

1. If necessary, specify the issue parameters and click **Move**.

