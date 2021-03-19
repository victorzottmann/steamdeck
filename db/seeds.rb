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


#====== USERS ======#
if User.count == 0
  user1 = User.create(
    first_name: "Victor",
    last_name: "Zottmann",
    email: "admin@gmail.com",
    password: "000000",
  )
  user1.profile_picture.attach(
    io: File.open("app/assets/images/users/admin.jpg"),
    filename: "admin.jpg",
    content_type: "image/jpg"
  )
  user1.add_role "admin" # set admin access to user1
  user1.save


  user2 = User.create(
    first_name: "Lily",
    last_name: "Dawson",
    email: "l@gmail.com",
    password: "000000"
  )
  user2.profile_picture.attach(
    io: File.open("app/assets/images/users/lily.jpg"),
    filename: "lily.jpg",
    content_type: "image/jpg"
  )


  user3 = User.create(
    first_name: "John",
    last_name: "Markson",
    email: "j@gmail.com",
    password: "000000"
  )
  user3.profile_picture.attach(
    io: File.open("app/assets/images/users/john.jpg"),
    filename: "john.jpg",
    content_type: "image/jpg"
  )
end


#====== AUTHORS ======#
if Author.count == 0
  # author1 => book1 => publisher1
  author1 = Author.create(
    first_name: "Marc", 
    last_name: "Asselineau"
  ) 
    
  # author2 => book2 => publisher1
  author2 = Author.create( 
    first_name: "Don",
    last_name: "Norman"
  ) 

  # author3 => book3 => publisher1
  author3 = Author.create(
    first_name: "Steven",
    last_name: "V. Szokolay"
  ) 

  # author4 => book4 => publisher4
  author4 = Author.create(
    first_name: "Walter",
    last_name: "Murch"
  ) 
end


#====== PUBLISHERS ======#
if Publisher.count == 0
  publisher1 = Publisher.create(name: "CRC Press") # book1
  publisher2 = Publisher.create(name: "Basic Books") # book2
  publisher3 = Publisher.create(name: "Routledge") # book3
  publisher4 = Publisher.create(name: "Silman-James Press") # book4
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
    quantity: 2,
    available: true,
    author_id: 1, # Marc Asselineau
    publisher_id: 1, # CRC Press
    category_id: 4, # Science
    user_id: 1 # Mark Johnson
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
    quantity: 1,
    available: true,
    author_id: 2, # Don Norman
    category_id: 2, # Design
    publisher_id: 2, # Basic Books
    user_id: 2 # Lily Dawson
  )
  book2.picture.attach(
    io: File.open("app/assets/images/design-everyday.jpg"),
    filename: "design-everyday.jpg",
    content_type: "image/jpg"
  )

  book3 = Book.create(
    title: "Introduction to Architectural Science",
    edition: 3,
    pages: 392,
    date: "10-03-2014",
    format: "Paperback",
    price: 5.00,
    quantity: 1,
    available: true,
    author_id: 3, # Steven V. Szokolay
    category_id: 4, # Science
    publisher_id: 3, # Routledge
    user_id: 2 # Lily Dawson
  )
  book3.picture.attach(
    io: File.open("app/assets/images/intro-arch-science.jpeg"),
    filename: "intro-arch-science.jpeg",
    content_type: "image/jpeg"
  )

  book4 = Book.create(
    title: "In the Blink of an Eye",
    edition: 2,
    pages: 146,
    date: "08-08-2001",
    format: "Paperback",
    price: 5.00,
    quantity: 3,
    available: true,
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