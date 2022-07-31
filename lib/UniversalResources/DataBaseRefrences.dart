import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

final usersReference = FirebaseFirestore.instance.collection("Users");

firebase_storage.Reference storageReference =
    firebase_storage.FirebaseStorage.instance.ref();

/// RTD test or Old

final rtMessages = FirebaseDatabase.instance.reference();

/// RTD Working
final userRefRTD =
    FirebaseDatabase.instance.reference().child("switchUsers-786");
final userRefForSearchRtd =
    FirebaseDatabase.instance.reference().child("searchUsers-786");
final chatListRtDatabaseReference =
    FirebaseDatabase.instance.reference().child("switchChatList-786");

// final compareListRtDatabaseReference =
//
//     FirebaseDatabase.instance.reference().child("compareList");

final messageRtDatabaseReference =
    FirebaseDatabase.instance.reference().child("switchChatMessages-786");

final commentRtDatabaseReference =
    FirebaseDatabase.instance.reference().child("switchComments-786");

final reactRtDatabaseReference =
    FirebaseDatabase.instance.reference().child("switchPostReacts-786");

final feedRtDatabaseReference =
    FirebaseDatabase.instance.reference().child("switchNotifyFeed-786");
final crushOfRTD =
    FirebaseDatabase.instance.reference().child("switchCrushOf-786");
final crushOnRTD =
    FirebaseDatabase.instance.reference().child("switchCrushOn-786");

final relationShipReferenceRtd =
    FirebaseDatabase.instance.reference().child("switchRelationShips-786");
final chatMoodReferenceRtd =
    FirebaseDatabase.instance.reference().child("switchChatMood-786");

final userProfileDecencyReport =
    FirebaseDatabase.instance.reference().child("switchProfileDecency-786");

final switchMoodLinksRTD = FirebaseDatabase.instance.reference().child("Moods");

final switchUserMoodsRTD =
    FirebaseDatabase.instance.reference().child("switchUserMoods-786");

final postsRtd =
    FirebaseDatabase.instance.reference().child("switchUsersPosts-786");

final userFollowingRtd = FirebaseDatabase.instance
    .reference()
    .child("switchFollowing-786"); //you following

final userFollowersRtd = FirebaseDatabase.instance
    .reference()
    .child("switchFollowers-786"); // your follower

final bestFriendsRtd =
    FirebaseDatabase.instance.reference().child("switchBesties-786");

final memeProfileRtd =
    FirebaseDatabase.instance.reference().child("switchMemeProfile-786");

final memerPercentageDecencyRtd =
    FirebaseDatabase.instance.reference().child("switchMemerDecency-786");

final userFollowersCountRtd = FirebaseDatabase.instance
    .reference()
    .child("switchFollowerCount-786"); // your follower

final appControlRTD =
    FirebaseDatabase.instance.reference().child("switchAppControl-786");

final clustyChatRTD =
    FirebaseDatabase.instance.reference().child("switchClsutyChat-786");

final reportRTD =
    FirebaseDatabase.instance.reference().child("switchReport-786");

final blockListRTD =
    FirebaseDatabase.instance.reference().child("switchBlockList-786");

final switchManiaTopicListRTD =
    FirebaseDatabase.instance.reference().child("SwitchManiaTopics");

final switchShowCaseRTD =
    FirebaseDatabase.instance.reference().child("memeShowCase-786");

final memeAndStuffRTD =
    FirebaseDatabase.instance.reference().child("MemeAndStuff-786");

final topMemerfRTD = FirebaseDatabase.instance.reference().child("TopMemer");

final switchAllUserIdRTD =
    FirebaseDatabase.instance.reference().child("AllUserId-786");

final switchAllUserFeedPostsRTD =
    FirebaseDatabase.instance.reference().child("AllUserFeedPosts-786");


/// This is slit function, All we need is to search "Slit is here" and uncomment
/// the comments, And at the end we need to unComment and place Total slit button
/// and to find that button we need to search this "This is slit button"

// final switchMemerSlitsRTD =
//     FirebaseDatabase.instance.reference().child("Memers-Slits-786");

final switchMemeCompRTD =
    FirebaseDatabase.instance.reference().child("switchMemeComp-786");

final topWinnerRTD =
    FirebaseDatabase.instance.reference().child("switchMemeCompWinner-786");

final switchCompTopicListRTD =
    FirebaseDatabase.instance.reference().child("switchCompTopicListRTD-786");


final switchHelpLinkListRTD =
FirebaseDatabase.instance.reference().child("switchHelpLinkListRTD-786");

