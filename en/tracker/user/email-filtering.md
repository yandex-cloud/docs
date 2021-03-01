# Filtering incoming emails

{{ tracker-name }} email notifications contain headers that can be used to filter emails.

You can set up incoming message filtering in [Yandex.Mail](https://mail.yandex-team.ru/#setup/filters).

| Header | Comment | Example |
| ----- | ----- | ----- |
| X-Startrek | The header means that the email is from {{ tracker-name }} | yes |
| X-Startrek-Key | Issue key | TEST-1 |
| X-Startrek-Priority | Priority | Normal |
| X-Startrek-Reporter | Issue reporter | cheshire.katze@yandex-team.ru |
| X-Startrek-IssueType | Issue type | Task |
| X-Startrek-Assignee | Assignee | cheshire.katze |
| X-Startrek-Tags | Tags | Moving |
| X-Startrek-From | The user who initiated the notification (for example, the author of the latest change to the issue) | cheshire.katze@yandex-team.ru |
| X-Startrek-Cc | Issue followers | cheshire.katze@startrek-cc |
| X-Startrek-Component | Issue components | 5075543ae4b03135cc676db1@startrek-component |
| X-Startrek-QA-Engineer | <q>QA engineer</q> field value. Available only if the field is filled in | cheshire.katze |
| X-Startrek-Changed | Updated fields. Available only if the fields were edited. Missing when cloning and creating an issue. | Followers,Type,Queue,Key,Tags |
| X-Startrek-Fix-Version | Value of the field <q>Fix Version</q> | Release_05.07.2016 |
| X-Startrek-Affected-Version | Value of the field <q>Affected version</q> | 0.1.2 |
| X-Startrek-FingerPrint | Backend MAC address hash | 2b953364 |
| X-Startrek-Old-Status | Old issue status | Testing |
| X-Startrek-New-Status | Current issue status | Testing |
| X-Startrek-Summon | Available if this is a message inviting to comments | Yes |
| X-Startrek-Queue | Issue queue key | TEST |
| X-Startrek-Voted | Available if you voted for this issue | Yes |
| X-Startrek-Favorite | Available if the issue is added to your Favorites | Yes |

[Contact support](../troubleshooting.md)

