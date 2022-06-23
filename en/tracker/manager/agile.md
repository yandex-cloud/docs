# Agile development tools

You can use various agile tools and methods to manage issues and projects in {{ tracker-name }}, such as issue boards, sprints, burn down charts, and poker planning.


[Agile software development]({{ link-wiki-agile }}) was initially designed to manage the software development process, but it has since been applied to many other areas. There are several variations of agile methodologies, such as [Scrum]({{ link-wiki-scrum }}) and [Kanban]({{ link-wiki-kanban }}).

For more information, see [{#T}](agile.md#sec_basics).

## Issue boards in {{ tracker-name }} {#sec_boards}

In {{ tracker-name }}, agile tools are grouped on the issue board.


![](../../_assets/tracker/agile-board-c.png)


Managing {{ tracker-name }} boards is similar to [working with a regular sticker board](#dlen_board). Use different board types to manage your workload and monitor your progress with agile methodologies:

- **Basic** boards let you arrange issues in columns based on their status.

- **Scrum** boards allow you to display statuses and offer [sprint](#dlen_sprint) management tools, [issue scoring](planning-poker.md), and [burndown charts](#dlen_burndown).

- The **Kanban** board is similar to the basic board, but all issues with the **Open** status are automatically moved to the [**Backlog**](#dlen_backlog) column.

You can learn more about issue boards:

- [{#T}](create-agile-board.md)
- [{#T}](../user/agile.md)
- [{#T}](create-agile-sprint.md)
- [{#T}](planning-poker.md)
- [{#T}](burndown.md)

## Basic concepts of agile development {#sec_basics}

{{ tracker-name }} uses terms taken from [Scrum]({{ link-wiki-scrum }}):

Backlog {#dlen_backlog}
:   A list of issues or product requirements that must be completed in the project. Backlog issues are usually sorted by priority.

Sprint {#dlen_sprint}
:   Project cycle, usually lasting 1-4 weeks. Each sprint focuses on developing a set of new product features and preparing them for release (an increment).

Planning poker
:   A method for [collaboratively evaluating issue complexity](planning-poker.md) using cards, where team members each rate complexity in [Story Points](#dlen_sp).

Issue board {#dlen_board}
:   A board for tracking the status of issues in the current sprint. Columns on the board correspond to issue statuses. Cards with issue descriptions are pinned to the board and [moved between columns as the issue status updates](../user/agile.md).

Burn down chart {#dlen_burndown}
:   A chart that [shows the completion speed of planned issues](burndown.md) during a sprint and the amount of work remaining.

User Story
:  A <q>User Story</q> is a description of a feature that needs to be implemented in a product as a result of previous experiences or issues faced by users. A User Story is divided into standalone issues. In {{ tracker-name }}, you can use Story issues to [group issues](../user/links.md) based on a common theme.

Story Point {#dlen_sp}
:   A relative rating that describes the effort needed to complete an issue. Usually a story point doesn't directly correlate with the number of work hours needed to solve the problem. [ The team rates issues collectively](planning-poker.md) by comparing them to a simple task.

Epic
:   A larger feature or requirement that can't be implemented within a single sprint. Epics are usually split into multiple User Stories or issues. In {{ tracker-name }}, you can use Epics to [group issues](../user/links.md) based on a common theme.

Sub-epic 
:   An issue that is included in an epic.

