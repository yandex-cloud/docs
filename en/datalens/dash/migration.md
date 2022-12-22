
# Statistics dashboard migration

**[Yandex Dash](https://dash.yandex-team.ru)** is a service for creating dashboards that enables you to pull together data from dozens of different sources.
The service replaced [Statistics dashboards](https://stat.yandex-team.ru/Dashboards) that were [discontinued](https://clubs.at.yandex-team.ru/statistics/1804) in 2020.

## Migration {#migration}

To migrate your dashboard, use a [dedicated page](https://dash.yandex-team.ru/migration).
A new dashboard in Yandex Dash will be created based on the Statistics dashboard scheme.
The original Statistics dashboard is **not deleted** and **can be accesses by the old link**.

Given the architectural specifics, the following items won't be moved from the Statistics dashboard:
* Old managers (use [selectors](../editor/widgets/selector/index.md) instead)
* Browser scripts written in ChartEditor (labeled in the editor as *deprecated*, which you can [migrate separately to Node.js](../editor/node-migration.md))
* Textual charts with wiki markup ([charts with Markdown support](../editor/widgets/markdown/index.md#about-markdown) are available instead)
* Rights to access the dashboard (the new dashboard will inherit the rights of its parent folder)

## Redirect {#redirect}

You can set up redirect from the Statistics dashboards to Yandex Dash.
For this, create a ticket in the CHARTS queue and specify the source and destination for the redirect.
The Statistics dashboard isn't deleted, but you won't be able to access it by a direct link,
so better create a copy somewhere else.
