import 'dart:io';

int numberOfCards = 1;
int numberOfPlayers = 1;
List<String> deck = [];
List<List<String>> players = [[]];

void main() {
  print(Process.runSync("clear", [], runInShell: true).stdout);
  bool exit = false;
  initializeState();
  while (!exit) {
    showSelectedCardsAndPlayersAmount();
    showMainMenu();
    int input = int.parse(stdin.readLineSync()!);
    switch (input) {
      case 1:
        {
          stdout.writeln('Cards has been shuffled \n');
          deck.shuffle();
          break;
        }
      case 2:
        {
          bool correctEnter = false;
          while (!correctEnter) {
            stdout.writeln('Type a value from 1 to ${deck.length}:');
            int value = int.parse(stdin.readLineSync()!);
            if (value >= 1 && value <= 16) {
              numberOfCards = value;
              correctEnter = true;
            }
          }

          break;
        }
      case 3:
        {
          bool correctEnter = false;
          while (!correctEnter) {
            stdout.writeln('Set number of players: ');
            int value = int.parse(stdin.readLineSync()!);
            if (value > numberOfCards) {
              stdout.writeln(
                  'Number of players can not be bigger than number of cards ');
              continue;
            }
            if (numberOfCards % value != 0) {
              stdout.writeln(
                  'Number of players should be multiple of $numberOfCards');
              continue;
            }
            numberOfPlayers = value;
            players = new List.filled(numberOfPlayers, []);
            correctEnter = true;
          }
          break;
        }
      case 4:
        {
          print(Process.runSync("clear", [], runInShell: true).stdout);
          List<String> cards = deck.sublist(0, numberOfCards);
          int cardAndPlayersDiv = (numberOfCards / numberOfPlayers).round();
          for (int i = 0; i < players.length; i++) {
            players[i] = cards.sublist(i * cardAndPlayersDiv,
                i * cardAndPlayersDiv + cardAndPlayersDiv);
          }
          for (int i = 0; i < players.length; i++) {
            stdout.writeln('Player${i + 1} cards: ${players[i].toString()}');
          }
          break;
        }
      case 5:
        {
          print(Process.runSync("clear", [], runInShell: true).stdout);
          initializeState();
          break;
        }
      case 6:
        {
          stdout.writeln('You selected : "Exit"');
          exit = true;
          break;
        }
      default:
        {
          stdout.writeln('Please, choose option from 1 to 6');
        }
    }
  }
}

void initializeState() {
  numberOfCards = 1;
  numberOfPlayers = 1;
  deck = [
    '2 clubs',
    '2 diamonds',
    '2 heaerts',
    '2 spades',
    '3 clubs',
    '3 diamonds',
    '3 heaerts',
    '3 spades',
    '4 clubs',
    '4 diamonds',
    '4 heaerts',
    '4 spades',
    '5 clubs',
    '5 diamonds',
    '5 heaerts',
    '5 spades',
  ];
  List<List<String>> players = [[]];
}

void showSelectedCardsAndPlayersAmount() {
  stdout.writeln('Number of cards: $numberOfCards');
  stdout.writeln('Number of players: $numberOfPlayers \n');
}

void showMainMenu() {
  stdout.writeln('[1]: Shuffle Cards');
  stdout.writeln('[2]: Set number of cards');
  stdout.writeln('[3]: Set number of players');
  stdout.writeln('[4]: Show cards of all the players');
  stdout.writeln('[5]: Restart');
  stdout.writeln('[6]: Exit');
  stdout.writeln('Please, choose an option');
}
