# == Schema Information
#
# Table name: subs
#
#  id          :bigint(8)        not null, primary key
#  title       :string           not null
#  description :string           not null
#  mod_id      :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Sub < ApplicationRecord
  validates :title, :description, presence: true

  belongs_to :mod,
    foreign_key: :mod_id,
    class_name: :User

  has_many :postsubs,
    dependent: :destroy,
    inverse_of: :sub

  has_many :posts,
    through: :postsubs

end
