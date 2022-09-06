/* create staging table in the Glue data catalog */
create table default_glue_catalog.royon.vpcflowlogs_staging_tbl
partitioned by $event_date;
