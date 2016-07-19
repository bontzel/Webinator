class CommentSerializer < ActiveModel::Serializer
  attributes :text, :id

  belongs_to :user, serializer: UserSerializer
end
