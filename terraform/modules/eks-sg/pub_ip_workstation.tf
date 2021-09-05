// This data is provided temporary only, in production we should use valid IP ranges

data "http" "workstation-external-ip" {
  url = "http://ipv4.icanhazip.com"
}

// We can override with variable or hardcoded value if necessary

locals {
  workstation-external-cidr = "${chomp(data.http.workstation-external-ip.body)}/32"
}

