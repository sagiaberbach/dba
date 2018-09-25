set define "^"
set echo on
set heading on
set feedback on
set sqlblank on
set sqlprefix off
set timing on
set time on 

spool drop_and_create_tablespaces.log

define DUMP_ID=^1
DEFINE PROCESSED_DUMPS_PATH=^2

DROP USER DMP_^DUMP_ID cascade;
DROP TABLESPACE TBS_STATIC_^DUMP_ID INCLUDING CONTENTS AND DATAFILES;
DROP TABLESPACE TBS_QIN_^DUMP_ID INCLUDING CONTENTS AND DATAFILES;

CREATE BIGFILE TABLESPACE TBS_QIN_^DUMP_ID  DATAFILE 
  '^PROCESSED_DUMPS_PATH.qin_^DUMP_ID..dbf' SIZE 100M AUTOEXTEND ON NEXT 100M MAXSIZE UNLIMITED;

CREATE BIGFILE TABLESPACE TBS_STATIC_^DUMP_ID  DATAFILE 
  '^PROCESSED_DUMPS_PATH.static_^DUMP_ID..dbf' SIZE 100M AUTOEXTEND ON NEXT 100M MAXSIZE UNLIMITED;


CREATE USER DMP_^DUMP_ID IDENTIFIED BY DMP_^DUMP_ID
  default tablespace TBS_STATIC_^DUMP_ID;
GRANT CONNECT,RESOURCE TO DMP_^DUMP_ID;


spool off
exit;

