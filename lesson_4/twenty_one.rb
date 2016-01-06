SUITS = ['HEARTS', 'DIAMONDS', 'SPADES', 'CLUBS']
FACE_CARDS = ['JACK', 'QUEEN', 'KING', 'ACE']
COMPUTER_NAME = 'Dealer'

def prompt(msg)
  puts "=> #{msg}"
end

def draw_player_card(deck, hand)
  hand << deck.pop
end

def draw_computer_card(deck, hand)
  hand << deck.pop
end

def display(hand, name)
  prompt "#{name} has #{hand} for a total of #{card_total(hand)}"
end

def face_card?(card)
  /\d/.match(card.first.to_s).nil?
end

def check_for_aces(ace_count, total)
  ace_count.times do
    if total <= 21
      break
    else
      total -= 10
    end
  end
  total
end

def card_total(hand)
  total = 0
  hand.each do |value|
    if face_card?(value)
      if value.first == 'ACE'
        total += 11
      else
        total += 10
      end
    else
      total += value.first
    end
  end
  total = check_for_aces(hand.flatten.count('ACE'), total)
end

def bust?(hand)
  card_total(hand) > 21
end

def blackjack(player_total, computer_total)
  winner = ''
  if player_total == 21 && computer_total == 21
    winner = 'Tie'
  elsif player_total == 21
    winner = 'Player'
  elsif computer_total == 21
    winner = 'Computer'
  end
  winner
end

def winning_hand(player_total, computer_total)
    winner = ''
    if player_total == 21
      winner = 'Player'
    elsif player_total > computer_total
      winner = 'Player'
    elsif player_total == computer_total
        winner = 'Tie'
    else
      winner = 'Computer'
    end
end

range = *(2..10)
deck = range.concat(FACE_CARDS).product(SUITS).shuffle
player_name = 'Ralphie'
player_hand = []
computer_hand = []

draw_player_card(deck, player_hand)
draw_player_card(deck, player_hand)
display(player_hand, player_name)

draw_computer_card(deck, computer_hand)
draw_computer_card(deck, computer_hand)
display(computer_hand, COMPUTER_NAME)


winner = blackjack(card_total(player_hand), card_total(computer_hand))


loop do
  puts "#{player_name} would you like to hit or stay?"
  answer = gets.chomp
  break if answer == 'stay' || bust?(player_hand)
  draw_player_card(deck, player_hand)
  display(player_hand, player_name)
end
display(player_hand, player_name)
if bust?(player_hand)
  puts 'Game over, you busted'
else
  puts "#{player_name} chose to stay"
end

while card_total(computer_hand) < 17
  draw_computer_card(deck, computer_hand)
  prompt "#{COMPUTER_NAME} hits"
  display(computer_hand, COMPUTER_NAME)
  if bust?(computer_hand)
    prompt "#{player_name} wins!"
  end
end

winner = winning_hand(card_total(player_hand), card_total(computer_hand))
prompt "#{winner} wins!"

puts deck.size
