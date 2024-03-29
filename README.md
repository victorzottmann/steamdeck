# STEAMdeck - Academic Rentals

STEAMdeck is a two-sided marketplace focused on affordable academic book rentals. The acronym STEAM means Science, Technology, Engineering, Arts, and Maths. 

## Links

### This app is currently going through maintenance to reestablish hosting on Heroku. In the meantime, please feel free to browse through the documentation to view how some of the key features were implemented. Thank you for your patience 🙂.

### GitHub Repo: https://github.com/victorzottmann/steamdeck

---

## Local Setup Instructions

- Clone this repository

- Make sure you have PostgreSQL installed as it is the database management system used in this project.

- Run `$ gem install bundler`  (if you don't have Bundler installed)

- Run `$ yarn install --check-files`

- Run ` $ bundle` to install all the required gems and dependencies for the app (as described in the Gemfile).

- Run `$ rake db:setup` to create a local database of the app and seed pre-defined data

- File storage is handled by Amazon S3; payments by Stripe; and webhook endpoints by Ultrahook. To get them working, make sure you go over the following steps:

  - To enable Amazon S3, uncomment the `amazon` section of the `config/storage.yml` file, then specify your region and bucket name. The public and secret keys must be passed in using Rails secure method:

    ```yaml
    access_key_id: <%= Rails.application.credentials.dig(:aws, :access_key_id) %>
    secret_access_key: <%= Rails.application.credentials.dig(:aws, :secret_access_key) %>
    ```

    Then follow the instructions provided in the file to insert your AWS credentials. 

  - To enable Stripe you must make an account to obtain your public and secret keys. Once you have them, they should also be inserted in the Rails credentials file to be encrypted. It is also demanded that you create the file `config/initializers/stripe.rb` in order to safely decrypt your keys for usage in the app. The file should contain this command:

    ```ruby
    Stripe.api_key = Rails.application.credentials.dig(:stripe, :secret_key)
    ```

  - To enable Ultrahoook you must also register an account to obtain your API key and follow the instructions provided on their website. In Stripe's website you must also create a webhook endpoint that points to the address that you provide (e.g. https://steamdeck-stripe.ultrahook.com/payments/webhook). The address must have the `/payments/webhook` section, otherwise it will not work. The settings for this will be located under the `Developers` sidebar menu in **Stripe's website**. Also, make sure that you select add the event called `checkout.session.completed` when creating an endpoint, otherwise the inventory update feature will not work. For example:

    ![ultrahook](app/assets/images/screenshots/ultrahook.png)

    Finally, given that the application is normally loaded through port 3000, running ultrahook requires the following command: `ultrahook stripe 3000`

- **The code was written in Ruby 2.7.2**. If for any reason you are unable to run the server, make sure you have this version installed.

- Once you have everything set up, run `$ rails s` in the terminal to start the server

- Load http://localhost:3000/ in the browser to run the app

---

## Login and Payments

#### Login Credentials from Pre-Defined Data (Database Seeds)

| Name                    | Email           | Password |
| ----------------------- | --------------- | -------- |
| Victor Zottmann (admin) | admin@gmail.com | 000000   |
| Lily Dawson             | l@gmail.com     | 000000   |
| John Markson            | j@gmail.com     | 000000   |

#### For all payments please either one of these dummy credit cards. The expiry date, CVV, and card holder's name can be random.
| Card Number          | Expiry Date | CVV |
| -------------------- | ----------- | --- |
| 4242 4242 4242 4242  | 11/22       | 000 |
| 5555 5555 5555 4444  | 11/22       | 000 |

---

## Purpose & Problem

Generally, academic and technical books tend to be quite expensive, with some only being available to order in Euros (EUR) or British Pounds (GBP). Indeed, students already enrolled in universities are given the ability to download many of them for free, or access them through the publisher's portal for a limited timeframe. However, many people might not be in the appropriate conditions to attend university, or the current institution in which they are enrolled does not have access to specifc books. It is also very common for even the digital versions of such books to be as expensive as their physical counterparts.

For example, the following images display the price of two technical books from a renowned publisher––the publisher's name has been omitted for privacy purposes. 

<img src="app/assets/images/screenshots/soundscape-book.png" alt="soundscape-book"  />



<img src="app/assets/images/screenshots/acoustics-book.png" alt="acoustics-book"  />



The proposition of STEAMdeck is to enable the target audience to rent such books at a very low price, ranging between $5 AUD and $10 AUD. However, given the scope of this project, no user-centered research has been conducted in order to identify how would people use the service, nor which features would they like to have available. Therefore, what follows is the description of a very early prototype of what could potentially become an actual business.

---

## Features

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

#### Interactive Map Integration

A key feature of the app is the ability for users to interact with a map to view store locations and opening hours. The implementation was made possible by integrating both the LeafletJS and Mapbox APIs. Leaflet is a user-friendly and open-source API for creating interactive maps. Their documentation is very easy to follow as well. As shown in the image below, Mapbox is an API that provides map tiles, whereas Leaflet is concerned with the container in which the tiles will be displayed in. 

<img src="app/assets/images/screenshots/maps.png" alt="maps" style="zoom: 33%;" />

As displayed in the code snippets below, integrating both APIs within a Ruby on Rails project is fairly straight-forward. This can be done either by linking directly to the Leaftlet and Mapbox JavaScript files in the `application.html.erb` file, or by installing Leafleft as a gem. I chose the former as the latter seemed to be less intuitive.

##### In `views/layouts/application.html.erb`:

```erb
<!-- Add the following links to the HEAD section of the file. The details can be found on their websites. -->
<head>
  <!-- For Leaflet -->
  <link rel="stylesheet" href="https://unpkg.com/leaflet@1.7.1/dist/leaflet.css" integrity="sha512-xodZBNTC5n17Xt2atTPuE1HxjVMSvLVW9ocqUKLsCC5CXdbqCmblAshOMAS6/keqq/sMZMZ19scR4PsZChSR7A==" crossorigin=""/>
  <script src="https://unpkg.com/leaflet@1.7.1/dist/leaflet.js" integrity="sha512-XQoYMqMTK8LvdxXYG3nZ448hOEQiglfqkJs1NOQV44cWnUrBc8PkAOcXy20w0vlaXaVUearIOBhiXZ5V3ynxwA==" crossorigin=""></script>
  
  <!-- For Mapbox -->
  <link href='https://api.mapbox.com/mapbox-gl-js/v2.1.1/mapbox-gl.css' rel='stylesheet' />
  <script src='https://api.mapbox.com/mapbox-gl-js/v2.1.1/mapbox-gl.js'></script>
</head>
```

##### In `javacript/packs` add a file with whichever name you want (e.g. `index.js`), then add the following:

```javascript
// This generates the map container and sets the view to the latitude and longitude, as well as the zoom level (max = 18)
var mymap = L.map('map').setView([latitude, longitude], zoom_level);

// Mapbox implementation
mapboxgl.accessToken = 'your_mapbox_public_key';
var map = new mapboxgl.Map({
  container: 'map',
  style: 'mapbox://styles/mapbox/streets-v11'
});

// This adds the tiles from Mapbox, attributes the copyright to each respective contributor, sets the max zoom level and other properties, includes your public key for accessing the Mapbox tiles, then adds all of it to the map, as declared above.
L.tileLayer('https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}', {
  attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors, Imagery © <a            href="https://www.mapbox.com/">Mapbox</a>',
  maxZoom: 17,
  id: 'mapbox/streets-v11',
  tileSize: 512,
  zoomOffset: -1,
  accessToken: 'your_mapbox_public_key'
}).addTo(mymap);

// This adds a pin marker to the given latitude and longitude values below and binds a popup message. In this case, the message displays the store name and opening hours.
L.marker([-33.869438, 151.208278]).addTo(mymap).bindPopup("<p>STEAMdeck Sydney CBD<br><br> Mon - Fri: 9am to 9pm</p>");
```

One downside of this, however, is that the public key does not lie in any encrypted files. I have tried storing it in the Rails credentials, changing the JavaScript file to `index.js.erb` in order to pass in the `Rails.application.credentials.dig` code as the access token, but it is not possible to do so. There does not seems to be a way to embed Ruby code into JavaScript code unfortunately. On the other hand, given that Mapbox is a free service and there is nothing dangerous to be stolen from my account, this might not be much of an issue in this case. Perhaps implementing Leaflet as a gem would make it possible to hide the access token, but I would not know for sure at this stage.

Finally, to load the map into the view page of choice, one must simply include a `javascript_pack_tag` and pass in the directory for the `index.js` file within a `<div>` with an `id` that is equal to `map`, like this:

```erb
<div class="map-container">
  <h5 class="map-heading">
    Locations Available for Pickup:
    <br><br>
    <p class="location-subs">(click on the pins to view store hours)</p>
  </h5>
  <div id="map">
    <%= javascript_pack_tag "leaflet/index" %>
  </div>
</div>
```



#### Payments Integration with Stripe and Ultrahook

As opposed to the maps implementation, Stripe was added to the app as a Ruby gem and its public and secret keys were properly encrypted in the Rails credentials. Stripe is a payments API that is both easy to use and reliable. When accessing a view page for any given book, users can see how many items are in stock and are provided with the ability to rent the book. Stripe is enabled directly from the `show` method in the `BooksController`:

```ruby
class BooksController < ApplicationController
  def show
    # current_user is a method implemented by the Devise gem for handling user authentication
    @user = current_user 
    # set_book is a private method that finds a book by its id.
    set_book

    if user_signed_in?
      # This creates a session for when the user view a given book.
      session = Stripe::Checkout::Session.create(
        payment_method_types: ['card'],
        customer_email: current_user.email,
        line_items: [{
          name: @book.title,
          amount: (@book.price * 100),
          currency: 'aud',
          quantity: 1
          }],
        payment_intent_data: {
          # The metadata included here are used to feed provide Ultrahook with information once a payment is 					 made.
          metadata: {
            user_id: current_user.id,
            book_id: @book.id
            }
          },
        success_url: "#{root_url}payments/success?bookId=#{@book.id}",
        cancel_url: "#{root_url}books"
        )
      @session_id = session.id
    end
  end
end
```

The configurations for Ultrahook are then set in the `PaymentsController`:

```ruby
class PaymentsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:webhook]

  def success
  end

  def webhook
    payment_id = params[:data][:object][:payment_intent]
    payment = Stripe::PaymentIntent.retrieve(payment_id)
    
    # This assigns the metadata described above into two variables
    book = Book.find(payment.metadata.book_id) 
    buyer = User.find(payment.metadata.user_id)

    # Then, the assigned metadata is used to create a new rental for the user
    rental = Rental.create(user_id: buyer.id, book_id: book.id)
    # This saves it to the database.
    rental.save!
    
    # Once a payment is made, the inventory for the given book decreases by 1 and updates the database
    book.quantity -= 1
    if book.quantity <= 0
      book.available = false
    end
    book.save!

    status 200
  end
end
```

---



## User Stories

- As a user, I would like to rent academic books at a low price.
- As a user, I would like to share my own books as well. 
- As a user, I would like to see where are the store locations around Sydney.
- As a user, I would like to check the opening hours of each store.
- As a user, I would like to easily find a book I am after by searching for it.

#### User stories for future implementations

- As a user, I would like to have the option to either rent or purchase a book.

- As a user, I would like to message other users.

---


## Sitemap

![Sitemap](app/assets/images/screenshots/Sitemap.png)

---


## Wireframes

In all honesty, I did not put too much effort into the wireframes this time. I had a very clear vision as to how would the pages below look like, and everything else in the app was designed with these pages as reference. There are also no responsive wireframes as I did not implement responsiveness in the website. The main focus was making the back end work; the styling was secondary.

#### Home page

![Home Page](app/assets/images/wireframes/home-page.png)



#### Book page

![Book Page](app/assets/images/wireframes/book-page.png)



#### User profile page

![Profile Page](app/assets/images/wireframes/profile-page.png)



---

## Screenshots

#### Sign up page

![signup-page](app/assets/images/screenshots/signup-page.png)



#### Login page

![login-page](app/assets/images/screenshots/login-page.png)



#### Home page

![home-page](app/assets/images/screenshots/home-page.png)



#### New book page

![new-book](app/assets/images/screenshots/new-book.png)

![new-book-cont](app/assets/images/screenshots/new-book-cont.png)



#### Book page

![book-page](app/assets/images/screenshots/book-page.png)



#### Payment page

![payment-page](app/assets/images/screenshots/payment-page.png)



#### User profile page. Once a transaction is made, the 'My Rentals' link appears on the nav bar

![my-profile](app/assets/images/screenshots/my-profile.png)

![my-profile-2](app/assets/images/screenshots/my-profile-2.png)



#### User profile editing page

![edit-profile](app/assets/images/screenshots/edit-profile.png)



#### Profile page from other users

![user-profile](app/assets/images/screenshots/user-profile.png)



#### Search results for the letter 'y'

![search-results](app/assets/images/screenshots/search-results.png)

---

## High-Level Components of the App

#### 1. Active Record

Representing the Model of the MVC acronym, Active Record is the system responsible for handling the business data and logic (**Rails Guides, n.d.**) and it facilitates the creation of objects whose data demands constant storage to the database (**Rails Guides, n.d.**). The system works by implementing the Object Relational Mapping (ORM) technique, which essentially allows developers to query data without writing SQL. Given that Rails follows a *convention over configuration* model, plenty of the configurations needed to set the system are managed under the hood, therefore allowing developers to create Active Record models more efficiently.

The main differences between Active Record and SQL commands lie in the naming conventions. For example, in Active Record models (database tables) are referred to in the singular tense, as opposed to the plural tense standardized in SQL. In addition, model names should be created in CamelCase style, also in the singular tense.

Active Record also provides CRUD methods for accessing the database. Common ones used throught the app are the following:

```ruby
# Book.all gets all books in the Book model (or books in SQL).
@books = Book.all

# Book.find(params[:id]) retrieves the book whose id matches the URL params. For example, if the URL is http://localhost:3000/books/1, the number 1 would be the book whose id is 1.
@book = Book.find(params[:id])

# Book.new simply creates a new book entry.
@book = Book.new

# Here @title is assigned to whichever value is passed into the params[:q] (in this case it would a search parameter, where :q is a symbol for 'query').
@title = params[:q].downcase
# Then, Book.where refers to the SQL command SELECT * FROM books WHERE title LIKE '%title%'. In this case, Book.where is looking for whichever characters are before, within, of after the keyword stored in @title (that's the role of the % signs)
@books = Book.where("lower(title) LIKE ?", "%#{@title}%")

# There are also many other self-explanatory methods utilized, such as:
@book.save
@book.create
@book.update
@book.destroy
```

In each model file, the class of the model is inherited from the ApplicationRecord class, which in turn is inherited from the ActiveRecord class. For example:

```ruby

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end

class Book < ApplicationRecord
  belongs_to :author
  belongs_to :category
  belongs_to :publisher
  belongs_to :user

  has_one_attached :picture

  # These two methods are discussed in 'X. Nested forms' section below.
  accepts_nested_attributes_for :author
  accepts_nested_attributes_for :publisher

  # This method is discussed in the 'X. Roles' section below.
  resourcify
end

class Author < ApplicationRecord
  has_many :books
end
```

In addition to the above-mentioned methods, Active Record also provides methods to define associations between models. For example, in the code snippet above, a book `belongs_to` an author, and an author `has_many` books. Despite the convention for referring to a model demanding it to be in the singular form, the model must be called in the plural when the method calling it is in the plural. Otherwise, `has_many`book would not make sense.  Furthermore, although the Book model does not contain a `picture`, the method `has_one_attached` allows one to associate a book with an uploaded image.

#### 2. Active Controller

Similar to Active Record, Active Controller follows Rails' *convention over configuration* style, and corresponds to the C in MVC. The Action Controller comprises several methods for handling HTTP requests sent by the browser. Such methods tell the controller what to do in relation to the requests themselves, such as display the home page or retrieve specific data from the database. As with the Active Record, the Action Controller inherits from a couple of parent classes, for example:

```ruby
class ApplicationController < ActionController::Base
end

class BooksController < ApplicationController
  # All the methods for handling HTTP requests are defined here. They usually consist of the following.
  
  def index # for displaying the main page of books. In this case it would be /books
  end
  
  def show # for showing only one item. In this case it would be /books/1, /books/2, etc.
  end
  
  def edit # for editing a book
  end
  
  def create # for creating a book
  end
  
  def update # for updating a book
  end
  
  def destroy # for deleting a book
  end
end
```

When creating a new controller, Rails automatically creates a folder for `books` under the `views` section of the app. Each Ruby file must follow the name of the methods defined in the controller. For example, the views for the controller above should be named as:

- `index.html.erb` (erb stands for Embedded Ruby and it is necessary in order to write Ruby code in HTML files).
- `show.html.erb`
- `edit.html.erb`
- `create.html.erb`
- `update.html.erb`
- `delete.html.erb`

In order for the Action Controller to work properly, routes must be defined, otherwise it would be impossible for HTTP requests to be sent to the controller at hand. The routes consist of GET, POST, PUT/PATCH, and DESTROY requests. In the case of the app, they are formatted like this:

```ruby
Rails.application.routes.draw do
  get "books/search", to: "books#search", as: "book_search"

  # Resources simply create all routes for any given controller at once. T
  # They can be accessed by running $ rails routes -g controller_name on the terminal
  # or it is also possible to see all routes for all by running $ rails routes.
  resources :authors
  resources :books
  resources :categories
  resources :rentals
  resources :publishers

  # devise_for generates all routes for the users controllers. Devise is a gem for handling authentications and its integration in the project is discussed in section X.
  devise_for :users
  get "/users/:id", to: "users#show", as: "user"
  
  get "/profile", to: "users#profile", as: "user_profile"
  get "/profile/edit", to: "users#edit", as: "edit_user"
  patch "/profile/edit", to: "users#update", as: "update_user"

  get "categories/1", to: "categories#show", as: "creative_arts"
  get "categories/2", to: "categories#show", as: "design"
  get "categories/3", to: "categories#show", as: "tech"
  get "categories/4", to: "categories#show", as: "science"
  
  get "/payments/success", to: "payments#success"
  post "/payments/webhook", to: "payments#webhook"

  root to: "home#index"
end
```



#### 3. Action View

Corresponding to the V in MVC, the Action View is what allows Ruby code to be embedded within HTML code. It demands that HTML files be extended with `.erb` at the end, and the syntax for `erb` is written in the following ways.

```erb
<!-- The <%=  %> with an equal sign tells HTML to display what is inside it. -->
<p><%= some_code %><p> 

<!-- The <%  %> without the equal sign tells HTML not to display, but to only run the code instead. In addition, CSS classes can be included in erb code, however, they must be written with a colon instead of around quotes -->
<% if condition %> 
  <%= link_to 'Log in', new_user_session_path, class: "dropdown-item" %>
<% else %>
  <%= link_to 'Log out', destroy_user_session_path, method: "delete", class: "dropdown-item" %>
<% end %>
```



The Action View also allows one to store a piece of code that is likely to be reused multiple times in a separate file, referred to as a `partial`. Once one needs to import the code, one need only call a `render` method to display it in the view at hand. For example:

```ruby
# Suppose this is to be reused in multiple places:
<nav class="footer fixed-bottom">
  <p class="copyright">Created by Victor Zottmann © 2021</p>
</nav>
```

Instead of copying the footer to every single view, one can store it in a partial. Partials are named with an underscore preceding the first word: `_footer.html.erb`. By default, Rails provides one with a file called `application.html.erb`, which essentially renders a unique piece of code into all views. Therefore, since the footer should appear everywhere in the app, the following code should be inserted into the `application.html.erb` file. The same is applicable to the `nav bar`.

```erb
<body>
  <%= render "shared/navbar" %>
  <div class="container">
    <%= yield %> <!-- yield grabs all content from all erb files -->
  </div>
  <%= render "shared/footer" %>
</body>
```



#### 4. Active Storage

A fourth high-level component used in the app is the Active Storage, whose role lies in facilitating the storage of files in cloud services, such as Amazon Web Services (AWS) S3, Cloudinary, or Microsoft Azure. It is also possible to set Active Storage to run locally. In the case of this project, I chose to use AWS for its simplicity, security and reliability. 

Unlike the previous components, however, Active Storage must be installed; it takes only two commands to do so: 

- `$ bin/rails active_storage:install` , which will create two tables (shown below), and
- `$ bin/rails db:migrate` to migrate the tables to the database. 

```ruby
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
```

Rails stores the default service that Active Storage should use in `config/storage.yml`. In order to declare AWS S3 as the service, one must uncomment the pre-defined amazon declarations and fill in the required fields.

```yaml
amazon:
  service: S3
  access_key_id: "your_key"
  secret_access_key: "your_key"
  bucket: "your_bucket_name"
  region: "" # e.g. 'us-east-1'
```

Given that both keys must not be accessable by others, Rails provides a very secure way to store them:

```yaml
amazon:
  service: S3
  # This line loads the encrypted credentials file which contains API keys for third-party services.
  access_key_id: <%= Rails.application.credentials.dig(:aws, :access_key_id) %>
  secret_access_key: <%= Rails.application.credentials.dig(:aws, :secret_access_key) %>
bucket: "your_bucket_name"
  region: "" # e.g. 'us-east-1'
```

---



## Database Relations

#### 1. Associations

The following list items display the existing models in the application, followed by in-depth descriptions of their relations with each other.

- Author

  An author is associated with books whereby an author has many books, and a book belongs to one author. Indeed, a book can have many author, though I decided to restrict it only to one author for simplicity reasons.

  

- Book

  A book is associated with an author by the relationship described above, and it is also related to a category, a publisher, and a user. The Book model contains a foreign key that refers to the primary key of the author, the `author_id`, as well as foreign keys that connect to the `category_id`, the `publisher_id`, and the `user_id`. 

  In terms of the Active Record associations between the last-mentioned models, a book `belongs_to` each one of them, and each `has_many` books. As mentioned in the Active Record section above, although the book model does not contain a picture, the Active Record provides a method to attach a picture to a model, which is called `has_one_attached`. Additional methods are declared in the book model:

  ```ruby
  accepts_nested_attributes_for :author
  accepts_nested_attributes_for :publisher
  ```

  The role of `accepts_nested_attributes_for` is to include fields from other models into the form for creating a new book. Because the Book model itself is referencing both the Author and the Publisher models, if one were to create a form with fields to input the author's and the publisher's names by themselves, the data would not be saved into either databases. Essentially, the idea is that whenever the user inputs the required data for the author and the publisher within the form to create a new book, the data should be saved into the Author and the Publisher models separately, and associate the respective`foreign keys` from the Book model with both the `author_id`and the `publisher_id`. Aside from declaring the methods above, the following code must be implemented in the `BooksController`


  ```ruby
  class BooksController < ApplicationController
    def new
      @book = Book.new
      @book.build_author # This line builds a new author when the book form is loaded
      @book.build_publisher # This line builds a new publisher when the book form is loaded
  
      load_categories
    end
  
    def create
      @book = Book.new(book_params)
      # This line assigns the current user to the book that is being created. current_user is a method from the Devise authentication gem.
      @book.user = current_user 
      # This line load all the categories as defined in the private section below
      load_categories 
  
      if @book.save
        flash[:success] = "A new book was successfully created."
        redirect_to book_path(@book.id)
      else
        flash.now[:error] = @book.errors.full_messages.to_sentence
        render "new"
      end    
    end
  
    private
    def load_categories
      @categories = Category.all # This line loads all the categories so that they can be selected within the book form.
    end
  
    def book_params
      # The key part here is including the author_attributes and the publisher_attributes in the permitted parameters. This method must be private.
      params.require(:book).permit(:picture, :title, :edition, :pages, :date, :format, :price, :quantity, 	   	 :author_id, :publisher_id, :category_id, author_attributes: [:first_name, :last_name], publisher_attributes: [:name])
    end
  end
  ```


  Finally, as it can be seen below, the form for creating a new book contains the required parameters for writing the input into the database.

  ![new-book-author-publisher](app/assets/images/screenshots/new-book-author-publisher.png)


  In order for the nested attributes to work properly, they were written like this in the book form:

  ```erb
  <%= form.fields_for :author do |f| %>
    <div class="first-last-names">
      <div>
        <%= f.label "Author's First Name" %>
        <%= f.text_field :first_name, class: "form-control first-name", autofocus: true, autocomplete: 					"email" %>
      </div>
      <div>
        <%= f.label "Author's Last Name" %>
        <%= f.text_field :last_name, class: "form-control last-name", autofocus: true, autocomplete: 						"email" %>
      </div>
    </div>
  <% end %>
  <br>
  <div class="field">
    <%= form.fields_for :publisher do |f| %>
    	<%= f.label :publisher %>
    	<%= f.text_field :name, class: "form-control", autocomplete: "off" %>
    <% end %>
  </div>
  ```

  

- Category

  The category model is only associated with books and follow the relationship described above.
  
- Publisher

  The publisher model follows the same pattern as the category model.
  
- Rental

  The Rental model is a join table associated with both a book and a user. This was necessary in order to allow the user to see the list of book they are currently renting after any given transaction is made. The rental model has an Active Record association that `belongs_to` both the Book and the User models.
  
- Role

  The Role model is generated by the Rolify gem, which serves to manage user roles within the app. The gem integrates well with both Devise and CanCanCan, which is an access authorisation gem. Once created, the model will contain an association that `has_and_belongs_to_many` users, and it explicitly points itself toward the `users_roles` join table. Rolify requires that the Book and the User models include the `resourcify` method. The code snippet below illustrates the declaration made in the Role model.

  ```ruby
  class Role < ApplicationRecord
    has_and_belongs_to_many :users, :join_table => :users_roles
    
    belongs_to :resource,
               :polymorphic => true,
               :optional => true
    
  
    validates :resource_type,
              :inclusion => { :in => Rolify.resource_types },
              :allow_nil => true
  
    scopify
  end
  ```

  In addition to the Role model, the CanCanCan gem creates an Ability model whose `initialize` method combines its features with Rolify to check whether the user has access to admin rights (see the code snippet below). The model itself does display any explicit associations.

  ```ruby
  class Ability
    include CanCan::Ability
  
    def initialize(user)      
      user ||= User.new # guest user (not logged in)
      if user.has_role? :admin
        can :manage, :all
      else
        can :read, :all
      end
    end
  end
  ```

  

- Users

  The User model consists of an Active Record association that `has_many`books, as well as `has_many` rentals. It also contains a `has_one_attached` method for the user to attach a picture to their profile. Moreover, the model contains declarations for Devise modules, which is the gem that handles user authentications. The code snippet below demonstrates the structure of the User model.

  ```ruby
  class User < ApplicationRecord
    rolify
  
    has_many :books, dependent: :destroy
    has_many :rentals
    has_one_attached :profile_picture
  
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable
  end
  ```

  

- User Roles

  Finally, the User Roles join table simply contains foreign keys to both the `role_id` and the `user_id`.



#### 2. Schema

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

create_table "categories", force: :cascade do |t|
  t.string "name"
  t.datetime "created_at", precision: 6, null: false
  t.datetime "updated_at", precision: 6, null: false
end

create_table "publishers", force: :cascade do |t|
  t.string "name"
  t.datetime "created_at", precision: 6, null: false
  t.datetime "updated_at", precision: 6, null: false
end

create_table "rentals", force: :cascade do |t|
  t.bigint "user_id", null: false
  t.bigint "book_id", null: false
  t.datetime "created_at", precision: 6, null: false
  t.datetime "updated_at", precision: 6, null: false
  t.index ["book_id"], name: "index_rentals_on_book_id"
  t.index ["user_id"], name: "index_rentals_on_user_id"
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
add_foreign_key "rentals", "books"
add_foreign_key "rentals", "users"

```



- ### Entity Relationship Diagram (ERD)

![Entity Relationship Diagram](app/assets/images/screenshots/ERD.png)

---

## Third Party Services

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
| Ultrahook  | Platform that provides realtime webhook endpoints. For example, when integrated with Stripe, whenever the user makes a transaction, ultrahook sets the quantity of the given book to decrease by 1. When the user goes back to the book page, the quantity displayed is automatically updated. |

---

## Tech Stack

- **HTML 5**: Markup language to structure the visuals of a website.
- **CSS 3 / SASS**: Styling language to modify the visuals of a website. SASS is a pre-processor that makes CSS more pleasant to work with.
- **Ruby on Rails**: Back end framework based on the Ruby programming language.
- **PostgreSQL**: Relational database management system.
- **Heroku**: Deployment platform (Rails industry standard).
- **Git / GitHub**: Platform for version control.
- **Trello**: Platform for task and project management.

---

## References

Rails Guides. (n.d.). Active Record Basics. Retrieved from https://guides.rubyonrails.org/active_record_basics.html
