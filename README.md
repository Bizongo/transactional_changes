# TransactionalChanges

This gem provides all the changes that has been made in a transaction.  
FYR, `ActiveModel::Dirty` provides a method `previous_changes` which only shows the last change that has been made. "https://api.rubyonrails.org/classes/ActiveModel/Dirty.html"

## Installation

```ruby
gem 'transactional_changes', git: "git@github.com:Bizongo/transactional_changes.git"
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install transactional_changes

## Usage

```ruby
class Dummy
  include TransactionalChanges
end

dummy = Dummy.new
dummy.name_had_changed? # => false

dummy.name = “Wade”
dummy.save!
dummy.name_had_changed? # => true

ActiveRecord::Base.transaction do
  dummy.name = “DeadPool”
  dummy.save!
  dummy.slug = “bla bla”
  dummy.save!
end

dummy.transaction_changes #=>
{“name”=>[“Wade”, “DeadPool”], “slug”=>[nil, “bla bla”], “updated_at”=>[Mon, 04 Feb 2019 01:27:33 IST +05:30, Mon, 18 Mar 2019 01:28:05 IST +05:30, Mon, 184 Mar 2019 01:28:05 IST +05:30]}
```
