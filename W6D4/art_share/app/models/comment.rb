# == Schema Information
#
# Table name: comments
#
#  id           :bigint           not null, primary key
#  body         :text             not null
#  commenter_id :integer          not null
#  artwork_id   :integer          not null
#
class Comment < ApplicationRecord
    validates :body, presence: true
    validates :commenter_id, presence: true
    validates :artwork_id, presence: true

    belongs_to :commenter,
        foreign_key: :commenter_id,
        class_name: :User

    belongs_to :artwork,
        foreign_key: :artwork_id,
        class_name: :Artwork

    has_many :likes, as: :likeable

    has_many :likers,
        through: :likes,
        source: :liker 
end
