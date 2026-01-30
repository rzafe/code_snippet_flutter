
/// DEVELOPMENT
const bool isProduction = true;

/// CMS CONSTANTS
const String baseURL = 'https://b4w9hdnsh4.execute-api.ap-southeast-1.amazonaws.com/production/';
const String baseURLLoginPost = 'login_post';
const String baseURLTransactionPost = 'transaction_post';
const String baseURLLoginGet = 'login_get';
const String baseURLTransactionGet = 'transaction_get';
const String appName = 'Tayabazen';
const String senderName = 'Tayabazen';

/// Website
const String websiteVisit = 'https://tayabas.gov.ph/';
const String defaultWebsite = 'https://tayabas.gov.ph/';

/// User Status
const String userStatusVerified = 'VERIFIED';
const String userStatusForReview = 'FOR REVIEW';
const String userStatusPending = 'PENDING';
const String userStatusNotVerified = 'NOT_VERIFIED';
const String userStatusCompliance = 'RECOMPLIANCE';
const String userStatusForVerified = 'FOR VERIFICATION';
const String userStatusDenied = 'DENIED';
const String userStatusGuest = 'GUEST';
const String userStatusDeactivated = 'DEACTIVATED';

/// Default Place
const String defaultCountry = 'PHILIPPINES';

/// Screen Name
const String signupScreen = 'signup';
const String forgotPinScreen = 'forgot_pin';

/// For Drawer
enum SupportState {
  unknown,
  supported,
  unsupported,
}

/// Gender
List<String> genderList = [
  'FEMALE',
  'MALE'
];

/// Civil Status
List<String> civilStatusList = [
  'SINGLE',
  'MARRIED',
  'WIDOW',
  'WIDOWER',
  'ANNULLED',
  'DIVORCED',
];

/// Employment Type List
List<String> employmentTypeList = [
  'Full-time',
  'Part-time',
  'Self-employed',
  'Temporary',
  'Contractual',
  'Freelance',
  'Other',
  'Internship',
  'Commission-based',
];

/// Employment Status
List<String> employmentStatusList = [
  'EMPLOYED',
  'SELF-EMPLOYED',
  'UNEMPLOYED',
];

/// APPLICATION CATEGORY
List<String> applicationCategoryList = [
  'Technology',
  'Healthcare',
  'Finance',
  'Education',
  'Non-profit',
  'Marketing',
  'Sales',
  'Engineering',
  'Human Resources',
  'Customer Service',
  'Internships',
  'Apprenticeships',
  'Entry-Level Positions',
  'Managerial Roles',
  'Freelance/Contract Roles'
];

/// Religion
List<String> religionList = [
  'Aglipayan',
  'Association of Fundamentals Baptist',
  'Bible Baptist Church',
  'Buddhist',
  'Church of Christ',
  'Churches in the Philippines',
  'Conservative Baptist Association of the Philippines',
  'Convention of the Philippines Baptist Church',
  'Crusaders of the Divine Church of Christ Inc.',
  'Evangelical Christian Outreach Foundation',
  'Evangelicals (PCEC)',
  'Faith Tabernacle Church',
  'Iglesia ni Cristo',
  'Iglesia sa Dios Espiritu Santo Inc.',
  'Islam',
  'Jehovas Witnesses',
  'Jesus is Lord Church',
  'Lutheran Church of the Phillipines',
  'Others',
  'Philippine Benevolent Missionaries Association',
  'Philippine Independent Catholic Church',
  'Roman Catholic',
  'Seventh-day Adventist',
  'The Church of Jesus Christ of Latter-Day Saints',
  'Union Esperitista Cristiana de Filipinas, Inc.',
  'United Church of Christ in the Philippines',
  'United Pentecostal Church Inc.',
];

final List<Map<String, dynamic>> serviceItems = [
  {
    "title": "Sanitary permit for Food and Non Food Establishments",
  },
  {
    "title": "Health Certificate/Health Card",
  },
  {
    "title": "Inspection of Food and Non Food Establishments",
  },
  {
    "title": "Burial Permit",
  },
  {
    "title": "Transfer Permit of Food",
  },
  {
    "title": "Water Test",
  },
  {
    "title": "Transfer of Skeletal / Exhumation",
  },
  {
    "title": "Transfer of Cadaver",
  },
  {
    "title": "Certificate of Siphoning",
  },
  {
    "title": "Water Potability Certificate",
  },

  /// For Health Services
  {
    'title': 'Barangay Health Stations & Clinical Schedules',
  },
  {
    'title': 'Appointment',
  },
  {
    'title': 'Clinical Records',
  },
  {
    'title': 'Medicine Issuance',
  },
  {
    'title': 'Rabies Exposure History',
  },
  {
    'title': 'Nutrition Consultation Records',
  },
  {
    'title': 'Nutrition Meal Plan',
  },
  {
    "title": "Sanitation Health Services",
  },
];

/// Classification
List<String> classificationList = [
  'Indigent',
  'Pensioner',
  'Supported',
];

/// Pension Range
List<String> pensionRangeList = [
  'Below P999.00',
  'P1,000.00 - P4,999.00',
  'P5,000.00 - P9,999.00',
  'P10,000.00 - P14,999.00',
  'P15,000.00 - P19,999.00',
  'P20,000.00 - P24,999.00',
  'P25,000.00 - P29,999.00',
  'P30,000.00 - P34,999.00',
  'P35,000.00 - P39,999.00',
  'P40,000.00 - P44,999.00',
  'P45,000.00 - P49,999.00',
  'Above P50,000.00',
];

/// Blood Type
List<String> bloodTypeList = [
  'O+',
  'A+',
  'B+',
  'AB+',
  'O-',
  'A-',
  'B-',
  'AB-',
];

final Map<String, List<String>> validIDTypeAliases = {
  "Driver's License": [
    "driver's license", "drivers license", "license", "dl"
  ],
  "Firearms License": [
    "firearms license", "gun license", "firearm license"
  ],
  "Passport": [
    "passport", "philippine passport", "foreign passport"
  ],
  "National ID/Philippine Identification System (PhilSys) ID": [
    "national id", "philsys id", "philippine id", "philippine identification system"
  ],
  "UMID Card": [
    "umid", "unified multi-purpose id", "unified multi purpose id", "umid card"
  ],
  "GSIS ID": [
    "gsis id", "gsis", "government service insurance system id"
  ],
  "NBI Clearance": [
    "nbi clearance", "nbi", "national bureau of investigation clearance"
  ],
  "Employee's ID": [
    "employee id", "company id", "work id", "employee's id"
  ],
  "Professional Regulation Commission (PRC) ID": [
    "prc id", "prc", "professional regulation commission id"
  ],
  "Senior Citizen ID": [
    "senior citizen id", "senior id", "senior card"
  ],
  "Voter's ID": [
    "voter id", "voter's id", "voters id", "comelec id"
  ],
  "Postal ID": [
    "postal id", "philpost id", "post office id"
  ],
  "Marriage Certificate": [
    "marriage certificate", "certificate of marriage"
  ],
  "OFW ID": [
    "ofw id", "overseas filipino worker id", "overseas worker id"
  ],
  "PRC ID": [
    "prc id", "professional regulation commission id", "prc"
  ],
  "Overseas Employment Certificate (OEC)": [
    "oec", "overseas employment certificate"
  ],
  "PhilHealth ID": [
    "philhealth id", "philhealth", "philhealth card"
  ],
  "Barangay ID": [
    "barangay id", "brgy id", "barangay clearance"
  ],
  "Diplomatic ID": [
    "diplomatic id", "diplomat id", "dfa id"
  ],
  "TIN ID": [
    "tin id", "tax identification number", "tin", "bir id"
  ],
  "Police Clearance": [
    "police clearance", "pnp clearance"
  ],
  "Person’s With Disability (PWD) ID": [
    "pwd id", "person with disability id", "disabled id"
  ],
  "School ID": [
    "school id", "student id", "university id", "college id"
  ],
  "Seaman's Book": [
    "seaman's book", "seafarer's identification", "srb", "sid", "seaman id"
  ],
};

/// SCHOOL SECTOR
List<String> schoolSectorList = [
  'PRIVATE',
  'PUBLIC'
];

/// Education Attainment
final List<String> educationAttainmentList = [
  'Elementary',
  'Elementary UnderGrad',
  'High School',
  'High School UnderGrad',
  'K-12 Senior High',
  'Vocational Course',
  'College UnderGrad',
  'Some College No Degree',
  'Associates Degree',
  'Bachelors Degree',
];

/// Yes or No
List<String> yesNoList = [
  'YES',
  'NO',
];

List<String> assistanceMedicalOptions = [
  "Guarantee Letter",
  "Laboratory Request Assistance",
  "Financial Assistance",
  "Medicine",
];

List<String> assistedByOptions = [
  "Representative", "Self",
];

List<String> contactMethods = [
  "Phone Call",
  "Text Message",
  "Email",
];

List<String> whoApplying = [
  "Myself",
  "Others",
];

List<String> validIDTypeList = [
  'Driver\'s License',
  'Firearms License',
  'Passport',
  'National ID/Philippine Identification System (PhilSys) ID',
  'UMID Card',
  'GSIS ID',
  'NBI Clearance',
  'Employee\'s ID',
  'Professional Regulation Commission (PRC) ID',
  'Senior Citizen ID',
  'Voter\'s ID',
  'Postal ID',
  'Marriage Certificate',
  'OFW ID',
  'PRC ID',
  'Overseas Employment Certificate (OEC)',
  'PhilHealth ID',
  'Barangay ID',
  'Diplomatic ID',
  'TIN ID',
  'Police Clearance',
  'Person’s With Disability (PWD) ID',
  'School ID',
  'Seaman\'s Book',
];





