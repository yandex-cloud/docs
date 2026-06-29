* You cannot use the following reserved keys:

  * `tab`
  * `state`
  * `mode`
  * `focus`
  * `grid`
  * `scale`
  * `tz`
  * `timezone`
  * `date`
  * `datetime`
  * `_action_params`
  * `_autoupdate`
  * `_opened_info`
  * `report_page`
  * `preview_mode`

  Parameters with these keys are ignored and not saved.

* Links can only use parameters that are set in the dashboard settings. Otherwise, they are ignored. For example, if a link contains `?product=Furniture`, but the dashboard settings have no `product` parameter (not even with an empty value), this parameter will be ignored.
* Dashboard parameters are applied to widgets anyway. This may lead to errors in data requests.