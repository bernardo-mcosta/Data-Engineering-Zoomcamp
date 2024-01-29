variable "project" {
  description = "Project"
  default     = "dtc-de-course-412223"
}

variable "region" {
  description = "Project Location"
  default     = "southamerica-east1"
}

variable "zone" {
  description = "Project zone"
  default     = "southamerica-east1-b"
}


variable "bq_dataset_name" {
  description = "My BigQuery Dataset Name"
  default     = "demo_dataset"
}

variable "gcs_storage_class" {
  description = "Bucket Storage Class"
  default     = "STANDARD"
}

variable "gcs_bucket_name" {
  description = "Bucket Storage Class"
  default     = "dtc-de-course-412223-terra-bucket"
}
