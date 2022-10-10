// general
const int MAX_NOP = 15;

// addresses

// WEB DEBUGGING
//const String ADDRESS_STORE_SERVER = "localhost:8180";
//const String ADDRESS_STORE_SERVER = "localhost:80";

const String ADDRESS_STORE_SERVER = "54.241.103.59:80";




// requests


// responses
const String RESPONSE_ERROR_MAIL_USER_ALREADY_EXISTS =
    "ERROR_MAIL_USER_ALREADY_EXISTS";

// docent
const String REQUEST_SEARCH_DOCENT_BY_EMAIL= "/cloudapi/Docent/showDocent";
const String REQUEST_SHOW_DOCENT_THESES = "/cloudapi/Docent/docentThesis";
const String REQUEST_ADD_NEW_THESIS = "/cloudapi/Docent/newThesis";
const String REQUEST_ADD_SUPERVISOR = "/cloudapi/Docent/addSupervisor";
const String REQUEST_SEARCH_DOCENT = "/cloudapi/Docent/searchDocents";
const String REQUEST_ADD_NEW_DOCENT = "/cloudapi/Docent/newDocent";
const String REQUEST_ADD_NEW_STUDENT = "/cloudapi/Docent/newStudent";
const String REQUEST_DOCENT_REGISTRATION = "/cloudapi/Docent/registration";
const String REQUEST_DOCENT_LOGIN = "/cloudapi/Docent/login";

//student
const String REQUEST_SEARCH_STUDENT_BY_EMAIL="/cloudapi/Student/showStudent" ;
const String REQUEST_SHOW_STUDENT_THESES = "/cloudapi/Student/studentThesis";
const String REQUEST_SEARCH_STUDENT = "/cloudapi/Student/searchStudents";
const String REQUEST_STUDENT_REGISTRATION = "/cloudapi/Student/registration";
const String REQUEST_STUDENT_LOGIN = "/cloudapi/Student/login";


//message
const String REQUEST_SHOW_UNREAD_MESSAGE = "/cloudapi/Message/notifyMessage";
const String REQUEST_SHOW_MESSAGES_CONVERSATION = "/cloudapi/Message/showAllMessagesConversation";
const String REQUEST_SEND_MESSAGE = "/cloudapi/Message/send";
//File
const String REQUEST_UPLOAD_FILE = "/cloudapi/api/v1/file/update";
const String REQUEST_DOWNLOAD_FILE = "/cloudapi/api/v1/file/download";
//Thesis
const String REQUEST_SHOW_ALL_THESIS_FILES = "/cloudapi/Thesis/files";
const REQUEST_SHOW_THESIS = "/cloudapi/Thesis/details";

// messages
const String MESSAGE_CONNECTION_ERROR = "connection_error";
