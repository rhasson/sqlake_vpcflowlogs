/* Create read-only connection to S3 data source */
create s3 connection royon_s3_conn3
    aws_role = 'arn:aws:iam::433987883887:role/royon_ro_role'
    external_id = 'ROYON'
    read_only = TRUE
;