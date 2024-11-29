
class AuthEntity {
final String uid;
final String? email;
 String? documentId;
 String? displayName;
 String? imageUrl;
 String? phoneNumber;
 String? address;
 String? paymentMethods;
 String? orderHistory;


AuthEntity( {required this.uid, required this.email,this.documentId,  this.displayName,  this.imageUrl, this.phoneNumber,this.address, this.paymentMethods, this.orderHistory});

}
