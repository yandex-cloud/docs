```bash
# Get ID and current size of the instance group
IG_SPEC=$(yc compute instance-group get --name $IG_NAME --folder-id $FOLDER_ID --format json)
IG_ID=$(jq -r ".id" <<< $IG_SPEC)
IG_SIZE=$(jq -r ".scale_policy.fixed_scale.size" <<< $IG_SPEC)

# Calculate new size for the instance group
if [ $IG_SIZE = $IG_BASE_SIZE ]; then
    IG_SIZE="$(($IG_BASE_SIZE + 1))"
else
    IG_SIZE=$IG_BASE_SIZE
fi

# Update the instance group
yc compute instance-group update --id $IG_ID --scale-policy-fixed-scale-size $IG_SIZE
```
