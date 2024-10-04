# Clear out existing data (optional for development purposes)
User.destroy_all
Team.destroy_all
Stock.destroy_all
Wallet.destroy_all
Transaction.destroy_all

# Create Users with Passwords
user1 = User.create!(
  username: 'john_doe', 
  email: 'john@example.com', 
  password: 'password123'
)

user2 = User.create!(
  username: 'jane_smith', 
  email: 'jane@example.com', 
  password: 'password456'
)

# Create Teams
team1 = Team.create!(name: 'Alpha Team', description: 'First test team')
team2 = Team.create!(name: 'Beta Team', description: 'Second test team')

# Create Stocks
stock1 = Stock.create!(symbol: 'AAPL', price: 150.25)
stock2 = Stock.create!(symbol: 'TSLA', price: 700.00)

# Create Wallets for Users
wallet1 = Wallet.create!(user: user1, balance: 1000.0)
wallet2 = Wallet.create!(user: user2, balance: 500.0)

# Create Wallets for Teams
wallet3 = Wallet.create!(team: team1, balance: 2000.0)
wallet4 = Wallet.create!(team: team2, balance: 3000.0)

# Create Wallets for Stocks
wallet5 = Wallet.create!(stock: stock1, balance: 500.0)
wallet6 = Wallet.create!(stock: stock2, balance: 100.0)

# Create Transactions
Transaction.create!(source_wallet: wallet1, target_wallet: wallet3, amount: 100.0, transaction_type: 'debit')
Transaction.create!(source_wallet: wallet3, target_wallet: wallet5, amount: 50.0, transaction_type: 'debit')
Transaction.create!(source_wallet: wallet2, target_wallet: wallet4, amount: 200.0, transaction_type: 'debit')
Transaction.create!(source_wallet: nil, target_wallet: wallet6, amount: 100.0, transaction_type: 'credit')


puts "Seeding completed successfully!"
