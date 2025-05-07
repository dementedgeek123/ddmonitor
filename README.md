# ddmonitor
A sample DD monitor that allows provisioning of two monitors that alerts for CPU high usage as well as latency errors (Status code 504)
No checks for minimum terraform version will be performed as part of this program
Current EOL is at 1.2
Stable LTS version is 3.2 as of 05/07/2025

To run:
Provide internal Datadog keys in line 3 of main.tf and run below commands:

terraform init
terraform plan
terraform apply
