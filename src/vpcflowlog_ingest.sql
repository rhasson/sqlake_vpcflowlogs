
-- clean up previous version of the resources
drop job royon_stage_vpc_flowlogs;
drop table default_glue_catalog.royon.vpcflowlogs_stage_tbl;
drop s3 connection royon_s3_conn;

-- Create read-only connection to S3 data source
create s3 connection royon_s3_conn
    aws_role = 'arn:aws:iam::433987883887:role/royon_ro_role'
    external_id = 'ROYON'
    read_only = TRUE
;

-- create staging table in the Glue data catalog
create table default_glue_catalog.royon.vpcflowlogs_stage_tbl;

-- create ingestion job to stage the S3 data in Glue table
create job royon_stage_vpc_flowlogs
  content_type = auto
  as copy from s3 royon_s3_conn
    bucket = 'dbxflowlog'
    prefix = 'AWSLogs/aws-account-id=433987883887/aws-service=vpcflowlogs/aws-region=us-east-1'
  into default_glue_catalog.royon.vpcflowlogs_stage_tbl;
;