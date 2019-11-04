module Gggiiifff
  class User < Ohm::Model
    attribute :username

    index :username
    unique :username
  end
end
