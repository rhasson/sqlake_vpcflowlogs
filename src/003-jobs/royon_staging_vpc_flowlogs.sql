/* create ingestion job to stage VPC flow logs */
create job royon_staging_vpc_flowlogs
  COMPUTE_CLUSTER = "Default Compute"
  --start_from = NOW
  --date_pattern = 'yyyy/MM/dd/HH/mm'
  --content_type = parquet
  as copy from s3 logs_bucket_conn
    bucket = 'dbxflowlog'
    prefix = 'AWSLogs/433987883887/vpcflowlogs/us-east-1'
  into default_glue_catalog.royon.vpcflowlogs_staging_tbl
;
