class Friend < ApplicationRecord
    has_one_attached :image
    has_one :content
    has_one :answer

    has_secure_password
end
