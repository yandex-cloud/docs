* `legacy_features`: Settings with the description of parameters for `Gen 1`:

    * `pci_topology`: Selecting the PCI topology. The possible values are:

        * `PCI_TOPOLOGY_V1`
        * `PCI_TOPOLOGY_V2`

    The `legacy_features` and `generation2_features` sections are mutually exclusive.
* `generation2_features`: Settings for `Gen 2`. If you select `Gen 2`, you do not need to specify any additional settings.

    The `generation2_features` and `legacy_features` sections are mutually exclusive.