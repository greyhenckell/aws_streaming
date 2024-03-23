locals {
  name   = "emr-test-serverless-spark"
  region = var.region

  vpc_cidr = "10.0.0.0/16"
  azs      = slice(data.aws_availability_zones.available.names, 0, 3)
}

################################################################################
# Cluster
################################################################################
module "emr_serverless_spark" {
  source  = "terraform-aws-modules/emr/aws//modules/serverless"
  version = "1.1.2"

  name = "${local.name}-demo"

  release_label_prefix = "emr-6"

  initial_capacity = {
    driver = {
      initial_capacity_type = "Driver"

      initial_capacity_config = {
        worker_count = 2
        worker_configuration = {
          cpu    = "2 vCPU"
          memory = "10 GB"
        }
      }
    }

    executor = {
      initial_capacity_type = "Executor"

      initial_capacity_config = {
        worker_count = 2
        worker_configuration = {
          cpu    = "2 vCPU"
          disk   = "32 GB"
          memory = "10 GB"
        }
      }
    }
  }

  maximum_capacity = {
    cpu    = "12 vCPU"
    memory = "100 GB"
  }
}

################################################################################
# Supporting Resources
################################################################################

resource "aws_s3_bucket" "bucket" {
  bucket = "fshdemo-bucket"
}

resource "aws_s3_object" "artifacts" {
  bucket = aws_s3_bucket.bucket.id
  key    = "artifacts/"
}

resource "aws_s3_object" "code" {
  bucket = aws_s3_bucket.bucket.id
  key    = "code/"
}