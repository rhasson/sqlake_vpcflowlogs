/* create a refined table for S3 access logs after it is modeled */
create table default_glue_catalog.royon.s3access_refined_tbl (
    bucket_owner_id string,
    bucket_name string,
    request_time_utc date,
    remote_ip string,
    requester_id string,
    request_id string,
    operation string,
    request_key string,
    request_uri string,
    http_status string,
    error_code string,
    bytes_sent bigint,
    object_size bigint,
    total_time_ms bigint,
    turn_around_time_ms bigint,
    referer string,
    user_agent string,
    version_id string
  )
  partitioned by request_time_utc
COMPUTE_CLUSTER = 'Default Compute';