resource "volterra_cloud_credentials" "aws" {
  name        = format("%s-cred", local.aws_name)
  description = format("AWS credential will be used to create site %s", local.aws_name)
  namespace   = "system"
  aws_secret_key {
    access_key = var.aws_access_key
    secret_key {
      clear_secret_info {
        url = "string:///${base64encode(var.aws_secret_key)}"
      }
    }
  }
}

resource "volterra_aws_vpc_site" "this" {
  name       = local.aws_name
  namespace  = "system"
  aws_region = var.aws_region
  aws_cred {
    name      = volterra_cloud_credentials.aws.name
    namespace = "system"
  }
  vpc {
    vpc_id = aws_vpc.this.id
  }
  disk_size     = var.site_disk_size
  instance_type = var.aws_instance_type

  voltstack_cluster {
    aws_certified_hw = "aws-byol-voltstack-combo"
    az_nodes {
      aws_az_name            = var.aws_az
      local_subnet {
        existing_subnet_id = aws_subnet.volterra_ce["outside"].id
      }
    }
    k8s_cluster {
      name  = local.k8s_name
      namespace = "system"   
    }
  }
}

resource "null_resource" "wait_for_aws_mns" {
  triggers = {
    depends = volterra_aws_vpc_site.this.id
  }
}

resource "volterra_tf_params_action" "apply_aws_vpc" {
  depends_on       = [null_resource.wait_for_aws_mns]
  site_name        = local.aws_name
  site_kind        = "aws_vpc_site"
  action           = "apply"
  wait_for_action  = true
  ignore_on_update = true
}
