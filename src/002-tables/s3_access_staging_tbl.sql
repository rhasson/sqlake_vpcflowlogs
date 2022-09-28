/* create staging table for S3 access logs */
create table default_glue_catalog.royon.s3access_staging_tbl
  partitioned by $event_date
;