# Filtering incoming emails

Email notifications in {{ tracker-name }} contain headers that can be used for filtering messages.

You can set up filters for incoming emails using [Mail](https://mail.yandex-team.ru/#setup/filters).

| Header | Comments | Example |
| ----- | ----- | ----- |
| X-Startrek | This header indicates a message received from {{ tracker-name }} | yes |
| X-Startrek-Key | Issue key | TEST-1 |
| X-Startrek-Priority | Priority | Normal |
| X-Startrek-Reporter | Issue reporter | cheshire.katze@yandex-team.ru |
| X-Startrek-IssueType | Issue type | Task |
| X-Startrek-Assignee | Assignee | cheshire.katze |
| X-Startrek-Tags | Tags | Relocation |
| X-Startrek-From | The user who initiated sending the notification (for example, the one who updated the issue last) | cheshire.katze@yandex-team.ru |
| X-Startrek-Cc | Issue followers | cheshire.katze@startrek-cc |
| X-Startrek-Component | Issue components | 5075543ae4b03135cc676db1@startrek-component |
| X-Startrek-QA-Engineer | The <q>QA engineer</q> field value. Only available if the field isn't empty | cheshire.katze |
| X-Startrek-Changed | Updated fields. Only available if the field values were edited. Not available when creating an issue | Followers,Type,Queue,Key,Tags |
| X-Startrek-Fix-Version | The <q>Fix Version</q> field value. | Release_05.07.2016 |
| X-Startrek-Affected-Version | The <q>Affected Version</q> field value. | 0.1.2 |
| X-Startrek-FingerPrint | Backend MAC address hash | 2b953364 |
| X-Startrek-Old-Status | Old issue status | Testing |
| X-Startrek-New-Status | Current issue status | Testing |
| X-Startrek-Summon | Present if this is a message about an invitation to comments | Yes |
| X-Startrek-Queue | Key of the issue queue | TEST |
| X-Startrek-Voted | Present if you voted for this issue | Yes |
| X-Startrek-Favorite | Present if the issue is in your favorites | Yes |

