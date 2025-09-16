/* Alta3 Research - rzfeeser@alta3.com
   An example of creating an intentional delay with Terraform. In most cases,
   doing something like this should be considered a "work-around". */

terraform {
  required_providers {
    null = {
      source = "hashicorp/null"
      version = "3.1.1"
    }
  }
}

// if no customizations are present
// the provider block is optional
provider "null" {
  # Configuration options
}

resource "null_resource" "next" {
  depends_on = [time_sleep.wait_30_seconds]
}


resource "null_resource" "previous" {
  provisioner "local-exec" {
    command = <<EOT
      echo 'foo' > file.txt
      echo 'Shankar' >> file.txt
    EOT
  }
}

resource "null_resource" "previous2" {
  provisioner "local-exec" {
    command = <<EOT
      echo 'Shankar' >> file2.txt
    EOT
  }
}

resource "time_sleep" "wait_30_seconds" {
  depends_on = [null_resource.previous]
  create_duration = "20s"   // pause this long when a creation occurs
  destroy_duration = "10s"  // pause this long when a destroy occurs
}

resource "time_sleep" "wait_30_seconds22" {
  depends_on = [null_resource.previous2]
  create_duration = "20s"   // pause this long when a creation occurs
  destroy_duration = "10s"  // pause this long when a destroy occurs
}
