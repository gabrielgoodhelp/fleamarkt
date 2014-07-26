class Listing < ActiveRecord::Base
	if Rails.env.development?
		has_attached_file :image, :styles => { :medium => "200x", :thumb => "100x100"}, :default_url => "no_image_available.png"
		validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
	else
		has_attached_file :image, :styles => { :medium => "200x", :thumb => "100x100"}, :default_url => "no_image_available.png",
						    :storage => :dropbox,
    						:dropbox_credentials => Rails.root.join("config/dropbox.yml"),
							:path => ":style/:id_:filename"
		validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
	end

	validates :name, :description, :price, presence: true
	validates :price, numericality: { greater_than_or_equal_to: 0 }
	validates_attachment_presence :image

	belongs_to :user

	has_many :orders
end
