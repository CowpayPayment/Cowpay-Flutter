class TokenizedCard {
  final String tokenId;
  final String cardCvv;
  final String returnUrl3DS;

  TokenizedCard({
    required this.cardCvv,
    required this.tokenId,
    required this.returnUrl3DS,
  });
}
