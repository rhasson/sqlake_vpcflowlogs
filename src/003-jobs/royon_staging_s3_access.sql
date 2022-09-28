/* create ingestion job to stage S3 access logs in data lake */
create job royon_staging_s3_access
  as copy from s3 logs_bucket_conn
    bucket = 'dbxflowlogs3logging'
    prefix = '/'
  into default_glue_catalog.royon.s3access_staging_tbl
  COMPUTE_CLUSTER = "Default Compute"
;