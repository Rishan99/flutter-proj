enum ViewState { idle, busy, error }

enum ApplicationType {
  customer("customer"),
  merchantCustomer("merchantcustomer");

  final String typeName;
  const ApplicationType(this.typeName);
}

enum MessageState { received, sending, error }

enum RoleEnum { merchant, customer }

enum PointFilterType {
  earned(1),
  redeemed(2),
  remaining(3);

  final int id;
  const PointFilterType(this.id);
}

enum ResendOtpType {
  password("password"),
  register("register");

  const ResendOtpType(this.name);

  final String name;
}

enum DeliveryLocationMode { mylocation, mapLocation }

enum LoginMethod { email, facebook, google, apple }

enum ForgotPasswordState { phoneNumber, otp, resetPassword, resetSuccess }

enum RegisterBusinessStatus {
  notRegistered("not_registered"),
  pending("pending"),
  approved("approved");

  const RegisterBusinessStatus(this.name);

  final String name;
}

enum Gender {
  male("Male", 1),
  female("Female", 2),
  other("Others", 3);

  const Gender(this.name, this.id);

  final String name;
  final int id;
}

enum PageTypes {
  points("Points"),
  // discount("Discount"),
  deals("Deals"),
  events("Events"),
  vouchers("Vouchers"),
  jobs("Jobs"),
  introducing("Introducing");

  const PageTypes(
    this.name,
  );

  final String name;
}

enum FilterType {
  onlyMe(0, "Only My", "me"),
  all(1, "All", "all");

  const FilterType(
    this.pageIndex,
    this.name,
    this.filterValue,
  );
  final int pageIndex;
  final String name;
  final String filterValue;
}

enum SortType {
  distance("Distance"),
  latest("Latest"),
  businessNameAsc("Name - Ascending"),
  businessNameDesc("Name - Descending"),
  discountAsc("Discount Percentage - Low to High"),
  discountDesc("Discount Percentage - High to Low");

  const SortType(
    this.name,
  );

  final String name;
}

enum BusinessDetailTypeEnum {
  overview("Overview", 1, "overview"),
  menu("Menu", 2, "menu"),
  rates("Tariff", 3, "tariff"),
  gallery("Gallery", 8, "gallery"),
  newArrival("Introducing", 7, "introducing"),
  events("Events", 5, "events"),
  deals("Deals", 4, "deals"),
  vouchers("Vouchers", 6, "vouchers"),
  jobs("Job", 8, "job"),
  stampCard("Stamp Cards", 9, "stampcards");

  const BusinessDetailTypeEnum(
    this.name,
    this.order,
    this.filterName,
  );

  final String name;
  final String filterName;
  final int order;
}

enum UnoCardHolderType {
  notApplied(1, "NotApplied"),
  pending(2, "Pending"),
  member(3, "Member"),
  expired(4, "Expired"),
  renewPending(5, "Renew-Pending");

  const UnoCardHolderType(
    this.id,
    this.name,
  );

  final int id;
  final String name;
}

enum CardType {
  silver("Silver"),
  gold("Gold");

  const CardType(
    this.name,
  );

  final String name;
}

enum PointType {
  redeemed("Redeemed"),
  earned("Earned"),
  remaining("Remaining");

  const PointType(
    this.name,
  );

  final String name;
}

enum ClaimDiscountState {
  scanQr,
  notClaimed,
  pending,
  claimed,
}

enum SocialMediaLinkType {
  facebook("Facebook"),
  instagram("Instagram"),
  website("Website"),
  whatsapp("Whatsapp"),
  viber("Viber");

  const SocialMediaLinkType(
    this.name,
  );

  final String name;
}
