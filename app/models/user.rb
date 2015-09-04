class User < ActiveRecord::Base

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      if auth['info']
         user.name = auth['info']['name'] || ""
      end
    end
  end

  def self.koala(auth)
  	token = auth[:token]
  	facebook = Koala::Facebook::API.new(token)
  	facebook.get_object("me?fields=picture")
  end

end
