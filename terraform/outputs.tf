################################################################################
# Spark
################################################################################

output "spark_arn" {
  description = "Amazon Resource Name (ARN) of the application"
  value       = module.emr_serverless_spark.arn
}

output "spark_id" {
  description = "ID of the application"
  value       = module.emr_serverless_spark.id
}