// enum EUserType {
//   customer,
//   driver,
// }

// class UserType {
//   const UserType._();

//   static EUserType type({required final int input}) {
//     switch (input) {
//       case 0:
//         return EUserType.customer;
//       case 1:
//         return EUserType.driver;
//     }
//   }

//   static EUserType typeFromString({required final String input}) =>
//       type(input: int.parse(input));

//   static int translate({required final EUserType input}) {
//     switch (input) {
//       case EUserType.customer:
//         return 0;
//       case EUserType.driver:
//         return 1;
//     }
//   }

//   static String translateAsString({required final EUserType input}) =>
//       "${translate(input: input)}";
// }
