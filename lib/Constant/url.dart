
// ignore_for_file: constant_identifier_names

class AppUrls{
  // Base Url....// IP Address
  static const BaseUrl= "http://ecs-api-earlyshuttle-service-1370643159.ap-south-1.elb.amazonaws.com/";

  //=================================================

  static const LoginApiUrl= "${BaseUrl}send-otp";

  static const HomePageTextBannerApiUrl= "${BaseUrl}get-banner";

  static const VerifyOtpApiUrl= "${BaseUrl}verify-otp";

  static const RegisterApiUrl= "${BaseUrl}register";

  static const NotificatinApiUrl= "${BaseUrl}notifications";

  static const FindRoutesApiUrl = "${BaseUrl}find-routes";

  static const GetAllStopsApiUrl= "${BaseUrl}getAllStops";

  static const ExploreRouteApiUrl= "${BaseUrl}get-routes";

  static const PassPurchaseApiUrl= "${BaseUrl}get-pass-routes";

  static const CurrentPassApiUrl= "${BaseUrl}get-user-passes-current";

  static const helpCallWriteApiurl= "${BaseUrl}getContactUs";

  static const ProfileViewApiUrl= "${BaseUrl}get-profile-new";

  static const CurrentRideApiUrl= "${BaseUrl}current-routes";

  static const HomePageImageSliderApiUrl= "${BaseUrl}default-home-api";

  static const LoginTermsOfUseApiUrl= "${BaseUrl}get-terms-of-use";

  static const PassTermsCondidtionApiUrl= "${BaseUrl}get-passes-terms-and-condition";

  static const UserCouponsApiUrl= "${BaseUrl}getUserCoupons";

  static const ReferalDataApiurl= "${BaseUrl}get-referral-detail";

  static const SubmitReferalDataApiUrl= "${BaseUrl}submit-referral";

  static const QuickBookDataApiUrl= "${BaseUrl}getLastShuttle";

  static const UpdateUserProfileDataApiUrl= "${BaseUrl}update-profile";

  static const ExpiredPassApiUrl= "${BaseUrl}get-user-passes-expired";

  static const EmergencyUserContacts= "${BaseUrl}get-emergency-contact";

  static const AddEmergencyContactApiUrl= "${BaseUrl}add-emergency-contact";

  static const DeleteEmergencyContactApiUrl= "${BaseUrl}delete-emergency-contact";

  static const UpdateEmergencyContactApiUrl= "${BaseUrl}update-emergency-contact";

  static const TripRelatedTicketTypeApiUrl= "${BaseUrl}get-ticket-types";

  static const SubmitTicketApiUrl= "${BaseUrl}submit-ticket";

  static const ViewSubmitTicketListApiUrl= "${BaseUrl}submit-help";

  static const RideHistoryApiUrl= "${BaseUrl}ride-history";

  static const BusTimeSlotApiUrl= "${BaseUrl}find-route-buses";

  static const GetBookingTranscationApiUrl= "${BaseUrl}shuttle-book-new";

  static const PaymentAndConfirmBookingApiUrl= "${BaseUrl}payment-store-new";

  static const CancelBookedRideApiUrl= "${BaseUrl}cancel-ride";

  static const CreditRideApiUrl= "${BaseUrl}credit-ride";

  static const DialogReasonsListApiUrl= "${BaseUrl}dialogue-message";

  static const BookCancelRideApiUrl= "${BaseUrl}book-cancelled-ride";

  static const RescheduleRideApiUrl= "${BaseUrl}reschedule-ride";

  static const ApplyPromoCouponApiUrl= "${BaseUrl}applyPromoOnPass";

  static const CheckPhonePePaymentStatusApiUrl= "${BaseUrl}check-phonepay-response";

  static const SendEmailOtp= "${BaseUrl}sendEmailOtp";

  static const VerifyEmailOtp= "${BaseUrl}verifyEmailOtp";
}