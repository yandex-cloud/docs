---
title: "{{ tracker-full-name }} release notes for February 2024"
description: "Check out {{ tracker-full-name }} release notes for February 2024."
---

# {{ tracker-full-name }} release notes: February 2024

* [Updates](#top-news)
* [Fixes and improvements](#fixes)

## Updates {#top-news}


### Cycle time chart, a new widget on dashboards {#cycle-time-widget}

Added a new widget on dashboards: a beta version of the [cycle time](../user/widgets.md#cycle-time) chart. To enable the chart, go to ![image](../../_assets/tracker/svg/settings.svg) **Settings** ⟶ ![image](../../_assets/tracker/svg/interface.svg) **Interface** and enable **Dashboard analytics**.

The widget supports automatic updates and filtering. Fixed certain bugs of the beta version.

### Baselines on a project's Gantt chart {#gantt-baseliness}

Added selection and display of [baselines](../gantt/project.md#baselines) to the Gantt chart settings panel. To open the project baseline panel, click ![image](../../_assets/console-icons/clock-arrow-rotate-left.svg) above the time scale on the right.


## Fixes and improvements {#fixes}

### Changing the order of filters saved on a board {#quick-filters}

You can now set the display order of filters saved on a board. To do this:

1. Click the ![image](../../_assets/console-icons/gear.svg) icon next to filters.
1. Change positions of filters in the **All filters** section by dragging them.
1. Click **Apply**.

### Updated the interface of the _Notifications_ tab {#subscriptions-font-update}

The **Queue settings** → **Notifications** page is now has a new interface.

### _Download all_ button in the project and portfolio description {#all-download-button}

Added **Download all** button in the project and portfolio description allowing to download the archive of all files attached to the description.

### Warning when attempting to add users to whom access is denied {#access-warning}

Now, if you try to add users to whom access to {{ tracker-name }} is denied when setting up access permissions for a queue, a prohibition warning will appear.


### Fixed the error of summon saving on the transition screen in the workflow editor {#call-save-fix}

Fixed the error that prevented saving an employee summon on the [transition screen](../manager/workflow-action-edit.md#screen) when setting up a workflow in the [workflow](../manager/workflow.md) visual editor.

### Fixed macros {#macros-fix}

Fixed operation of [macros](../manager/create-macroses.md): they now open in the sheet on the right rather than a pop-up window, and you can copy information from the issue.

### Default background on boards {#default-background-fix}

Added grey background by default for boards to improve visual perception.
