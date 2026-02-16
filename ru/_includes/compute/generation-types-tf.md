* `legacy_features` — блок настроек с описанием параметров при выборе поколения `Gen 1`:

    * `pci_topology` — выбор топологии PCI. Возможные значения:

        * `PCI_TOPOLOGY_V1` — выбор топологии `PCI_TOPOLOGY_V1`.
        * `PCI_TOPOLOGY_V2` — выбор топологии `PCI_TOPOLOGY_V2`.

    Использование блока `legacy_features` делает невозможным использование блока `generation2_features`.
* `generation2_features` — блок настроек для выбора поколения `Gen 2`. При выборе поколения `Gen 2` задавать дополнительные настройки не требуется.

    Использование блока `generation2_features` делает невозможным использование блока `legacy_features`.