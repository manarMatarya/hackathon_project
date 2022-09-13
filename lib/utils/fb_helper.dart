import 'package:hackathon_project/models/fb_response.dart';

mixin FirebaseHelper {
  FbResponse get successResponce => FbResponse('تمت المهمة بنجاح', true);
  FbResponse get errorResponce => FbResponse('فشلت المهمة ', false);
}
