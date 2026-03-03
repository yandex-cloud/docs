```bash
#!/bin/bash

# OpenTelemetry Trace Sender Script
# Sends trace data to Monium with realistic timestamps and unique trace IDs

set -euo pipefail

# =============================================================================
# CONFIGURATION VARIABLES
# =============================================================================

# Monium configuration - loaded from environment variables
# MONIUM_PROJECT and MONIUM_API_KEY must be set in the environment
MONIUM_ENDPOINT="ingest.monium.yandex.cloud:443"

# File paths
PROTO_PATH="opentelemetry-proto"
PROTO_FILE="opentelemetry/proto/collector/trace/v1/trace_service.proto"
TRACE_FILE="test_trace_data.json"

# gRPC service
SERVICE_NAME="opentelemetry.proto.collector.trace.v1.TraceService/Export"

# =============================================================================
# COLOR CODES FOR OUTPUT
# =============================================================================

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# =============================================================================
# UTILITY FUNCTIONS
# =============================================================================

# Print colored output
print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1" >&2
}

# Get current time in nanoseconds (cross-platform)
get_current_nanos() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS - use Python for accurate nanosecond timestamps
        python3 -c "import time; print(int(time.time() * 1000000000))"
    else
        # Linux
        date +%s%N
    fi
}

# Generate a new trace ID (16 bytes, base64 encoded)
generate_trace_id() {
    if command -v openssl &> /dev/null; then
        openssl rand -base64 16 | tr -d '\n'
    else
        # Fallback to /dev/urandom
        head -c 16 /dev/urandom | base64 | tr -d '\n'
    fi
}

# Generate random duration variation (±20% of base duration)
generate_random_duration() {
    local base_duration=$1
    local variation=$((base_duration / 5))  # 20% variation
    local min_duration=$((base_duration - variation))
    local max_duration=$((base_duration + variation))
    
    # Generate random number between min and max
    local random_duration=$((min_duration + RANDOM % (max_duration - min_duration + 1)))
    echo $random_duration
}

# Calculate timestamp with offset in milliseconds and random duration
calculate_timestamp() {
    local base_time=$1
    local offset_ms=$2
    local base_duration_ms=$3
    local random_duration_ms=$(generate_random_duration $base_duration_ms)
    local start_time=$((base_time + (offset_ms * 1000000)))
    local end_time=$((start_time + (random_duration_ms * 1000000)))
    echo "$start_time $end_time"
}

# =============================================================================
# VALIDATION FUNCTIONS
# =============================================================================

check_dependencies() {
    print_info "Checking dependencies..."
    
    local missing_deps=()
    
    if ! command -v grpcurl &> /dev/null; then
        missing_deps+=("grpcurl")
    fi
    
    if [ ${#missing_deps[@]} -ne 0 ]; then
        print_error "Missing required dependencies: ${missing_deps[*]}"
        exit 1
    fi
    
    print_success "All dependencies are available"
}

validate_configuration() {
    print_info "Validating configuration..."
    
    # Check if MONIUM_PROJECT is set
    if [[ -z "${MONIUM_PROJECT:-}" ]]; then
        print_error "MONIUM_PROJECT environment variable is not set"
        echo "Please set MONIUM_PROJECT environment variable:"
        echo "  export MONIUM_PROJECT=your-project-name"
        exit 1
    fi
    
    # Check if MONIUM_PROJECT is not empty
    if [[ -z "$MONIUM_PROJECT" ]]; then
        print_error "MONIUM_PROJECT environment variable is empty"
        echo "Please set MONIUM_PROJECT to a valid project name."
        exit 1
    fi
    
    # Check if MONIUM_API_KEY is set
    if [[ -z "${MONIUM_API_KEY:-}" ]]; then
        print_error "MONIUM_API_KEY environment variable is not set"
        echo "Please set MONIUM_API_KEY environment variable:"
        echo "  export MONIUM_API_KEY=your-api-key"
        exit 1
    fi
    
    # Check if MONIUM_API_KEY is not empty
    if [[ -z "$MONIUM_API_KEY" ]]; then
        print_error "MONIUM_API_KEY environment variable is empty"
        echo "Please set MONIUM_API_KEY to a valid API key."
        exit 1
    fi
    
    print_success "Configuration is valid"
}

validate_files() {
    print_info "Validating required files..."
    
    if [[ ! -f "$TRACE_FILE" ]]; then
        print_error "Trace file not found: $TRACE_FILE"
        exit 1
    fi
    
    if [[ ! -d "$PROTO_PATH" ]]; then
        print_error "Proto path not found: $PROTO_PATH"
        exit 1
    fi
    
    local full_proto_path="$PROTO_PATH/$PROTO_FILE"
    if [[ ! -f "$full_proto_path" ]]; then
        print_error "Proto file not found: $full_proto_path"
        exit 1
    fi
    
    print_success "All required files are valid"
}

# =============================================================================
# JSON PROCESSING FUNCTIONS
# =============================================================================

update_trace_json() {
    local input_file="$1"
    local output_file="$2"
    local new_trace_id="$3"
    local base_time="$4"
    
    print_info "Updating trace data with new timestamps and trace ID..."
    
    # Copy input to output first
    cp "$input_file" "$output_file"
    
    # Replace trace ID - escape special characters for sed
    local escaped_trace_id=$(echo "$new_trace_id" | sed 's/[\/&]/\\&/g')
    sed -i.bak "s/not_var{{TRACE_ID}}/$escaped_trace_id/g" "$output_file"
    
    # Define span timings (offset_ms duration_ms)
    local span_timings=(
        "0 500"    "10 50"    "70 420"   "15 40"    "20 30"    "75 410"   "80 60"
        "150 40"   "200 80"   "290 100"  "400 80"   "85 50"    "155 30"   "205 70"
    )
    
    # Build sed script for all replacements
    local sed_script=""
    for i in "${!span_timings[@]}"; do
        local timing=(${span_timings[$i]})
        local offset_ms=${timing[0]}
        local duration_ms=${timing[1]}
        local timestamps=$(calculate_timestamp "$base_time" "$offset_ms" "$duration_ms")
        local start_time=$(echo $timestamps | cut -d' ' -f1)
        local end_time=$(echo $timestamps | cut -d' ' -f2)
        local index=$((i + 1))
        
        sed_script="${sed_script} -e s/not_var{{START_TIME_$index}}/$start_time/g"
        sed_script="${sed_script} -e s/not_var{{END_TIME_$index}}/$end_time/g"
    done
    
    # Apply all replacements in one sed call
    eval sed -i.bak $sed_script "$output_file"
    rm -f "$output_file.bak"
    
    print_success "Trace data updated successfully"
}

# =============================================================================
# TRACE SENDING FUNCTION
# =============================================================================

send_trace() {
    local trace_file=$1
    
    print_info "Sending trace to Monium endpoint: $MONIUM_ENDPOINT"
    print_info "Project: $MONIUM_PROJECT"
    
    # Execute the grpcurl command
    if grpcurl \
        -proto "$PROTO_PATH/$PROTO_FILE" \
        -import-path "$PROTO_PATH" \
        -d @ < "$trace_file" \
        -H "Authorization: Api-Key $MONIUM_API_KEY" \
        -H "x-monium-project: $MONIUM_PROJECT" \
        "$MONIUM_ENDPOINT" \
        "$SERVICE_NAME"; then
        print_success "Trace sent successfully!"
    else
        local exit_code=$?
        print_error "Failed to send trace (exit code: $exit_code)"
        echo
        echo "Common issues:"
        echo "  - Check your API key and project name"
        echo "  - Verify network connectivity to $MONIUM_ENDPOINT"
        echo "  - Ensure the proto files are correct"
        exit $exit_code
    fi
}

# =============================================================================
# CLEANUP FUNCTION
# =============================================================================

cleanup() {
    if [[ -n "${TEMP_FILE:-}" && -f "$TEMP_FILE" ]]; then
        rm -f "$TEMP_FILE"
    fi
}

# =============================================================================
# MAIN FUNCTION
# =============================================================================

main() {
    echo "OpenTelemetry Trace Sender for Monium"
    echo
    
    # Set up cleanup trap
    trap cleanup EXIT
    
    # Run all validations
    check_dependencies
    validate_configuration
    validate_files
    
    echo
    print_info "Starting trace processing..."
    
    # Generate new trace ID
    local new_trace_id
    new_trace_id=$(generate_trace_id)
    
    # Calculate base time (current time - 500ms to account for total span duration)
    local current_nanos base_time
    current_nanos=$(get_current_nanos)
    base_time=$((current_nanos - 500000000))
    
    # Create temporary file for updated JSON
    TEMP_FILE=$(mktemp)
    
    # Update the trace JSON with new timestamps and trace ID
    update_trace_json "$TRACE_FILE" "$TEMP_FILE" "$new_trace_id" "$base_time"
    
    echo
    print_info "Trace data prepared, sending to Monium..."
    echo
    
    # Send the trace
    send_trace "$TEMP_FILE"
    
    echo
    print_success "Trace processing completed successfully!"
}

# =============================================================================
# SCRIPT ENTRY POINT
# =============================================================================

# Check if script is being sourced or executed
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
```