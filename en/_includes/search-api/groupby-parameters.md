* `mode`: Grouping method. Possible values:
   * `flat`: Flat grouping. Each group contains a single document. Provided with the `attr` parameter set to Null.
   * `deep`: Grouping by domain. Each group contains documents from one domain. Provided with the `attr` parameter set to `d`.
      If you skip this parameter, grouping by domain is used.
* `attr`: Service attribute. Depends on the `mode` attribute value.
* `groups-on-page`: Maximum number of groups that can be returned per page with search results. Possible values are from 1 to 100.
* `docs-in-group`: Maximum number of documents that can be returned per group. Possible values are from 1 to 3.
