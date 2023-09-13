# Links between issues

By adding links between issues, you can group issues that have the same subject and set mutual dependencies between them.

{{ tracker-name }} has several link types:

Parent issue — Sub-issue
:   You can use this link type to decompose your issues. Break larger project chunks into standalone issues and sub-issues.
:   For example, let's assume you need to implement a new feature in your product, which implies resolving multiple smaller issues. For such cases, you can create a parent issue of the <q>New feature</q> type and link sub-issues to it.

Related to
:  Use this link type to reference other issues with a common topic.

Depends on — Blocker to {#blocker}
:   Use this link type if a certain issue can only be worked on after another issue is completed. For instance, a new app feature that can only enter development once the interface has been designed.

Duplicated by
:  Use this link type to group issues that describe the same task. For example, you should use this link if there are multiple <q>{{ ui-key.startrek.blocks-desktop_queue-new-presets.preset--task-type--bug }}</q> issues describing the same problem.

Epic for — Sub-epic
:   Use this link type to decompose issues if [you're working with Scrum](../manager/create-agile-sprint.md#section_vj5_4f5_zfb).

You can view and edit the link list on the [issue page](ticket-links.md).
