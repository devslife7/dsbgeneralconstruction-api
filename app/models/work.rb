class Work < ApplicationRecord
  has_many :comments, :dependent => :destroy
  # has_many_attached :files
  has_one_attached :images
end
