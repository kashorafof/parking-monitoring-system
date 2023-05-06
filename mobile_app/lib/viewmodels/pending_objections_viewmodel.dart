
import 'package:mobile_app/repositories/pending_objections_repository.dart';

void AcceptObjection(String ID){
  changeObjectionStatus(ID, true);
  
}