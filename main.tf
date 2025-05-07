provider "datadog" {
#Org specific site/keys here
  api_key = var.datadog_api_key
  app_key = var.datadog_app_key
}
#measures cpu on any host
resource "datadog_monitor" "high_cpu" {
  name    = "CPU Usage Alert"
  type    = "metric alert"
  message = "CPU usage is high on {{host.name}}"

  query = <<-EOT
    avg(last_5m):avg:system.cpu.user{*} by {host} > 80
  EOT

  tags = [
    "env:prod",
    "os:linux",
    "region:us-east-1",
    "sev:2"
  ]

  priority = 2

  thresholds {
    critical = 90
    warning  = 80
  }

  notify_no_data = true
}
#high severity monitor
resource "datadog_monitor" "gateway_unavbl_504_errors" {
  name    = "High number of 504 Gateway Timeout errors on {{host.name}}"
  type    = "log alert"
  message = "More than 5 HTTP 504 errors in 5 minutes on host {{host.name}}"

  query = <<-EOT
    logs("status:504 @host:*").index("main").rollup("count").by("host").last("5m") > 5
  EOT

  tags = [
    "sev:1",
    "env:preprod"
  ]

  priority = 1

  thresholds {
    critical = 5
  }

  notify_no_data = false
}
