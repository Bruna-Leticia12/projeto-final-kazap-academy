class Contact < Sequel::Model
    many_to_one :clients
end