# README

Steps to run the app

`bundle install`

`rails db:setup`

Steps to recreate the app:

`$ rails new fakeflix --database=postgresql --skip-test --api`

`$ rails g model Movie title:string description:text rating:integer duration:integer price:integer`

`$ rails g model Serie title:string description:text rating:integer price:integer`

`$ rails g model Episode title:string description:text duration:integer serie:references`

`$ rails g model Rental paid_price:integer rentable:references{polymorphic}:index`

`$ rake db:create`

`$ rake db:migrate`
