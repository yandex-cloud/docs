```bash
set -e

# Getting the instance group ID and current size
IG_SPEC=$(yc compute instance-group get --name "$IG_NAME" --folder-id "$FOLDER_ID" --format json)
IG_ID=$(jq -r ".id" <<< "$IG_SPEC")
IG_SIZE=$(jq -r ".scale_policy.fixed_scale.size" <<< "$IG_SPEC")

# Calculating the new instance group size
if [ "$IG_SIZE" = "$IG_BASE_SIZE" ]; then
    IG_SIZE="$(($IG_BASE_SIZE + 1))"
else
    IG_SIZE="$IG_BASE_SIZE"
fi

# Updating the instance group
yc compute instance-group update --id "$IG_ID" --scale-policy-fixed-scale-size "$IG_SIZE"
```