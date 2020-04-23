# == Schema Information
#
# Table name: artworks
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  image_url  :string           not null
#  artist_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Artwork < ApplicationRecord

    validates :title, presence: true, uniqueness: { scope: :artist_id,
        message: 'title with that name already exists' }
    validates :image_url, presence: true
    validates :artist_id, presence: true

    
    belongs_to :artist,
        foreign_key: :artist_id,
        class_name: :User

    has_many :shares, 
        foreign_key: :artwork_id,
        class_name: :ArtworkShare,
        dependent: :destroy

    has_many :shared_viewers,
        through: :shares,
        source: :viewer

    has_many :comments,
        foreign_key: :artwork_id,
        class_name: :Comment,
        dependent: :destroy

    has_many :likes, as: :likeable
    
    has_many :likers,
        through: :likes,
        source: :liker

    

end
