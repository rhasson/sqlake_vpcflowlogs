/* create ingestion job to stage the S3 data in Glue table */
create job royon_staging_vpc_flowlogs
  start_from = NOW
  date_pattern = 'yyyy/MM/dd/HH/mm'
  content_type = parquet
  as copy from s3 royon_s3_conn
    bucket = 'dbxflowlog'
    prefix = 'AWSLogs/433987883887/vpcflowlogs/us-east-1'
  into default_glue_catalog.royon.vpcflowlogs_staging_tbl;
;
