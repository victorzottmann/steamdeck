# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


#====== CATEGORIES ======#
categories = ["Creative Arts", "Design", "Information Technology", "Science"]

if Category.count == 0
  categories.each do |c|
    Category.create(name: c)
  end
end


#====== SUBCATEGORIES ======#
# arts_subcategories = [
#   "Audio",
#   "Filmmaking",
#   "Film & Video Editing",
#   "Music",
#   "Photography",
#   "Visual Effects"
# ]

# design_subcategories = [
#   "Architecture",
#   "Illumination Design",
#   "Interaction Design"
# ]

# tech_subcategories = [
#   "Interactive Media",
#   "Mobile App Development",
#   "Web Development"
# ]

# science_subcategories = [
#   "Acoustics",
#   "Architectural Science"
# ]

# if Subcategory.count == 0
#   arts_subcategories.each do |type|
#     Subcategory.create(name: type, category_id: 1)
#   end

#   design_subcategories.each do |type|
#     Subcategory.create(name: type, category_id: 2)
#   end

#   tech_subcategories.each do |type|
#     Subcategory.create(name: type, category_id: 3)
#   end
  
#   science_subcategories.each do |type|
#     Subcategory.create(name: type, category_id: 4)
#   end
# end



#====== AUTHORS ======#
if Author.count == 0
  author1 = Author.create(name: "Marc Asselineau") #book1
  author2 = Author.create(name: "Don Norman") #book2
  author3 = Author.create(name: "Chris Pine") #book3
  author3 = Author.create(name: "Walter Murch") #book4
end


#====== PUBLISHERS ======#
if Publisher.count == 0
  publisher1 = Publisher.create(name: "CRC Press") #book1
  publisher2 = Publisher.create(name: "Basic Books") # book2
  publisher3 = Publisher.create(name: "Pragmatic Bookshelf") # book3
  publisher4 = Publisher.create(name: "Silman-James Press") # book4
end


#====== USERS ======#
if User.count == 0
  user1 = User.create(
    first_name: "Victor",
    last_name: "Zottmann",
    email: "victor@email.com",
    password: "123456"
  )

  user2 = User.create(
    first_name: "Mark",
    last_name: "Johnson",
    email: "markj@email.com",
    password: "123456"
  )

  user3 = User.create(
    first_name: "John",
    last_name: "Markson",
    email: "johnm@email.com",
    password: "123456"
  )
end


#====== BOOKS ======#
if Book.count == 0
  book1 = Book.create(
    title: "Building Acoustics",
    edition: 1,
    pages: 984,
    date: "05-02-2014",
    format: "Paperback",
    price: 5.00,
    author_id: 1, # Marc Asselineau
    publisher_id: 1, # CRC Press
    category_id: 4, # Science
    user_id: 2 # Mark Johnson
  )
  book1.picture.attach(
    io: File.open("app/assets/images/building-acoustics.jpg"),
    filename: "building-acoustics.jpg",
    content_type: "image/jpg"
  )

  book2 = Book.create(
    title: "The Design of Everyday Things",
    edition: 1,
    pages: 384,
    date: "05-11-2013",
    format: "Paperback",
    price: 5.00,
    author_id: 2, # Don Norman
    category_id: 2, # Design
    publisher_id: 2, # Basic Books
    user_id: 2 # Mark Johnson
  )
  book2.picture.attach(
    io: File.open("app/assets/images/design-everyday.jpg"),
    filename: "design-everyday.jpg",
    content_type: "image/jpg"
  )

  book3 = Book.create(
    title: "Learn to Program",
    edition: 2,
    pages: 194,
    date: "28-03-2009",
    format: "E-book",
    price: 5.00,
    author_id: 3, # Chris Pine
    category_id: 3, # Information Technology
    publisher_id: 3, # Pragmatic Bookshelf
    user_id: 3 # John Markson
  )
  book3.picture.attach(
    io: File.open("app/assets/images/learn-to-program.jpg"),
    filename: "learn-to-program.jpg",
    content_type: "image/jpg"
  )

  book4 = Book.create(
    title: "In the Blink of an Eye",
    edition: 2,
    pages: 146,
    date: "08-08-2001",
    format: "Paperback",
    price: 5.00,
    author_id: 4, # Walter Murch
    category_id: 1, # Creative Arts
    publisher_id: 4, # Silman-James Press
    user_id: 3 # John Markson
  )
  book4.picture.attach(
    io: File.open("app/assets/images/blink-eye.jpg"),
    filename: "blink-eye.jpg",
    content_type: "image/jpg"
  )
end