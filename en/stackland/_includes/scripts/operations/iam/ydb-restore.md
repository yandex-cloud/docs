```bash
#!/usr/bin/env bash

set -Eeuo pipefail

usage() {
  printf 'Usage: %s --kubeconfig PATH --storage-class NAME [--timeout SECONDS] BACKUP.tar.gz\n' "$(basename -- "$0")"
}

log() {
  printf '[ydb-restore] %s\n' "$*"
}

fail() {
  printf '[ydb-restore] ERROR: %s\n' "$*" >&2
  exit 1
}

kubectl_target() {
  kubectl --kubeconfig "${KUBECONFIG_PATH}" "$@"
}

kubectl_iam() {
  kubectl_target --namespace "${IAM_NAMESPACE}" "$@"
}

wait_for_deployment_scale_down() {
  local namespace="$1"
  local deployment="$2"
  local selector="$3"
  local pod_name=""
  local -a pod_names=()

  kubectl_target --namespace "${namespace}" scale deployment "${deployment}" --replicas=0
  kubectl_target --namespace "${namespace}" rollout status deployment "${deployment}" \
    --timeout="${TIMEOUT}s"
  while IFS= read -r pod_name; do
    [[ -n "${pod_name}" ]] && pod_names+=("${pod_name}")
  done < <(kubectl_target --namespace "${namespace}" get pod \
    --selector "${selector}" --output name)
  if (( ${#pod_names[@]} > 0 )); then
    kubectl_target --namespace "${namespace}" wait --for=delete "${pod_names[@]}" \
      --timeout="${TIMEOUT}s"
  fi
}

wait_for_any_ready_pod() {
  local namespace="$1"
  local selector="$2"
  local description="$3"
  local deadline=$((SECONDS + TIMEOUT))
  local pod_name=""

  while (( SECONDS < deadline )); do
    while IFS= read -r pod_name; do
      [[ -n "${pod_name}" ]] || continue
      if kubectl_target --namespace "${namespace}" wait \
        --for=condition=Ready "${pod_name}" --timeout=1s >/dev/null 2>&1; then
        log "${description} is ready: ${namespace}/${pod_name#pod/}"
        return
      fi
    done < <(kubectl_target --namespace "${namespace}" get pod \
      --selector "${selector}" --output name)
    sleep 5
  done

  fail "No Ready ${description} Pod found in namespace ${namespace} within ${TIMEOUT} seconds"
}

secret_value() {
  local secret_name="$1"
  local key="$2"

  kubectl_iam get secret "${secret_name}" \
    --output "go-template={{ index .data \"${key}\" | base64decode }}"
}

confirm_restore() {
  local confirmation=""

  printf '\n'
  printf 'Restore YDB from backup\n'
  printf '\n'
  printf '  Cluster:     %s\n' "${target_api_server}"
  printf '  Backup:      %s\n' "${BACKUP_ARCHIVE}"
  printf '  Volume size: %s\n' "${VOLUME_SIZE}"
  printf '  Restore PVC: %s\n' "${RESTORE_PVC_SIZE}"
  printf '\n'
  printf 'WARNING: DESTRUCTIVE OPERATION\n'
  printf '\n'
  printf '  Existing YDB data and all PVCs will be permanently deleted.\n'
  printf '  The cluster will be unavailable during the restore.\n'
  printf '  A failed restore may leave it unavailable until the next attempt.\n'
  printf '\n'
  printf 'Proceed? Type "yes": '

  if ! IFS= read -r confirmation </dev/tty; then
    fail "Cannot read confirmation from the terminal"
  fi
  [[ "${confirmation}" == "yes" ]] \
    || fail "Restore was not confirmed"
}

decimal_at_least() {
  local value="$1"
  local minimum="$2"

  if (( ${#value} > ${#minimum} )); then
    return 0
  fi
  if (( ${#value} < ${#minimum} )); then
    return 1
  fi
  (( 10#${value} >= 10#${minimum} ))
}

volume_size_at_least_100gi() {
  local amount=""
  local suffix=""

  [[ "${VOLUME_SIZE}" =~ ^([1-9][0-9]*)(Ei|Pi|Ti|Gi|Mi|Ki|E|P|T|G|M|K)?$ ]] \
    || return 1
  amount="${BASH_REMATCH[1]}"
  suffix="${BASH_REMATCH[2]:-}"

  case "${suffix}" in
    Ei|Pi|Ti|E|P|T)
      return 0
      ;;
    Gi)
      decimal_at_least "${amount}" 100
      ;;
    G)
      decimal_at_least "${amount}" 108
      ;;
    Mi)
      decimal_at_least "${amount}" 102400
      ;;
    M)
      decimal_at_least "${amount}" 107375
      ;;
    Ki)
      decimal_at_least "${amount}" 104857600
      ;;
    K)
      decimal_at_least "${amount}" 107374183
      ;;
    '')
      decimal_at_least "${amount}" 107374182400
      ;;
  esac
}

confirm_small_volume_size() {
  local confirmation=""

  volume_size_at_least_100gi && return

  printf '\n'
  printf 'WARNING: SMALL YDB VOLUME\n'
  printf '\n'
  printf '  Requested:   %s\n' "${VOLUME_SIZE}"
  printf '  Recommended: at least 100Gi\n'
  printf '\n'
  printf '  Smaller volumes may make YDB unstable.\n'
  printf '\n'
  printf 'Proceed anyway? Type "yes": '

  if ! IFS= read -r confirmation </dev/tty; then
    fail "Cannot read volume size confirmation from the terminal"
  fi
  [[ "${confirmation}" == "yes" ]] \
    || fail "Volume size was not confirmed"
}

target_kubeconfig=""
storage_class=""
volume_size="100Gi"
timeout="3600"
backup_archive=""
while (( $# > 0 )); do
  case "$1" in
    --kubeconfig)
      (( $# >= 2 )) || fail "Missing value for --kubeconfig"
      target_kubeconfig="$2"
      shift 2
      ;;
    --kubeconfig=*)
      target_kubeconfig="${1#*=}"
      shift
      ;;
    --volume-size)
      (( $# >= 2 )) || fail "Missing value for --volume-size"
      volume_size="$2"
      shift 2
      ;;
    --volume-size=*)
      volume_size="${1#*=}"
      shift
      ;;
    --storage-class)
      (( $# >= 2 )) || fail "Missing value for --storage-class"
      storage_class="$2"
      shift 2
      ;;
    --storage-class=*)
      storage_class="${1#*=}"
      shift
      ;;
    --timeout)
      (( $# >= 2 )) || fail "Missing value for --timeout"
      timeout="$2"
      shift 2
      ;;
    --timeout=*)
      timeout="${1#*=}"
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    -*)
      printf 'Unknown option: %s\n' "$1" >&2
      usage >&2
      exit 2
      ;;
    *)
      [[ -z "${backup_archive}" ]] || {
        printf 'Only one backup archive may be specified\n' >&2
        usage >&2
        exit 2
      }
      backup_archive="$1"
      shift
      ;;
  esac
done

[[ -n "${target_kubeconfig}" ]] || {
  printf -- '--kubeconfig must explicitly identify the target cluster\n' >&2
  usage >&2
  exit 2
}
[[ -n "${storage_class}" ]] || {
  printf -- '--storage-class is required\n' >&2
  usage >&2
  exit 2
}
[[ -n "${backup_archive}" ]] || {
  printf 'Backup archive is required\n' >&2
  usage >&2
  exit 2
}

readonly KUBECONFIG_PATH="${target_kubeconfig}"
readonly YDB_STORAGE_CLASS="${storage_class}"
readonly VOLUME_SIZE="${volume_size}"
readonly BACKUP_ARCHIVE="${backup_archive}"
readonly TIMEOUT="${timeout}"
readonly IAM_NAMESPACE="stackland-iam"
readonly IAM_CONFIG_NAME="main"
readonly IAM_CONFIG_RESOURCE="iamconfigs.stackland.yandex.cloud"
readonly IAM_CONFIG_CRD="iamconfigs.stackland.yandex.cloud"
readonly CILIUM_NETWORK_POLICY_CRD="ciliumnetworkpolicies.cilium.io"
readonly RESTORE_STATE_SECRET="ydb-restore-state"
readonly COMPONENT_MANAGER_NAMESPACE="stackland-component-manager"
readonly COMPONENT_MANAGER_DEPLOYMENT="component-manager"
readonly COMPONENT_MANAGER_SELECTOR="control-plane=component-manager,app.kubernetes.io/name=component-manager"
readonly IAM_OPERATOR_DEPLOYMENT="iam-operator"
readonly IAM_OPERATOR_SELECTOR="app.kubernetes.io/name=iam-operator,app.kubernetes.io/instance=iam-operator"
readonly IAM_UBER_DEPLOYMENT="iam-uber"
readonly IAM_UBER_SELECTOR="app=iam-uber"
readonly YDB_RELEASE="ydb"
readonly YDB_STORAGE_NAME="ydb-storage"
readonly YDB_DATABASE_NAME="ydb-database"
readonly YDB_ENDPOINT="grpcs://ydb-storage-grpc.${IAM_NAMESPACE}.svc.cluster.local:2135"
readonly YDB_DATABASE="/ydb-storage/iam"
readonly YDB_USER="operator"
readonly CILIUM_NETWORK_POLICY_NAME="ydb-restore-block-iam-uber"
readonly RESTORE_POD_NAME="ydb-restore"
readonly RESTORE_PVC_NAME="ydb-restore"

WORK_DIR=""
RESTORE_POD_CREATED=false
RESTORE_PVC_CREATED=false

cleanup() {
  local exit_code=$?
  trap - EXIT INT TERM

  if [[ "${RESTORE_POD_CREATED}" == true ]]; then
    log "Deleting restore Pod ${IAM_NAMESPACE}/${RESTORE_POD_NAME}"
    kubectl_iam delete pod "${RESTORE_POD_NAME}" --ignore-not-found --wait=false >/dev/null || true
  fi

  if [[ "${RESTORE_PVC_CREATED}" == true ]]; then
    log "Deleting restore PVC ${IAM_NAMESPACE}/${RESTORE_PVC_NAME}"
    kubectl_iam delete pvc "${RESTORE_PVC_NAME}" --ignore-not-found --wait=false >/dev/null || true
  fi

  if [[ -n "${WORK_DIR}" && -d "${WORK_DIR}" ]]; then
    rm -rf -- "${WORK_DIR}"
  fi

  if (( exit_code != 0 )); then
    printf '[ydb-restore] Recovery stopped after an error. Re-run the same command to continue safely.\n' >&2
  fi
  exit "${exit_code}"
}

trap cleanup EXIT
trap 'exit 130' INT
trap 'exit 143' TERM

for command_name in awk du jq kubectl tar mktemp; do
  command -v "${command_name}" >/dev/null 2>&1 \
    || fail "Required command is not installed: ${command_name}"
done

[[ -f "${KUBECONFIG_PATH}" ]] || fail "Target kubeconfig does not exist: ${KUBECONFIG_PATH}"
[[ -f "${BACKUP_ARCHIVE}" ]] || fail "Backup archive does not exist: ${BACKUP_ARCHIVE}"
[[ "${TIMEOUT}" =~ ^[1-9][0-9]*$ ]] || fail "Timeout must be a positive number of seconds"
[[ "${VOLUME_SIZE}" =~ ^[1-9][0-9]*(Ei|Pi|Ti|Gi|Mi|Ki|E|P|T|G|M|K)?$ ]] \
  || fail "Volume size must be a positive Kubernetes quantity, for example 100Gi"

target_api_server="$(kubectl_target config view --minify --output jsonpath='{.clusters[0].cluster.server}')"
[[ -n "${target_api_server}" ]] || fail "Cannot resolve target Kubernetes API server"

kubectl_target get namespace "${IAM_NAMESPACE}" >/dev/null \
  || fail "Required namespace does not exist: ${IAM_NAMESPACE}"
kubectl_target --namespace "${COMPONENT_MANAGER_NAMESPACE}" \
  get deployment "${COMPONENT_MANAGER_DEPLOYMENT}" >/dev/null \
  || fail "Required Deployment does not exist: ${COMPONENT_MANAGER_NAMESPACE}/${COMPONENT_MANAGER_DEPLOYMENT}"
kubectl_iam get deployment "${IAM_OPERATOR_DEPLOYMENT}" >/dev/null \
  || fail "Required Deployment does not exist: ${IAM_NAMESPACE}/${IAM_OPERATOR_DEPLOYMENT}"
kubectl_iam get deployment "${IAM_UBER_DEPLOYMENT}" >/dev/null \
  || fail "Required Deployment does not exist: ${IAM_NAMESPACE}/${IAM_UBER_DEPLOYMENT}"
kubectl_target get storageclass "${YDB_STORAGE_CLASS}" >/dev/null \
  || fail "Required StorageClass does not exist: ${YDB_STORAGE_CLASS}"
kubectl_target get customresourcedefinition "${CILIUM_NETWORK_POLICY_CRD}" >/dev/null \
  || fail "Required CiliumNetworkPolicy CRD does not exist: ${CILIUM_NETWORK_POLICY_CRD}"

log "Validating backup archive"
tar -tzf "${BACKUP_ARCHIVE}" >/dev/null || fail "Backup archive is not a readable tar.gz file"
backup_entry_count=0
while IFS= read -r archive_entry; do
  normalized_entry="${archive_entry#./}"
  if [[ "${normalized_entry}" == /* ||
        "${normalized_entry}" == ".." ||
        "${normalized_entry}" == ../* ||
        "${normalized_entry}" == */.. ||
        "${normalized_entry}" == */../* ]]; then
    fail "Backup archive contains an unsafe path: ${archive_entry}"
  fi
  [[ -z "${normalized_entry}" ]] || (( backup_entry_count += 1 ))
done < <(tar -tzf "${BACKUP_ARCHIVE}")
(( backup_entry_count > 0 )) || fail "Backup archive is empty"
while IFS= read -r archive_listing; do
  case "${archive_listing:0:1}" in
    l|h)
      fail "Backup archive must not contain symbolic or hard links"
      ;;
  esac
done < <(tar -tvzf "${BACKUP_ARCHIVE}")

WORK_DIR="$(mktemp -d "${TMPDIR:-/tmp}/ydb-restore.XXXXXX")"
readonly ORIGINAL_IAM_CONFIG="${WORK_DIR}/iamconfig.json"
readonly IAM_CONFIG_CEL_PATCH="${WORK_DIR}/iamconfig-cel-patch.json"
readonly BACKUP_DIRECTORY="${WORK_DIR}/database"

mkdir -p -- "${BACKUP_DIRECTORY}"
tar -xzf "${BACKUP_ARCHIVE}" -C "${BACKUP_DIRECTORY}"
[[ -f "${BACKUP_DIRECTORY}/database.pb" && -s "${BACKUP_DIRECTORY}/database.pb" ]] \
  || fail "Backup archive is not a YDB database dump: root database.pb is missing or empty"

backup_size_kib="$(du -sk "${BACKUP_DIRECTORY}" | awk '{print $1}')"
[[ "${backup_size_kib}" =~ ^[0-9]+$ ]] \
  || fail "Cannot calculate the unpacked backup size"
padded_backup_size_kib=$(( (backup_size_kib * 110 + 99) / 100 ))
restore_pvc_size_gib=$(( (padded_backup_size_kib + 1048575) / 1048576 ))
if (( restore_pvc_size_gib < 10 )); then
  restore_pvc_size_gib=10
fi
readonly RESTORE_PVC_SIZE="${restore_pvc_size_gib}Gi"
log "Unpacked backup occupies ${backup_size_kib}Ki; restore PVC size is ${RESTORE_PVC_SIZE}"

confirm_restore
confirm_small_volume_size

# 0. Resolve the YDB image and update retry state.
YDB_IMAGE="$(kubectl_iam get storages.ydb.tech "${YDB_STORAGE_NAME}" \
  --output jsonpath='{.spec.image.name}' 2>/dev/null || true)"
if [[ -n "${YDB_IMAGE}" ]]; then
  log "Updating the retry state with YDB image ${YDB_IMAGE}"
  kubectl_iam create secret generic "${RESTORE_STATE_SECRET}" \
    --from-literal="ydb-image=${YDB_IMAGE}" \
    --dry-run=client --output yaml \
    | kubectl_iam apply --filename -
elif kubectl_iam get secret "${RESTORE_STATE_SECRET}" >/dev/null 2>&1; then
  log "YDB Storage is absent; using the image from Secret ${IAM_NAMESPACE}/${RESTORE_STATE_SECRET}"
  YDB_IMAGE="$(secret_value "${RESTORE_STATE_SECRET}" "ydb-image")"
else
  fail "Cannot resolve the YDB image and retry Secret ${IAM_NAMESPACE}/${RESTORE_STATE_SECRET} does not exist"
fi

[[ -n "${YDB_IMAGE}" ]] || fail "Resolved YDB image is empty"
readonly YDB_IMAGE
log "Using YDB image ${YDB_IMAGE} and StorageClass ${YDB_STORAGE_CLASS}"

# 1. Stop component-manager.
log "Scaling ${COMPONENT_MANAGER_NAMESPACE}/${COMPONENT_MANAGER_DEPLOYMENT} to 0"
wait_for_deployment_scale_down \
  "${COMPONENT_MANAGER_NAMESPACE}" "${COMPONENT_MANAGER_DEPLOYMENT}" "${COMPONENT_MANAGER_SELECTOR}"

# 2. Stop IAM workloads.
log "Scaling ${IAM_NAMESPACE}/${IAM_OPERATOR_DEPLOYMENT} to 0"
wait_for_deployment_scale_down \
  "${IAM_NAMESPACE}" "${IAM_OPERATOR_DEPLOYMENT}" "${IAM_OPERATOR_SELECTOR}"
log "Scaling ${IAM_NAMESPACE}/${IAM_UBER_DEPLOYMENT} to 0"
wait_for_deployment_scale_down \
  "${IAM_NAMESPACE}" "${IAM_UBER_DEPLOYMENT}" "${IAM_UBER_SELECTOR}"

# 3. Delete the existing YDB Helm release without Helm.
log "Removing finalizers from YDB ServiceAccounts"
while IFS= read -r service_account_name; do
  [[ -n "${service_account_name}" ]] || continue
  kubectl_iam patch serviceaccount "${service_account_name}" \
    --type=merge --patch '{"metadata":{"finalizers":null}}'
done < <(kubectl_iam get serviceaccounts \
  --selector "app.kubernetes.io/instance=${YDB_RELEASE},app.kubernetes.io/managed-by=Helm" \
  --output jsonpath='{range .items[*]}{.metadata.name}{"\n"}{end}')

log "Deleting resources of Helm release ${IAM_NAMESPACE}/${YDB_RELEASE} without Helm"
kubectl_iam delete databases.ydb.tech \
  --selector "app.kubernetes.io/instance=${YDB_RELEASE},app.kubernetes.io/managed-by=Helm" \
  --ignore-not-found --wait=true --timeout="${TIMEOUT}s"
kubectl_iam delete storages.ydb.tech \
  --selector "app.kubernetes.io/instance=${YDB_RELEASE},app.kubernetes.io/managed-by=Helm" \
  --ignore-not-found --wait=true --timeout="${TIMEOUT}s"
kubectl_iam delete persistentvolumeclaims \
  --selector "ydb.tech/statefulset-name=${YDB_STORAGE_NAME}" \
  --ignore-not-found --wait=true --timeout="${TIMEOUT}s"

while IFS= read -r resource_type; do
  [[ -n "${resource_type}" ]] || continue
  RELEASE_RESOURCES=()
  while IFS= read -r release_resource; do
    [[ -n "${release_resource}" ]] && RELEASE_RESOURCES+=("${release_resource}")
  done < <(kubectl_iam get "${resource_type}" \
    --selector "app.kubernetes.io/instance=${YDB_RELEASE},app.kubernetes.io/managed-by=Helm" \
    --output name --ignore-not-found 2>/dev/null || true)
  if (( ${#RELEASE_RESOURCES[@]} > 0 )); then
    kubectl_iam delete "${RELEASE_RESOURCES[@]}" \
      --ignore-not-found --wait=true --timeout="${TIMEOUT}s"
  fi
done < <(kubectl_target api-resources --verbs=list,delete --namespaced --output name)

kubectl_iam delete secret --selector "owner=helm,name=${YDB_RELEASE}" \
  --ignore-not-found --wait=true --timeout="${TIMEOUT}s"
log "Helm release ${IAM_NAMESPACE}/${YDB_RELEASE} resources deleted"

# 4. Update IAMConfig in place.
kubectl_target get "${IAM_CONFIG_RESOURCE}" "${IAM_CONFIG_NAME}" \
  --output json >"${ORIGINAL_IAM_CONFIG}" \
  || fail "Required IAMConfig does not exist: ${IAM_CONFIG_NAME}"

log "Temporarily removing all IAMConfig CEL rules"
kubectl_target get customresourcedefinition "${IAM_CONFIG_CRD}" --output json \
  | jq '[
      paths(type == "object" and has("x-kubernetes-validations")) as $path
      | {
          op: "remove",
          path: (
            "/" + (
              ($path + ["x-kubernetes-validations"])
              | map(tostring | gsub("~"; "~0") | gsub("/"; "~1"))
              | join("/")
            )
          )
        }
    ]' >"${IAM_CONFIG_CEL_PATCH}"
kubectl_target patch customresourcedefinition "${IAM_CONFIG_CRD}" \
  --type=json --patch-file "${IAM_CONFIG_CEL_PATCH}"

restore_iam_config_patch="$(jq --null-input --compact-output \
  --arg storage_class "${YDB_STORAGE_CLASS}" --arg volume_size "${VOLUME_SIZE}" '
    {
      spec: {
        settings: {
          ydb: {
            storage: {
              disksPerNode: 3,
              groupsCount: 1,
              storageClass: $storage_class,
              volumeSize: $volume_size
            }
          }
        }
      }
    }
  ')"

log "Updating IAMConfig ${IAM_CONFIG_NAME} YDB storage settings in place"
kubectl_target patch "${IAM_CONFIG_RESOURCE}" "${IAM_CONFIG_NAME}" \
  --type=merge --patch "${restore_iam_config_patch}"

restore_iam_status_patch="$(jq --compact-output '
    (.status // {}) as $status
    | {
        status: (
          reduce [
            "ydbStorageReady",
            "ydbDiskExpand",
            "ydbGroupExpand",
            "ydbCurrentGroupsCount",
            "ydbDatabaseReady",
            "ydbStorageInitialized"
          ][] as $field (
            {};
            if ($status | type) == "object" and ($status | has($field)) then
              . + {($field): null}
            else
              .
            end
          )
          + if ($status | type) == "object" and
              ($status.conditions | type) == "array" and
              any($status.conditions[]; .type == "YDBStorageReady" or .type == "YDBDatabaseReady") then
            {
              conditions: [
                $status.conditions[]
                | select(
                    .type != "YDBStorageReady" and
                    .type != "YDBDatabaseReady"
                  )
              ]
            }
          else
            {}
            end
        )
      }
  ' "${ORIGINAL_IAM_CONFIG}")"

log "Removing YDB fields from IAMConfig ${IAM_CONFIG_NAME} status"
kubectl_target patch "${IAM_CONFIG_RESOURCE}" "${IAM_CONFIG_NAME}" \
  --subresource=status --type=merge --patch "${restore_iam_status_patch}"

# 5. Isolate iam-uber from YDB.
log "Blocking egress from iam-uber while YDB is restored"
kubectl_target apply --filename - <<EOF
apiVersion: cilium.io/v2
kind: CiliumNetworkPolicy
metadata:
  name: ${CILIUM_NETWORK_POLICY_NAME}
  namespace: ${IAM_NAMESPACE}
spec:
  endpointSelector:
    matchLabels:
      app: iam-uber
  egressDeny:
    - toEntities:
        - all
EOF
kubectl_iam get "ciliumnetworkpolicy/${CILIUM_NETWORK_POLICY_NAME}" >/dev/null
log "Waiting for CiliumNetworkPolicy propagation"
# CiliumNetworkPolicy has no portable readiness condition confirming propagation to every Cilium agent.
sleep 30

# 6. Create and obliterate the new YDB storage PVCs.
log "Deleting stale restore and disk preparation workloads"
kubectl_iam delete pod "${RESTORE_POD_NAME}" --ignore-not-found --wait=true --timeout="${TIMEOUT}s"
kubectl_iam delete jobs \
  ydb-restore-obliterate-0 \
  ydb-restore-obliterate-1 \
  ydb-restore-obliterate-2 \
  --ignore-not-found --wait=true --timeout="${TIMEOUT}s"

YDB_PVCS=()
for node_index in 0 1 2; do
  for disk_number in 0 1 2; do
    printf -v disk_index '%02d' "${disk_number}"
    YDB_PVCS+=("${YDB_STORAGE_NAME}-${disk_index}-${YDB_STORAGE_NAME}-${node_index}")
  done
done

log "Deleting old YDB storage PVCs"
kubectl_iam delete pvc --selector "ydb.tech/statefulset-name=${YDB_STORAGE_NAME}" \
  --ignore-not-found --wait=true --timeout="${TIMEOUT}s"

log "Creating nine ${VOLUME_SIZE} YDB storage PVCs"
for pvc_name in "${YDB_PVCS[@]}"; do
  kubectl_target apply --filename - <<EOF
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: ${pvc_name}
  namespace: ${IAM_NAMESPACE}
  labels:
    ydb.tech/statefulset-name: ${YDB_STORAGE_NAME}
spec:
  accessModes:
    - ReadWriteOnce
  volumeMode: Block
  storageClassName: ${YDB_STORAGE_CLASS}
  resources:
    requests:
      storage: ${VOLUME_SIZE}
EOF
done

OBLITERATE_JOBS=()
log "Creating disk obliterate Jobs"
for node_index in 0 1 2; do
  obliterate_job="ydb-restore-obliterate-${node_index}"
  OBLITERATE_JOBS+=("${obliterate_job}")
  kubectl_target apply --filename - <<EOF
apiVersion: batch/v1
kind: Job
metadata:
  name: ${obliterate_job}
  namespace: ${IAM_NAMESPACE}
  labels:
    app.kubernetes.io/name: ydb
    app.kubernetes.io/component: ydb-restore-disk-obliterate
spec:
  backoffLimit: 0
  activeDeadlineSeconds: ${TIMEOUT}
  template:
    metadata:
      labels:
        app.kubernetes.io/name: ydb
        app.kubernetes.io/component: ydb-restore-disk-obliterate
    spec:
      automountServiceAccountToken: false
      restartPolicy: Never
      priorityClassName: stackland-system
      affinity:
        podAntiAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
            - labelSelector:
                matchLabels:
                  app.kubernetes.io/component: ydb-restore-disk-obliterate
              topologyKey: kubernetes.io/hostname
      containers:
        - name: obliterate
          image: ${YDB_IMAGE}
          imagePullPolicy: IfNotPresent
          command:
            - /bin/bash
            - -c
            - |
              set -Eeuo pipefail
              for device in /dev/kikimr_ssd_00 /dev/kikimr_ssd_01 /dev/kikimr_ssd_02; do
                /opt/ydb/bin/ydbd admin blobstorage disk obliterate "\${device}"
              done
          securityContext:
            runAsUser: 0
            privileged: true
            capabilities:
              add:
                - SYS_RAWIO
          volumeDevices:
            - name: disk-00
              devicePath: /dev/kikimr_ssd_00
            - name: disk-01
              devicePath: /dev/kikimr_ssd_01
            - name: disk-02
              devicePath: /dev/kikimr_ssd_02
      volumes:
        - name: disk-00
          persistentVolumeClaim:
            claimName: ${YDB_STORAGE_NAME}-00-${YDB_STORAGE_NAME}-${node_index}
        - name: disk-01
          persistentVolumeClaim:
            claimName: ${YDB_STORAGE_NAME}-01-${YDB_STORAGE_NAME}-${node_index}
        - name: disk-02
          persistentVolumeClaim:
            claimName: ${YDB_STORAGE_NAME}-02-${YDB_STORAGE_NAME}-${node_index}
EOF
done

for obliterate_job in "${OBLITERATE_JOBS[@]}"; do
  log "Waiting for disk preparation Job ${IAM_NAMESPACE}/${obliterate_job}"
  if ! kubectl_iam wait --for=condition=Complete "job/${obliterate_job}" --timeout="${TIMEOUT}s"; then
    kubectl_iam logs "job/${obliterate_job}" --all-containers=true --prefix=true || true
    fail "Disk preparation Job failed or timed out: ${IAM_NAMESPACE}/${obliterate_job}"
  fi
done

for pvc_name in "${YDB_PVCS[@]}"; do
  kubectl_iam annotate pvc "${pvc_name}" ydb.tech/disk-obliterated=true --overwrite
done
kubectl_iam delete jobs "${OBLITERATE_JOBS[@]}" --wait=true --timeout="${TIMEOUT}s"
log "YDB storage PVCs prepared"

# 7. Start component-manager.
log "Scaling ${COMPONENT_MANAGER_NAMESPACE}/${COMPONENT_MANAGER_DEPLOYMENT} to 1"
kubectl_target --namespace "${COMPONENT_MANAGER_NAMESPACE}" \
  scale deployment "${COMPONENT_MANAGER_DEPLOYMENT}" --replicas=1
kubectl_target --namespace "${COMPONENT_MANAGER_NAMESPACE}" \
  rollout status deployment "${COMPONENT_MANAGER_DEPLOYMENT}" --timeout="${TIMEOUT}s"

# 8. Wait for YDB Storage and Database to become ready.
log "Waiting for Storage ${IAM_NAMESPACE}/${YDB_STORAGE_NAME}"
kubectl_iam wait --for=create "storages.ydb.tech/${YDB_STORAGE_NAME}" --timeout="${TIMEOUT}s"
kubectl_iam wait "storages.ydb.tech/${YDB_STORAGE_NAME}" \
  --for=jsonpath='{.status.state}'=Ready --timeout="${TIMEOUT}s"

log "Waiting for Database ${IAM_NAMESPACE}/${YDB_DATABASE_NAME}"
kubectl_iam wait --for=create "databases.ydb.tech/${YDB_DATABASE_NAME}" --timeout="${TIMEOUT}s"
kubectl_iam wait "databases.ydb.tech/${YDB_DATABASE_NAME}" \
  --for=jsonpath='{.status.state}'=Ready --timeout="${TIMEOUT}s"

# 9. Upload and restore the database backup.
log "Deleting stale restore PVC ${IAM_NAMESPACE}/${RESTORE_PVC_NAME}"
kubectl_iam delete pvc "${RESTORE_PVC_NAME}" \
  --ignore-not-found --wait=true --timeout="${TIMEOUT}s"

log "Creating ${RESTORE_PVC_SIZE} restore PVC ${IAM_NAMESPACE}/${RESTORE_PVC_NAME}"
RESTORE_PVC_CREATED=true
kubectl_target apply --filename - <<EOF
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: ${RESTORE_PVC_NAME}
  namespace: ${IAM_NAMESPACE}
  labels:
    app.kubernetes.io/name: ydb
    app.kubernetes.io/component: database-restore
spec:
  accessModes:
    - ReadWriteOnce
  volumeMode: Filesystem
  storageClassName: ${YDB_STORAGE_CLASS}
  resources:
    requests:
      storage: ${RESTORE_PVC_SIZE}
EOF

log "Creating restore Pod ${IAM_NAMESPACE}/${RESTORE_POD_NAME}"
RESTORE_POD_CREATED=true
kubectl_target apply --filename - <<EOF
apiVersion: v1
kind: Pod
metadata:
  name: ${RESTORE_POD_NAME}
  namespace: ${IAM_NAMESPACE}
  labels:
    app.kubernetes.io/name: ydb
    app.kubernetes.io/component: database-restore
spec:
  automountServiceAccountToken: false
  restartPolicy: Never
  securityContext:
    runAsNonRoot: true
    runAsUser: 65532
    runAsGroup: 65532
    fsGroup: 65532
    seccompProfile:
      type: RuntimeDefault
  containers:
    - name: restore
      image: ${YDB_IMAGE}
      imagePullPolicy: IfNotPresent
      command:
        - /bin/bash
        - -c
        - sleep infinity
      env:
        - name: HOME
          value: /tmp
      securityContext:
        allowPrivilegeEscalation: false
        capabilities:
          drop:
            - ALL
      volumeMounts:
        - name: backup
          mountPath: /backup
        - name: ydb-ca
          mountPath: /credentials/ydb/ca.crt
          subPath: ca.crt
          readOnly: true
        - name: ydb-password
          mountPath: /credentials/ydb/password
          subPath: password
          readOnly: true
  volumes:
    - name: backup
      persistentVolumeClaim:
        claimName: ${RESTORE_PVC_NAME}
    - name: ydb-ca
      secret:
        secretName: ydb-storage-grpc-tls
        items:
          - key: ca.crt
            path: ca.crt
    - name: ydb-password
      secret:
        secretName: ydb-storage-operator-user
        items:
          - key: password
            path: password
EOF
kubectl_iam wait --for=condition=Ready "pod/${RESTORE_POD_NAME}" --timeout="${TIMEOUT}s"

log "Checking database ${YDB_DATABASE} availability"
readiness_attempts=$(( (TIMEOUT + 4) / 5 ))
for (( attempt = 1; attempt <= readiness_attempts; attempt++ )); do
  if kubectl_iam exec "${RESTORE_POD_NAME}" --container restore -- \
    /opt/ydb/bin/ydb \
    --ca-file /credentials/ydb/ca.crt \
    -e "${YDB_ENDPOINT}" \
    -d "${YDB_DATABASE}" \
    --user "${YDB_USER}" \
    --password-file /credentials/ydb/password \
    scheme ls >/dev/null 2>&1; then
    break
  fi
  if (( attempt == readiness_attempts )); then
    fail "Database ${YDB_DATABASE} did not become available within ${TIMEOUT} seconds"
  fi
  sleep 5
done

log "Uploading backup into Pod ${IAM_NAMESPACE}/${RESTORE_POD_NAME}"
kubectl_iam exec "${RESTORE_POD_NAME}" --container restore -- /bin/mkdir -p /backup/database
kubectl_iam cp "${BACKUP_DIRECTORY}/." "${RESTORE_POD_NAME}:/backup/database" --container restore

log "Restoring ${YDB_DATABASE}"
if kubectl_iam exec "${RESTORE_POD_NAME}" --container restore -- \
  timeout "${TIMEOUT}s" \
  /opt/ydb/bin/ydb \
  --ca-file /credentials/ydb/ca.crt \
  -e "${YDB_ENDPOINT}" \
  -d "${YDB_DATABASE}" \
  --user "${YDB_USER}" \
  --password-file /credentials/ydb/password \
  --assume-yes \
  admin database restore \
  --input /backup/database; then
  :
else
  restore_exit_code=$?
  if (( restore_exit_code == 124 )); then
    fail "YDB restore timed out after ${TIMEOUT} seconds"
  fi
  fail "YDB restore failed with exit code ${restore_exit_code}"
fi
log "Database ${YDB_DATABASE} restored successfully"

# wipe sensitive data
kubectl_iam exec "${RESTORE_POD_NAME}" --container restore -- \
  timeout "${TIMEOUT}s" /bin/sh -eu -c '
    command -v find >/dev/null
    command -v shred >/dev/null
    if [ -d /backup/database ]; then
      find /backup/database -type f -exec shred --iterations=1 --zero --exact -- {} +
    fi
    sync
  ' >/dev/null 2>&1 || true

kubectl_iam delete pod "${RESTORE_POD_NAME}" --wait=true --timeout="${TIMEOUT}s"
RESTORE_POD_CREATED=false
kubectl_iam delete pvc "${RESTORE_PVC_NAME}" --wait=true --timeout="${TIMEOUT}s"
RESTORE_PVC_CREATED=false

# 10. Restore iam-uber connectivity.
log "Restoring network access for iam-uber"
kubectl_iam delete ciliumnetworkpolicy "${CILIUM_NETWORK_POLICY_NAME}" \
  --ignore-not-found --wait=true --timeout="${TIMEOUT}s"

# 11. Start IAM workloads.
log "Scaling ${IAM_NAMESPACE}/${IAM_UBER_DEPLOYMENT} to 1"
kubectl_iam scale deployment "${IAM_UBER_DEPLOYMENT}" --replicas=1
log "Waiting for any Ready ${IAM_NAMESPACE}/${IAM_UBER_DEPLOYMENT} Pod"
wait_for_any_ready_pod "${IAM_NAMESPACE}" "${IAM_UBER_SELECTOR}" "${IAM_UBER_DEPLOYMENT}"

log "Scaling ${IAM_NAMESPACE}/${IAM_OPERATOR_DEPLOYMENT} to 1"
kubectl_iam scale deployment "${IAM_OPERATOR_DEPLOYMENT}" --replicas=1
log "Waiting for any Ready ${IAM_NAMESPACE}/${IAM_OPERATOR_DEPLOYMENT} Pod"
wait_for_any_ready_pod "${IAM_NAMESPACE}" "${IAM_OPERATOR_SELECTOR}" "${IAM_OPERATOR_DEPLOYMENT}"

log "Removing restore state Secret"
kubectl_iam delete secret "${RESTORE_STATE_SECRET}" \
  --ignore-not-found --wait=false >/dev/null

log "Restore completed successfully"
```
