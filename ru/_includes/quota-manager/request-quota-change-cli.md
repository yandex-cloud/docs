```bash
yc quota-manager quota-request create \
  --resource-id <идентификатор_облака> \
  --resource-type resource-manager.cloud \
  --desired-limit quota-id=compute.placementGroups.count,value=5 \
  --desired-limit quota-id=storage.buckets.count,value=30
```