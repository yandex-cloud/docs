* `mode`: Grouping method. The possible values include:
   * `flat`: Flat grouping. Each group contains a single document. This value is provided with the `attr` parameter set to `null`.
   * `deep`: Grouping by domain. Each group contains documents from one domain. This value is provided with the `attr` parameter set to `d`.
      If you skip this parameter, grouping by domain is used.
* `attr`: Service attribute that depends on the `mode` attribute value.
* `groups-on-page`: Maximum number of groups that can be returned per page with search results. The range of possible values is 1 to 100.
* `docs-in-group`: Maximum number of documents that can be returned per group. The range of possible values is 1 to 3.
