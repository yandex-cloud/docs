* `mode`: Grouping method. The possible values are:
   * `flat`: Flat grouping. Each group contains a single document. Provided with an empty value for the `attr` parameter.
   * `deep`: Grouping by domain. Each group contains documents from one domain. Provided with the `attr` parameter set to `d`.
   If the parameter is not set, grouping by domain is used.
* `attr`: Service attribute. It depends on the `mode` attribute value.
* `groups-on-page`: Maximum number of groups that can be returned per search results page. The values range from 1 to 100.
* `docs-in-group`: Maximum number of documents that can be returned per group. The values range from 1 to 3. 
