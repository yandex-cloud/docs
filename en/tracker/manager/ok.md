# OK

To carry out approvals in {{ tracker-name }} issues, use the OK service. It lets you ask questions in the issue comments and collect votes (OK's) from relevant users. All employees who have access to the issue will see the list of approvers and their answers.

## Create approval {#create_ok}

1. Make sure that the `robot-ok` robot has [permission to edit issues](queue-access.md) in the queue where you'll carry out the approval. This permission is required to update the <q>Approval status</q> field and to add approvers to the <q>Access</q> field.

1. Copy the following text to the issue comment:

    ```
    {{iframe src="https://ok.yandex-team.ru/tracker?_embedded=1&author=<login>&object_id=<issue_key>&uid=00001" frameborder=0 width=100% height=400px scrolling=no}}
    ```

1. In the comment text, specify:
    - The `author` parameter value: Your username.
    - The `object_id` parameter value: The key of the issue to create the approval in.
    - As the `uid`, you can set any string. It must be unique in the current issue.

    {% note tip %}

    If you don't want to configure the approval process next time, you can [create a macro](#macros) and use it in any issue of the queue.

    {% endnote %}

1. Click **Submit**. An empty approval form appears in the comment.

1. Fill out the approval form:

    - Describe the subject of approval.

    - List the approval participants. Their order matters: approval notifications are sent sequentially to each participant once the previous one has voted.
A calendar that shows when a participant is going to be absent during the week is displayed next to the participant's name.

        {% note warning %}

        Only employees who have [access to the issue](../user/ticket-access.md) can vote.

        {% endnote %}

    - To create a group of approvers, click **Add group** and specify its members.
By default, getting an OK from at least one member of the group for approval is enough. If you need to get approval from each group member, select **Confirmation from everyone**.

    - To allow participants to vote in any order, select **Parallel approval**.

    - To enable them to disapprove the topic in question, select **Allow "Not OK"**.

1. Click **Create approval**.

## Voting {#vote}

- Once an approval is created, each participant receives a message from the robot asking them to come to the issue and vote.

    {% note info %}

    The robot will send a reminder once a day until the participant votes. If no response is received from the approver within three days, the approval author is additionally notified.

    {% endnote %}

- In the issue comments, each participant can see the approval status and can vote **OK** or **Not OK**.

- If at least one participant rejects the subject in question, the robot sends a message to the approval author.

- The approval author has the right to vote for any of the participants.

## Set up a macro {#macros}

If you frequently run approvals with the same parameters, set up a [macro](create-macroses.md) in the queue specifying the code to start approval. Example:

```
{{iframe src="https://ok.yandex-team.ru/tracker?_embedded=1&author=<%currentUser.login%>&object_id=<%issue.key%>&uid=<%currentDateTime.iso8601%>&text=Needs an approval&users=<user_login>&users=<user_login2>" frameborder=0 width=100% height=400px scrolling=no}}
```

You can use additional parameters in the approval code:

- `text=any text`: Approval text.

- `users=login1&users=login2&...`: Usernames of approval participants.

- `groups=yandex&groups=svc_ok&groups=salary-hr...`: A [list of Staff API groups](https://staff-api.yandex-team.ru/v3/groups?_doc=1) whose staff members are granted permission to start or stop the approval. The following group types are supported: `department, service, servicerole, and wiki`.

    {% note info %}

    The members of the added groups do not receive approval notifications.

    {% endnote %}

- `is_parallel=true|false`: Flag indicating parallel approval.

- `is_reject_allowed=true|false`: Flag indicating that the **Not OK** response to the approval is allowed.

