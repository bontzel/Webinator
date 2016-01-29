class UserSerializer < ActiveModel::Serializer
  attributes :id

  has_one :profile, serializer: ProfileSerializer
end
