import '../../../common/entities/User.dart';

abstract class ProfileEvents{
  const ProfileEvents();

}

class TriggerProfileName extends ProfileEvents{
  final User userProfile;
  const TriggerProfileName(this.userProfile);


}