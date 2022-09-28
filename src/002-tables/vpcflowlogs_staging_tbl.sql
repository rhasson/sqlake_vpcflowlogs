/* create staging table for vpc flow logs */
create table default_glue_catalog.royon.vpcflowlogs_staging_tbl
  partitioned by $event_date
;
