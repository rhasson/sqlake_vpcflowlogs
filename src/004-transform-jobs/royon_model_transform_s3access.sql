/* read the raw S3 access logs from the staging table
*  model and transform it before writing the output to a new table 
*/

create job royon_model_transform_s3access
  compute_cluster = 'Default Compute'
  add_missing_columns = true
  start_from = NOW
  as insert into default_glue_catalog.mei.s3_access_log_flattened MAP_COLUMNS_BY_NAME 
    unnest (
        select
            matches[].bucketowner as bucket_owner_id,
            matches[].bucket as bucket_name,
            matches[].requesttime::date as request_time_utc,
            matches[].remoteip as remote_ip,
            matches[].requester as requester_id,
            matches[].requestid as request_id,
            matches[].operation as operation,
            matches[].requestkey as request_key,
            matches[].requesturi as request_uri,
            matches[].httpstatus as http_status,
            matches[].errorcode as error_code,
            matches[].bytessent::bigint as bytes_sent,
            matches[].objectsize::bigint as object_size,
            matches[].totaltime::bigint as total_time_ms,
            matches[].turnaroundtime::bigint as turn_around_time_ms,
            matches[].referer as referer,
            matches[].useragent as user_agent,
            matches[].versionid as version_id
        from default_glue_catalog.mei.s3_access_log_staging
        where $commit_time between run_start_time() and run_end_time()
    )
;