
import '_utils.dart';

class Common {
  Common._();

  static const String noInternet = 'No internet connection. Please connect online and try again.';
  static const String serverError = 'Server Error. Please try again.';
  static const String somethingWrong = 'Something went wrong.';
  static const String errorMessage = 'Something isn\'t working. This may be because of a technical error we\'re working to fix.';

  /// User Status
  static const String rejected = 'Your account has been rejected. Please contact sent message in $websiteVisit website for assistance.';
  static const String deactivated = 'Your account has been deactivated. Please contact sent message in $websiteVisit website for assistance.';

  /// Job Vacancies Applicant
  static const String jobApplicantExistTitle = 'Confirm Application';
  static const String jobApplicantExistMessage = 'We\'ll use your current application details. You can update them before applying.';
  static const String jobApplicantExistOk = 'Submit Application';
  static const String jobApplicantExistCancel = 'Update Application Details';

  /// Create Job Seeker Profile
  static const String createJobProfileTitle = 'Create Your Job Seeker Profile';
  static const String createJobProfileMessage = 'Fill out the Job Seeker Registration Form to proceed';
  static const String createJobProfileOk = 'Proceed to Registration';

  /// Apply Now Status
  static const String applyNowSuccessTitle = 'Application Sent';
  static const String applyNowSuccessMessage = 'Your application has been submitted successfully.';
  static const String applyNowOngoingTitle = 'Application Ongoing';
  static const String applyNowOngoingMessage = 'You already submit';
}