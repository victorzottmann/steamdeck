# STEAMdeck - Academic Rentals

---

STEAMdeck is a two-sided marketplace focused on affordable academic book rentals. The acronym STEAM means Science, Technology, Engineering, Arts, and Maths. 


## Links

---

### Deployed app: https://steamdeck.herokuapp.com/

### GitHub Repo: https://github.com/victorzottmann/steamdeck



## Local Setup Instructions

---

- Clone this repository
- Run `$ gem install bundler`  (if you don't have Bundler installed)
- Run `$ yarn install --check-files`
- Run ` $ bundle` to install all the required gems and dependencies for the app (as described in the Gemfile).
- Run `$ rake db:setup` to create a local database of the app and seed pre-defined data
- Run `$ rails s` to load the server
- Load http://localhost:3000/ in the browser to run the app

#### Login Credentials from Pre-Defined Data (Database Seeds)

| Name            | Email           | Password |
| --------------- | --------------- | -------- |
| Victor Zottmann | admin@gmail.com | 000000   |
| Lily Dawson     | l@gmail.com     | 000000   |
| John Markson    | j@gmail.com     | 000000   |



## Purpose & Problem

---

Generally, academic and technical books tend to be quite expensive, with some only being available to order in Euros (EUR) or British Pounds (GBP). Indeed, students already enrolled in universities are given the ability to download many of them for free, or access them through the publisher's portal for a limited timeframe. However, many people might not be in the appropriate conditions to attend university, or the current institution in which they are enrolled does not have access to specifc books. 

For example, the following images display the price of two technical books from a renowned publisher––the publisher's name has been omitted for privacy purposes. 

<img src="/Users/victor/code/coder/term2/assignments/z_Deliverables/VictorZottmann_T2A2/docs/screenshots/soundscape-book.png" alt="soundscape-book" style="zoom: 33%;" />



<img src="/Users/victor/code/coder/term2/assignments/z_Deliverables/VictorZottmann_T2A2/docs/screenshots/acoustics-book.png" alt="acoustics-book" style="zoom:33%;" />



The proposition of STEAMdeck is to enable the target audience to rent such books at a very low price, ranging between $5 AUD and $10 AUD. However, given the scope of this project, no user-centered research has been conducted in order to identify how would people use the service, nor which features would they like to have available. Therefore, what follows is the description of a very early prototype of what could potentially become an actual business.

 

## Features

---

STEAMdeck currently supports a limited number of features:

- Users can browse the website freely, but only rent books and view who is  if logged in.
- Users can edit their profile to include a profile picture and a short biography.
- When a user adds a book to STEAMdeck, they can upload a book cover. The same feature is available for editing the book details.
- Users can search for a book by its title or any keyword that relates to the title. Searching by author or publisher is unavailable. On the other hand, users can view books by a given author when clicking on their names.
- Users can browse books by categories.
- Users can see who owns the book.
- Users can see where a book can be pickup around Sydney by interacting with a map of the city.
- Users can edit only the books they added to the website.
- Once a payment is made, users gain access to a rentals page from the nav bar and they are also able to view each rental directly from their profile page.
- Users are restricted from managing the list of categories and the list of all books registered in the website; these functionalities belong to the admin user. In fact, these options are hidden from the navigation bar by default, unless the admin (myself) is the one logged in.

STEAMdeck also envisions a different method of exchanging books, as opposed to simply having it delivered at home or picking it up in a given location. The books registered in the platform belong to any given user. When renting the book, users can see who is kindly sharing it in the platform. Despite not being possible to message users at this stage, this is a feature that would definitely improve the user experience.



## User Stories

---

- As a user, I would like to rent academic books at a low price.
- As a user, I would like to share my own books as well. 
- As a user, I would like to see where are the store locations around Sydney.
- As a user, I would like to check the opening hours of each store.
- As a user, I would like to easily find a book I am after by searching for it.
- 

#### User stories for future implementations

- As a user, I would like to have the option to either rent or purchase a book.



## Sitemap

---

![Sitemap](/Users/victor/code/coder/term2/assignments/z_Deliverables/VictorZottmann_T2A2/docs/screenshots/Sitemap.png)



## Wireframes

---





## Screenshots

#### Sign up page

![signup-page](/Users/victor/code/coder/term2/assignments/z_Deliverables/VictorZottmann_T2A2/docs/screenshots/signup-page.png)



#### Login page

![login-page](/Users/victor/code/coder/term2/assignments/z_Deliverables/VictorZottmann_T2A2/docs/screenshots/login-page.png)



#### Home page

![home-page](/Users/victor/code/coder/term2/assignments/z_Deliverables/VictorZottmann_T2A2/docs/screenshots/home-page.png)



#### New book page

![new-book](/Users/victor/code/coder/term2/assignments/z_Deliverables/VictorZottmann_T2A2/docs/screenshots/new-book.png)

![new-book-cont](/Users/victor/code/coder/term2/assignments/z_Deliverables/VictorZottmann_T2A2/docs/screenshots/new-book-cont.png)



#### Book page

![book-page](/Users/victor/code/coder/term2/assignments/z_Deliverables/VictorZottmann_T2A2/docs/screenshots/book-page.png)



#### Payment page

![payment-page](/Users/victor/code/coder/term2/assignments/z_Deliverables/VictorZottmann_T2A2/docs/screenshots/payment-page.png)



#### User profile page. Once a transaction is made, the 'My Rentals' link appears on the nav bar

![my-profile](/Users/victor/code/coder/term2/assignments/z_Deliverables/VictorZottmann_T2A2/docs/screenshots/my-profile.png)

![my-profile-2](/Users/victor/code/coder/term2/assignments/z_Deliverables/VictorZottmann_T2A2/docs/screenshots/my-profile-2.png)



#### User profile editing page

![edit-profile](/Users/victor/code/coder/term2/assignments/z_Deliverables/VictorZottmann_T2A2/docs/screenshots/edit-profile.png)



#### Profile page from other users

![user-profile](/Users/victor/code/coder/term2/assignments/z_Deliverables/VictorZottmann_T2A2/docs/screenshots/user-profile.png)



#### Search results for the letter 'y'

![search-results](/Users/victor/code/coder/term2/assignments/z_Deliverables/VictorZottmann_T2A2/docs/screenshots/search-results.png)



## High-Level Components

**DISCUSS THE FOLLOWING POINTS:**

- LeafleftJS + Mapbox
- Devise + CanCanCan + Rolify
- Rentals join table
- Stripe + Ultrahook updating inventory
- Search bar 
- Nested forms to write both to the authors, books and publishers tables
- AWS S3



## Database Relations

---

- ### Associations

  

  

  
  

- ### Schema

```ruby
#==== Schema for Rails Active Storage ====#
# Active storage is Rails storage system that handles file uploads and downloads. By default, it is set to a local storage. In this case, the storage is connected to Amazon's S3.
create_table "active_storage_attachments", force: :cascade do |t|
  t.string "name", null: false
  t.string "record_type", null: false
  t.bigint "record_id", null: false
  t.bigint "blob_id", null: false
  t.datetime "created_at", null: false
  t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
  t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
end

create_table "active_storage_blobs", force: :cascade do |t|
  t.string "key", null: false
  t.string "filename", null: false
  t.string "content_type"
  t.text "metadata"
  t.bigint "byte_size", null: false
  t.string "checksum", null: false
  t.datetime "created_at", null: false
  t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
end
#========================================#

create_table "authors", force: :cascade do |t|
  t.string "first_name"
  t.string "last_name"
  t.datetime "created_at", precision: 6, null: false
  t.datetime "updated_at", precision: 6, null: false
end

create_table "books", force: :cascade do |t|
  t.string "title"
  t.text "description"
  t.integer "edition"
  t.integer "pages"
  t.date "date"
  t.string "format"
  t.integer "price"
  t.integer "quantity"
  t.boolean "available"
  t.bigint "author_id", null: false
  t.bigint "category_id", null: false
  t.bigint "publisher_id", null: false
  t.bigint "user_id", null: false
  t.datetime "created_at", precision: 6, null: false
  t.datetime "updated_at", precision: 6, null: false
  t.index ["author_id"], name: "index_books_on_author_id"
  t.index ["category_id"], name: "index_books_on_category_id"
  t.index ["publisher_id"], name: "index_books_on_publisher_id"
  t.index ["user_id"], name: "index_books_on_user_id"
end

create_table "carts", force: :cascade do |t|
  t.datetime "created_at", precision: 6, null: false
  t.datetime "updated_at", precision: 6, null: false
  t.boolean "completed"
end

create_table "categories", force: :cascade do |t|
  t.string "name"
  t.datetime "created_at", precision: 6, null: false
  t.datetime "updated_at", precision: 6, null: false
end

create_table "line_items", force: :cascade do |t|
  t.bigint "book_id", null: false
  t.bigint "cart_id", null: false
  t.datetime "created_at", precision: 6, null: false
  t.datetime "updated_at", precision: 6, null: false
  t.integer "quantity", default: 1
  t.index ["book_id"], name: "index_line_items_on_book_id"
  t.index ["cart_id"], name: "index_line_items_on_cart_id"
end

create_table "publishers", force: :cascade do |t|
  t.string "name"
  t.datetime "created_at", precision: 6, null: false
  t.datetime "updated_at", precision: 6, null: false
end

# This table is created by the Rolify gem for managing user roles
create_table "roles", force: :cascade do |t|
  t.string "name"
  t.string "resource_type"
  t.bigint "resource_id"
  t.datetime "created_at", precision: 6, null: false
  t.datetime "updated_at", precision: 6, null: false
  t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
  t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id"
end

create_table "users", force: :cascade do |t|
  t.string "email", default: "", null: false
  t.string "encrypted_password", default: "", null: false
  t.string "reset_password_token"
  t.datetime "reset_password_sent_at"
  t.datetime "remember_created_at"
  t.datetime "created_at", precision: 6, null: false
  t.datetime "updated_at", precision: 6, null: false
  t.string "first_name"
  t.string "last_name"
  t.text "bio"
  t.string "username"
  t.index ["email"], name: "index_users_on_email", unique: true
  t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
end

# This table is created by the Rolify gem for managing user roles
create_table "users_roles", id: false, force: :cascade do |t|
  t.bigint "user_id"
  t.bigint "role_id"
  t.index ["role_id"], name: "index_users_roles_on_role_id"
  t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
  t.index ["user_id"], name: "index_users_roles_on_user_id"
end

add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
add_foreign_key "books", "authors"
add_foreign_key "books", "categories"
add_foreign_key "books", "publishers"
add_foreign_key "books", "users"
add_foreign_key "line_items", "books"
add_foreign_key "line_items", "carts"
```



- ### Entity Relationship Diagram (ERD)

![Steamdeck-ERD](/Users/victor/code/coder/term2/assignments/z_Deliverables/VictorZottmann_T2A2/docs/screenshots/Steamdeck-ERD.png)





## Third Party Services

---

| Service    | Description                                                  |
| ---------- | ------------------------------------------------------------ |
| AWS S3     | The Amazon Web Services (AWS) S3 is a cloud storage tool used to host all the website's footage, such as the book covers and user profile picture. The platform is both secure and reliable. |
| Bootstrap  | Framework used to implement template-based styling across the application. Some of the templates rely upon JavaScript, and jQuery is needed as a dependency in order for it to function properly in Rails. |
| CanCanCan  | Authorization library to restrict what a user can access.    |
| Devise     | Authentication library to implement user accounts. Devise has its own set of MVC components to handle registrations, sessions, passwords, and more. It works well alongside CanCanCan and Rolify. |
| Leaflet.js | User-friendly and open-source JavaScript API for implementing interactive maps. |
| Mapbox     | Open-source library for displaying maps. While Leaflet is used to implement the map, Mapbox provides the map tiles for the map display itself. Mapbox is among some of the platforms recommended by Leaflet. The map tiles are displayed through JavaScript. |
| Rolify     | Library used to implement user roles (e.g. admin, moderator, etc.). It is well integrated with Devise and CanCanCan. |
| Stripe     | Transactions platform chosen for the app. Stripe's API allows users to test transactions securely (i.e. cashless transactions). |
| Ultrahook  | Platform that provides realtime webhook endpoints. For example, when integrated with Stripe, by default a cart would be set as *incomplete*. Once the user submits a payment, the webhook would set the boolean to *complete*, thus updating a given parameter related to the cart. |



## Tech Stack

---

- **HTML 5**: Markup language to structure the visuals of a website

- **CSS 3 / SASS**: Styling language to modify the visuals of a website. SASS is a pre-processor that makes CSS more pleasant to work with.

- **Ruby on Rails**: Back end framework for the Ruby programming language  

- **PostgreSQL**: Relational database management system

- **Heroku**: Deployment platform (Rails industry standard)

- **Git / GitHub**: Platform for version control.

  



