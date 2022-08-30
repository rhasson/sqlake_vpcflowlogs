
/* Create read-only connection to S3 data source */
--drop connection royon_s3_conn;
create s3 connection royon_s3_conn
    aws_role = 'arn:aws:iam::433987883887:role/royon_ro_role'
    external_id = 'ROYON'
    read_only = TRUE
;

/* create staging table in the Glue data catalog */
-- drop table default_glue_catalog.royon.vpcflowlogs_stage_tbl DELETE_DATA=TRUE;
create table default_glue_catalog.royon.vpcflowlogs_staging_tbl();

/* create ingestion job to stage the S3 data in Glue table */
create job royon_staging_vpc_flowlogs
  content_type = auto
  as copy from s3 royon_s3_conn
    bucket = 'dbxflowlog'
    prefix = 'AWSLogs/433987883887/vpcflowlogs/us-east-1'
  into default_glue_catalog.royon.vpcflowlogs_staging_tbl;
;

-- clean up previous version of the resources
drop job royon_stage_vpc_flowlogs;
drop table default_glue_catalog.royon.vpcflowlogs_stage_tbl DELETE_DATA=TRUE;
drop connection royon_s3_conn;