/* create ingestion job to stage S3 access logs in data lake */
create job royon_staging_s3_access
  COMPUTE_CLUSTER = "Default Compute"
  START_FROM = BEGINNING
  CONTENT_TYPE = (
    TYPE = REGEX
    PATTERN = '^(?<bucketowner>.*?)\s(?<bucket>.*?)\s(?<requesttime>\[.*?\])\s(?<remoteip>.*?)\s(?<requester>.*?)\s(?<requestid>.*?)\s(?<operation>.*?)\s(?<requestkey>.*?)\s(?<requesturi>\".*?\")\s(?<httpstatus>.*?)\s(?<errorcode>.*?)\s(?<bytessent>.*?)\s(?<objectsize>.*?)\s(?<totaltime>.*?)\s(?<turnaroundtime>.*?)\s(?<referer>\".*?\")\s(?<useragent>\".*?\")\s(?<versionid>.*?)$'
    MULTI_LINE = TRUE
    INFER_TYPES = FALSE
  )
  as copy from s3 logs_bucket_conn
    bucket = 'dbxflowlogs3logging'
    prefix = ''
  into default_glue_catalog.royon.s3access_staging_tbl
;