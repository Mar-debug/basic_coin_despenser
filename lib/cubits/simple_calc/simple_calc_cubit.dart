import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'simple_calc_state.dart';

class SimpleCalcCubit extends Cubit<SimpleCalcState> {
  SimpleCalcCubit() : super(SimpleCalcCalculated({}, 0));

  List<num> validDenominations = [200, 50, 20, 10, 5, 2, 1, 0.5, 0.2];

  void calculateWithMod(double? cost, double? tender) {
    if (cost == null || tender == null) return;

    num totalChange = tender - cost;
    Map<String, num> breakdown = {};

    //iterating through the cash choices to see what change to give
    for(var i =0; i< validDenominations.length; i++){
      //this is to calculate how much of each note or coins to give for the change
      var tempNum = (totalChange/validDenominations[i]).floor();
      totalChange= totalChange%validDenominations[i];

      //makes sure to only show the values that's being used
      if(tempNum > 0){
        breakdown['${validDenominations[i]}'] = tempNum;
      }
    }
    //totalChange is used again because its been overwritten in the for loop
  totalChange = tender - cost;

    emit(SimpleCalcCalculated(breakdown, totalChange));
  }

  void clearAll() {
    emit(SimpleCalcCalculated({}, 0));
  }
}
