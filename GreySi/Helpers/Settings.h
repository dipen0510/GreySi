//
//  Settings.h
//  GreySi
//
//  Created by Dipen Sekhsaria on 16/08/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#ifndef Settings_h
#define Settings_h

#define DomainBaseURL @"http://greyscissors.com/GreySi"

#define kSignUpService @"signUp.php"
#define kLoginService @"login.php"

#define kPostLocation @"Location/PostLocation.php"
#define kGetLocation @"Location/GetLocation.php?User_id="
#define kGetProfileInfo @"Get.php?User_id="

#define kUploadProfileService @"upload.php"

// CUSTOMER
#define kCustomerGetAdService @"Hair_dressor_post/GetAd.php"
#define kCustomerGetPostedProjectsService @"Customer_Projects/PostedProjects.php?User_id="
#define kCustomerGetActiveProjectsService @"Customer_Projects/ActiveProjects.php?User_id="
#define kCustomerGetCompletedProjectsService @"Customer_Projects/CompletedProjects.php?User_id="
#define kCustomerAddTreatmentService @"Project%20Posting%20Module/AddTreatment.php"
#define kCustomerBookingsService @"GetByBookerid.php?Booker_id="
#define kCustomerFetchBidService @"FetchBid.php?Project_id="
#define kCustomerAssignProjectService @"Complete_Project_Section/AssignProject.php"
#define kCustomerBookProjectService @"PostBooking.php"
#define kCustomerProjectComplete @"Complete_Project_Section/TreatmentComplete.php"
#define kCustomerPostReviewService @"Reviews/PostReview.php"

//HAIRDRESSER
#define kHairFetchProjectsService @"FetchProject.php"
#define kHairGetBiddedProjectsService @"BidddedProject.php?User_id="
#define kHairGetActiveProjectsService @"Active_Project_Hairdresser.php?User_id="
#define kHairGetCompletedProjectsService @"Completed_Project_Hairdresser.php?User_id="
#define kHairBookingsService @"GetByHairdresser.php?Hairdresser_id="
#define kHairPostAdService @"Hair_dressor_post/PostAd.php"
#define kHairPlaceBidService @"PostBid.php"
#define kHairProjectComplete @"CompleteBooking.php"

#endif /* Settings_h */
