```bash
DATA=$(cat | jq -sr '.[0].messages[0].details')
ID=$(echo $DATA | jq -r '.image_id')
NAME=$(echo $DATA | jq -r '.repository_name')
TAG=$(echo $DATA | jq -r '.tag')
yc container image scan --id ${ID} --async 1>&2
```