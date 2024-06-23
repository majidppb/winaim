enum SaleStages {
  co,
  de,
  pr,
  ne,
  wo,
  po;

  String getName() {
    switch (this) {
      case SaleStages.co:
        return 'Contact';
      case SaleStages.de:
        return 'Demo';
      case SaleStages.pr:
        return 'Proposal';
      case SaleStages.ne:
        return 'Negotiation';
      case SaleStages.wo:
        return 'Sale won';
      case SaleStages.po:
        return 'Post sale';
    }
  }

  static SaleStages fromString(String value) {
    switch (value) {
      case 'co':
        return SaleStages.co;
      case 'de':
        return SaleStages.de;
      case 'pr':
        return SaleStages.pr;
      case 'ne':
        return SaleStages.ne;
      case 'wo':
        return SaleStages.wo;
      case 'po':
        return SaleStages.po;
      default:
        return SaleStages.co;
    }
  }
}
