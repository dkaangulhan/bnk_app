import 'package:banking_application/models/card_data_model.dart';
import 'package:flutter/material.dart';

const kPrimaryTextColor = Color(0xFF262851);
const kWhiteishBackgroundColor = Color(0xFFD4E1FC);

const kStickInfoMargin = EdgeInsets.only(right: 25.0);

const kDummyOperationsUrl = 'http://10.0.2.2:3000/users/operations';
const dummyUser = 'user1';

/*Height of items which displays transaction history. Also, used in
ListIndicatorLine widget's custom painter
to draw lines between transactions.*/
const kTransactionHistoryListHeight = 68.0;

final dummyOperations = {
  '1': {
    "owner": "user1",
    "cardId": "1234",
    "provider": "MasterCard",
    "transactions": {
      "1": {
        "from": "user1",
        "to": "Computer Shop",
        "total": 62,
        "date": "2022-11-24 17:05:29.338"
      },
      "2": {
        "from": "user1",
        "to": "Grocery",
        "total": 86,
        "date": "2022-11-24 17:01:29.338"
      },
      "3": {
        "from": "Christina Erikksen",
        "to": "user1",
        "total": 38,
        "date": "2022-11-24 17:02:29.338"
      },
      "4": {
        "from": "user1",
        "to": "Grocery",
        "total": 62,
        "date": "2022-11-24 17:05:29.338"
      },
      "5": {
        "from": "user1",
        "to": "Tax",
        "total": 86,
        "date": "2022-11-24 17:01:29.338"
      },
      "6": {
        "from": "Christina Erikksen",
        "to": "user1",
        "total": 25,
        "date": "2022-11-24 17:02:29.338"
      },
      "7": {
        "from": "Christina Erikksen",
        "to": "user1",
        "total": 42,
        "date": "2022-11-24 17:02:29.338"
      },
    }
  },
  '2': {
    "owner": "user1",
    "cardId": "2345",
    "provider": "MasterCard",
    "transactions": {
      "1": {
        "from": "user1",
        "to": "Mobile Operator",
        "total": 224,
        "date": "2022-11-24 17:05:29.338"
      },
      "2": {
        "from": "user1",
        "to": "Tax",
        "total": 54,
        "date": "2022-11-24 17:01:29.338"
      },
      "3": {
        "from": "Sebastian Kane",
        "to": "user1",
        "total": 96,
        "date": "2022-11-24 17:02:29.338"
      }
    }
  }
};
