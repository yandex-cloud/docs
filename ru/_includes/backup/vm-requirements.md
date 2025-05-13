Минимальные характеристики ВМ и серверов {{ baremetal-name }} для установки и корректной работы агента {{ backup-name }}:

* Объем свободного места на диске:

  * Для ВМ с ОС Linux — 2 ГБ.
  * Для ВМ с ОС Windows — 1,2 ГБ.

* Объем памяти (RAM) — при резервном копировании требуется 1 ГБ RAM на каждый ТБ резервной копии. Объем используемой памяти зависит от объема и типа данных, обрабатываемых [агентом {{ backup-name }}](../../backup/concepts/agent.md).

{% include [agent-ram-usage-paragraph](./operations/agent-ram-usage-paragraph.md) %}

{% include [agent-ram-usage-second-paragraph](./operations/agent-ram-usage-second-paragraph.md) %}

{% include [agent-ram-usage-notice](./operations/agent-ram-usage-notice.md) %}