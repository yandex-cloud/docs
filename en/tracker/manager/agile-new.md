# Issue boards (beta version)

New issue boards are a reworked version of the standard [boards in {{ tracker-name }}](../user/agile.md). They help you track and manage your issues in a streamlined manner.

The updated boards look and work quite differently compared to their previous version:

* Issue card management has been improved: you can now use quick actions, create issues in any queue, and update cards automatically.

* Configuring issue cards and board columns has become easier.

* Issue grouping and issue filters have been improved.

* New issue boards are integrated into the [beta version of projects](../user/personal.md#sec_beta) in the updated {{ tracker-name }} interface.

* New issue boards support {% if lang == "ru" %}[Agile development]({{ link-wiki-agile }}){% else %}[Agile development]({{ link-wiki-agile-en }}){% endif %} tools: [issue backlogs](backlog.md) and [sprints](create-agile-sprint.md). Support for planning poker and burn down charts will be added in a while.

* New boards currently don't let you add issues automatically by filters. If you need this feature, you can set up a [trigger](trigger-examples.md#board) that will automatically add issues to the issue board.

New issue boards are available in the beta version. All the missing features previously available on standard issue boards in {{ tracker-name }} will be added to the new boards throughout 2022.

{% note warning %}

Standard issue boards that use the old interface can't be converted into new issue boards.

{% endnote %}

## Getting started {#quick-start}

To get started with the beta version of the new issue board:

* [Create a standard issue board](agile-new-create.md) or a **Scrum** board by enabling the **Try new boards** option.

* Create a [project in the beta version of the new interface](create-project.md#add-tickets). The project board will be created automatically.

You can use the board to group and filter issues, move them between columns, and configure issue card fields.

## See also

* [Configuring issue board columns](agile-new-set.md#cols)

* [Managing issues](agile-new-use.md#manage)

* [Configuring issue cards](agile-new-set.md#cards)

* [Using issue filters on the board](agile-new-use.md#filter)
