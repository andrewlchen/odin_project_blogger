class Article < ActiveRecord::Base
	has_many :comments
	has_many :taggings
	has_many :tags, through: :taggings 

	has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }
	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]

	validates :title, presence: true 
	validates :body, presence: true 

	def tag_list 
		tags.join(", ")
	end 

	def tag_list=(tags_string)
		tag_list = tags_string.split(",")
		tag_list = tag_list.collect{|word| word.strip.downcase }
		unique_tags = tag_list.uniq 
		new_or_found_tags = unique_tags.collect{ |word| Tag.find_or_create_by(name: word) }
		self.tags = new_or_found_tags
	end 

end
