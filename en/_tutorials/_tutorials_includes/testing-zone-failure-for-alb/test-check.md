Make sure traffic has stopped entering the selected zone. You can do this in the [monitoring](../../../monitoring/index.yaml) service by plotting total traffic on your virtual machines' interfaces grouped by availability zone. 

> Currently, you cannot have zone-by-zone traffic distribution plotted through one simple request to the monitoring service. To get this done:
> 1. Create a chart in the monitoring service.
> 1. Create lists of VM IDs for the `ru-central1-a` zone, e.g., using this command:
>    ```
>    yc compute instance list --jq '[.[] | select(.zone_id=="{{ region-id }}-a") | .id ] | join("|")'`
>    ```
>    The command output will be a single-line list of VM IDs separated by `|`. For example: `fhm**********uv5|fhm**********aab|fhm**********ui1|...`. 
> 1. Add a query to the monitoring chart: 
>    ```
>    alias(series_sum("network_received_packets"{folderId = "b1g**********", service = "compute", resource_type = "vm", resource_id = "<delimiter-separated_list_of_VM_IDs_from_previous_step_|>"}), "{{ region-id }}-a")`
>    ```
> 1. Repeat steps 2 and 3 for zones `{{ region-id }}-b` and `{{ region-id }}-d`.
> 1. Run the queries.