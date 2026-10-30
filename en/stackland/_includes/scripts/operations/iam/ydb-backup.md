```bash
#!/usr/bin/env bash

set -Eeuo pipefail

usage() {
  printf 'Usage: %s [--kubeconfig PATH] [--pvc-size SIZE] [--timeout SECONDS] [OUTPUT_PATH]\n' "$(basename -- "$0")"
}

kubeconfig_flag=""
pvc_size="20Gi"
timeout="3600"
output_argument=""
while (( $# > 0 )); do
  case "$1" in
    --kubeconfig)
      (( $# >= 2 )) || {
        printf 'Missing value for --kubeconfig\n' >&2
        exit 2
      }
      kubeconfig_flag="$2"
      shift 2
      ;;
    --kubeconfig=*)
      kubeconfig_flag="${1#*=}"
      shift
      ;;
    --pvc-size)
      (( $# >= 2 )) || {
        printf 'Missing value for --pvc-size\n' >&2
        exit 2
      }
      pvc_size="$2"
      shift 2
      ;;
    --pvc-size=*)
      pvc_size="${1#*=}"
      shift
      ;;
    --timeout)
      (( $# >= 2 )) || {
        printf 'Missing value for --timeout\n' >&2
        exit 2
      }
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
      [[ -z "${output_argument}" ]] || {
        printf 'Only one output path may be specified\n' >&2
        usage >&2
        exit 2
      }
      output_argument="$1"
      shift
      ;;
  esac
done

if [[ -n "${kubeconfig_flag}" ]]; then
  resolved_kubeconfig_path="${kubeconfig_flag}"
elif [[ -n "${KUBECONFIG:-}" ]]; then
  resolved_kubeconfig_path="${KUBECONFIG}"
elif [[ -n "${HOME:-}" ]]; then
  resolved_kubeconfig_path="${HOME}/.kube/config"
else
  printf 'Cannot resolve kubeconfig: HOME is not set\n' >&2
  exit 2
fi

readonly SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

readonly YDB_NAMESPACE="stackland-iam"
readonly YDB_ENDPOINT="grpcs://ydb-storage-grpc.${YDB_NAMESPACE}.svc.cluster.local:2135"
readonly YDB_DATABASE="/ydb-storage/iam"
readonly YDB_USER="operator"
readonly KUBECONFIG_PATH="${resolved_kubeconfig_path}"
readonly PVC_SIZE="${pvc_size}"
readonly TIMEOUT="${timeout}"
readonly BACKUP_TIMESTAMP="$(date -u +%Y%m%dT%H%M%SZ)"
readonly POD_NAME="ydb-backup"
readonly PVC_NAME="ydb-backup"
readonly OUTPUT_PATH="${output_argument:-${SCRIPT_DIR}/ydb-backup-${BACKUP_TIMESTAMP}.tar.gz}"

POD_CREATED=false
PVC_CREATED=false
STAGING_DIR=""

log() {
  printf '[ydb-backup] %s\n' "$*"
}

fail() {
  printf '[ydb-backup] ERROR: %s\n' "$*" >&2
  exit 1
}

cleanup() {
  local exit_code=$?
  trap - EXIT INT TERM

  if [[ "${POD_CREATED}" == true ]]; then
    log "Deleting Pod ${YDB_NAMESPACE}/${POD_NAME}"
    kubectl --kubeconfig "${KUBECONFIG_PATH}" \
      --namespace "${YDB_NAMESPACE}" \
      delete pod "${POD_NAME}" --ignore-not-found --wait=false >/dev/null || true
  fi

  if [[ "${PVC_CREATED}" == true ]]; then
    log "Deleting PVC ${YDB_NAMESPACE}/${PVC_NAME}"
    kubectl --kubeconfig "${KUBECONFIG_PATH}" \
      --namespace "${YDB_NAMESPACE}" \
      delete pvc "${PVC_NAME}" --ignore-not-found --wait=false >/dev/null || true
  fi

  if [[ -n "${STAGING_DIR}" && -d "${STAGING_DIR}" ]]; then
    rm -rf -- "${STAGING_DIR}"
  fi

  exit "${exit_code}"
}

trap cleanup EXIT
trap 'exit 130' INT
trap 'exit 143' TERM

for command_name in kubectl tar mktemp; do
  command -v "${command_name}" >/dev/null 2>&1 || fail "Required command is not installed: ${command_name}"
done

[[ -f "${KUBECONFIG_PATH}" ]] || fail "Kubeconfig does not exist: ${KUBECONFIG_PATH}"
[[ "${TIMEOUT}" =~ ^[1-9][0-9]*$ ]] || fail "Timeout must be a positive number of seconds"
[[ "${PVC_SIZE}" =~ ^[1-9][0-9]*(Ei|Pi|Ti|Gi|Mi|Ki|E|P|T|G|M|K)?$ ]] \
  || fail "PVC size must be a positive Kubernetes quantity, for example 20Gi"
[[ ! -e "${OUTPUT_PATH}" ]] || fail "Output file already exists: ${OUTPUT_PATH}"

YDB_IMAGE="$(kubectl --kubeconfig "${KUBECONFIG_PATH}" \
  --namespace "${YDB_NAMESPACE}" \
  get statefulset ydb-storage \
  --output jsonpath='{.spec.template.spec.containers[0].image}')"
[[ -n "${YDB_IMAGE}" ]] || fail "Cannot resolve image from StatefulSet ${YDB_NAMESPACE}/ydb-storage"
readonly YDB_IMAGE

output_directory="$(dirname -- "${OUTPUT_PATH}")"
mkdir -p -- "${output_directory}"
STAGING_DIR="$(mktemp -d "${output_directory}/.ydb-backup.XXXXXX")"

log "Deleting stale Pod ${YDB_NAMESPACE}/${POD_NAME}"
kubectl --kubeconfig "${KUBECONFIG_PATH}" \
  --namespace "${YDB_NAMESPACE}" \
  delete pod "${POD_NAME}" --ignore-not-found --wait=true --timeout="${TIMEOUT}s" >/dev/null

log "Deleting stale PVC ${YDB_NAMESPACE}/${PVC_NAME}"
kubectl --kubeconfig "${KUBECONFIG_PATH}" \
  --namespace "${YDB_NAMESPACE}" \
  delete pvc "${PVC_NAME}" --ignore-not-found --wait=true --timeout="${TIMEOUT}s" >/dev/null

log "Creating ${PVC_SIZE} PVC ${YDB_NAMESPACE}/${PVC_NAME} using the default StorageClass"
PVC_CREATED=true
kubectl --kubeconfig "${KUBECONFIG_PATH}" apply -f - <<EOF
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: ${PVC_NAME}
  namespace: ${YDB_NAMESPACE}
  labels:
    app.kubernetes.io/name: ydb
    app.kubernetes.io/component: dump-download
spec:
  accessModes:
    - ReadWriteOnce
  volumeMode: Filesystem
  resources:
    requests:
      storage: ${PVC_SIZE}
EOF

log "Creating Pod ${YDB_NAMESPACE}/${POD_NAME}"
POD_CREATED=true
kubectl --kubeconfig "${KUBECONFIG_PATH}" apply -f - <<EOF
apiVersion: v1
kind: Pod
metadata:
  name: ${POD_NAME}
  namespace: ${YDB_NAMESPACE}
  labels:
    app.kubernetes.io/name: ydb
    app.kubernetes.io/component: dump-download
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
    - name: backup
      image: ${YDB_IMAGE}
      imagePullPolicy: IfNotPresent
      command:
        - /bin/sleep
        - infinity
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
        claimName: ${PVC_NAME}
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

log "Waiting for Pod ${YDB_NAMESPACE}/${POD_NAME}"
kubectl --kubeconfig "${KUBECONFIG_PATH}" \
  --namespace "${YDB_NAMESPACE}" \
  wait --for=condition=Ready "pod/${POD_NAME}" --timeout="${TIMEOUT}s" >/dev/null

log "Creating YDB dump in Pod ${POD_NAME}"
if kubectl --kubeconfig "${KUBECONFIG_PATH}" \
  --namespace "${YDB_NAMESPACE}" \
  exec "${POD_NAME}" --container backup -- \
  timeout "${TIMEOUT}s" \
  /opt/ydb/bin/ydb \
  --ca-file /credentials/ydb/ca.crt \
  -e "${YDB_ENDPOINT}" \
  -d "${YDB_DATABASE}" \
  --user "${YDB_USER}" \
  --password-file /credentials/ydb/password \
  admin database dump \
  --output /backup/database; then
  :
else
  dump_exit_code=$?
  if (( dump_exit_code == 124 )); then
    fail "YDB dump timed out after ${TIMEOUT} seconds"
  fi
  fail "YDB dump failed with exit code ${dump_exit_code}"
fi

log "Downloading /backup/database"
kubectl --kubeconfig "${KUBECONFIG_PATH}" \
  --namespace "${YDB_NAMESPACE}" \
  cp "${POD_NAME}:/backup/database" "${STAGING_DIR}/database" --container backup

# wipe sensitive data
kubectl --kubeconfig "${KUBECONFIG_PATH}" \
  --namespace "${YDB_NAMESPACE}" \
  exec "${POD_NAME}" --container backup -- \
  timeout "${TIMEOUT}s" /bin/sh -eu -c '
    command -v find >/dev/null
    command -v shred >/dev/null
    if [ -d /backup/database ]; then
      find /backup/database -type f -exec shred --iterations=1 --zero --exact -- {} +
    fi
    sync
  ' >/dev/null 2>&1 || true

log "Creating ${OUTPUT_PATH}"
tar -C "${STAGING_DIR}/database" -czf "${STAGING_DIR}/backup.tar.gz" .
tar -tzf "${STAGING_DIR}/backup.tar.gz" >/dev/null \
  || fail "Created backup archive is not readable"
mv -- "${STAGING_DIR}/backup.tar.gz" "${OUTPUT_PATH}"

archive_size="$(du -h "${OUTPUT_PATH}" | awk '{print $1}')"
log "Backup completed: ${OUTPUT_PATH} (${archive_size})"
```
