drop job royon_staging_vpc_flowlogs;
drop table default_glue_catalog.royon.vpcflowlogs_staging_tbl DELETE_DATA = TRUE;
drop connection royon_s3_conn;