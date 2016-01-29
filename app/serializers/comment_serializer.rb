class CommentSerializer < ActiveModel::Serializer
  attributes :text

  has_one :user, serializer: UserSerializer
end
