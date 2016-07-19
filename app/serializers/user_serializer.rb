class UserSerializer < ActiveModel::Serializer
  attributes :id, :profile

  has_one :profile
	class ProfileSerializer < ActiveModel::Serializer
    attributes :id
  end
end
