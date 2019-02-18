require "rails_helper"

describe Message do
  context "validations & attributes" do
    it { should validate_presence_of(:body) }
    it { should belong_to :user }

    it "has attributes" do
      data = {
              username: "mr_steal_yo_gurl",
              image_url: "https://bit.ly/2tlLmZc",
              spotify_token: "t0k3n"}

      user_1 = User.create(data)
      message = Message.create(body: "Hello", user: user_1)


      expect(message.body).to eq("Hello")
      expect(message.user).to eq(user_1)
    end
  end
end
