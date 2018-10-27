package com.arkentos.util.varlist;

/**
 *
 * @author jayana_i
 */
public class MessageVarList {

    public static final String COMMON_ERROR_PROCESS = "error occurred while processing";
    public static final String COMMON_NOT_EXISTS = "Record does not exist.";
    public static final String COMMON_NOT_DELETE = "Record cannot be deleted";
    public static final String COMMON_ALREADY_EXISTS = "Record already exists";
    public static final String COMMON_ALREADY_IN_USE = "Record already in use.";
    public static final String COMMON_SUCC_INSERT = "created successfully";
    public static final String COMMON_SUCC_UPDATE = "updated successfully";

    public static final String COMMON_ERROR_UPDATE = "Error occurred while updating";
    public static final String COMMON_SUCC_DELETE = "deleted successfully";

    public static final String COMMON_SUCC_CONFIRM = "Confirmed successfully";
    public static final String ALREADY_CONFIRM = "Already confirmed";
    public static final String COMMON_ERROR_DELETE = "Error occurred while deleting";
    public static final String COMMON_SUCC_ASSIGN = "assigned successfully";
    public static final String COMMON_SUCC_ACTIVATE = "Activated successfully";
    public static final String COMMON_ERROR_ACTIVATE = "Error occurred while activating";
    public static final String COMMON_WARN_CHANGE_PASSWORD = "Your password will expire ";
    //--------------------Login---------------//
    public static final String LOGIN_EMPTY_USERNAME = "Username or Password cannot be empty";
    public static final String LOGIN_EMPTY_PASSWORD = "Username or Password cannot be empty";
    public static final String LOGIN_INVALID = "Your login attempt was not successful. Please try again.";
    public static final String LOGIN_ERROR_LOAD = "Cannot login. Please contact administrator";
    public static final String LOGIN_DEACTIVE = "User has been deactivated. Please contact administrator";
    public static final String LOGIN_USERROLE_BLOCK = "Merchant users cannot login. Please contact administrator.";
    
    public static final String PASSWORDRESET_EMPTY_PASSWORD = "Password cannot be empty";
    public static final String PASSWORDRESET_EMPTY_COM_PASSWORD = "Confirm password cannot be empty";
    public static final String PASSWORDRESET_MATCH_PASSWORD = "Passwords mismatched.";
    public static final String PASSWORDRESET_INVALID_CURR_PWD = "Current password invalid";
    // --------------------Task Management---------------//
    public static final String TASK_MGT_EMPTY_TASK_CODE = "Task code cannot be empty";
    public static final String TASK_MGT_EMPTY_DESCRIPTION = "Description cannot be empty";
    public static final String TASK_MGT_EMPTY_SORTKEY = "Sort key cannot be empty";
    public static final String TASK_MGT_EMPTY_STATUS = "Status cannot be empty";
    public static final String TASK_MGT_ERROR_SORTKEY_INVALID = "Sort key invalid";
    public static final String TASK_MGT_ERROR_DESC_INVALID = "Description invalid";
    public static final String TASK_MGT_ERROR_TASKCODE_INVALID = "Task code invalid";
    //--------------------- Password policy management-------------//
    public static final String PASSPOLICY_MINLEN_INVALID = "Minimum length should be equal or greater than ";
//    public static final String PASSPOLICY_MINLEN_INVALID = "Minimum length should be greater than ";
    public static final String PASSPOLICY_MAXLEN_INVALID = "Maximum length should not exceed ";
    public static final String PASSPOLICY_MINLEN_EMPTY = "Minimum length can not be empty";
    public static final String PASSPOLICY_MAXLEN_EMPTY = "Maximum length can not be empty";
    public static final String PASSPOLICY_MIN_MAX_LENGHT_DIFF = "Maximum length should be greater than the minimum length";
    public static final String PASSPOLICY_SPECCHARS_EMPTY = "Entered special characters allowed";
    public static final String PASSPOLICY_MINSPECCHARS_EMPTY = "Special characters cannot be empty";
    public static final String PASSPOLICY_MINUPPER_EMPTY = "Uppercase characters cannot be empty";
    public static final String PASSPOLICY_MINNUM_EMPTY = "Numerical characters cannot be empty";
    public static final String PASSPOLICY_MINLOWER_EMPTY = "Lowercase characters cannot be empty";
    public static final String PASSPOLICY_SUCCESS_ADD = "Password policy successfully added";
    public static final String PASSPOLICY_SUCCESS_DELETE = "Password policy successfully deleted";
    public static final String PASSPOLICY_SUCCESS_UPDATE = "Password policy successfully updated";
    public static final String PASSPOLICY_STATUS_EMPTY = "Select status";
    public static final String PASSPOLICY_POLICYID_EMPTY = "Password policy ID cannot be empty";
    public static final String PASSPOLICY_REPEATE_CHARACTERS_EMPTY = "Allowed repeat characters cannot be empty";
    public static final String PASSPOLICY_INIT_PASSWORD_EXPIRY_STATUS_EMPTY = "Initial password expiry status cannot be empty";
    public static final String PASSPOLICY_PASSWORD_EXPIRY_PERIOD_EMPTY = "Password expiry period cannot be empty";
    public static final String PASSPOLICY_NO_OF_HISTORY_PASSWORD_EMPTY = "No. of history passwords cannot be empty";
    public static final String PASSPOLICY_MIN_PASSWORD_CHANGE_PERIOD_EMPTY = "Password expiry notification period cannot be empty";
    public static final String PASSPOLICY_IDLE_ACCOUNT_EXPIRY_PERIOD_EMPTY = "Idle account expiry period cannot be empty";
    public static final String PASSPOLICY_IDLE_ACCOUNT_EXPIRY_PERIOD_INVALID = "Idle account expiry period should be 10 days or above";
    public static final String PASSPOLICY_PASSWORD_EXPIRY_PERIOD_INVALID = "Password expiry period should be 10 days or above";
    public static final String PASSPOLICY_NO_OF_INVALID_LOGIN_ATTEMPTS_EMPTY = "No. of invalid login attempts cannot be empty";
    public static final String PASSPOLICY_NO_OF_HISTORY_PASSWORD_INVALID = "No. of history passwords should be 1 or above";
    // --------------------User Role Management---------------//
    public static final String USER_ROLE_MGT_EMPTY_USER_ROLE_CODE = "User role code cannot be empty";
    public static final String USER_ROLE_MGT_EMPTY_DESCRIPTION = "Description cannot be empty";
    public static final String USER_ROLE_MGT_EMPTY_USER_ROLE_LEVEL = "User role level cannot be empty";
    public static final String USER_ROLE_MGT_EMPTY_STATUS = "Status cannot be empty";
    public static final String USER_ROLE_MGT_ERROR_USER_ROLE_LEVEL_INVALID = "User role level invalid";
    public static final String USER_ROLE_MGT_ERROR_DESC_INVALID = "Description invalid";
    public static final String USER_ROLE_MGT_ERROR_USER_ROLE_CODE_INVALID = "User role code invalid";
    // --------------------Section Management---------------//
    public static final String SECTION_CODE_EMPTY = "Section code cannot be empty";
    public static final String SECTION_DESC_EMPTY = "Description cannot be empty";
    public static final String SECTION_SORY_KEY_EMPTY = "Sort key cannot be empty";
    public static final String SECTION_STATUS_EMPTY = "Status should be selected";
    public static final String SECTION_SORT_KEY_ALREADY_EXISTS = "Sort key already exists";
    // --------------------Transaction Type Management---------------//
    public static final String TXN_TYPE_MGT_EMPTY_TT_CODE = "Transaction type code cannot be empty";
    public static final String TXN_TYPE_MGT_EMPTY_DESCRIPTION = "Description cannot be empty";
    public static final String TXN_TYPE_MGT_EMPTY_SORTKEY = "Sort key cannot be empty";
    public static final String TXN_TYPE_MGT_EMPTY_STATUS = "Status cannot be empty";
    public static final String TXN_TYPE_MGT_EMPTY_OTPREQSTATUS = "OTP required status cannot be empty";
    public static final String TXN_TYPE_MGT_ERROR_SORTKEY_INVALID = "Sort key invalid";
    public static final String TXN_TYPE_MGT_ERROR_DESC_INVALID = "Description invalid";
    public static final String TXN_TYPE_MGT_ERROR_TT_CODE_INVALID = "Transaction type code invalid";

    // --------------------Page Management---------------//
    public static final String PAGE_MGT_EMPTY_PAGE_CODE = "Page code cannot be empty";
    public static final String PAGE_MGT_EMPTY_DESCRIPTION = "Description cannot be empty";
    public static final String PAGE_MGT_EMPTY_SORTKEY = "Sort key cannot be empty";
    public static final String PAGE_MGT_EMPTY_STATUS = "Status cannot be empty";
    public static final String PAGE_MGT_EMPTY_URL = "URL cannot be empty";
    public static final String PAGE_MGT_ERROR_SORTKEY_INVALID = "Sort key invalid";
    public static final String PAGE_MGT_ERROR_DESC_INVALID = "Description invalid";
    public static final String PAGE_MGT_ERROR_PAGE_CODE_INVALID = "Page code invalid";
     public static final String PAGE_MGT_ERROR_URL_INVALID = "URL invalid";
     public static final String PAGE_MGT_ERROR_SORT_KEY_ALREADY_EXSITS = "Sort key already exists";
    //------------------- System User Management----------//
    public static final String SYSUSER_MGT_EMPTY_USERNAME = "User ID cannot be empty";
    public static final String SYSUSER_MGT_EMPTY_PASSWORD = "Password cannot be empty";
    public static final String SYSUSER_MGT_PASSWORD_MISSMATCH = "Password confirmation mismatched";
    public static final String SYSUSER_MGT_EMPTY_USERROLE = "User role cannot be empty";
    public static final String SYSUSER_MGT_EMPTY_DUALAUTHUSER = "Dual auth user cannot be empty";
    public static final String SYSUSER_MGT_EMPTY_STATUS = "Status cannot be empty";
    public static final String SYSUSER_MGT_EMPTY_SERVICEID = "Service ID cannot be empty";
    public static final String SYSUSER_MGT_EMPTY_EXPIRYDATE = "Password expiry date cannot be empty";
    public static final String SYSUSER_MGT_EMPTY_DATEOFBIRTH = "Date of birth cannot be empty";
    public static final String SYSUSER_MGT_EMPTY_FULLNAME = "Full name cannot be empty";
    public static final String SYSUSER_MGT_EMPTY_ADDRESS1 = "Address cannot be empty";
    public static final String SYSUSER_MGT_EMPTY_ADDRESS2 = "Address2 cannot be empty";
    public static final String SYSUSER_MGT_EMPTY_CITY = "City cannot be empty";
    public static final String SYSUSER_MGT_EMPTY_COANTACTNO = "Contact number cannot be empty";
    public static final String SYSUSER_MGT_EMPTY_FAX = "Fax cannot be empty";
    public static final String SYSUSER_MGT_EMPTY_EMAIL = "Email cannot be empty";
    public static final String SYSUSER_MGT_EMPTY_NIC = "NIC cannot be empty";
    public static final String SYSUSER_MGT_INVALID_EMAIL = "Invalid email";
    public static final String SYSUSER_PASSWORD_TOO_SHORT = "Password is shorter than the expected minimum length ";
    public static final String SYSUSER_PASSWORD_TOO_LARGE = "Password is longer than the expected maximum length ";
    public static final String SYSUSER_PASSWORD_LESS_LOWER_CASE_CHARACTERS = "Lower case characters are less than required";
    public static final String SYSUSER_PASSWORD_LESS_UPPER_CASE_CHARACTERS = "Upper case characters are less than required";
    public static final String SYSUSER_PASSWORD_MORE_CHAR_REPEAT = "Password contains characters repeating more than allowed";
    public static final String SYSUSER_PASSWORD_LESS_NUMERICAL_CHARACTERS = "Numerical characters are less than required";
    public static final String SYSUSER_PASSWORD_LESS_SPACIAL_CHARACTERS = "Special characters are less than required";
    public static final String SYSUSER_PASSWORD_MISSMATCH = "Passwords mismatched";
    public static final String RESET_PASSWORD_SUCCESS = "Password reset successful";
    public static final String SYSUSER_DEL_INVALID = " is already Logged-In, cannot be deleted!";
    public static final String RESET_PASS_NEW_EXIST = "New password already exists in history";
    public static final String RESET_PASS_CURRENT_EXIST = "Current password already exists in history";
    public static final String RESET_PASS_SAME_NEW_CURRENT = "New password and current password cannot be the same";

    // --------------------User Role Privilege Management---------------//
    public static final String USER_ROLE_PRI_EMPTY_USER_ROLE = "User role cannot be empty";
    public static final String USER_ROLE_PRI_EMPTY_CATAGARY = "Please select one of the categories to proceed";
    public static final String USER_ROLE_PRI_INVALID_CATAGARY = "Categories should be sections or pages or operations";
    public static final String USER_ROLE_PRI_EMPTY_SECTION = "Section cannot be empty";
    public static final String USER_ROLE_PRI_EMPTY_PAGE = "Page cannot be empty";
    public static final String USER_ROLE_PRI_SEC_DEPEND = "Cannot delete the section because pages are already assigned to it";
    public static final String USER_ROLE_PRI_PAGE_DEPEND = "Cannot delete the page because tasks are already assigned to it";

    // --------------------M-Server Configuration Management---------------//
    public static final String MSERVER_CONFIG_MGT_EMPTY_MID_CODE = "MID cannot be empty";
    public static final String MSERVER_CONFIG_MGT_EMPTY_TID_CODE = "TID cannot be empty";
    public static final String MSERVER_CONFIG_MGT_EMPTY_IP_CODE = "IP cannot be empty";
    public static final String MSERVER_CONFIG_MGT_EMPTY_PORT_CODE = "Port cannot be empty";
    public static final String MSERVER_CONFIG_MGT_EMPTY_READ_TIME_CODE = "Read time out cannot be empty";
    public static final String MSERVER_CONFIG_MGT_EMPTY_CONN_TIME_CODE = "Connection time out cannot be empty";
    public static final String MSERVER_CONFIG_MGT_INVALID_MID_CODE = "MID invalid";
    public static final String MSERVER_CONFIG_MGT_INVALID_TID_CODE = "TID invalid";
    public static final String MSERVER_CONFIG_MGT_INVALID_TID_LENGTH = "TID length should be ";
    public static final String MSERVER_CONFIG_MGT_INVALID_IP_CODE = "Invalid IP address";

    public static final String MSERVER_CONFIG_MGT_INVALID_PORT_CODE = "Port is invalid";
    public static final String MSERVER_CONFIG_MGT_INVALID_READ_TIME_CODE = "Read time out invalid";
    public static final String MSERVER_CONFIG_MGT_INVALID_CONN_TIME_CODE = "Connection time out invalid";

    //-----------------------------------common configuration-----------------------------
    public static final String COMMON_CONFIG_EMPTY_ID = "Id cannot be empty";
    public static final String COMMON_CONFIG_EMPTY_ENVIRONMENT = "Environment cannot be empty";
    public static final String COMMON_CONFIG_EMPTY_POS_TIME_OUT = "POS time out cannot be empty";
    public static final String COMMON_CONFIG_EMPTY_API_KEY = "API key cannot be empty";
    public static final String COMMON_CONFIG_EMPTY_COUNTRY_CODE = "Country code cannot be empty";
    public static final String COMMON_CONFIG_EMPTY_PIN_ACT_PERIOD_CODE = "Pin cctivation period cannot be empty";
    public static final String COMMON_CONFIG_INVALID_ID = "Id is invalid";
    public static final String COMMON_CONFIG_EMPTY_ENCRYPTION_KEY = "Encryption key cannot be empty";
    public static final String COMMON_CONFIG_EMPTY_MAX_ATTEMPT = "Max attempt cannot be empty";
    public static final String COMMON_CONFIG_INVALID_MAX_ATTEMPT = "Max attempt is invalid";
    public static final String COMMON_CONFIG_INVALID_PIN_ACT_PERIOD_CODE = "Pin Activation Period is invalid";
    public static final String COMMON_CONFIG_INVALID_POS_TIME_OUT = "POS time out is invalid";
    public static final String COMMON_CONFIG_INVALID_COUNTRY_CODE = "Country code is invalid";
    public static final String COMMON_CONFIG_INVALID_ENVIRONMENT = "Environment is invalid";

    //-----------------------------------OTP Server configuration-----------------------------
    public static final String OTP_SERVER_CONFIG_EMPTY_ID = "ID cannot be empty";

    public static final String OTP_SERVER_CONFIG_EMPTY_SMS_SERVER_IP = "SMS server IP cannot be empty";
    public static final String OTP_SERVER_CONFIG_EMPTY_SMS_SERVER_PORT = "SMS server port cannot be empty";
    public static final String OTP_SERVER_CONFIG_EMPTY_SMS_SERVER_PORT_TIMEOUT = "SMS server port timeout cannot be empty";
    public static final String OTP_SERVER_CONFIG_EMPTY_SMS_SERVER_PORT_SO_TIMEOUT = "SMS server port socket timeout cannot be empty";

    public static final String OTP_SERVER_CONFIG_EMPTY_API_PORT_TIMEOUT = "API port timeout cannot be empty";
    public static final String OTP_SERVER_CONFIG_EMPTY_API_PORT_SO_TIMEOUT = "API port socket timeout cannot be empty";
    public static final String OTP_SERVER_CONFIG_EMPTY_API_QUEUE_SIZE = "API queue size cannot be empty";

//    public static final String OTP_SERVER_CONFIG_EMPTY_API_THREAD_MAX_POOL = "API thread pool max cannot be empty";
//    public static final String OTP_SERVER_CONFIG_EMPTY_API_THREAD_MIN_POOL = "API thread pool min cannot be empty";
    public static final String OTP_SERVER_CONFIG_EMPTY_API_THREAD_MAX_POOL = "API thread pool max size cannot be empty";
    public static final String OTP_SERVER_CONFIG_EMPTY_API_THREAD_MIN_POOL = "API thread pool min size cannot be empty";

    public static final String OTP_SERVER_CONFIG_EMPTY_OTP_SERVER_IP = "OTP server IP cannot be empty";
    public static final String OTP_SERVER_CONFIG_EMPTY_OTP_SERVER_PORT = "OTP server port cannot be empty";

    public static final String OTP_SERVER_CONFIG_EMPTY_MAIL_ID = "Mail ID cannot be empty";
    public static final String OTP_SERVER_CONFIG_EMPTY_MAIL_SERVER_IP = "Mail server IP cannot be empty";
    public static final String OTP_SERVER_CONFIG_EMPTY_MAIL_SERVER_PORT = "Mail server port cannot be empty";
    public static final String OTP_SERVER_CONFIG_EMPTY_MAIL_PASSWORD = "Mail password cannot be empty";

    public static final String OTP_SERVER_CONFIG_EMPTY_SERVER_LOG_LEVEL = "Server log level cannot be empty";
    public static final String OTP_SERVER_CONFIG_EMPTY_SPLITTER = "Splitter cannot be empty";

    public static final String OTP_SERVER_CONFIG_INVALID_ID = "ID is invalid";
    public static final String OTP_SERVER_CONFIG_INVALID_MAIL_PORT = "Mail server port is invalid";
    public static final String OTP_SERVER_CONFIG_INVALID_SMS_PORT = "SMS server port is invalid";
    public static final String OTP_SERVER_CONFIG_INVALID_OTP_PORT = "OTP server port is invalid";
    public static final String OTP_SERVER_CONFIG_INVALID_MAIL_IP = "Invalid mail server IP address";
    public static final String OTP_SERVER_CONFIG_INVALID_SMS_IP = "Invalid SMS server IP address";
    public static final String OTP_SERVER_CONFIG_INVALID_OTP_IP = "Invalid OTP server IP address";

    //-----------------------------------Wam configuration-----------------------------
    public static final String WAM_CONFIG_EMPTY_ID = "Id cannot be empty";
    public static final String WAM_CONFIG_EMPTY_MAX_POOL = "Max pool key cannot be empty";
    public static final String WAM_CONFIG_EMPTY_MIN_POOL = "Min pool cannot be empty";
    public static final String WAM_CONFIG_INVALID_MAX_MIN_POOL = "Min pool should be less than max pool";
    public static final String WAM_CONFIG_EMPTY_MAX_POOL_QUEUE = "Max pool queue cannot be empty";
    public static final String WAM_CONFIG_EMPTY_SERVICE_PORT = "Service port cannot be empty";
    public static final String WAM_CONFIG_EMPTY_SERVICE_READ_TIMEOUT = "Service read timeout cannot be empty";
    public static final String WAM_CONFIG_EMPTY_LOG_LEVEL = "Log level cannot be empty";
    public static final String WAM_CONFIG_EMPTY_LOG_BACKUP_PATH = "Log backup path cannot be empty";
    public static final String WAM_CONFIG_EMPTY_LOG_BACKUP_STATUS = "Log backup status cannot be empty";
    public static final String WAM_CONFIG_EMPTY_NOOF_LOG_FILE = "No. of log file cannot be empty";

    public static final String WAM_CONFIG_INVALID_ID = "Id is invalid";
    public static final String WAM_CONFIG_INVALID_MAX_POOL = "Max pool is invalid";
    public static final String WAM_CONFIG_INVALID_MIN_POOL = "Min pool is invalid";
    public static final String WAM_CONFIG_INVALID_MAX_POOL_QUEUE = "Max pool queue is invalid";
    public static final String WAM_CONFIG_INVALID_SERVICE_PORT = "Service port is invalid";
    public static final String WAM_CONFIG_INVALID_SETT_TXN_COUNT = "Settlement transaction count is invalid";
    public static final String WAM_CONFIG_INVALID_SETT_SLEEP_TIME = "Settlement process sleep time cannot be empty";
    public static final String WAM_CONFIG_INVALID_SETT_PROCESS_STATUS = "Settlement process status time cannot be empty";
    public static final String WAM_CONFIG_INVALID_LOG_FILE = "Log level is invalid";
    public static final String WAM_CONFIG_INVALID_LOG_BACKUP_PATH = "Log backup path is invalid";
    public static final String WAM_CONFIG_SYNTAX_ERROR = "Syntax error found in a regular-expression pattern";
    public static final String WAM_CONFIG_URL_ERROR = "Error found in URL validation";
//------------------Common File Path Management---------------//
    public static final String COMMON_FILE_PATH_EMPTY_OS_TYPE = "OS type cannot be empty";
    public static final String COMMON_FILE_PATH_EMPTY_INFO_LOG = "Info log cannot be empty";
    public static final String COMMON_FILE_PATH_EMPTY_ERROR_LOG = "Error log cannot be empty";
    public static final String COMMON_FILE_PATH_EMPTY_TRANSACTION_LOG = "Transaction log cannot be empty";
    public static final String COMMON_FILE_PATH_INVALID_INFO_LOG = "Info log is invalid";
    public static final String COMMON_FILE_PATH_INVALID_ERROR_LOG = "Error log is invalid";
    public static final String COMMON_FILE_PATH_INVALID_TRANSACTION_LOG = "Transaction log is invalid";
    public static final String COMMON_FILE_PATH_SYNTAX_ERROR = "Syntax error found in a regular-expression pattern";
    public static final String COMMON_FILE_PATH_URL_ERROR = "Error found in URL validation";

    // --------------------M-Server Currency Management---------------//
    public static final String MSERVER_CURRENCY_MGT_EMPTY_TID_CODE = "TID cannot be empty";
    public static final String MSERVER_CURRENCY_MGT_EMPTY_CURRENCY_CODE = "Currency cannot be empty";
    public static final String MSERVER_CURRENCY_MGT_INVALID_TID_CODE = "TID is invalid";
    public static final String MSERVER_CURRENCY_MGT_INVALID_TID_LENGTH = "TID length should be ";

    // --------------------TXN Currency Management---------------//
    public static final String TXN_CUR_EMPTY_TID_CODE = "TID cannot be empty";
    public static final String TXN_CUR_EMPTY_MID_CODE = "MID cannot be empty";
    public static final String TXN_CUR_EMPTY_CURRENCY_CODE = "Currency code cannot be empty";
    public static final String TXN_CUR_EMPTY_TXN_TYPE = "Transaction type cannot be empty";
    public static final String TXN_CUR_INVALID_TID_CODE = "TID is invalid";
    public static final String TXN_CUR_INVALID_MID_CODE = "MID is invalid";
    public static final String TXN_CUR_INVALID_TID_LENGTH = "TID length should be ";
    public static final String TXN_CUR_INVALID_MID_LENGTH = "MID length should be ";

    // --------------------Channel Configuation---------------//
    public static final String CHANNEL_CONFIGUATION_EMPTY_ID = "Id cannot be empty";
    public static final String CHANNEL_CONFIGUATION_EMPTY_NAME = "Name cannot be empty";
    public static final String CHANNEL_CONFIGUATION_EMPTY_IP = "IP cannot be empty";
    public static final String CHANNEL_CONFIGUATION_EMPTY_PORT = "Port cannot be empty";
    public static final String CHANNEL_CONFIGUATION_EMPTY_TYPE = "Type cannot be empty";
    public static final String CHANNEL_CONFIGUATION_EMPTY_HEADER_SIZE = "Header size cannot be empty";
    public static final String CHANNEL_CONFIGUATION_EMPTY_REAL_TIMEOUT = "Real timeout cannot be empty";
    public static final String CHANNEL_CONFIGUATION_EMPTY_CON_TIMEOUT = "Connection timeout cannot be empty";
    public static final String CHANNEL_CONFIGUATION_EMPTY_STATUS = "Status cannot be empty";
    public static final String CHANNEL_CONFIGUATION_INVALID_NAME = "Name is invalid";
    public static final String CHANNEL_CONFIGUATION_INVALID_IP = "Invalid IP address";
    public static final String CHANNEL_CONFIGUATION_INVALID_PORT = "Port is invalid";
    public static final String CHANNEL_CONFIGUATION_INVALID_TYPE = "Type is invalid";
    public static final String CHANNEL_CONFIGUATION_INVALID_HEADER_SIZE = "Header size is invalid";
    public static final String CHANNEL_CONFIGUATION_INVALID_REAL_TIMEOUT = "Real timeout size is invalid";
    public static final String CHANNEL_CONFIGUATION_INVALID_CON_TIMEOUT = "Con timeout size is invalid";
    public static final String CHANNEL_CONFIGUATION_SYNTAX_ERROR = "Syntax error found in a regular-expression pattern";

    //---------------------vsf config--------------------------//
    public static final String VSF_CONFIGUATION_EMPTY_ID = "Id cannot be empty";
    public static final String VSF_CONFIGUATION_EMPTY_STATUS = "Status cannot be empty";
    public static final String VSF_CONFIGUATION_EMPTY_DESCRIPTION = "Description cannot be empty";
    public static final String VSF_CONFIGUATION_EMPTY_URITYPE = "Uri type cannot be empty";
    //------------------------risk profile------------------------
    public static final String RISK_PROFILE_EMPTY_RISK_PROFILE_CODE = "Risk profile code cannot be empty";
    public static final String RISK_PROFILE_INVALID_RISK_PROFILE_CODE = "Risk profile code is invalid";
    public static final String RISK_PROFILE_EMPTY_POS_MAX_TRANSACTION_AMOUNT = "POS max transaction amount cannot be empty";
    public static final String RISK_PROFILE_INVALID_POS_MAX_TRANSACTION_AMOUNT = "POS max transaction amount is invalid";
    public static final String RISK_PROFILE_EMPTY_POS_MIN_TRANSACTION_AMOUNT = "POS min transaction amount cannot be empty";
    public static final String RISK_PROFILE_INVALID_POS_MIN_TRANSACTION_AMOUNT = "POS min transaction amount is invalid";
    public static final String RISK_PROFILE_INVALID_POS_MIN_MAX_TRANSACTION_AMOUNT = "POS min transaction amount cannot be greater POS max transaction amount";
    public static final String RISK_PROFILE_EMPTY_P2P_MAX_TRANSACTION_AMOUNT = "P2P max transaction amount cannot be empty";
    public static final String RISK_PROFILE_INVALID_P2P_MAX_TRANSACTION_AMOUNT = "P2P max transaction amount is invalid";
    public static final String RISK_PROFILE_EMPTY_P2P_MIN_TRANSACTION_AMOUNT = "P2P min transaction amount cannot be empty";
    public static final String RISK_PROFILE_INVALID_P2P_MIN_TRANSACTION_AMOUNT = "P2P min transaction amount is invalid";
    public static final String RISK_PROFILE_INVALID_P2P_MIN_MAX_TRANSACTION_AMOUNT = "P2P min transaction amount cannot be greater than P2P max transaction amount";
    public static final String RISK_PROFILE_EMPTY_POS_MAX_TRANSACTION_COUNT_PER_DAY = "POS max transaction count per day cannot be empty";
    public static final String RISK_PROFILE_INVALID_POS_MAX_TRANSACTION_COUNT_PER_DAY = "POS max transaction count per day is invalid";
    public static final String RISK_PROFILE_EMPTY_POS_MAX_TRANSACTION_AMOUNT_PER_DAY = "POS max transaction amount per day cannot be empty";
    public static final String RISK_PROFILE_INVALID_POS_MAX_TRANSACTION_AMOUNT_PER_DAY = "POS max transaction amount per day is invalid";
    public static final String RISK_PROFILE_EMPTY_P2P_MAX_TRANSACTION_COUNT_PER_DAY = "P2P max transaction count per day cannot be empty";
    public static final String RISK_PROFILE_INVALID_P2P_MAX_TRANSACTION_COUNT_PER_DAY = "P2P max transaction count per day is invalid";
    public static final String RISK_PROFILE_EMPTY_P2P_MAX_TRANSACTION_AMOUNT_PER_DAY = "P2P max transaction amount per day cannot be empty";
    public static final String RISK_PROFILE_INVALID_P2P_MAX_TRANSACTION_AMOUNT_PER_DAY = "P2P max transaction amount per day is invalid";
    public static final String RISK_PROFILE_EMPTY_DEFAULT_STATUS = "Default status cannot be empty";
    public static final String RISK_PROFILE_DEFAULT_STATUS_YES_REPEAT = "Default status \"yes\" cannot be repeat";
    public static final String RISK_PROFILE_DEFAULT_ATLEAST_STATUS_YES = "At least one record should have default status \"yes\"";

    public static final String ACQUIRER_TXN_RISK_PROFILE_TXN_EMPTY = "Please assign acquirer risk profile transactions";
    
    public static final String RISK_PROFILE_INVALID_POS_MAX = "POS max txn amount per day should be within [POS Min Txn Amount * POS Max Txn Count Per Day] and [POS Max Txn Amount * POS Max Txn Count Per Day]";
    public static final String RISK_PROFILE_INVALID_P2P_MAX = "P2P max txn amount per day should be within [P2P Min Txn Amount * P2P Max Txn Count Per Day] and [P2P Max Txn Amount * P2P Max Txn Count Per Day]";
    public static final String RISK_PROFILE_INVALID = "Transaction type daily amount should be within [Min Amount * Daily Count] and [Max Amount * Daily Count]";

    public static final String RISK_PROFILE_EMPTY_DESCRIPTION = "Description cannot be empty";
    public static final String RISK_PROFILE_INVALID_DESCRIPTION = "Description is invalid";
    public static final String RISK_PROFILE_ALREADY_DESCRIPTION = "Description already exists";

    public static final String RISK_PROFILE_EMPTY_RISK_TXN_PROFILE_CODE = "Risk transaction profile code cannot be empty";
    public static final String RISK_PROFILE_EMPTY_DEF_STATUS = "Default status cannot be empty";
    public static final String RISK_PROFILE_EMPTY_TXN_TYPE = "Transaction type cannot be empty";
    public static final String RISK_PROFILE_EMPTY_CURRENCY = "Currency cannot be empty";
    public static final String RISK_PROFILE_INVALID_RISK_TXN_PROFILE_CODE = "Risk transaction profile code is invalid";
    public static final String RISK_PROFILE_EMPTY_DAILY_COUNT = "Daily count cannot be empty";
    public static final String RISK_PROFILE_INVALID_DAILY_COUNT = "Daily count is invalid";
    public static final String RISK_PROFILE_EMPTY_DAILY_AMOUNT = "Daily amount cannot be empty";
    public static final String RISK_PROFILE_INVALID_DAILY_AMOUNT = "Daily amount is invalid";
    public static final String RISK_PROFILE_EMPTY_MAX_AMOUNT = "Max amount cannot be empty";
    public static final String RISK_PROFILE_EMPTY_MPIN_MIN_AMOUNT = "MPIN min amount cannot be empty";
    public static final String RISK_PROFILE_INVALID_MPIN_MIN_AMOUNT = "MPIN min amount is invalid";
    public static final String RISK_PROFILE_INVALID_MAX_AMOUNT = "Max amount is invalid";
    public static final String RISK_PROFILE_EMPTY_MIN_AMOUNT = "Min amount cannot be empty";
    public static final String RISK_PROFILE_INVALID_MIN_AMOUNT = "Min amount is invalid";
    public static final String RISK_PROFILE_INVALID_MIN_MAX_TRANSACTION_AMOUNT = "Min amount cannot be greater than max amount";
    public static final String RISK_PROFILE_INVALID_MPIN_MAX_AMOUNT = "MPIN min amount cannot be greater than max amount";
    public static final String RISK_PROFILE_INVALID_MPIN_AMOUNT = "MPIN min amount cannot be lesser than min amount";
    public static final String RISK_PROFILE_INVALID_AMT_GREATER = "Daily amount cannot be greater than risk profile daily amount: ";
    public static final String RISK_PROFILE_INVALID_COUNT = "Daily count cannot be greater than risk profile daily count: ";
    public static final String RISK_PROFILE_TXN_TYPE_EXISTS = "Transaction type already exists";
    public static final String RISK_PROFILE_INVALID_DAILY_MAX_COUNT_AMOUNT = "Daily amount cannot be greater than [Max Amount * Daily Count]";

    //------------------------risk profile------------------------//
    public static final String LISTNER_CONFIGUATION_EMPTY_BACKLOG_SIZE = "Backlog size cannot be empty";
    public static final String LISTNER_CONFIGUATION_INVALID_BACKLOG_SIZE = "Backlog size is invalid";
    public static final String LISTNER_CONFIGUATION_EMPTY_PREFIX = "Prefix cannot be empty";
    public static final String LISTNER_CONFIGUATION_INVALID_PREFIX = "Prefix is invalid";
    public static final String LISTNER_CONFIGUATION_EMPTY_NAME = "Name cannot be empty";
    public static final String LISTNER_CONFIGUATION_INVALID_NAME = "Name is invalid";
    public static final String LISTNER_CONFIGUATION_EMPTY_PORT = "Port cannot be empty";
    public static final String LISTNER_CONFIGUATION_INVALID_PORT = "Port is invalid";
    public static final String LISTNER_CONFIGUATION_EMPTY_READ_TIMEOUT = "Read timeout cannot be empty";
    public static final String LISTNER_CONFIGUATION_INVALID_READ_TIMEOUT = "Read timeout is invalid";
    public static final String LISTNER_CONFIGUATION_EMPTY_UID = "UID cannot be empty";
    public static final String LISTNER_CONFIGUATION_INVALID_UID = "UID is invalid";
    public static final String LISTNER_CONFIGUATION_EMPTY_TYPE = "Type cannot be empty";
    public static final String LISTNER_CONFIGUATION_EMPTY_HEADER_SIZE = "Header size cannot be empty";
    public static final String LISTNER_CONFIGUATION_EMPTY_STATUS = "Status cannot be empty";

    public static final String OTP_POLICY_EMPTY_OTPTYPE = "OTP type cannot be empty";
    public static final String OTP_POLICY_EMPTY_OTPLENGTH = "OTP length cannot be empty";
    public static final String OTP_POLICY_EMPTY_EXPIRYPERIOD = "Expiry period cannot be empty";
    public static final String OTP_POLICY_INVALID_OTPLENGTH = "OTP length is invalid";
    public static final String OTP_POLICY_INVALID_EXPIRYPERIOD = "Expiry period is invalid";
    // customer wallet
    public static final String CUS_WALLET_EMPTY_RISK_PROFILE = "Risk profile cannot be empty";
    public static final String CUS_WALLET_EMPTY_STATUS = "Status cannot be empty";

    // --------------------OTP Email Template---------------//
    public static final String OTP_EMAIL_TEMPLATE_EMPTY_MESSAGE_ID = "Message ID cannot be empty";
    public static final String OTP_EMAIL_TEMPLATE_INVALID_MESSAGE_ID = "Message ID is in valid";
    public static final String OTP_EMAIL_TEMPLATE_EMPTY_MESSAGE = "Message cannot be empty";
    public static final String OTP_EMAIL_TEMPLATE_INVALID_MESSAGE = "Message should contains <OTP> and <REF> tags only once";
    public static final String OTP_EMAIL_TEMPLATE_EMPTY_SUBJECT = "Subject cannot be empty";
    public static final String OTP_EMAIL_TEMPLATE_INVALID_SUBJECT = "Message is in valid";

    // --------------------OTP SMS Template---------------//
    public static final String OTP_SMS_TEMPLATE_EMPTY_MESSAGE_ID = "Sms ID cannot be empty";
    public static final String OTP_SMS_TEMPLATE_INVALID_MESSAGE_ID = "Sms ID is in valid";
    public static final String OTP_SMS_TEMPLATE_EMPTY_MESSAGE = "Message cannot be empty";
    public static final String OTP_SMS_TEMPLATE_INVALID_MESSAGE = "Message should contains |OTP| tag only once";
    public static final String OTP_SMS_TEMPLATE_EMPTY_SUBJECT = "Subject cannot be empty";
    public static final String OTP_SMS_TEMPLATE_INVALID_SUBJECT = "Message is in valid";

    //-----------------------otp application--------------------//
    public static final String OTP_APPLICATION_EMPTY_APPLICATION_CODE = "Application code cannot be empty";
    public static final String OTP_APPLICATION_INVALID_APPLICATION_CODE = "Application code is invalid";
    public static final String OTP_APPLICATION_EMPTY_DESCRIPTION = "Description cannot be empty";
    public static final String OTP_APPLICATION_INVALID_DESCRIPTION = "Description is invalid";
    public static final String OTP_APPLICATION_EMPTY_MAIL_MSG_ID = "Mail message ID cannot be empty";
    public static final String OTP_APPLICATION_EMPTY_SMS_MSG_ID = "SMS message ID cannot be empty";
    public static final String OTP_APPLICATION_INVALID_SMS_MSG_ID = "SMS message ID is invalid";
    public static final String OTP_APPLICATION_EMPTY_URL = "URL cannot be empty";
    public static final String OTP_APPLICATION_INVALID_URL = "URL is invalid";
    public static final String OTP_APPLICATION_EMPTY_PASSWORD = "Password cannot be empty";
    public static final String OTP_APPLICATION_EMPTY_PASSWORD_CONFIRM = "Confirm password cannot be empty";
    public static final String OTP_APPLICATION_PASSWORD_MISSMATCH = "Password and confirm password mismatched";
    public static final String OTP_APPLICATION_EMPTY_SUBSCRIPTION_STATUS = "Subscription status cannot be empty";
    public static final String OTP_APPLICATION_EMPTY_OTP_TYPE = "OTP type cannot be empty";
    public static final String OTP_APPLICATION_EMPTY_STATUS = "Status cannot be empty";

    //-------------------- service configuation --------------------------------
    public static final String SERVICE_CONFIGUATION_EMPTY_ID = "Id cannot be empty";
    public static final String SERVICE_CONFIGUATION_EMPTY_NAME = "Name cannot be empty";
    public static final String SERVICE_CONFIGUATION_EMPTY_URL = "URL cannot be empty";
    public static final String SERVICE_CONFIGUATION_EMPTY_TIMEOUT = "Timeout cannot be empty";
    public static final String SERVICE_CONFIGUATION_EMPTY_REQ_METHOD = "Request method cannot be empty";
    public static final String SERVICE_CONFIGUATION_EMPTY_REQ_PRO_KEY = "Request property key cannot be empty";
    public static final String SERVICE_CONFIGUATION_EMPTY_REQ_PRO_VALUE = "Request property value cannot be empty";
    public static final String SERVICE_CONFIGUATION_EMPTY_STATUS = "Status cannot be empty";
    public static final String SERVICE_CONFIGUATION_INVALID_URL = "URL is invalid";
    public static final String SERVICE_CONFIGUATION_SYNTAX_ERROR = "Syntax error found in a regular-expression pattern";

    public static final String FILE_UPLOAD_SUCCESS = "File has been successfully uploaded";
    public static final String FILE_UPLOAD_ERROR = "An error occurred while uploading the file";
    public static final String FILE_UPLOAD_EMPTY_ONLY_PDF = "No file has been uploaded / uploaded file type is not a PDF";

    public static final String CARD_PRODUCT_EMPTY = "Card product cannot be empty";
    public static final String CARD_BIN_EMPTY = "Card bin cannot be empty";
    public static final String CARD_CURRENCY_EMPTY = "Card currency cannot be empty";
    public static final String CARD_DESCRIPTION_EMPTY = "description cannot be empty";

    //-------------------- Card Product --------------------------------
    public static final String CARD_PRODUCT_EMPTY_PRODUCT_CODE = "Product code cannot be empty";
    public static final String CARD_PRODUCT_EMPTY_DESCRIPTION = "Description cannot be empty";
    public static final String CARD_PRODUCT_EMPTY_CARD_TYPE = "Card type cannot be empty";
    public static final String CARD_PRODUCT_EMPTY_CARD_BRAND = "Card brand cannot be empty";
    public static final String CARD_PRODUCT_EMPTY_DISPLAY_NAME = "Display name cannot be empty";
    public static final String CARD_PRODUCT_EMPTY_INVALIDDIS_NAME = "Display name should contains [CARD]";

    public static final String CARD_PRODUCT_LARGE_IMAGE = "Image is too large. File size should be less than 650kb.";
    public static final String CARD_PRODUCT_LARGE_WIDTH = "Image width should be less than 450 pixels.";
    public static final String CARD_PRODUCT_SMALL_WIDTH = "Image width should be more than 445 pixels.";
    public static final String CARD_PRODUCT_LARGE_HEIGHT = "Image height should be less than 290 pixels.";
    public static final String CARD_PRODUCT_SMALL_HEIGHT = "Image height should be more than 280 pixels.";

    public static final String URI_TYPE_CODE_EMPTY = "URI type code cannot be empty";
    public static final String URI_TYPE_NAME_EMPTY = "URI type name cannot be empty";
    public static final String URI_TYPE_ROUTINGTAG_EMPTY = "URI routing tag cannot be empty";
    public static final String URI_TYPE_CODE_INVALID_LENGTH = "URI type code length should not exceed 10 ";
    public static final String URI_TYPE_NAME_INVALID_LENGTH = "URI type name length should not exceed 50";

    //----------------------------------------Country List -----------------------------------------
    public static final String COUNTRY_LIST_EMPTY_CODE = "Country code cannot be empty";
    public static final String COUNTRY_LIST_EMPTY_NAME = "Name cannot be empty";
    public static final String COUNTRY_LIST_EMPTY_STATUS = "Status cannot be empty";
    public static final String COUNTRY_LIST_EMPTY_CURRENCY = "Currency cannot be empty";
    public static final String COUNTRY_LIST_EMPTY_FX_RATE = "Fx rate cannot be empty";
    public static final String COUNTRY_LIST_EMPTY_REMIT_TAX = "Remit tax cannot be empty";
    public static final String COUNTRY_LIST_EMPTY_REMIT_FEE = "Remit fee cannot be empty";
    public static final String COUNTRY_LIST_EMPTY_SRC_URI = "Source uri cannot be empty";
    public static final String COUNTRY_LIST_EMPTY_DEST_URI = "Destination uri cannot be empty";
    public static final String COUNTRY_LIST_EMPTY_ROUTING_TAG = "Routing tag cannot be empty";
    public static final String COUNTRY_LIST_EMPTY_FETCH_TIME = "Fetch time cannot be empty";
    public static final String COUNTRY_LIST_EMPTY_VSF600STATUS = "Vsf 600 status cannot be empty";
    public static final String COUNTRY_LIST_EMPTY_VSF600DATA = "Vsf 600 data cannot be empty";

    public static final String ESWITCH_CALL_EMPTY_SERVICE = "Status cannot be empty";
    public static final String ESWITCH_CALL_EMPTY_COUNTRY = "Status cannot be empty";
    public static final String ESWITCH_CALL_EMPTY_SERVICE_URI = "Status cannot be empty";
    public static final String ESWITCH_CALL_EMPTY_BANKCODE = "Status cannot be empty";
    public static final String ESWITCH_CALL_EMPTY_BRANCH = "Status cannot be empty";
//    public static final String ESWITCH_CALL_EMPTY_SERVICE_URI = "Status cannot be empty";

    //----------------------------------------Service Supported URIs-----------------------------------------
    public static final String SERVICE_SUPPORTED_URIS_EMPTY_ID = "Service supported URI ID cannot be empty";
    public static final String SERVICE_SUPPORTED_URIS_INVALID_ID_LENGTH = "Service supported URI ID length should not exceed 10";
    public static final String SERVICE_SUPPORTED_URIS_INVALID_ID = "Service supported URI ID should be numberic";
    public static final String SERVICE_SUPPORTED_URIS_EMPTY_SERVICE_ID = "Service supported URI service ID cannot be empty";
    public static final String SERVICE_SUPPORTED_URIS_EMPTY_URI_TYPE = "Service supported URI type cannot be empty";
    public static final String SERVICE_SUPPORTED_URIS_EMPTY_SP_TAG_STATUS = "Service supported URI SP tag status cannot be empty";
    public static final String SERVICE_SUPPORTED_URIS_EMPTY_STATUS = "Service supported URI status cannot be empty";
    public static final String SERVICE_SUPPORTED_URIS_EMPTY_VSF = "Service supported URI Vsf profile cannot be empty";
    public static final String SERVICE_SUPPORTED_URIS_EMPTY_FORMAT = "Service supported URI format cannot be empty";
    public static final String SERVICE_SUPPORTED_URIS_EMPTY_BIC_STATUS = "Service supported URI BIC status cannot be empty";
    public static final String SERVICE_SUPPORTED_URIS_EMPTY_BANK_CODE_STATUS = "Service supported URI bank code status cannot be empty";
    public static final String SERVICE_SUPPORTED_URIS_EMPTY_BRANCH_CODE_STATUS = "Service supported URI branch code status cannot be empty";
    public static final String SERVICE_SUPPORTED_URIS_EMPTY_BIC_TYPE = "Service supported URI BIC type cannot be empty";

    //----------------------------------------Service Details -----------------------------------------
    public static final String SERVICE_DETAILS_ID = "ID cannot be empty";
    public static final String SERVICE_DETAILS_NAME = "Name cannot be empty";
    public static final String SERVICE_DETAILS_COUNRTY = "Country cannot be empty";
    public static final String SERVICE_DETAILS_SP_SHORT_CODE = "SP short code cannot be empty";
    public static final String SERVICE_DETAILS_SERVICE_TYPE = "Service type cannot be empty";
    public static final String SERVICE_DETAILS_BENIFICIARY_CURR = "Benificiary currency cannot be empty";
    public static final String SERVICE_DETAILS_DIGIT_PRECISION = "Digit Precision cannot be empty";
    public static final String SERVICE_DETAILS_MIN_AMOUNT_PER_TXN = "Min amount per txn cannot be empty";
    public static final String SERVICE_DETAILS_MAX_AMOUNT_PER_TXN = "Max amount per txn cannot be empty";
    public static final String SERVICE_DETAILS_MAX_AMOUNT_PER_PER = "Max amount for period cannot be empty";
    public static final String SERVICE_DETAILS_MAX_TXN_PER_PER = "Max txn for period cannot be empty";
    public static final String SERVICE_DETAILS_LIMIT_PERIOD = "Limit period cannot be empty";
    public static final String SERVICE_DETAILS_TERM_DELIVERY = "Term of delivery cannot be empty";
    public static final String SERVICE_DETAILS_EXPIRATION_TIME = "Expiration time cannot be empty";
    public static final String SERVICE_DETAILS_ROUTIONG_TAG = "Routing tag cannot be empty";
    public static final String SERVICE_DETAILS_SETTLEMENT_CURR = "Settlement currency cannot be empty";
    public static final String SERVICE_DETAILS_STATUS = "Status cannot be empty";

    //----------------------------------------Purpose of remit -----------------------------------------
    public static final String PURPOSE_OF_REMIT_EMPTY_CODE = "Purpose of remit code cannot be empty";
    public static final String PURPOSE_OF_REMIT_EMPTY_DESCRIPTION = "Purpose of remit description cannot be empty";
    public static final String PURPOSE_OF_REMIT_EMPTY_STATUS = "Purpose of remit status cannot be empty";

    //----------------------------------------Source of income -----------------------------------------
    public static final String SOURCE_OF_INCMOE_EMPTY_CODE = "Source of income code cannot be empty";
    public static final String SOURCE_OF_INCMOE_EMPTY_DESCRIPTION = "Source of income description cannot be empty";
    public static final String SOURCE_OF_INCMOE_EMPTY_STATUS = "Source of income status cannot be empty";

    //----------------------------------------Sender ID type -----------------------------------------
    public static final String SENDER_ID_TYPE_EMPTY_CODE = "Sender ID type code cannot be empty";
    public static final String SENDER_ID_TYPE_EMPTY_DESCRIPTION = "Sender ID type description cannot be empty";
    public static final String SENDER_ID_TYPE_EMPTY_STATUS = "Sender ID type status cannot be empty";

    //----------------------------------------Response Codes -----------------------------------------
    public static final String RESPONSECODE_EMPTY_CODE = "Code cannot be empty";
    public static final String RESPONSECODE_EMPTY_DESC = "Description cannot be empty";
    public static final String RESPONSECODE_EMPTY_END_USER = "End user message cannot be empty";

    //----------------------------------------Commissiom -----------------------------------------
    public static final String COMMISSION_EMPTY_FLAT_PERCENTAGE = "Flat/percentage cannot be empty";
    public static final String COMMISSION_EMPTY_AMOUNT = "Amount cannot be empty";
    public static final String COMMISSIONT_PERCENTAGE_INVALID = "Percentage ";

    // --------------------User Parameter---------------//
    public static final String USER_PARAM_EMPTY_CODE = "User parameter code cannot be empty";
    public static final String USER_PARAM_EMPTY_VALUE = "User parameter value cannot be empty";
    public static final String USER_PARAM_EMPTY_DESCRIPTION = "Description cannot be empty";

    //--------------------Monitor----------------------//
    public static final String FAILED_TO_SEND_MESSAGE_TO_SERVER = "Failed to send request message to server.";
    public static final String FAILED_TO_SEND_MESSAGE_TO_SERVER_TIMEOUT = "Request time out";
    public static final String INVALID_SERVER_RESPONSE = "Invalid response.";
    public static final String FAILED_TO_RECEIVE_MESSAGE_FROM_SERVER = "Failed to receive response message from server.";
    public static final String FAILD_REQUEST_CREATE = "Failed to generate server request.";
    public static final String FAILD_REQUEST_CONNECTION_REFUSED = "No response from the server";

    public static final String VSF_FIELD_ID_EMPTY = "Vsf field ID cannot be empty";
    public static final String VSF_FIELD_DESCRIPTION_EMPTY = "Vsf field description cannot be empty";
    public static final String VSF_FIELD_HSPROVIDEDKEY_EMPTY = "Vsf field HS provided key cannot be empty";
    public static final String VSF_FIELD_HSPROVIDEDKEY_INVALID_LENGTH = "Invalid length for HS provided key";
    public static final String VSF_FIELD_CUS_SERVICE_JSON_KEY_EMPTY = "Vsf field customer service json key cannot be empty";

    // --------------------Transaction Type Management---------------//
    public static final String TIER_FEE_MGT_EMPTY_COUNTRY_CODE = "Country cannot be empty";
    public static final String TIER_FEE_MGT_EMPTY_TIER = "Tier cannot be empty";
    public static final String TIER_FEE_MGT_EMPTY_STATUS = "Status cannot be empty";
    public static final String TIER_FEE_MGT_EMPTY_MINFEE= "Minimum fee cannot be empty";
    public static final String TIER_FEE_MGT_EMPTY_FIXEDFEE = "Fixed fee cannot be empty";
    public static final String TIER_FEE_MGT_EMPTY_VARFEE = "Variable fee cannot be empty";
    public static final String TIER_FEE_MGT_IVALID_FIXF = "Fixed fee cannot be less than minimum fee";
    
    // --------------------Merchant Customer Management---------------//
    public static final String MCC_EMPTY_MCCCODE= "Merchant customer category cannot be empty";
    public static final String MCC_EMPTY_DESCRIPTION = "Description cannot be empty";
    public static final String MCC_EMPTY_STATUS = "Status cannot be empty";
        
    //------------------- Terminal Management----------//
    public static final String COMMON_AVAILABLE_MERCHANT = "Merchant ID not exists";
    public static final String COMMON_NOT_AVAILABLE_MERCHANT = "Merchant ID already exists";
    public static final String COMMON_AVAILABLE_TERMINAL = "Terminal ID not exists";
    public static final String COMMON_NOT_AVAILABLE_TERMINAL = "Terminal ID already exists";
    
    public static final String TERMINAL_ORI_EMPTY_ID = "Terminal ID cannot be empty";
    public static final String TERMINAL_ORI_ID_LENGTH = "Terminal ID length should be ";
    public static final String TERMINAL_ORI_EMPTY_TERMINAL_NAME = "Terminal name cannot be empty";
    public static final String TERMINAL_ORI_EMPTY_SERIALNO = "Serial number cannot be empty";
    public static final String TERMINAL_ORI_EMPTY_MANUFACTURER = "Manufacturer cannot be empty";
    public static final String TERMINAL_ORI_EMPTY_MODEL = "Model cannot be empty";
    public static final String TERMINAL_ORI_EMPTY_TERMINAL_STATUS = "Terminal status cannot be empty";
    public static final String TERMINAL_ORI_EMPTY_STATUS = "Status cannot be empty";
    public static final String TERMINAL_ORI_ACT_DEACT_TO_INITIAL = "Status cannot update to initial";
    public static final String TERMINAL_ORI_INITIAL_OTHER = "Initial status cannot update";

    public static final String TERMINAL_ORI_EMPTY_MOBILE = "Mobile cannot be empty";
    public static final String TERMINAL_ORI_INVALID_MOBILE = "Mobile is invalid";
    public static final String TERMINAL_ORI_EMPTY_TERMINAL_CATE = "Terminal category cannot be empty";
    public static final String TERMINAL_ORI_EMPTY_MID = "Merchant ID cannot be empty";
    public static final String TERMINAL_ORI_EMPTY_CURRENCY = "Currency cannot be empty";
    public static final String TERMINAL_ORI_EMPTY_DATE_INSTALLED = "Date installed cannot be empty";

    public static final String TERMINAL_ORI_EMPTY_MCC = "Merchant category cannot be empty";
    public static final String TERMINAL_ORI_EMPTY_RISKPROFILE = "Acquirer risk Profile cannot be empty";
    public static final String TERMINAL_ORI_INVALID_ASSIGN = "Terminal ORI must add before assign transactions";

    // --------------------Merchant Management---------------//
    public static final String GENERATE_SUCC = "generated successfully";

    public static final String MERCHANT_MGT_MERCHANT = "Merchant customer name cannot be empty";
    public static final String MERCHANT_MGT_EMPTY_MCC = "Merchant ID cannot be empty";
    public static final String MERCHANT_MGT_EMPTY_DESCRIPTION = "Description cannot be empty";
    public static final String MERCHANT_MGT_EMPTY_LATITUDE = "Latitude cannot be empty";
    public static final String MERCHANT_MGT_EMPTY_LONGITUDE = "Longitude cannot be empty";
    public static final String MERCHANT_MGT_EMPTY_ADDRESS = "Address cannot be empty";
    public static final String MERCHANT_MGT_INVALID_ADDRESS = "Address is invalid";
    public static final String MERCHANT_MGT_EMPTY_STATUS = "Status cannot be empty";
    public static final String MERCHANT_MGT_EMPTY_COMMISION = "Acquirer commission cannot be empty";
    public static final String MERCHANT_MGT_EMPTY_PROMOTION = "Acquirer promotion cannot be empty";
    public static final String MERCHANT_MGT_EMPTY_LEGAL_NAME = "Legal name cannot be empty";
    public static final String MERCHANT_MGT_EMPTY_TOPUP_ACC = "Top up account cannot be empty";
    public static final String MERCHANT_MGT_EMPTY_POS_ACC = "POS account cannot be empty";
    public static final String MERCHANT_MGT_ERROR_DESC_INVALID = "Description is invalid";
    public static final String MERCHANT_MGT_ERROR_MERCHANT_CODE = "Merchant ID is invalid";
    public static final String MERCHANT_MGT_EMPTY_MERCHANT_CATEGORY_CODE = "Merchant category code cannot be empty";
    
     // --------------------Merchant Customer Management---------------//
    public static final String MERCHANT_CUS_MGT_EMPTY_MID = "Merchant customer code cannot be empty";
    public static final String MERCHANT_CUS_MGT_INVALIDMID = "Merchant customer code is invalid";
    public static final String MERCHANT_CUS_MGT_MERCHANT_NAME = "Merchant customer name cannot be empty";
    public static final String MERCHANT_CUS_MGT_MERCHANT_INVALID_NAME = "Merchant customer name is invalid";
    public static final String MERCHANT_CUS_MGT_MERCHANT_STATUS = "Status cannot be empty";
    public static final String MERCHANT_CUS_MGT_INVALID_MAX_MID = "Merchant customer code maximum length should not exceed ";
    public static final String MERCHANT_CUS_MGT_INVALID_MAX_MERCHANT_NAME = "Merchant customer name maximum length should not exceed ";
    public static final String MERCHANT_CUS_MGT_GENERATE_USER_PASS_EMPTY_MERCHANT_NAME = "Merchant customer name maximum length should not exceed ";

    // --------------------Merchant Management---------------//
    
    public static final String MERCHANT_MGT_EMPTY_CHI_IEX = "Cash in credit income/expenses cannot be empty";
    public static final String MERCHANT_MGT_EMPTY_CHI_FPE = "Cash in credit flat/percentage cannot be empty";
    public static final String MERCHANT_MGT_EMPTY_CHI_AMT = "Cash in credit amount cannot be empty";
    public static final String MERCHANT_MGT_EMPTY_CHI_AMT_PERCENTAGE = "Cash in credit percentage amount should not exceed 100";
    public static final String MERCHANT_MGT_EMPTY_CHI_AMT_ISVALID = "Cash in credit percentage amount";
    public static final String MERCHANT_MGT_EMPTY_CHI_AMT_ISVALID_FLAT = "Cash in credit flat amount";
    public static final String MERCHANT_MGT_EMPTY_CHI_DEB_IEX = "Cash in debit income/expenses cannot be empty";
    public static final String MERCHANT_MGT_EMPTY_CHI_DEB_FPE = "Cash in debit flat/percentage cannot be empty";
    public static final String MERCHANT_MGT_EMPTY_CHI_DEB_AMT = "Cash in debit amount cannot be empty";
    public static final String MERCHANT_MGT_EMPTY_CHI_DEB_AMT_PERCENTAGE = "Cash in debit percentage amount should not exceed 100";
    public static final String MERCHANT_MGT_EMPTY_CHI_DEB_AMT_ISVALID = "Cash in debit percentage amount";
    public static final String MERCHANT_MGT_EMPTY_CHI_DEB_AMT_ISVALID_FLAT = "Cash in debit flat amount";

//    public static final String MERCHANT_MGT_EMPTY_CHO_ACT = "Cash out Credit account type cannot be empty";
    public static final String MERCHANT_MGT_EMPTY_CHO_IEX = "Cash out credit income/expenses cannot be empty";
    public static final String MERCHANT_MGT_EMPTY_CHO_FPE = "Cash out credit flat/percentage cannot be empty";
    public static final String MERCHANT_MGT_EMPTY_CHO_AMT = "Cash out credit amount cannot be empty";
    public static final String MERCHANT_MGT_EMPTY_CHO_AMT_PERCENTAGE = "Cash out credit percentage amount should not exceed 100";
    public static final String MERCHANT_MGT_EMPTY_CHO_AMT_ISVALID = "Cash out credit percentage amount";
    public static final String MERCHANT_MGT_EMPTY_CHO_AMT_ISVALID_FLAT = "Cash out credit flat amount";
    public static final String MERCHANT_MGT_EMPTY_CHO_DEB_IEX = "Cash out debit income/expenses cannot be empty";
    public static final String MERCHANT_MGT_EMPTY_CHO_DEB_FPE = "Cash out debit flat/percentage cannot be empty";
    public static final String MERCHANT_MGT_EMPTY_CHO_DEB_AMT = "Cash out debit amount cannot be empty";
    public static final String MERCHANT_MGT_EMPTY_CHO_DEB_AMT_PERCENTAGE = "Cash out debit percentage amount should not exceed 100";
    public static final String MERCHANT_MGT_EMPTY_CHO_DEB_AMT_ISVALID = "Cash out debit percentage amount";
    public static final String MERCHANT_MGT_EMPTY_CHO_DEB_AMT_ISVALID_FLAT = "Cash out debit flat amount";

//    public static final String MERCHANT_MGT_EMPTY_NOL_ACT = "Normal Credit account type cannot be empty";
    public static final String MERCHANT_MGT_EMPTY_NOL_IEX = "Normal credit income/expenses cannot be empty";
    public static final String MERCHANT_MGT_EMPTY_NOL_FPE = "Normal credit flat/percentage cannot be empty";
    public static final String MERCHANT_MGT_EMPTY_NOL_AMT = "Normal credit amount cannot be empty";
    public static final String MERCHANT_MGT_EMPTY_NOL_AMT_PERCENTAGE = "Normal credit percentage amount should not exceed 100";
    public static final String MERCHANT_MGT_EMPTY_NOL_AMT_ISVALID = "Normal credit percentage amount";
    public static final String MERCHANT_MGT_EMPTY_NOL_AMT_ISVALID_FLAT = "Normal credit flat amount";
    public static final String MERCHANT_MGT_EMPTY_NOL_DEB_IEX = "Normal debit income/expenses cannot be empty";
    public static final String MERCHANT_MGT_EMPTY_NOL_DEB_FPE = "Normal debit flat/percentage cannot be empty";
    public static final String MERCHANT_MGT_EMPTY_NOL_DEB_AMT = "Normal debit amount cannot be empty";
    public static final String MERCHANT_MGT_EMPTY_NOL_DEB_AMT_PERCENTAGE = "Normal debit percentage amount should not exceed 100";
    public static final String MERCHANT_MGT_EMPTY_NOL_DEB_AMT_ISVALID = "Normal debit percentage amount";
    public static final String MERCHANT_MGT_EMPTY_NOL_DEB_AMT_ISVALID_FLAT = "Normal debit flat amount";
    public static final String MERCHANT_MGT_EMPTY_FPE = "Flat/Percentage cannot be empty";
    public static final String MERCHANT_MGT_EMPTY_AMT = "Amount cannot be empty";
    public static final String MERCHANT_MGT_EMPTY_AMT_ISVALID = "Percentage amount";

    public static final String MERCHANT_MGT_EMPTY_MID = "Merchant id cannot be empty";
    public static final String MERCHANT_MGT_INVALID_MID = "Merchant id is invalid";
    public static final String MERCHANT_MGT_MERCHANT_NAME = "Merchant name cannot be empty";
    public static final String MERCHANT_MGT_MERCHANT_INVALID_NAME = "Merchant name is invalid";
    public static final String MERCHANT_MGT_EMPTY_LOGO = "Mobile logo cannot be empty";
    public static final String MERCHANT_MGT_EMPTY_LOGO_WEB = "Web logo cannot be empty";
    public static final String MERCHANT_MGT_EMPTY_RISK_PROFILE = "Acquirer risk profile cannot be empty";
    public static final String MERCHANT_MGT_EMPTY_ = "Risk profile cannot be empty";
    public static final String MERCHANT_MGT_EMPTY_MOBILE = "Mobile cannot be empty";
    public static final String MERCHANT_MGT_EMPTY_CURRENCY = "Currency cannot be empty,Please select one of the currency to proceed";
    public static final String MERCHANT_MGT_EMPTY_MERCANT_MCC = "Merchant category code cannot be empty,Please select one of the category code to proceed";
    public static final String MERCHANT_MGT_EMPTY_TRANSACTION = "Transaction cannot be empty,Please select one of the transaction to proceed";

    public static final String MERCHANT_MGT_INVALID_MAX_MERCHANT = "Merchant customer name maximum length should not exceed ";
    public static final String MERCHANT_MGT_INVALID_MAX_MCC = "Merchant ID maximum length should not exceed ";
    public static final String MERCHANT_MGT_MAX_LATITUDE = "Latitude maximum length should not exceed ";
    public static final String MERCHANT_MGT_INVALID_MAX_RISK_PROFILE = "Risk profile maximum length should not exceed ";
    public static final String MERCHANT_MGT_INVALID_MAX_MOBILE = "Mobile maximum length should not exceed ";
    public static final String MERCHANT_MGT_ERROR_DESC_INVALID_MAX = "Description maximum length should not exceed ";
    public static final String MERCHANT_MGT_INVALID_MAX__STATUS = "Status maximum length should not exceed ";
    public static final String MERCHANT_MGT_ADDRESS_MAX = "Address maximum length should not exceed ";
    public static final String MERCHANT_MGT_MAX_LONGITUDE = "Longitude maximum length should not exceed ";
    public static final String MERCHANT_MGT_INVALID_MAX_MERCHANT_NAME = "Merchant name maximum length should not exceed ";
    public static final String MERCHANT_MGT_INVALID_MAX_MID = "Merchant id maximum length should not exceed ";

    public static final String MERCHANT_MGT_LARGE_IMAGE = "Mobile logo is too large. File size should be less than 1MB.";
    public static final String MERCHANT_MGT_LARGE_IMAGE_WEB = "Web logo image is too large. File size should be less than 1MB.";

    public static final String MERCHANT_MGT_LARGE_WIDTH = "Image width should be less than 480 pixels.";
    public static final String MERCHANT_MGT_LARGE_HEIGHT = "Image height should be less than 800 pixels.";

    public static final String MERCHANT_MGT_INVALID_MERCHANT_NAME = "Merchant name does not exists";
    public static final String MERCHANT_MGT_INVALID_RISK_PROFILE = "Acquirer risk profile does not exists";
    public static final String MERCHANT_MGT_INVALID_STATUS = "Status does not exists";
    public static final String MERCHANT_MGT_INVALID_STATUS_EXCEED = "Status does not exists";
    public static final String MERCHANT_MGT_INVALID_MOBILE = "Mobile is invalid";
    public static final String MERCHANT_MGT_INVALID_CONTACT1 = "Contact number 1 is invalid";
    public static final String MERCHANT_MGT_INVALID_CONTACT2 = "Contact number 2 is invalid";
    public static final String MERCHANT_MGT_INVALID_EMAIL1 = "Email 1 is invalid";
    public static final String MERCHANT_MGT_INVALID_EMAIL2 = "Email 2 is invalid";
    public static final String MERCHANT_MGT_EMPTY_ACC_TYPE = "Account type cannot be empty";
    public static final String MERCHANT_MGT_EMPTY_ACC_NUMBER = "Account number cannot be empty";
    public static final String MERCHANT_MGT_EMPTY_PAYMENT_TYPE = "Payment type cannot be empty";
    public static final String MERCHANT_MGT_EMPTY_BANK = "Bank name cannot be empty";
    public static final String MERCHANT_MGT_EMPTY_BRANCH = "Branch name cannot be empty";
    public static final String MERCHANT_MGT_EMPTY_BRANCH_CODE = "Branch code cannot be empty";
    public static final String MERCHANT_MGT_CURRENCY_TYPE_EXISTS = "Currency type already exists";
    public static final String MERCHANT_MGT_COMMISION_EMPTY = "Please assign merchaant management commission";
    
    //------------------- Acquirer Management----------//
    public static final String SYSUSER_MGT_EMPTY_ID = "User ID cannot be empty";
    public static final String RISK_PROFILE_EMPTY_RISK_PROFILE_TYPE = "Risk profile type cannot be empty";
    public static final String RISK_PROFILE_INVALID_RISK_PROFILE_TYPE = "Risk profile type is invalid";
    public static final String RISK_PROFILE_EMPTY_STATUS = "Status cannot be empty";
    public static final String RISK_PROFILE_EMPTY_TYPE = "Risk profile type cannot be empty";
    public static final String RECORD_ALREADY_IN_USE = "Already assing for a Risk Transaction.";
    public static final String RISK_PROFILE_CURRENCY_EMPTY_TYPE = "Risk profile currency cannot be empty";
    
    public static final String ACQUIRER_PROMOTION_TXN_EMPTY = "Please assign acquirer promotion transactions";
    public static final String ACQUIRER_PROMOTION_TRANSACTION_TYPE_EXISTS = "Transaction type already exists";
    //-------------------- Acquirer Promotion Management --------------------------------
    public static final String ACQUIRER_PROMOTION_MGT_EMPTY_CODE = "Acquirer promotion code cannot be empty";
    public static final String ACQUIRER_PROMOTION_MGT_EMPTY_DESCRIPTION = "Description cannot be empty";
    public static final String ACQUIRER_PROMOTION_MGT_EMPTY_STATUS = "Status should be selected";
    public static final String ACQUIRER_PROMOTION_MGT_EMPTY_TRANSACTION_TYPE = "Transaction type should be selected";
    public static final String ACQUIRER_PROMOTION_MGT_EMPTY_BANK_AMOUNT_TYPE = "Bank amount type should be selected";
    public static final String ACQUIRER_PROMOTION_MGT_EMPTY_BANK_AMOUNT = "Bank amount cannot be empty";
    public static final String ACQUIRER_PROMOTION_MGT_INVALID_BANK_AMOUNT_PER_FLAT = "Bank amount";
    public static final String ACQUIRER_PROMOTION_MGT_EMPTY_BANK_AMOUNT_ISVALID = "Bank amount";
    public static final String ACQUIRER_PROMOTION_MGT_INVALID_BANK_AMOUNT = "Bank amount is invalid";
    public static final String ACQUIRER_PROMOTION_MGT_EMPTY_MERCHANT_AMOUNT_TYPE = "Merchant amount type should be selected";
    public static final String ACQUIRER_PROMOTION_MGT_EMPTY_MERCHANT_AMOUNT = "Merchant amount cannot be empty";
    public static final String ACQUIRER_PROMOTION_MGT_EMPTY_MERCHANT_AMOUNT_PER_FLAT = "Merchant amount";
    public static final String ACQUIRER_PROMOTION_MGT_EMPTY_MERCHANT_AMOUNT_ISVALID = "Merchant amount";
    public static final String ACQUIRER_PROMOTION_MGT_INVALID_MERCHANT_AMOUNT = "Merchant amount is invalid";
    public static final String ACQUIRER_PROMOTION_MGT_EMPTY_CURRENCY = "Acquirer promotion currency cannot be empty";
    
    //------------------------------------------EOD Configuration--------------------------------------
    
    public static final String EOD_CONFIGURATION_EMPTY_ALIPAY_SETTLEMENT_FILE_PATH="Alipy settlement file path cannot be empty";
    public static final String EOD_CONFIGURATION_EMPTY_MERCHANT_SETTLEMENT_FILE_PATH="Merchant settlement file path cannot be empty";
    public static final String EOD_CONFIGURATION_EMPTY_TXN_AMOUNT_TOLERANCE="Txn amount tolerance cannot be empty";
    public static final String EOD_CONFIGURATION_EMPTY_TXN_DAYS_TOLERANCE="Txn days tolerance cannot be empty";
    public static final String EOD_CONFIGURATION_EMPTY_BML_BANK_CODE="BML bank code cannot be empty";
    public static final String EOD_CONFIGURATION_EMPTY_EOD_LOG_PATH="EOD log path cannot be empty";
    public static final String EOD_CONFIGURATION_EMPTY_BRANCH_ID="Branch ID cannot be empty";
    public static final String EOD_CONFIGURATION_INVALID_TXN_AMOUNT_TOLERANCE="Txn amount tolerance is invalid";
    public static final String EOD_CONFIGURATION_INVALID_TXN_DAYS_TOLERANCE="Txn days tolerance is invalid";
}
