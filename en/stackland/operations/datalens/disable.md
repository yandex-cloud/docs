# Disabling {{ datalens-name }}

## Disabling a component {#disable}

1. Open the `DataLensConfig` resource to edit it:

   ```bash
   kubectl edit datalensconfig main
   ```

1. Set `spec.enabled: false`:

   ```yaml
   spec:
     enabled: false
   ```

1. Save the changes and close the editor.

1. Make sure the component pods were deleted:

   ```bash
   kubectl get pods -n stackland-datalens
   ```

   The list of pods should be empty.

{% note warning %}

Disabling {{ datalens-name }} will delete all data created by this component.

{% endnote %}
