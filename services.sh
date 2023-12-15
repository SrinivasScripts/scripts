# Function to check service status
check_service() {
    SERVICE_NAME="plymouth"
    if ! (service --status-all | grep -E "\[.+\]\s+$SERVICE_NAME" > /dev/null); then
        echo "ERROR: Service $SERVICE_NAME is not running"
        exit 1
    fi
}
# Main function
main() {
     exec > metrics.txt 2>&1
    check_service
    echo "Service Status: Running" >> metrics.txt
        echo "Metrics collected successfully and stored in metrics.txt"
}

# Run the main function
main

