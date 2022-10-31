import 'dart:io';

void main() {
  Game game = Game();
  print('Welcome to card game!');
  print('Available commands:');
  print(
      '"deal" - Deal a configurable number of cards to a configurable number of players');
  print('"show players cards" - show the cards each player has been dealt');
  print('"shuffle" - shuffle cards');
  print('"restart" - start a new game');

  while (true) {
    final input = stdin.readLineSync();
    if (input == 'deal') {
      print("Write num of cards to be dealt:");
      final cards = stdin.readLineSync();
      print("Write num of players:");
      final players = stdin.readLineSync();
      game.deal(cards: cards, playersCount: players);
    } else if (input == 'shuffle') {
      game.deck.shuffle();
    } else if (input == 'show players cards') {
      game.showPlayersHands();
    } else if (input == 'restart') {
      game = Game();
      print('Game restarted');
    } else if (input == 'q') {
      break;
    } else {
      print('Unknown command');
    }
  }
}

class Card {
  String rank;
  String suit;

  Card(this.rank, this.suit);

  showCard() {
    return '$rank of $suit';
  }
}

class Deck {
  List<Card> cards = [];

  Deck() {
    var ranks = [
      'Two',
      'Three',
      'Four',
      'Five',
      'Six',
      'Seven',
      'Eight',
      'Nine',
      'Ten',
      'Jack',
      'Queen',
      'King',
      'Ace'
    ];
    var suits = ['Hearts', 'Clubs', 'Diamonds', 'Spades'];

    for (var suit in suits) {
      for (var rank in ranks) {
        var card = Card(rank, suit);
        cards.add(card);
      }
    }
  }

  String showDeck() {
    return cards.map((c) => c.showCard()).toList().join(', ');
  }

  void shuffle() {
    cards.shuffle();
    print('Cards shuffled');
  }
}

class Player {
  int? number;
  List<Card> cardsOnHand;

  Player({this.number, this.cardsOnHand = const []});

  String showHand() {
    return cardsOnHand.map((c) => c.showCard()).toList().join(', ');
  }
}

class Game {
  Deck deck = Deck();
  List<Player> players = [];

  void deal({String? cards, String? playersCount}) {
    if (cards == null || playersCount == null) {
      return;
    }
    int? numCards = int.tryParse(cards);
    int? numOfPlayers = int.tryParse(playersCount);
    if (numCards != null && numOfPlayers != null) {
      if (numCards * numOfPlayers > deck.cards.length) {
        print('Not enough cards in deck!');
        return;
      }
      for (var i = 0; i <= numOfPlayers; i++) {
        var cardsOnHand = deck.cards.sublist(0, numCards);
        deck.cards.replaceRange(0, numCards, []);
        Player player = Player(number: i, cardsOnHand: cardsOnHand);
        players.add(player);
      }
      print('Cards dealt');
    } else {
      print('Invalid input number');
    }
  }

  void showPlayersHands() {
    for (var player in players) {
      print('Player #${player.number} has ${player.showHand()}');
    }
  }
}
