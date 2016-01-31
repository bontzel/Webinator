class CommentSerializer < ActiveModel::Serializer
  attributes :text, :id

  has_one :user, serializer: UserSerializer
end
