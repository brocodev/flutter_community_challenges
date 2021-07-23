//--------------------------------------------
// BANK ACCOUNT MODEl
//--------------------------------------------
class BankAccount {
  const BankAccount(
    this.balance,
    this.numberCard,
    this.rawForegroundColor,
    this.bankName,
    this.bankLogo,
    this.imageBackground,
    this.lastTransaction,
  );

  final int numberCard;
  final int rawForegroundColor;
  final double balance;
  final String bankName;
  final String bankLogo;
  final String imageBackground;
  final AccountTransaction lastTransaction;

  static List<BankAccount> get accountCards => [
        //First Account Card
        BankAccount(
          10230,
          9002,
          0x400040FF,
          'BBVA Bancomer',
          'assets/bank_challenge/img/bbva-logo.png',
          'assets/bank_challenge/img/bbva-background.jpg',
          const AccountTransaction('Next 30 July', 'HBO Max', -14.99,
              'assets/bank_challenge/img/hbo-max-logo.webp'),
        ),
        //Second Account Card
        BankAccount(
          1460,
          8021,
          0x40000000,
          'Citi Banamex',
          'assets/bank_challenge/img/citi-logo.png',
          'assets/bank_challenge/img/citi-background.jpg',
          const AccountTransaction('Next 06 August', 'Netflix', -12.99,
              'assets/bank_challenge/img/netflix-logo.jpg'),
        ),
        //Third Account Card
        BankAccount(
          13230,
          9002,
          0x40FF0000,
          'Santander',
          'assets/bank_challenge/img/san-logo.png',
          'assets/bank_challenge/img/santander-background.jpg',
          const AccountTransaction('June 31', 'Deposit', 320.00,
              'assets/bank_challenge/img/save-money.jpg'),
        ),
      ];
}

//--------------------------------------------
// BANK CLIENT MODEL
//--------------------------------------------
class BankClient {
  const BankClient(this.name, this.pathImage, this.accounts);

  final String name;
  final String pathImage;
  final List<BankAccount> accounts;

  static BankClient get currentUser => BankClient(
        'Matt Johnson',
        'assets/bank_challenge/img/user5.jpg',
        BankAccount.accountCards,
      );

  static List<BankClient> get users => [
        BankClient('Francis Garcia', 'assets/bank_challenge/img/user1.jpg', []),
        BankClient('Arthur Li', 'assets/bank_challenge/img/user2.jpg', []),
        BankClient('Christian Lake', 'assets/bank_challenge/img/user3.jpg', []),
        BankClient('Liam Smith', 'assets/bank_challenge/img/user4.jpg', []),
        BankClient('Carl ', 'assets/bank_challenge/img/user6.jpg', []),
        BankClient('Guadalupe', 'assets/bank_challenge/img/user7.jpg', []),
        BankClient('Liliano', 'assets/bank_challenge/img/user8.jpg', []),
      ];
}

//--------------------------------------------
// ACCOUNT TRANSACTIONS MODEL
//--------------------------------------------
class AccountTransaction {
  const AccountTransaction(
    this.header,
    this.concept,
    this.money,
    this.srcImage,
  );

  final String header;
  final String concept;
  final double money;
  final String srcImage;
}
