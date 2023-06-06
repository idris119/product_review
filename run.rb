
# Set up database connection
require 'active_record'
require 'sqlite3'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: ':memory:'
)

# Load migrations
require_relative 'migrations/create_reviews_table'

# Load models
require_relative 'models/review'
require_relative 'models/product'
require_relative 'models/user'

# Create instances and test methods
user1 = User.create(name: 'John')
user2 = User.create(name: 'Jane')

product1 = Product.create(name: 'Product 1')
product2 = Product.create(name: 'Product 2')

product1.leave_review(user1, 4, 'Great product')
product1.leave_review(user2, 5, 'Excellent product')
product2.leave_review(user1, 3, 'Average product')

puts "User's reviews:"
user1.reviews.each { |review| puts review.comment }

puts "Product's reviews:"
product1.print_all_reviews

puts "Product's average rating:"
puts product1.average_rating

puts "User's favorite product:"
puts user1.favorite_product.name

user1.remove_reviews(product1)
puts "User's reviews after removing product1 reviews:"
user1.reviews.each { |review| puts review.comment }