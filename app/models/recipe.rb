class Recipe < ActiveRecord::Base
  
  belongs_to :chef
  has_many :likes
  
  validates :name, presence: true, length: {minimum: 5, maximum: 100}
  validates :summary, presence: true, length: {minimum: 10, maximum: 150}
  validates :description, presence: true, length: {minimum: 20, maximum: 500}
  validates :chef_id, presence: true
  
  mount_uploader :picture, PictureUploader
  
  validate :picture_size
  
  default_scope -> {order(updated_at: :desc)}
  
  def thumps_up_total
    self.likes.where(like: true).size
  end
  
  def thumps_down_total
    self.likes.where(like: false).size
  end
  
  
  private
  
    def picture_size
      if picture.size > 3.megabytes 
        errors.add(:picture, "should be less than 3MB")
      end
    end
  
  
end
